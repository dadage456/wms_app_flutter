import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/inventory_command_models.dart';
import '../services/aswh_inventory_command_service.dart';
import 'aswh_inventory_command_event.dart';
import 'aswh_inventory_command_state.dart';

class AswhInventoryCommandBloc
    extends Bloc<AswhInventoryCommandEvent, AswhInventoryCommandState> {
  AswhInventoryCommandBloc({
    required AswhInventoryCommandService commandService,
  })  : _commandService = commandService,
        super(const AswhInventoryCommandState()) {
    on<AswhInventoryCommandStarted>(_onStarted);
    on<AswhInventoryCommandRefreshRequested>(_onRefreshRequested);
    on<AswhInventoryCommandSelectionChanged>(_onSelectionChanged);
    on<AswhInventoryCommandActionRequested>(_onActionRequested);
  }

  final AswhInventoryCommandService _commandService;

  Future<void> _onStarted(
    AswhInventoryCommandStarted event,
    Emitter<AswhInventoryCommandState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AswhInventoryCommandStatus.loading,
        category: event.category,
        taskComment: event.taskComment,
        taskId: event.taskId,
        taskNo: event.taskNo,
        taskType: event.taskType,
        clearMessage: true,
      ),
    );

    await _loadCommands(emit);
  }

  Future<void> _onRefreshRequested(
    AswhInventoryCommandRefreshRequested event,
    Emitter<AswhInventoryCommandState> emit,
  ) async {
    emit(state.copyWith(status: AswhInventoryCommandStatus.loading, clearMessage: true));
    await _loadCommands(emit);
  }

  void _onSelectionChanged(
    AswhInventoryCommandSelectionChanged event,
    Emitter<AswhInventoryCommandState> emit,
  ) {
    emit(state.copyWith(selectedRows: event.selectedRows, clearMessage: true));
  }

  Future<void> _onActionRequested(
    AswhInventoryCommandActionRequested event,
    Emitter<AswhInventoryCommandState> emit,
  ) async {
    final command = state.selectedCommand;
    if (command == null) {
      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.success,
          message: '请选择需要撤销的指令',
        ),
      );
      return;
    }

    final taskComment = state.taskComment;
    final taskNo = state.taskNo ?? command.taskNo ?? command.palletNo ?? '';
    if (taskComment == null || taskComment.isEmpty) {
      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.failure,
          message: '缺少任务参数，无法撤销指令',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AswhInventoryCommandStatus.actionInProgress,
        clearMessage: true,
      ),
    );

    try {
      await _commandService.revokeCommand(
        action: event.action,
        command: command,
        taskId: state.taskId,
        taskNo: taskNo,
      );

      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.success,
          message: '指令撤销成功',
        ),
      );

      await _loadCommands(emit, preserveMessage: true);
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.failure,
          message: '指令撤销失败：${error.toString()}',
        ),
      );
    }
  }

  Future<void> _loadCommands(
    Emitter<AswhInventoryCommandState> emit, {
    bool preserveMessage = false,
  }) async {
    final taskComment = state.taskComment;
    final taskType = state.taskType ??
        (state.category == InventoryCommandCategory.checkOrder ? '03' : '03');
    if (taskComment == null || taskComment.isEmpty) {
      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.failure,
          message: '缺少任务信息，无法加载指令列表',
        ),
      );
      return;
    }

    try {
      final commands = await _commandService.fetchCommands(
        taskComment: taskComment,
        taskId: state.taskId,
        taskType: taskType,
      );

      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.success,
          commands: commands,
          selectedRows: const [],
          clearMessage: preserveMessage ? false : true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhInventoryCommandStatus.failure,
          message: '指令列表加载失败：${error.toString()}',
        ),
      );
    }
  }
}
