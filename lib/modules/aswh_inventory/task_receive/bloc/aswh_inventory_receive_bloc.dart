import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../services/aswh_inventory_task_service.dart';
import '../../task_list/models/inventory_task.dart';
import 'aswh_inventory_receive_event.dart';
import 'aswh_inventory_receive_state.dart';

@immutable
class AswhInventoryReceiveBloc
    extends Bloc<AswhInventoryReceiveEvent, AswhInventoryReceiveState> {
  AswhInventoryReceiveBloc({
    required AswhInventoryTaskService taskService,
    required UserManager userManager,
  })  : _taskService = taskService,
        _userManager = userManager,
        super(
          AswhInventoryReceiveState(
            filter: InventoryTaskFilter(
              userId: 'ALL',
              roleOrUserId: '${userManager.userInfo?.userId ?? ''}',
            ),
          ),
        ) {
    on<AswhInventoryReceiveStarted>(_onStarted);
    on<AswhInventoryReceiveSearchSubmitted>(_onSearchSubmitted);
    on<AswhInventoryReceiveScanCaptured>(_onScanCaptured);
    on<AswhInventoryReceivePageChanged>(_onPageChanged);
    on<AswhInventoryReceiveConfirmed>(_onReceiveConfirmed);

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
    AswhInventoryReceiveStarted event,
    Emitter<AswhInventoryReceiveState> emit,
  ) async {
    _ignoreNextPageChange = true;
    await _loadPage(emit, pageIndex: state.filter.pageIndex);
  }

  Future<void> _onSearchSubmitted(
    AswhInventoryReceiveSearchSubmitted event,
    Emitter<AswhInventoryReceiveState> emit,
  ) async {
    final updatedFilter = state.filter.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );
    emit(state.copyWith(filter: updatedFilter));
    await _loadPage(emit, pageIndex: 1);
  }

  Future<void> _onScanCaptured(
    AswhInventoryReceiveScanCaptured event,
    Emitter<AswhInventoryReceiveState> emit,
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
    AswhInventoryReceivePageChanged event,
    Emitter<AswhInventoryReceiveState> emit,
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

  Future<void> _onReceiveConfirmed(
    AswhInventoryReceiveConfirmed event,
    Emitter<AswhInventoryReceiveState> emit,
  ) async {
    if (state.status == InventoryReceiveStatus.actionInProgress) {
      return;
    }
    final userId = _userManager.userInfo?.userId;
    if (userId == null || userId.toString().isEmpty) {
      emit(
        state.copyWith(
          status: InventoryReceiveStatus.failure,
          message: '用户信息缺失，请重新登录',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: InventoryReceiveStatus.actionInProgress,
        clearMessage: true,
      ),
    );
    try {
      await _taskService.cancelInventoryTask(
        taskComment: event.task.taskComment,
        userId: userId.toString(),
        confirm: false,
      );
      await _loadPage(
        emit,
        pageIndex: state.filter.pageIndex,
        successMessage: '单据接收成功',
        successStatus: InventoryReceiveStatus.actionSuccess,
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: InventoryReceiveStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _loadPage(
    Emitter<AswhInventoryReceiveState> emit, {
    required int pageIndex,
    String? successMessage,
    InventoryReceiveStatus successStatus = InventoryReceiveStatus.success,
  }) async {
    emit(
      state.copyWith(
        status: InventoryReceiveStatus.loading,
        clearMessage: true,
      ),
    );

    final completer = Completer<DataGridResponseData<InventoryTaskSummary>>();
    _gridBloc.add(LoadDataEvent(pageIndex, completer: completer));

    try {
      final response = await completer.future;
      final emptyMessage =
          response.data.isEmpty ? '当前任务列表没有待处理任务！' : null;
      final displayMessage = successMessage ?? emptyMessage;
      emit(
        state.copyWith(
          status: successStatus,
          tasks: response.data,
          currentPage: pageIndex,
          totalPages: response.totalPages,
          total: _latestTotalCount,
          filter: state.filter.copyWith(pageIndex: pageIndex),
          message: displayMessage,
          clearMessage: displayMessage == null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: InventoryReceiveStatus.failure,
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
