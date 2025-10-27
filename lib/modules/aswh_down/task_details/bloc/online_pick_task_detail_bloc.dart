import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/utils/error_handler.dart';
import 'package:wms_app/services/user_manager.dart';

import 'online_pick_task_detail_event.dart';
import 'online_pick_task_detail_state.dart';

class OnlinePickTaskDetailBloc
    extends Bloc<OnlinePickTaskDetailEvent, OnlinePickTaskDetailState> {
  OnlinePickTaskDetailBloc({
    required AswhDownTaskService taskService,
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
  }) : _taskService = taskService,
       _userManager = userManager,
       super(const OnlinePickTaskDetailState()) {
    gridBloc = CommonDataGridBloc<OnlinePickTaskItem>(
      dataLoader: _loadData,
      dataDeleter: _deleteSelected,
    );

    on<OnlinePickTaskDetailInitialized>(_onInitialized);
    on<OnlinePickTaskDetailSearchSubmitted>(_onSearchSubmitted);
    on<OnlinePickTaskDetailCancelSubmitted>(_onCancelSubmitted);
    on<OnlinePickTaskDetailRefreshRequested>(_onRefreshRequested);
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
    final rawPages = (response.total / query.pageSize).ceil();
    final totalPages = rawPages > 0 ? rawPages : 1;
    return DataGridResponseData(totalPages: totalPages, data: response.rows);
  }

  Future<void> _deleteSelected(List<int> indices) async {
    if (indices.isEmpty) {
      throw Exception('请至少选择一行记录');
    }
    final rows = gridBloc.state.data;
    final ids = indices
        .map((index) => rows[index].outTaskItemId.toString())
        .toList();
    await _taskService.commitTaskItems(
      taskItemIds: ids,
      isCancel: true,
      roomTag: '0',
    );
  }

  Future<void> _onInitialized(
    OnlinePickTaskDetailInitialized event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    final task = event.task;
    final user = _userManager.userInfo;

    _currentQuery = OnlinePickTaskItemQuery(
      outTaskId: task.outTaskId,
      outTaskNo: task.outTaskNo,
      workStation: task.workStation,
      roleOrUserId: '${user?.userId}',
      userId: '${user?.userId}',
      roomTag: '1',
      finishFlag: task.finishFlag ?? '0',
      pageIndex: 1,
      pageSize: 100,
    );
  }

  Future<void> _onSearchSubmitted(
    OnlinePickTaskDetailSearchSubmitted event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    _currentQuery = _currentQuery.copyWith(
      searchKey: event.keyword,
      pageIndex: 1,
    );
    gridBloc.add(LoadDataEvent(_currentQuery.pageIndex));
  }

  Future<void> _onCancelSubmitted(
    OnlinePickTaskDetailCancelSubmitted event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    await _deleteSelected(event.selectedRows);
    gridBloc.add(RefrenshLoadDataEvent());
  }

  Future<void> _onRefreshRequested(
    OnlinePickTaskDetailRefreshRequested event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    gridBloc.add(RefrenshLoadDataEvent());
  }
}
