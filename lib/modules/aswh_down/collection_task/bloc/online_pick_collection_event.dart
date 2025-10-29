import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

abstract class OnlinePickCollectionEvent extends Equatable {
  const OnlinePickCollectionEvent();

  @override
  List<Object?> get props => [];
}

class OnlinePickCollectionStarted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStarted({this.restoreCache = true});

  final bool restoreCache;

  @override
  List<Object?> get props => [restoreCache];
}

class OnlinePickCollectionScanPerformed extends OnlinePickCollectionEvent {
  const OnlinePickCollectionScanPerformed(this.rawValue);

  final String rawValue;

  @override
  List<Object?> get props => [rawValue];
}

class OnlinePickCollectionQuantitySubmitted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionQuantitySubmitted(this.quantity);

  final num quantity;

  @override
  List<Object?> get props => [quantity];
}

class OnlinePickCollectionStocksSynced extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStocksSynced(this.payload);

  final List<Map<String, dynamic>> payload;

  @override
  List<Object?> get props => [payload];
}

class OnlinePickCollectionResetStatus extends OnlinePickCollectionEvent {
  const OnlinePickCollectionResetStatus();
}

class OnlinePickCollectionChangeTab extends OnlinePickCollectionEvent {
  const OnlinePickCollectionChangeTab(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class OnlinePickCollectionSelectionChanged extends OnlinePickCollectionEvent {
  const OnlinePickCollectionSelectionChanged(this.selectedItems);

  final List<OnlinePickTaskItem> selectedItems;

  @override
  List<Object?> get props => [selectedItems];
}

class OnlinePickCollectionFocusRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionFocusRequested(this.focus);

  final bool focus;

  @override
  List<Object?> get props => [focus];
}

class OnlinePickCollectionDeleteStocksRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionDeleteStocksRequested(this.stockIds);

  final List<String> stockIds;

  @override
  List<Object?> get props => [stockIds];
}

class OnlinePickCollectionResultRemoved extends OnlinePickCollectionEvent {
  const OnlinePickCollectionResultRemoved(this.removedStocks);

  final List<OnlinePickCollectionStock> removedStocks;

  @override
  List<Object?> get props => [removedStocks];
}

class OnlinePickCollectionDetailsRefreshRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionDetailsRefreshRequested({
    this.showLoading = false,
    this.successMessage,
  });

  final bool showLoading;
  final String? successMessage;

  @override
  List<Object?> get props => [showLoading, successMessage];
}

class OnlinePickCollectionSubmitRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionSubmitRequested();
}

class OnlinePickCollectionCacheCleared extends OnlinePickCollectionEvent {
  const OnlinePickCollectionCacheCleared();
}

class OnlinePickCollectionModeChanged extends OnlinePickCollectionEvent {
  const OnlinePickCollectionModeChanged(this.mode);

  final OnlinePickCollectionMode mode;

  @override
  List<Object?> get props => [mode];
}

class OnlinePickCollectionLocationSelected extends OnlinePickCollectionEvent {
  const OnlinePickCollectionLocationSelected(this.location);

  final OnlinePickLocationOption location;

  @override
  List<Object?> get props => [location];
}

class OnlinePickCollectionPalletsCallRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionPalletsCallRequested(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}

class OnlinePickCollectionExceptionSubmitted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionExceptionSubmitted(this.submission);

  final OnlinePickExceptionSubmission submission;

  @override
  List<Object?> get props => [submission];
}

class OnlinePickCollectionEmptyTrayOutboundRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionEmptyTrayOutboundRequested();
}

class OnlinePickCollectionTrayReturnRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionTrayReturnRequested();
}

class OnlinePickCollectionInventoryCheckSubmitted
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionInventoryCheckSubmitted(this.quantity);

  final num quantity;

  @override
  List<Object?> get props => [quantity];
}

class OnlinePickCollectionEmptyTrayInboundRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionEmptyTrayInboundRequested();
}

class OnlinePickCollectionSingleTrayRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionSingleTrayRequested();
}
