import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/aswh_up_wcs_instruction.dart';
import '../../services/aswh_up_task_service.dart';

class AswhUpWcsInstructionState extends Equatable {
  const AswhUpWcsInstructionState({
    required this.taskComment,
    required this.taskId,
    required this.taskType,
    this.instructions = const <AswhUpWcsInstruction>[],
    this.isLoading = false,
    this.errorMessage,
  });

  final String taskComment;
  final int taskId;
  final String taskType;
  final List<AswhUpWcsInstruction> instructions;
  final bool isLoading;
  final String? errorMessage;

  AswhUpWcsInstructionState copyWith({
    bool? isLoading,
    List<AswhUpWcsInstruction>? instructions,
    String? errorMessage,
  }) {
    return AswhUpWcsInstructionState(
      taskComment: taskComment,
      taskId: taskId,
      taskType: taskType,
      instructions: instructions ?? this.instructions,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        taskComment,
        taskId,
        taskType,
        instructions,
        isLoading,
        errorMessage,
      ];
}

class AswhUpWcsInstructionCubit extends Cubit<AswhUpWcsInstructionState> {
  AswhUpWcsInstructionCubit({
    required AswhUpTaskService service,
    required String taskComment,
    required int taskId,
    required String taskType,
  })  : _service = service,
        super(
          AswhUpWcsInstructionState(
            taskComment: taskComment,
            taskId: taskId,
            taskType: taskType,
          ),
        );

  final AswhUpTaskService _service;

  Future<void> load({String? queryStr}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final result = await _service.getWmsToWcsByTaskID(
        taskComment: state.taskComment,
        taskId: state.taskId,
        taskType: state.taskType,
        queryStr: queryStr,
      );
      emit(state.copyWith(isLoading: false, instructions: result));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
