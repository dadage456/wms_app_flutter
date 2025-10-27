import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

abstract class OnlinePickCollectionEvent extends Equatable {
  const OnlinePickCollectionEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCollectionEvent extends OnlinePickCollectionEvent {
  final OnlinePickTask task;
  final int userId;

  const InitializeCollectionEvent({required this.task, required this.userId});

  @override
  List<Object?> get props => [task, userId];
}

class PerformScanEvent extends OnlinePickCollectionEvent {
  final String barcode;

  const PerformScanEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class ChangeCollectionTabEvent extends OnlinePickCollectionEvent {
  final int index;

  const ChangeCollectionTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateSelectionEvent extends OnlinePickCollectionEvent {
  final List<int> selectedItemIds;

  const UpdateSelectionEvent(this.selectedItemIds);

  @override
  List<Object?> get props => [selectedItemIds];
}

class ResetCollectionStatusEvent extends OnlinePickCollectionEvent {
  const ResetCollectionStatusEvent();
}

class SetCollectionFocusEvent extends OnlinePickCollectionEvent {
  final bool focus;

  const SetCollectionFocusEvent(this.focus);

  @override
  List<Object?> get props => [focus];
}

class DeleteCollectedStocksEvent extends OnlinePickCollectionEvent {
  final List<String> stockIds;

  const DeleteCollectedStocksEvent(this.stockIds);

  @override
  List<Object?> get props => [stockIds];
}

class SubmitCollectionEvent extends OnlinePickCollectionEvent {
  const SubmitCollectionEvent();
}

class LoadPickLocationsEvent extends OnlinePickCollectionEvent {
  const LoadPickLocationsEvent();
}

class SelectPickLocationEvent extends OnlinePickCollectionEvent {
  final String location;

  const SelectPickLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}

class ChangeCollectionModeEvent extends OnlinePickCollectionEvent {
  final OnlinePickCollectionModeType mode;

  const ChangeCollectionModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}

class RequestEmptyTrayOutEvent extends OnlinePickCollectionEvent {
  const RequestEmptyTrayOutEvent();
}

class RequestEmptyTrayInEvent extends OnlinePickCollectionEvent {
  const RequestEmptyTrayInEvent();
}

class RequestSingleTrayEvent extends OnlinePickCollectionEvent {
  const RequestSingleTrayEvent();
}

class RequestReturnTrayEvent extends OnlinePickCollectionEvent {
  const RequestReturnTrayEvent();
}

class RequestAllTrayEvent extends OnlinePickCollectionEvent {
  final int count;

  const RequestAllTrayEvent(this.count);

  @override
  List<Object?> get props => [count];
}

class PersistCollectionCacheEvent extends OnlinePickCollectionEvent {
  const PersistCollectionCacheEvent();
}
