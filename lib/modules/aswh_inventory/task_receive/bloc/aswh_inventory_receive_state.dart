import 'package:equatable/equatable.dart';

import '../../task_list/models/inventory_task.dart';

/// 页面状态枚举
enum InventoryReceiveStatus {
  initial,
  loading,
  success,
  failure,
  actionInProgress,
  actionSuccess,
}

/// 立库盘点接收页状态
class AswhInventoryReceiveState extends Equatable {
  const AswhInventoryReceiveState({
    this.status = InventoryReceiveStatus.initial,
    required this.filter,
    this.tasks = const <InventoryTaskSummary>[],
    this.selectedTask,
    this.currentPage = 1,
    this.totalPages = 1,
    this.total = 0,
    this.message,
  });

  final InventoryReceiveStatus status;
  final InventoryTaskFilter filter;
  final List<InventoryTaskSummary> tasks;
  final InventoryTaskSummary? selectedTask;
  final int currentPage;
  final int totalPages;
  final int total;
  final String? message;

  AswhInventoryReceiveState copyWith({
    InventoryReceiveStatus? status,
    InventoryTaskFilter? filter,
    List<InventoryTaskSummary>? tasks,
    InventoryTaskSummary? selectedTask,
    bool clearSelectedTask = false,
    int? currentPage,
    int? totalPages,
    int? total,
    String? message,
    bool clearMessage = false,
  }) {
    return AswhInventoryReceiveState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      tasks: tasks ?? this.tasks,
      selectedTask:
          clearSelectedTask ? null : (selectedTask ?? this.selectedTask),
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
        status,
        filter,
        tasks,
        selectedTask,
        currentPage,
        totalPages,
        total,
        message,
      ];
}
