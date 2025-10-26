import 'package:equatable/equatable.dart';

abstract class AswhUpTaskDetailEvent extends Equatable {
  const AswhUpTaskDetailEvent();

  @override
  List<Object?> get props => [];
}

class AswhUpTaskDetailInitialized extends AswhUpTaskDetailEvent {
  const AswhUpTaskDetailInitialized({required this.taskId, this.workStation});

  final int taskId;
  final String? workStation;

  @override
  List<Object?> get props => [taskId, workStation];
}

class AswhUpTaskDetailSearchRequested extends AswhUpTaskDetailEvent {
  const AswhUpTaskDetailSearchRequested({required this.searchKey});

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class AswhUpTaskDetailDeleteSelected extends AswhUpTaskDetailEvent {
  const AswhUpTaskDetailDeleteSelected({required this.selectedRows});

  final List<int> selectedRows;

  @override
  List<Object?> get props => [selectedRows];
}

class AswhUpTaskDetailRefreshRequested extends AswhUpTaskDetailEvent {
  const AswhUpTaskDetailRefreshRequested();
}
