import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/inventory_task.dart';

part 'aswh_inventory_task_list_state.freezed.dart';

/// 列表状态枚举
enum AswhTaskListStatus { initial, loading, success, failure, actionInProgress }

/// 立库盘点任务列表状态
@freezed
class AswhInventoryTaskListState with _$AswhInventoryTaskListState {
  const factory AswhInventoryTaskListState({
    @Default(AswhTaskListStatus.initial) AswhTaskListStatus status,
    required InventoryTaskFilter filter,
    @Default(<InventoryTaskSummary>[]) List<InventoryTaskSummary> tasks,
    @Default(0) int total,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    String? message,
  }) = _AswhInventoryTaskListState;
}
