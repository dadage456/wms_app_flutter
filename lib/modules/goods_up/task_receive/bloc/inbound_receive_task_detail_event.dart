import 'package:equatable/equatable.dart';

abstract class InboundReceiveTaskDetailEvent extends Equatable {
  const InboundReceiveTaskDetailEvent();

  @override
  List<Object?> get props => [];
}

class SearchInboundReceiveTaskItemsEvent
    extends InboundReceiveTaskDetailEvent {
  const SearchInboundReceiveTaskItemsEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class ReceiveSelectedInboundItemsEvent
    extends InboundReceiveTaskDetailEvent {
  const ReceiveSelectedInboundItemsEvent(this.selectedRows);

  final List<int> selectedRows;

  @override
  List<Object?> get props => [selectedRows];
}

class RefreshInboundReceiveTaskItemsEvent
    extends InboundReceiveTaskDetailEvent {
  const RefreshInboundReceiveTaskItemsEvent();
}
