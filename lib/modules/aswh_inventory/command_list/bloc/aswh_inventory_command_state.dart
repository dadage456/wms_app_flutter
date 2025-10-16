import 'package:equatable/equatable.dart';

import '../models/inventory_command_models.dart';

enum AswhInventoryCommandStatus {
  initial,
  loading,
  success,
  failure,
  actionInProgress,
}

class AswhInventoryCommandState extends Equatable {
  const AswhInventoryCommandState({
    this.status = AswhInventoryCommandStatus.initial,
    this.commands = const [],
    this.selectedRows = const [],
    this.message,
    this.category = InventoryCommandCategory.inventory,
    this.taskComment,
    this.taskId,
    this.taskNo,
    this.taskType,
  });

  final AswhInventoryCommandStatus status;
  final List<InventoryWcsCommand> commands;
  final List<int> selectedRows;
  final String? message;
  final InventoryCommandCategory category;
  final String? taskComment;
  final String? taskId;
  final String? taskNo;
  final String? taskType;

  String get title =>
      category == InventoryCommandCategory.checkOrder ? '立库盘点采集结果' : '在线拣选采集结果';

  InventoryWcsCommand? get selectedCommand {
    if (selectedRows.isEmpty || selectedRows.first >= commands.length) {
      return null;
    }
    return commands[selectedRows.first];
  }

  AswhInventoryCommandState copyWith({
    AswhInventoryCommandStatus? status,
    List<InventoryWcsCommand>? commands,
    List<int>? selectedRows,
    String? message,
    bool clearMessage = false,
    InventoryCommandCategory? category,
    String? taskComment,
    String? taskId,
    String? taskNo,
    String? taskType,
  }) {
    return AswhInventoryCommandState(
      status: status ?? this.status,
      commands: commands ?? this.commands,
      selectedRows: selectedRows ?? this.selectedRows,
      message: clearMessage ? null : message ?? this.message,
      category: category ?? this.category,
      taskComment: taskComment ?? this.taskComment,
      taskId: taskId ?? this.taskId,
      taskNo: taskNo ?? this.taskNo,
      taskType: taskType ?? this.taskType,
    );
  }

  @override
  List<Object?> get props => [
        status,
        commands,
        selectedRows,
        message,
        category,
        taskComment,
        taskId,
        taskNo,
        taskType,
      ];
}
