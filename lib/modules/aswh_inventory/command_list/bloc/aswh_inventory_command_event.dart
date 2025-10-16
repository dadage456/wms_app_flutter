import 'package:equatable/equatable.dart';

import '../models/inventory_command_models.dart';

abstract class AswhInventoryCommandEvent extends Equatable {
  const AswhInventoryCommandEvent();

  @override
  List<Object?> get props => [];
}

class AswhInventoryCommandStarted extends AswhInventoryCommandEvent {
  const AswhInventoryCommandStarted({
    required this.taskComment,
    this.taskId,
    this.taskNo,
    this.taskType,
    this.category = InventoryCommandCategory.inventory,
  });

  final String taskComment;
  final String? taskId;
  final String? taskNo;
  final String? taskType;
  final InventoryCommandCategory category;

  @override
  List<Object?> get props => [taskComment, taskId, taskNo, taskType, category];
}

class AswhInventoryCommandRefreshRequested extends AswhInventoryCommandEvent {
  const AswhInventoryCommandRefreshRequested();
}

class AswhInventoryCommandSelectionChanged extends AswhInventoryCommandEvent {
  const AswhInventoryCommandSelectionChanged(this.selectedRows);

  final List<int> selectedRows;

  @override
  List<Object?> get props => [selectedRows];
}

class AswhInventoryCommandActionRequested extends AswhInventoryCommandEvent {
  const AswhInventoryCommandActionRequested(this.action);

  final InventoryCommandAction action;

  @override
  List<Object?> get props => [action];
}
