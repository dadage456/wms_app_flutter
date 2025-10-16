import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import '../../services/aswh_down_task_service.dart';
import 'online_pick_receive_event.dart';
import 'online_pick_receive_state.dart';

class OnlinePickReceiveBloc
    extends Bloc<OnlinePickReceiveEvent, OnlinePickReceiveState> {
  OnlinePickReceiveBloc({
    required AswhDownTaskService taskService,
    required UserManager userManager,
  }) : _taskService = taskService,
       _userManager = userManager,
       super(const OnlinePickReceiveState()) {
    gridBloc = CommonDataGridBloc<OnlinePickTask>(
      dataLoader: _createDataLoader(),
    );

    _gridSubscription = gridBloc.stream.listen((gridState) {
      add(OnlinePickReceiveRecordCountChanged(gridState.data.length));
    });

    on<OnlinePickReceiveStarted>(_onStarted);
    on<OnlinePickReceiveSearchRequested>(_onSearch);
    on<OnlinePickReceiveRefreshRequested>(_onRefresh);
    on<OnlinePickReceiveStatusCleared>(_onStatusCleared);
    on<OnlinePickReceiveRecordCountChanged>(_onRecordCountChanged);
  }

  final AswhDownTaskService _taskService;
  final UserManager _userManager;

  late final CommonDataGridBloc<OnlinePickTask> gridBloc;
  late final StreamSubscription _gridSubscription;

  late OnlinePickTaskQuery _currentQuery = _buildDefaultQuery();

  DataGridLoader<OnlinePickTask> _createDataLoader() {
    return (pageIndex) async {
      final query = _currentQuery.copyWith(pageIndex: pageIndex);
      _currentQuery = query;

      final response = await _taskService.fetchTaskList(query: query);
      final totalPagesRaw = (response.total / query.pageSize).ceil();
      final totalPages = totalPagesRaw > 0 ? totalPagesRaw : 1;

      return DataGridResponseData<OnlinePickTask>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  Future<void> _onStarted(
    OnlinePickReceiveStarted event,
    Emitter<OnlinePickReceiveState> emit,
  ) async {
    gridBloc.add(const LoadDataEvent(1));
  }

  Future<void> _onSearch(
    OnlinePickReceiveSearchRequested event,
    Emitter<OnlinePickReceiveState> emit,
  ) async {
    _currentQuery = _currentQuery.copyWith(
      searchKey: event.keyword,
      pageIndex: 1,
    );
    emit(
      state.copyWith(
        searchKeyword: event.keyword,
        status: CollectionStatus.loading(),
      ),
    );
    final completer = Completer<DataGridResponseData<OnlinePickTask>>();
    gridBloc.add(LoadDataEvent(_currentQuery.pageIndex, completer: completer));
    try {
      await completer.future;
      emit(state.copyWith(status: CollectionStatus.success()));
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _onRefresh(
    OnlinePickReceiveRefreshRequested event,
    Emitter<OnlinePickReceiveState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(_currentQuery.pageIndex));
  }

  Future<void> _onStatusCleared(
    OnlinePickReceiveStatusCleared event,
    Emitter<OnlinePickReceiveState> emit,
  ) async {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  Future<void> _onRecordCountChanged(
    OnlinePickReceiveRecordCountChanged event,
    Emitter<OnlinePickReceiveState> emit,
  ) async {
    emit(state.copyWith(recordCount: event.count));
  }

  OnlinePickTaskQuery _buildDefaultQuery() {
    final user = _userManager.userInfo;
    final userId = user == null ? '' : '${user.userId}';

    return OnlinePickTaskQuery(
      userId: 'ALL',
      roleOrUserId: userId,
      roomTag: '1',
      pageIndex: 1,
      pageSize: 100,
      finishFlag: '0',
    );
  }

  @override
  Future<void> close() async {
    await _gridSubscription.cancel();
    await gridBloc.close();
    return super.close();
  }
}
