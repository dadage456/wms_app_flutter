import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/services/user_manager.dart';

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
    gridBloc = CommonDataGridBloc<OnlinePickTaskItem>(
      dataLoader: _loadData,
      dataCommiter: _createReceiver(),
    );

    on<OnlinePickReceiveDetailStarted>(_onStarted);
    on<OnlinePickReceiveDetailSearchSubmitted>(_onSearchSubmitted);
    on<OnlinePickReceiveDetailRefreshRequested>(_onRefreshRequested);
    on<OnlinePickReceiveDetailCommitRequested>(_onCommitRequested);
  }

  final AswhDownTaskService _taskService;
  final UserManager _userManager;

  late final CommonDataGridBloc<OnlinePickTaskItem> gridBloc;

  late OnlinePickTaskItemQuery _currentQuery;

  Future<DataGridResponseData<OnlinePickTaskItem>> _loadData(
    int pageIndex,
  ) async {
    final query = _currentQuery.copyWith(pageIndex: pageIndex);

    _currentQuery = query;
    final response = await _taskService.fetchTaskItemList(query: query);
    final totalPagesRaw = (response.total / query.pageSize).ceil();
    final totalPages = totalPagesRaw > 0 ? totalPagesRaw : 1;

    return DataGridResponseData<OnlinePickTaskItem>(
      totalPages: totalPages,
      data: response.rows,
    );
  }

  DataGridDeleter _createReceiver() {
    return (selectedRows) async {
      final datas = gridBloc.state.data;
      final ids = selectedRows.map((index) {
        return datas[index].outTaskItemId.toString();
      }).toList();

      await _taskService.commitTaskItems(
        taskItemIds: ids,
        isCancel: false,
        roomTag: '1',
      );

      gridBloc.add(const RefrenshLoadDataEvent());
    };
  }

  Future<void> _onStarted(
    OnlinePickReceiveDetailStarted event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    final user = _userManager.userInfo;
    _currentQuery = OnlinePickTaskItemQuery(
      outTaskId: event.outTaskId,
      outTaskNo: event.task?.outTaskNo,
      workStation: event.task?.workStation,
      roleOrUserId: '${user?.userId}',
      userId: 'ALL',
      roomTag: '1',
      pageIndex: 1,
      pageSize: 100,
      finishFlag: event.task?.finishFlag ?? '0',
      forceBatch: event.task?.forceBatch,
      forceSite: event.task?.forceSite,
    );

    gridBloc.add(LoadDataEvent(_currentQuery.pageIndex));
  }

  Future<void> _onSearchSubmitted(
    OnlinePickReceiveDetailSearchSubmitted event,
    Emitter<OnlinePickReceiveDetailState> emit,
  ) async {
    _currentQuery = _currentQuery.copyWith(
      searchKey: event.keyword,
      pageIndex: 1,
    );

    gridBloc.add(LoadDataEvent(_currentQuery.pageIndex));
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
    gridBloc.add(CommitSelectedRowsEvent(event.indexes));
  }
}
