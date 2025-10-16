import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../services/inventory_task_service.dart';
import '../../task_list/models/inventory_task.dart';
import 'inventory_receive_event.dart';
import 'inventory_receive_state.dart';

@immutable
class InventoryReceiveBloc
    extends Bloc<InventoryReceiveEvent, InventoryReceiveState> {
  InventoryReceiveBloc({
    required InventoryTaskService taskService,
    required UserManager userManager,
  })  : _taskService = taskService,
        _userManager = userManager,
        super(
          InventoryReceiveState(
            filter: InventoryTaskQuery(
              userId: 'ALL',
              roleOrUserId: '${userManager.userInfo?.userId ?? ''}',
            ),
          ),
        ) {
    on<_Started>(_onStarted);
    on<_Scanned>(_onScanned);
    on<_SearchSubmitted>(_onSearchSubmitted);
    on<_PageChanged>(_onPageChanged);
    on<_ReceiveRequested>(_onReceiveRequested);

    _gridBloc = CommonDataGridBloc<InventoryTask>(
      dataLoader: _createLoader(),
    );
  }

  final InventoryTaskService _taskService;
  final UserManager _userManager;

  late final CommonDataGridBloc<InventoryTask> _gridBloc;
  CommonDataGridBloc<InventoryTask> get gridBloc => _gridBloc;

  int _latestTotal = 0;
  bool _ignoreNextPageChange = false;

  DataGridLoader<InventoryTask> _createLoader() {
    return (pageIndex) async {
      final filter = state.filter.copyWith(pageIndex: pageIndex);
      final response =
          await _taskService.fetchReceivableTasks(query: filter);
      _latestTotal = response.total;
      final totalPages = response.total == 0
          ? 1
          : (response.total / filter.pageSize).ceil().clamp(1, 999999);
      return DataGridResponseData(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<InventoryReceiveState> emit,
  ) async {
    _ignoreNextPageChange = true;
    await _loadPage(emit, pageIndex: state.filter.pageIndex);
  }

  Future<void> _onScanned(
    _Scanned event,
    Emitter<InventoryReceiveState> emit,
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
    Emitter<InventoryReceiveState> emit,
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
    Emitter<InventoryReceiveState> emit,
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

  Future<void> _onReceiveRequested(
    _ReceiveRequested event,
    Emitter<InventoryReceiveState> emit,
  ) async {
    final userId = _userManager.userInfo?.userId;
    if (userId == null) {
      emit(
        state.copyWith(
          status: InventoryReceiveStatus.failure,
          message: '用户信息缺失，请重新登录',
        ),
      );
      return;
    }

    emit(state.copyWith(status: InventoryReceiveStatus.actionInProgress));
    try {
      await _taskService.receiveTask(
        taskComment: event.task.taskComment,
        userId: userId.toString(),
      );
      await _loadPage(
        emit,
        pageIndex: state.filter.pageIndex,
        successMessage: '单据接收成功',
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
    Emitter<InventoryReceiveState> emit, {
    required int pageIndex,
    String? successMessage,
  }) async {
    emit(
      state.copyWith(
        status: InventoryReceiveStatus.loading,
        message: null,
      ),
    );

    final completer = Completer<DataGridResponseData<InventoryTask>>();
    _gridBloc.add(LoadDataEvent(pageIndex, completer: completer));

    try {
      final result = await completer.future;
      emit(
        state.copyWith(
          status: InventoryReceiveStatus.success,
          tasks: result.data,
          currentPage: pageIndex,
          totalPages: result.totalPages,
          total: _latestTotal,
          message: successMessage,
          filter: state.filter.copyWith(pageIndex: pageIndex),
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
