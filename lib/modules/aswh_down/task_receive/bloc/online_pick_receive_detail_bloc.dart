import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/utils/online_pick_scanner_parser.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import '../../services/aswh_down_task_service.dart';
import 'online_pick_receive_detail_event.dart';
import 'online_pick_receive_detail_state.dart';

class OnlinePickReceiveDetailBloc
    extends Bloc<OnlinePickReceiveDetailEvent, OnlinePickReceiveDetailState> {
  OnlinePickReceiveDetailBloc({
    required AswhDownTaskService taskService,
    required UserManager userManager,
  }) : _taskService = taskService,
       _userManager = userManager,
       super(const OnlinePickReceiveDetailState()) {
    gridBloc = CommonDataGridBloc<OnlinePickTaskItem>(dataLoader: _loadData);

    _gridSubscription = gridBloc.stream.listen((gridState) {
      add(OnlinePickReceiveDetailRecordCountChanged(gridState.data.length));
    });

    on<OnlinePickReceiveDetailStarted>(_onStarted);
    on<OnlinePickReceiveDetailSearchSubmitted>(_onSearchSubmitted);
    on<OnlinePickReceiveDetailScanSubmitted>(_onScanSubmitted);
    on<OnlinePickReceiveDetailRefreshRequested>(_onRefreshRequested);
    on<OnlinePickReceiveDetailCommitRequested>(_onCommitRequested);
    on<OnlinePickReceiveDetailStatusCleared>(_onStatusCleared);
    on<OnlinePickReceiveDetailRecordCountChanged>(_onRecordCountChanged);
  }

  final AswhDownTaskService _taskService;
  final UserManager _userManager;

  late final CommonDataGridBloc<OnlinePickTaskItem> gridBloc;
  late final StreamSubscription _gridSubscription;

  OnlinePickTaskItemQuery? _currentQuery;
  OnlinePickTask? _currentTask;

  Future<DataGridResponseData<OnlinePickTaskItem>> _loadData(
    int pageIndex,
  ) async {
    final query = _currentQuery?.copyWith(pageIndex: pageIndex);
    if (query == null) {
      return const DataGridResponseData(totalPages: 1, data: []);
    }

    _currentQuery = query;
    final response = await _taskService.fetchTaskItemList(query: query);
    final totalPagesRaw = (response.total / query.pageSize).ceil();
    final totalPages = totalPagesRaw > 0 ? totalPagesRaw : 1;

    return DataGridResponseData<OnlinePickTaskItem>(
      totalPages: totalPages,
      data: response.rows,
    );
  }

  Future<void> _onStarted(
    OnlinePickReceiveDetailStarted event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    final user = _userManager.userInfo;
    if (user == null) {
      emit(state.copyWith(status: CollectionStatus.error('用户信息缺失，请重新登录')));
      return;
    }

    _currentTask = event.task;
    _currentQuery = OnlinePickTaskItemQuery(
      outTaskId: event.outTaskId,
      outTaskNo: event.task?.outTaskNo,
      workStation: event.task?.workStation,
      roleOrUserId: '${user.userId}',
      userId: 'ALL',
      roomTag: '1',
      pageIndex: 1,
      pageSize: 100,
      finishFlag: event.task?.finishFlag ?? '0',
      forceBatch: event.task?.forceBatch,
      forceSite: event.task?.forceSite,
    );

    emit(
      state.copyWith(
        task: event.task,
        query: _currentQuery,
        status: CollectionStatus.loading(),
      ),
    );

    gridBloc.add(const LoadDataEvent(1));
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  Future<void> _onSearchSubmitted(
    OnlinePickReceiveDetailSearchSubmitted event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    if (_currentQuery == null) return;

    _currentQuery = _currentQuery!.copyWith(
      searchKey: event.keyword,
      pageIndex: 1,
    );

    emit(
      state.copyWith(
        query: _currentQuery,
        searchKeyword: event.keyword,
        status: CollectionStatus.loading(),
      ),
    );

    final completer = Completer<DataGridResponseData<OnlinePickTaskItem>>();
    gridBloc.add(LoadDataEvent(1, completer: completer));
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

  Future<void> _onScanSubmitted(
    OnlinePickReceiveDetailScanSubmitted event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    try {
      final result = OnlinePickScannerParser.parse(event.scanContent);
      switch (result.type) {
        case OnlinePickScanType.location:
        case OnlinePickScanType.material:
        case OnlinePickScanType.tray:
          add(OnlinePickReceiveDetailSearchSubmitted(result.normalizedValue));
          break;
        case OnlinePickScanType.quantity:
          add(OnlinePickReceiveDetailSearchSubmitted(result.normalizedValue));
          break;
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    OnlinePickReceiveDetailRefreshRequested event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    gridBloc.add(const RefrenshLoadDataEvent());
  }

  Future<void> _onCommitRequested(
    OnlinePickReceiveDetailCommitRequested event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    final selected = gridBloc.state.selectedRows;
    if (selected.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请至少选择一条明细')));
      return;
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final rows = gridBloc.state.data;
      final ids = selected
          .map((index) => rows[index].outTaskItemId.toString())
          .toList();

      await _taskService.commitTaskItems(
        taskItemIds: ids,
        isCancel: false,
        roomTag: '1',
      );

      gridBloc.add(const RefrenshLoadDataEvent());
      emit(
        state.copyWith(
          status: CollectionStatus.success('接收成功'),
          shouldNotifyParent: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _onStatusCleared(
    OnlinePickReceiveDetailStatusCleared event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  Future<void> _onRecordCountChanged(
    OnlinePickReceiveDetailRecordCountChanged event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    emit(state.copyWith(recordCount: event.count));
  }

  @override
  Future<void> close() async {
    await _gridSubscription.cancel();
    await gridBloc.close();
    return super.close();
  }
}
