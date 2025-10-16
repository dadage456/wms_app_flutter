import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../services/aswh_inventory_task_service.dart';
import '../models/inventory_task.dart';
import 'aswh_inventory_task_list_event.dart';
import 'aswh_inventory_task_list_state.dart';

@immutable
class AswhInventoryTaskListBloc
    extends Bloc<AswhInventoryTaskListEvent, AswhInventoryTaskListState> {
  AswhInventoryTaskListBloc({
    required AswhInventoryTaskService taskService,
    required UserManager userManager,
  }) : _taskService = taskService,
       _userManager = userManager,
       super(
         AswhInventoryTaskListState(
           filter: InventoryTaskFilter(
             userId: '${userManager.userInfo?.userId ?? ''}',
             roleOrUserId: '${userManager.userInfo?.userId ?? ''}',
           ),
         ),
       ) {
    on<_Started>(_onStarted);
    on<_FilterSubmitted>(_onFilterSubmitted);
    on<_ScanContentReceived>(_onScanContentReceived);
    on<_PageChanged>(_onPageChanged);
    on<_TaskCancelRequested>(_onTaskCancelRequested);
    on<_RefreshRequested>(_onRefreshRequested);

    _gridBloc = CommonDataGridBloc<InventoryTaskSummary>(
      dataLoader: _createDataLoader(),
    );
  }

  final AswhInventoryTaskService _taskService;
  final UserManager _userManager;

  late final CommonDataGridBloc<InventoryTaskSummary> _gridBloc;
  CommonDataGridBloc<InventoryTaskSummary> get gridBloc => _gridBloc;

  int _latestTotalCount = 0;
  bool _ignoreNextPageChange = false;

  DataGridLoader<InventoryTaskSummary> _createDataLoader() {
    return (pageIndex) async {
      final filter = state.filter.copyWith(pageIndex: pageIndex);
      final result = await _taskService.fetchInventoryTasks(filter: filter);
      _latestTotalCount = result.total;
      final totalPages = result.total == 0
          ? 1
          : (result.total / filter.pageSize).ceil().clamp(1, 999999);
      return DataGridResponseData<InventoryTaskSummary>(
        totalPages: totalPages,
        data: result.rows,
      );
    };
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<AswhInventoryTaskListState> emit,
  ) async {
    _ignoreNextPageChange = true;
    await _loadPage(emit, pageIndex: state.filter.pageIndex);
  }

  Future<void> _onFilterSubmitted(
    _FilterSubmitted event,
    Emitter<AswhInventoryTaskListState> emit,
  ) async {
    final updatedFilter = state.filter.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );
    emit(state.copyWith(filter: updatedFilter));
    await _loadPage(emit, pageIndex: 1);
  }

  Future<void> _onScanContentReceived(
    _ScanContentReceived event,
    Emitter<AswhInventoryTaskListState> emit,
  ) async {
    if (event.scanContent.isEmpty) {
      return;
    }
    final updatedFilter = state.filter.copyWith(
      searchKey: event.scanContent,
      pageIndex: 1,
    );
    emit(state.copyWith(filter: updatedFilter));
    await _loadPage(emit, pageIndex: 1);
  }

  Future<void> _onPageChanged(
    _PageChanged event,
    Emitter<AswhInventoryTaskListState> emit,
  ) async {
    if (_ignoreNextPageChange) {
      _ignoreNextPageChange = false;
      return;
    }
    emit(
      state.copyWith(filter: state.filter.copyWith(pageIndex: event.pageIndex)),
    );
    await _loadPage(emit, pageIndex: event.pageIndex);
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<AswhInventoryTaskListState> emit,
  ) async {
    await _loadPage(emit, pageIndex: state.filter.pageIndex);
  }

  Future<void> _onTaskCancelRequested(
    _TaskCancelRequested event,
    Emitter<AswhInventoryTaskListState> emit,
  ) async {
    final userId = _userManager.userInfo?.userId;
    if (userId == null) {
      emit(
        state.copyWith(
          status: AswhTaskListStatus.failure,
          message: '用户信息缺失，请重新登录',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AswhTaskListStatus.actionInProgress));
    try {
      await _taskService.cancelInventoryTask(
        taskComment: event.task.taskComment,
        userId: userId.toString(),
      );
      await _loadPage(
        emit,
        pageIndex: state.filter.pageIndex,
        successMessage: '单据撤销成功',
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhTaskListStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadPage(
    Emitter<AswhInventoryTaskListState> emit, {
    required int pageIndex,
    String? successMessage,
  }) async {
    emit(state.copyWith(status: AswhTaskListStatus.loading, message: null));

    final completer = Completer<DataGridResponseData<InventoryTaskSummary>>();
    _gridBloc.add(LoadDataEvent(pageIndex, completer: completer));

    try {
      final response = await completer.future;
      emit(
        state.copyWith(
          status: AswhTaskListStatus.success,
          tasks: response.data,
          currentPage: pageIndex,
          totalPages: response.totalPages,
          total: _latestTotalCount,
          filter: state.filter.copyWith(pageIndex: pageIndex),
          message: successMessage,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhTaskListStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _gridBloc.close();
    return super.close();
  }
}
