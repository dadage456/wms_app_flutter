import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/inventory_task.dart';

part 'inventory_task_state.freezed.dart';

enum InventoryTaskListStatus { initial, loading, success, failure, actionInProgress }

@freezed
class InventoryTaskState with _$InventoryTaskState {
  const factory InventoryTaskState({
    @Default(InventoryTaskListStatus.initial) InventoryTaskListStatus status,
    @Default(InventoryTaskQuery(userId: '', roleOrUserId: ''))
    InventoryTaskQuery filter,
    @Default(<InventoryTask>[]) List<InventoryTask> tasks,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(0) int total,
    String? message,
  }) = _InventoryTaskState;
}
