import 'package:freezed_annotation/freezed_annotation.dart';

import '../../task_list/models/inventory_task.dart';

part 'inventory_receive_state.freezed.dart';

enum InventoryReceiveStatus { initial, loading, success, failure, actionInProgress }

@freezed
class InventoryReceiveState with _$InventoryReceiveState {
  const factory InventoryReceiveState({
    @Default(InventoryReceiveStatus.initial) InventoryReceiveStatus status,
    @Default(InventoryTaskQuery(userId: 'ALL', roleOrUserId: 'ALL'))
    InventoryTaskQuery filter,
    @Default(<InventoryTask>[]) List<InventoryTask> tasks,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(0) int total,
    String? message,
  }) = _InventoryReceiveState;
}
