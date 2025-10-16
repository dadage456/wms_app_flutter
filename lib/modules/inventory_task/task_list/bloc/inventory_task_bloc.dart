import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../services/inventory_task_service.dart';
import '../models/inventory_task.dart';
import 'inventory_task_event.dart';
import 'inventory_task_state.dart';

@immutable
class InventoryTaskBloc extends Bloc<InventoryTaskEvent, InventoryTaskState> {
  InventoryTaskBloc({
    required InventoryTaskService taskService,
    required UserManager userManager,
  })  : _taskService = taskService,
        _userManager = userManager,
        super(
          InventoryTaskState(
            filter: InventoryTaskQuery(
              userId: '${userManager.userInfo?.userId ?? ''}',
              roleOrUserId: '${userManager.userInfo?.userId ?? ''}',
            ),
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Scanned>(_onScanned);
    on<_SearchSubmitted>(_onSearchSubmitted);
    on<_PageChanged>(_onPageChanged);
    on<_RefreshRequested>(_onRefreshRequested);
    on<_CancelTaskRequested>(_onCancelTaskRequested);

    _gridBloc = CommonDataGridBloc<InventoryTask>(
      dataLoader: _createDataLoader(),
    );
  }

  final InventoryTaskService _taskService;
  final UserManager _userManager;

  late final CommonDataGridBloc<InventoryTask> _gridBloc;
  CommonDataGridBloc<InventoryTask> get gridBloc => _gridBloc;

  int _latestTotalCount = 0;
  bool _ignoreNextPageChange = false;

  DataGridLoader<InventoryTask> _createDataLoader() {
    return (pageIndex) async {
      final filter = state.filter.copyWith(pageIndex: pageIndex);
      final response = await _taskService.fetchInventoryTasks(query: filter);
      _latestTotalCount = response.total;
      final totalPages = response.total == 0
          ? 1
          : (response.total / filter.pageSize).ceil().clamp(1, 999999);
      return DataGridResponseData<InventoryTask>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<InventoryTaskState> emit,
  ) async {
    _ignoreNextPageChange = true;
    await _loadPage(emit, pageIndex: state.filter.pageIndex);
  }

  Future<void> _onScanned(
    _Scanned event,
    Emitter<InventoryTaskState> emit,
  ) async {
    if (event.content.isEmpty) {
      return;
    }
    final updatedFilter = state.filter.copyWith(
      searchKey: event.content,
      pageIndex: 1,
    );
    emit(state.copyWith(filter: updatedFilter));
    await _loadPage(emit, pageIndex: 1);
  }

  Future<void> _onSearchSubmitted(
    _SearchSubmitted event,
    Emitter<InventoryTaskState> emit,
  ) async {
    final updatedFilter = state.filter.copyWith(
      searchKey: event.keyword,
      pageIndex: 1,
    );
    emit(state.copyWith(filter: updatedFilter));
    await _loadPage(emit, pageIndex: 1);
  }

  Future<void> _onPageChanged(
    _PageChanged event,
    Emitter<InventoryTaskState> emit,
  ) async {
    if (_ignoreNextPageChange) {
      _ignoreNextPageChange = false;
      return;
    }
    emit(
      state.copyWith(
        filter: state.filter.copyWith(pageIndex: event.pageIndex),
      ),
    );
    await _loadPage(emit, pageIndex: event.pageIndex);
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<InventoryTaskState> emit,
  ) async {
    await _loadPage(emit, pageIndex: state.filter.pageIndex);
  }

  Future<void> _onCancelTaskRequested(
    _CancelTaskRequested event,
    Emitter<InventoryTaskState> emit,
  ) async {
    final userId = _userManager.userInfo?.userId;
    if (userId == null) {
      emit(
        state.copyWith(
          status: InventoryTaskListStatus.failure,
          message: '用户信息缺失，请重新登录',
        ),
      );
      return;
    }

    emit(state.copyWith(status: InventoryTaskListStatus.actionInProgress));
    try {
      await _taskService.cancelTask(
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
          status: InventoryTaskListStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadPage(
    Emitter<InventoryTaskState> emit, {
    required int pageIndex,
    String? successMessage,
  }) async {
    emit(state.copyWith(status: InventoryTaskListStatus.loading, message: null));

    final completer = Completer<DataGridResponseData<InventoryTask>>();
    _gridBloc.add(LoadDataEvent(pageIndex, completer: completer));

    try {
      final response = await completer.future;
      emit(
        state.copyWith(
          status: InventoryTaskListStatus.success,
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
          status: InventoryTaskListStatus.failure,
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
