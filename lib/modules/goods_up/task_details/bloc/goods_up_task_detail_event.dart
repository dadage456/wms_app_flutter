import 'package:equatable/equatable.dart';

abstract class GoodsUpTaskDetailEvent extends Equatable {
  const GoodsUpTaskDetailEvent();

  @override
  List<Object?> get props => [];
}

class InitializedEvent extends GoodsUpTaskDetailEvent {
  const InitializedEvent({required this.inTaskId, required this.workStation});

  final int inTaskId;
  final String? workStation;

  @override
  List<Object?> get props => [inTaskId, workStation];
}

class SearchEvent extends GoodsUpTaskDetailEvent {
  const SearchEvent({required this.searchKey});

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class CancelSelectedEvent extends GoodsUpTaskDetailEvent {
  const CancelSelectedEvent({required this.selectedRows});

  final List<int> selectedRows;

  @override
  List<Object?> get props => [selectedRows];
}

class RefreshEvent extends GoodsUpTaskDetailEvent {
  const RefreshEvent();
}
