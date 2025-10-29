import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';

class OnlinePickInventoryPrompt extends Equatable {
  const OnlinePickInventoryPrompt({
    required this.materialCode,
    this.storeSite = '',
    this.trayNo = '',
  });

  final String materialCode;
  final String storeSite;
  final String trayNo;

  @override
  List<Object?> get props => [materialCode, storeSite, trayNo];
}

/// 提交接口通道枚举。
enum OnlinePickSubmissionChannel {
  /// 自动化立库下架（CommitASWHDownShelves）。
  aswh,

  /// 平库/常规下架（commitDownShelves）。
  standard,

  /// 整托托盘下架（commitTrayDownShelves）。
  tray,
}

extension OnlinePickSubmissionChannelX on OnlinePickSubmissionChannel {
  String get label {
    switch (this) {
      case OnlinePickSubmissionChannel.aswh:
        return 'ASWH 下架';
      case OnlinePickSubmissionChannel.standard:
        return '平库下架';
      case OnlinePickSubmissionChannel.tray:
        return '整托下架';
    }
  }
}

class OnlinePickCollectionState extends Equatable {
  const OnlinePickCollectionState({
    required this.task,
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.detailList = const [],
    this.collectingList = const [],
    this.collectedStocks = const [],
    this.barcodeContent,
    this.currentItem,
    this.location = '',
    this.trayNo = '',
    this.expectedErpStore = '',
    this.mode = OnlinePickCollectionModeType.outbound,
    this.step = OnlinePickCollectionStep.location,
    this.serialMap = const {},
    this.materialQtyMap = const {},
    this.inventoryQtyMap = const {},
    this.pendingQuantity,
    this.currentTab = 0,
    this.placeholder = '请扫描库位条码',
    this.focus = false,
    this.selectedDetailIds = const [],
    this.wcsCommands = const [],
    this.availableModes = const [
      OnlinePickCollectionMode(code: 'outbound', label: '正常采集'),
      OnlinePickCollectionMode(code: 'inventory', label: '库存核对', type: OnlinePickCollectionModeType.inventory),
      OnlinePickCollectionMode(code: 'exception', label: '异常补录', type: OnlinePickCollectionModeType.exception),
    ],
    this.locationOptions = const [],
    this.selectedLocation,
    this.requestedPallets = const [],
    this.submitChannel = OnlinePickSubmissionChannel.aswh,
    this.inventoryChecks = const [],
    this.pendingInventoryPrompt,
    this.roomMatControl = '0',
  });

  factory OnlinePickCollectionState.initial(
    OnlinePickTask task, {
    OnlinePickSubmissionChannel submitChannel =
        OnlinePickSubmissionChannel.aswh,
  }) {
    return OnlinePickCollectionState(
      task: task,
      submitChannel: submitChannel,
    );
  }

  final OnlinePickTask task;
  final CollectionStatus status;
  final List<OnlinePickTaskItem> detailList;
  final List<OnlinePickTaskItem> collectingList;
  final List<OnlinePickCollectionStock> collectedStocks;
  final OnlinePickBarcodeContent? barcodeContent;
  final OnlinePickTaskItem? currentItem;
  final String location;
  final String trayNo;
  final String expectedErpStore;
  final OnlinePickCollectionModeType mode;
  final OnlinePickCollectionStep step;
  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final num? pendingQuantity;
  final int currentTab;
  final String placeholder;
  final bool focus;
  final List<int> selectedDetailIds;
  final List<OnlinePickWcsCommand> wcsCommands;
  final List<OnlinePickCollectionMode> availableModes;
  final List<OnlinePickLocationOption> locationOptions;
  final OnlinePickLocationOption? selectedLocation;
  final List<String> requestedPallets;
  final OnlinePickSubmissionChannel submitChannel;
  final List<OnlinePickInventoryCheck> inventoryChecks;
  final OnlinePickInventoryPrompt? pendingInventoryPrompt;
  final String roomMatControl;

  OnlinePickCollectionState copyWith({
    CollectionStatus? status,
    List<OnlinePickTaskItem>? detailList,
    List<OnlinePickTaskItem>? collectingList,
    List<OnlinePickCollectionStock>? collectedStocks,
    OnlinePickBarcodeContent? barcodeContent,
    OnlinePickTaskItem? currentItem,
    String? location,
    String? trayNo,
    String? expectedErpStore,
    OnlinePickCollectionModeType? mode,
    OnlinePickCollectionStep? step,
    Map<String, String>? serialMap,
    Map<String, List<double>>? materialQtyMap,
    Map<String, double>? inventoryQtyMap,
    num? pendingQuantity,
    int? currentTab,
    String? placeholder,
    bool? focus,
    List<int>? selectedDetailIds,
    List<OnlinePickWcsCommand>? wcsCommands,
    List<OnlinePickCollectionMode>? availableModes,
    List<OnlinePickLocationOption>? locationOptions,
    OnlinePickLocationOption? selectedLocation,
    List<String>? requestedPallets,
    OnlinePickSubmissionChannel? submitChannel,
    List<OnlinePickInventoryCheck>? inventoryChecks,
    OnlinePickInventoryPrompt? pendingInventoryPrompt,
    String? roomMatControl,
    bool clearBarcode = false,
    bool clearCurrentItem = false,
    bool clearPendingQuantity = false,
    bool clearPendingInventoryPrompt = false,
  }) {
    return OnlinePickCollectionState(
      task: task,
      status: status ?? this.status,
      detailList: detailList ?? this.detailList,
      collectingList: collectingList ?? this.collectingList,
      collectedStocks: collectedStocks ?? this.collectedStocks,
      barcodeContent: clearBarcode ? null : barcodeContent ?? this.barcodeContent,
      currentItem: clearCurrentItem ? null : currentItem ?? this.currentItem,
      location: location ?? this.location,
      trayNo: trayNo ?? this.trayNo,
      expectedErpStore: expectedErpStore ?? this.expectedErpStore,
      mode: mode ?? this.mode,
      step: step ?? this.step,
      serialMap: serialMap ?? this.serialMap,
      materialQtyMap: materialQtyMap ?? this.materialQtyMap,
      inventoryQtyMap: inventoryQtyMap ?? this.inventoryQtyMap,
      pendingQuantity:
          clearPendingQuantity ? null : pendingQuantity ?? this.pendingQuantity,
      currentTab: currentTab ?? this.currentTab,
      placeholder: placeholder ?? this.placeholder,
      focus: focus ?? this.focus,
      selectedDetailIds: selectedDetailIds ?? this.selectedDetailIds,
      wcsCommands: wcsCommands ?? this.wcsCommands,
      availableModes: availableModes ?? this.availableModes,
      locationOptions: locationOptions ?? this.locationOptions,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      requestedPallets: requestedPallets ?? this.requestedPallets,
      submitChannel: submitChannel ?? this.submitChannel,
      inventoryChecks: inventoryChecks ?? this.inventoryChecks,
      pendingInventoryPrompt: clearPendingInventoryPrompt
          ? null
          : pendingInventoryPrompt ?? this.pendingInventoryPrompt,
      roomMatControl: roomMatControl ?? this.roomMatControl,
    );
  }

  @override
  List<Object?> get props => [
        task,
        status,
        detailList,
        collectingList,
        collectedStocks,
        barcodeContent,
        currentItem,
        location,
        trayNo,
        expectedErpStore,
        mode,
        step,
        serialMap,
        materialQtyMap,
        inventoryQtyMap,
        pendingQuantity,
        currentTab,
        placeholder,
        focus,
        selectedDetailIds,
        wcsCommands,
        availableModes,
        locationOptions,
        selectedLocation,
        requestedPallets,
        submitChannel,
        inventoryChecks,
        pendingInventoryPrompt,
        roomMatControl,
      ];
}
