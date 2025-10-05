import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class InitializeTaskEvent extends CollectionEvent {
  final OutboundTask task;

  final int userId;

  const InitializeTaskEvent(this.task, this.userId);

  @override
  List<Object> get props => [task];
}

class PerformBarcodeEvent extends CollectionEvent {
  final String barcode;

  const PerformBarcodeEvent(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class ChangeTabEvent extends CollectionEvent {
  final int index;

  const ChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}

class ChangedSelectionEvent extends CollectionEvent {
  final List<String> ids;

  const ChangedSelectionEvent(this.ids);

  @override
  List<Object> get props => [ids];
}

class ToggleItemSelectionEvent extends CollectionEvent {
  final String itemId;
  final bool selected;

  const ToggleItemSelectionEvent(this.itemId, this.selected);

  @override
  List<Object> get props => [itemId, selected];
}

class ToggleAllSelectionEvent extends CollectionEvent {
  final bool selected;

  const ToggleAllSelectionEvent(this.selected);

  @override
  List<Object> get props => [selected];
}

class CommitCollectionEvent extends CollectionEvent {
  const CommitCollectionEvent();
}

class ReportShortageEvent extends CollectionEvent {
  const ReportShortageEvent();
}

class ResetStatusEvent extends CollectionEvent {
  const ResetStatusEvent();
}

class SetFocusEvent extends CollectionEvent {
  final bool focus;

  const SetFocusEvent(this.focus);

  @override
  List<Object> get props => [focus];
}

class DeleteCollectedStocksEvent extends CollectionEvent {
  final List<String> stockIds;

  const DeleteCollectedStocksEvent(this.stockIds);

  @override
  List<Object> get props => [stockIds];
}

class UpdateFromResultEvent extends CollectionEvent {
  final List<CollectionStock>
  deletedStocks; // accept dynamic to avoid import loop; cast in Bloc

  const UpdateFromResultEvent(this.deletedStocks);

  @override
  List<Object> get props => [deletedStocks];
}
