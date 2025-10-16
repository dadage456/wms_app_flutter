import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../services/aswh_down_task_service.dart';
import 'online_pick_task_event.dart';
import 'online_pick_task_state.dart';

class OnlinePickTaskBloc
    extends Bloc<OnlinePickTaskEvent, OnlinePickTaskState> {
  OnlinePickTaskBloc({
    required AswhDownTaskService taskService,
    required UserManager userManager,
  })  : _taskService = taskService,
        _userManager = userManager,
        super(const OnlinePickTaskState()) {
    _currentQuery = _buildDefaultQuery();
    gridBloc = CommonDataGridBloc<OnlinePickTask>(
      dataLoader: _createDataLoader(),
    );

    on<OnlinePickTaskInitialized>(_onInitialized);
    on<OnlinePickTaskSearchSubmitted>(_onSearchSubmitted);
    on<OnlinePickTaskFinishFlagChanged>(_onFinishFlagChanged);
    on<OnlinePickTaskRefreshRequested>(_onRefreshRequested);
  }

  final AswhDownTaskService _taskService;
  final UserManager _userManager;

  late OnlinePickTaskQuery _currentQuery;
  late final CommonDataGridBloc<OnlinePickTask> gridBloc;

  DataGridLoader<OnlinePickTask> _createDataLoader() {
    return (pageIndex) async {
      final nextQuery = _currentQuery.copyWith(pageIndex: pageIndex);
      _currentQuery = nextQuery;
      final result = await _taskService.fetchTaskList(query: nextQuery);

      final totalPagesRaw = (result.total / nextQuery.pageSize).ceil();
      final totalPages = totalPagesRaw > 0 ? totalPagesRaw : 1;

      return DataGridResponseData<OnlinePickTask>(
        totalPages: totalPages,
        data: result.rows,
      );
    };
  }

  Future<void> _onInitialized(
    OnlinePickTaskInitialized event,
    Emitter<OnlinePickTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(0));
  }

  Future<void> _onSearchSubmitted(
    OnlinePickTaskSearchSubmitted event,
    Emitter<OnlinePickTaskState> emit,
  ) async {
    _currentQuery = _currentQuery.copyWith(
      searchKey: event.keyword,
      pageIndex: 0,
    );
    emit(state.copyWith(searchKeyword: event.keyword));
    gridBloc.add(LoadDataEvent(0));
  }

  Future<void> _onFinishFlagChanged(
    OnlinePickTaskFinishFlagChanged event,
    Emitter<OnlinePickTaskState> emit,
  ) async {
    _currentQuery = _currentQuery.copyWith(
      finishFlag: event.finishFlag,
      pageIndex: 0,
    );
    emit(state.copyWith(finishFlag: event.finishFlag));

    final completer = Completer<DataGridResponseData<OnlinePickTask>>();
    gridBloc.add(LoadDataEvent(0, completer: completer));
    try {
      await completer.future;
    } catch (_) {}
  }

  Future<void> _onRefreshRequested(
    OnlinePickTaskRefreshRequested event,
    Emitter<OnlinePickTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(_currentQuery.pageIndex));
  }

  OnlinePickTaskQuery _buildDefaultQuery() {
    final userInfo = _userManager.userInfo;

    final userId = userInfo == null ? '' : '${userInfo.userId}';

    return OnlinePickTaskQuery(
      userId: userId,
      roleOrUserId: userId,
      roomTag: '1',
      finishFlag: '0',
      pageIndex: 0,
      pageSize: 100,
    );
  }
}
