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
  })  : _taskService = taskService,
        _collectionService = collectionService,
        _userManager = userManager,
        super(const OnlinePickTaskDetailState()) {
    gridBloc = CommonDataGridBloc<OnlinePickTaskItem>(
      dataLoader: _loadData,
      dataDeleter: _deleteSelected,
    );

    on<OnlinePickTaskDetailInitialized>(_onInitialized);
    on<OnlinePickTaskDetailSearchSubmitted>(_onSearchSubmitted);
    on<OnlinePickTaskDetailScanRequested>(_onScanRequested);
    on<OnlinePickTaskDetailCancelSubmitted>(_onCancelSubmitted);
    on<OnlinePickTaskDetailRefreshRequested>(_onRefreshRequested);
    on<OnlinePickTaskDetailStatusReset>(_onStatusReset);
  }

  final AswhDownTaskService _taskService;
  final AswhDownCollectionService _collectionService;
  final UserManager _userManager;

  late final CommonDataGridBloc<OnlinePickTaskItem> gridBloc;
  OnlinePickTaskItemQuery? _currentQuery;

  Future<DataGridResponseData<OnlinePickTaskItem>> _loadData(int pageIndex) async {
    final query = _currentQuery?.copyWith(pageIndex: pageIndex);
    if (query == null) {
      return const DataGridResponseData(totalPages: 1, data: []);
    }
    _currentQuery = query;
    final response = await _taskService.fetchTaskItemList(query: query);
    final rawPages = (response.total / query.pageSize).ceil();
    final totalPages = rawPages > 0 ? rawPages : 1;
    return DataGridResponseData(
      totalPages: totalPages,
      data: response.rows,
    );
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
    if (user == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('用户信息缺失，请重新登录'),
          task: task,
        ),
      );
      return;
    }

    _currentQuery = OnlinePickTaskItemQuery(
      outTaskId: task.outTaskId,
      outTaskNo: task.outTaskNo,
      workStation: task.workStation,
      roleOrUserId: '${user.userId}',
      userId: '${user.userId}',
      roomTag: '1',
      finishFlag: task.finishFlag ?? '0',
      pageIndex: 0,
      pageSize: 100,
    );

    emit(
      state.copyWith(
        task: task,
        query: _currentQuery,
        status: CollectionStatus.loading(),
      ),
    );

    gridBloc.add(LoadDataEvent(0));
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  Future<void> _onSearchSubmitted(
    OnlinePickTaskDetailSearchSubmitted event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    if (_currentQuery == null) return;
    _currentQuery = _currentQuery!.copyWith(
      searchKey: event.keyword,
      pageIndex: 0,
    );
    emit(state.copyWith(query: _currentQuery));
    gridBloc.add(LoadDataEvent(0));
  }

  Future<void> _onScanRequested(
    OnlinePickTaskDetailScanRequested event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final content = event.scanContent.trim();
      String keyword = content;

      if (content.contains('MC')) {
        final info = await _collectionService.getMaterialInfoByQr(content);
        if (info.materialCode == null || info.materialCode!.isEmpty) {
          throw Exception('物料条码识别失败');
        }
        keyword = info.materialCode!;
      } else if (content.contains(r'$KW$')) {
        final parts = content.split(r'$');
        if (parts.length > 2) {
          keyword = parts[2];
        }
      }

      add(OnlinePickTaskDetailSearchSubmitted(keyword));
      emit(state.copyWith(status: CollectionStatus.success()));
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(e)),
        ),
      );
    }
  }

  Future<void> _onCancelSubmitted(
    OnlinePickTaskDetailCancelSubmitted event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    try {
      final selected = gridBloc.state.selectedRows;
      if (selected.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('请至少选择一行记录')));
        return;
      }
      emit(state.copyWith(status: CollectionStatus.loading()));
      await _deleteSelected(selected);
      gridBloc.add(RefrenshLoadDataEvent());
      emit(
        state.copyWith(
          status: CollectionStatus.success('单据撤销成功'),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(e)),
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    OnlinePickTaskDetailRefreshRequested event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) async {
    gridBloc.add(RefrenshLoadDataEvent());
  }

  void _onStatusReset(
    OnlinePickTaskDetailStatusReset event,
    Emitter<OnlinePickTaskDetailState> emit,
  ) {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }
}
