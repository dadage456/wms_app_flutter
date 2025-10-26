import 'package:equatable/equatable.dart';

abstract class AswhUpReceiveDetailEvent extends Equatable {
  const AswhUpReceiveDetailEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAswhUpReceiveDetailEvent extends AswhUpReceiveDetailEvent {
  final int taskId;
  final String? workStation;
  const InitializeAswhUpReceiveDetailEvent({
    required this.taskId,
    this.workStation,
  });

  @override
  List<Object?> get props => [taskId, workStation];
}

class SearchAswhUpReceiveDetailEvent extends AswhUpReceiveDetailEvent {
  const SearchAswhUpReceiveDetailEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class ReceiveSelectedAswhUpItemsEvent extends AswhUpReceiveDetailEvent {
  const ReceiveSelectedAswhUpItemsEvent(this.selectedRows);

  final List<int> selectedRows;

  @override
  List<Object?> get props => [selectedRows];
}

class RefreshAswhUpReceiveDetailEvent extends AswhUpReceiveDetailEvent {
  const RefreshAswhUpReceiveDetailEvent();
}
