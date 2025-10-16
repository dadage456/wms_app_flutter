import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

abstract class OnlinePickCollectionEvent extends Equatable {
  const OnlinePickCollectionEvent();

  @override
  List<Object?> get props => [];
}

class OnlinePickCollectionStarted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStarted(this.payload);

  final Map<String, dynamic> payload;

  @override
  List<Object?> get props => [payload];
}

class OnlinePickCollectionSubmitPressed extends OnlinePickCollectionEvent {
  const OnlinePickCollectionSubmitPressed();
}

class OnlinePickCollectionScanSubmitted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionScanSubmitted(this.content);

  final String content;

  @override
  List<Object?> get props => [content];
}

class OnlinePickCollectionStepResetRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStepResetRequested();
}

class OnlinePickCollectionLocationSelected
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionLocationSelected(this.locationCode);

  final String locationCode;

  @override
  List<Object?> get props => [locationCode];
}

class OnlinePickCollectionCacheCleared extends OnlinePickCollectionEvent {
  const OnlinePickCollectionCacheCleared();
}

class OnlinePickCollectionModeChanged extends OnlinePickCollectionEvent {
  const OnlinePickCollectionModeChanged(this.mode);

  final OnlinePickCollectionModeType mode;

  @override
  List<Object?> get props => [mode];
}

enum OnlinePickCommandType {
  downShelf,
  inventoryDownShelf,
  emptyTray,
  reset,
  inventoryReset,
}

class OnlinePickCollectionCommandSubmitted
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionCommandSubmitted({
    required this.commandType,
    required this.startAddress,
    required this.endAddress,
    this.trayNo,
    this.singleFlag = 'N',
  });

  final OnlinePickCommandType commandType;
  final String startAddress;
  final String endAddress;
  final String? trayNo;
  final String singleFlag;

  @override
  List<Object?> get props =>
      [commandType, startAddress, endAddress, trayNo, singleFlag];
}

class OnlinePickCollectionReloadRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionReloadRequested();
}

class OnlinePickCollectionStocksSynced extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStocksSynced(this.stocks);

  /// List of serialized [OnlinePickCollectionStock] maps.
  final List<Map<String, dynamic>> stocks;

  @override
  List<Object?> get props => [stocks];
}
