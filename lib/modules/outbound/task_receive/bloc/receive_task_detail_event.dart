import 'package:equatable/equatable.dart';

abstract class ReceiveTaskDetailEvent extends Equatable {
  const ReceiveTaskDetailEvent();

  @override
  List<Object?> get props => [];
}

class SearchReceiveTaskItemsEvent extends ReceiveTaskDetailEvent {
  final String searchKey;

  const SearchReceiveTaskItemsEvent(this.searchKey);

  @override
  List<Object?> get props => [searchKey];
}

class ReceiveSelectedItemsEvent extends ReceiveTaskDetailEvent {
  final List<int> selectedRows;

  const ReceiveSelectedItemsEvent(this.selectedRows);

  @override
  List<Object?> get props => [selectedRows];
}

class RefreshReceiveTaskItemsEvent extends ReceiveTaskDetailEvent {
  const RefreshReceiveTaskItemsEvent();

  @override
  List<Object?> get props => [];
}
