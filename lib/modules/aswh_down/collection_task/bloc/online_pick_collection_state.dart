import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

enum OnlinePickSelectionSource { taskList, collectingList }

class OnlinePickCollectionState extends Equatable {
  const OnlinePickCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.taskItems = const <OnlinePickTaskItem>[],
    this.collectingItems = const <OnlinePickTaskItem>[],
    this.collectedStocks = const <OnlinePickCollectionStock>[],
    this.serialMap = const <String, String>{},
    this.materialQtyMap = const <String, List<double>>{},
    this.inventoryQtyMap = const <String, double>{},
    this.inventoryCheckDetails = const <OnlinePickInventoryCheckDetail>[],
    this.locationOptions = const <OnlinePickLocationOption>[],
    this.barcodeContent,
    this.pendingQuantity,
    this.currentMode = const OnlinePickCollectionMode(
      code: 'outbound',
      label: '正常出库',
      type: OnlinePickCollectionModeType.outbound,
    ),
    this.currentStep = OnlinePickCollectionStep.tray,
    this.currentLocation = '',
    this.currentTray = '',
    this.placeholder = '请扫描托盘',
    this.currentTab = 0,
    this.isScannerFocused = false,
    this.expectedErpStore,
    this.selectedDestination = '',
    this.isInventoryEntryPending = false,
    this.pendingInventoryDetail,
    this.selectedTaskItemId,
    this.selectedCollectingItemId,
    this.activeSelectionSource,
    this.dispatchedTrayNos = const <String>{},
  });

  final CollectionStatus status;
  final List<OnlinePickTaskItem> taskItems;
  final List<OnlinePickTaskItem> collectingItems;
  final List<OnlinePickCollectionStock> collectedStocks;
  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final List<OnlinePickInventoryCheckDetail> inventoryCheckDetails;
  final List<OnlinePickLocationOption> locationOptions;
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
  final String selectedDestination;
  final bool isInventoryEntryPending;
  final OnlinePickInventoryCheckDetail? pendingInventoryDetail;
  final int? selectedTaskItemId;
  final int? selectedCollectingItemId;
  final OnlinePickSelectionSource? activeSelectionSource;
  final Set<String> dispatchedTrayNos;

  OnlinePickCollectionState copyWith({
    CollectionStatus? status,
    List<OnlinePickTaskItem>? taskItems,
    List<OnlinePickTaskItem>? collectingItems,
    List<OnlinePickCollectionStock>? collectedStocks,
    Map<String, String>? serialMap,
    Map<String, List<double>>? materialQtyMap,
    Map<String, double>? inventoryQtyMap,
    List<OnlinePickInventoryCheckDetail>? inventoryCheckDetails,
    List<OnlinePickLocationOption>? locationOptions,
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
    String? selectedDestination,
    bool? isInventoryEntryPending,
    OnlinePickInventoryCheckDetail? pendingInventoryDetail,
    bool clearPendingInventoryDetail = false,
    int? selectedTaskItemId,
    bool clearSelectedTaskItem = false,
    int? selectedCollectingItemId,
    bool clearSelectedCollectingItem = false,
    OnlinePickSelectionSource? activeSelectionSource,
    bool clearActiveSelectionSource = false,
    Set<String>? dispatchedTrayNos,
  }) {
    return OnlinePickCollectionState(
      status: status ?? this.status,
      taskItems: taskItems ?? this.taskItems,
      collectingItems: collectingItems ?? this.collectingItems,
      collectedStocks: collectedStocks ?? this.collectedStocks,
      serialMap: serialMap ?? this.serialMap,
      materialQtyMap: materialQtyMap ?? this.materialQtyMap,
      inventoryQtyMap: inventoryQtyMap ?? this.inventoryQtyMap,
      inventoryCheckDetails:
          inventoryCheckDetails ?? this.inventoryCheckDetails,
      locationOptions: locationOptions ?? this.locationOptions,
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
      selectedDestination: selectedDestination ?? this.selectedDestination,
      isInventoryEntryPending:
          isInventoryEntryPending ?? this.isInventoryEntryPending,
      pendingInventoryDetail: clearPendingInventoryDetail
          ? null
          : (pendingInventoryDetail ?? this.pendingInventoryDetail),
      selectedTaskItemId: clearSelectedTaskItem
          ? null
          : (selectedTaskItemId ?? this.selectedTaskItemId),
      selectedCollectingItemId: clearSelectedCollectingItem
          ? null
          : (selectedCollectingItemId ?? this.selectedCollectingItemId),
      activeSelectionSource: clearActiveSelectionSource
          ? null
          : (activeSelectionSource ?? this.activeSelectionSource),
      dispatchedTrayNos: dispatchedTrayNos ?? this.dispatchedTrayNos,
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
        inventoryCheckDetails,
        locationOptions,
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
        selectedDestination,
        isInventoryEntryPending,
        pendingInventoryDetail,
        selectedTaskItemId,
        selectedCollectingItemId,
        activeSelectionSource,
        dispatchedTrayNos,
      ];
}
