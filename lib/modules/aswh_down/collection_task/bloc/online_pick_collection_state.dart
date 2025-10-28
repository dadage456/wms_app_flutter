import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

class OnlinePickCollectionState extends Equatable {
  const OnlinePickCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.taskItems = const <OnlinePickTaskItem>[],
    this.collectingItems = const <OnlinePickTaskItem>[],
    this.collectedStocks = const <OnlinePickCollectionStock>[],
    this.serialMap = const <String, String>{},
    this.materialQtyMap = const <String, List<double>>{},
    this.inventoryQtyMap = const <String, double>{},
    this.barcodeContent,
    this.pendingQuantity,
    this.currentMode = const OnlinePickCollectionMode(
      code: 'outbound',
      label: '正常出库',
      type: OnlinePickCollectionModeType.outbound,
    ),
    this.currentStep = OnlinePickCollectionStep.location,
    this.currentLocation = '',
    this.currentTray = '',
    this.placeholder = '请扫描库位',
    this.currentTab = 0,
    this.isScannerFocused = false,
    this.expectedErpStore,
  });

  final CollectionStatus status;
  final List<OnlinePickTaskItem> taskItems;
  final List<OnlinePickTaskItem> collectingItems;
  final List<OnlinePickCollectionStock> collectedStocks;
  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final OnlinePickBarcodeContent? barcodeContent;
  final num? pendingQuantity;
  final OnlinePickCollectionMode currentMode;
  final OnlinePickCollectionStep currentStep;
  final String currentLocation;
  final String currentTray;
  final String placeholder;
  final int currentTab;
  final bool isScannerFocused;
  final String? expectedErpStore;

  OnlinePickCollectionState copyWith({
    CollectionStatus? status,
    List<OnlinePickTaskItem>? taskItems,
    List<OnlinePickTaskItem>? collectingItems,
    List<OnlinePickCollectionStock>? collectedStocks,
    Map<String, String>? serialMap,
    Map<String, List<double>>? materialQtyMap,
    Map<String, double>? inventoryQtyMap,
    OnlinePickBarcodeContent? barcodeContent,
    bool clearBarcodeContent = false,
    num? pendingQuantity,
    bool clearPendingQuantity = false,
    OnlinePickCollectionMode? currentMode,
    OnlinePickCollectionStep? currentStep,
    String? currentLocation,
    String? currentTray,
    String? placeholder,
    int? currentTab,
    bool? isScannerFocused,
    String? expectedErpStore,
  }) {
    return OnlinePickCollectionState(
      status: status ?? this.status,
      taskItems: taskItems ?? this.taskItems,
      collectingItems: collectingItems ?? this.collectingItems,
      collectedStocks: collectedStocks ?? this.collectedStocks,
      serialMap: serialMap ?? this.serialMap,
      materialQtyMap: materialQtyMap ?? this.materialQtyMap,
      inventoryQtyMap: inventoryQtyMap ?? this.inventoryQtyMap,
      barcodeContent: clearBarcodeContent ? null : (barcodeContent ?? this.barcodeContent),
      pendingQuantity: clearPendingQuantity ? null : (pendingQuantity ?? this.pendingQuantity),
      currentMode: currentMode ?? this.currentMode,
      currentStep: currentStep ?? this.currentStep,
      currentLocation: currentLocation ?? this.currentLocation,
      currentTray: currentTray ?? this.currentTray,
      placeholder: placeholder ?? this.placeholder,
      currentTab: currentTab ?? this.currentTab,
      isScannerFocused: isScannerFocused ?? this.isScannerFocused,
      expectedErpStore: expectedErpStore ?? this.expectedErpStore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        taskItems,
        collectingItems,
        collectedStocks,
        serialMap,
        materialQtyMap,
        inventoryQtyMap,
        barcodeContent,
        pendingQuantity,
        currentMode,
        currentStep,
        currentLocation,
        currentTray,
        placeholder,
        currentTab,
        isScannerFocused,
        expectedErpStore,
      ];
}
