import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/utils/online_pick_scanner_parser.dart';

class OnlinePickCollectionState extends Equatable {
  static const Object _unset = Object();

  const OnlinePickCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.currentStepLabel = '',
    this.task,
    this.currentLocation,
    this.currentTrayNo,
    this.barcodeContent,
    this.pendingQuantity,
    this.nextExpectedScanType = OnlinePickScanType.location,
    this.focusSequence = 0,
    this.scannerPlaceholder = '请扫描库位',
    this.locationOptions = const [],
    this.collectedStocks = const [],
    this.serialMap = const {},
    this.materialQtyMap = const {},
    this.inventoryQtyMap = const {},
    this.expectedErpStore = '',
    this.currentMode = OnlinePickCollectionModeType.outbound,
    this.taskItems = const [],
    this.collectedQtyByItemId = const {},
    this.inventoryRecords = const [],
    this.roomMatControl = '0',
    this.forceSiteCheck = false,
    this.forceBatchCheck = false,
    this.materialControls = const {},
    this.currentMaterialControl,
  });

  final CollectionStatus status;
  final String currentStepLabel;
  final OnlinePickTask? task;
  final String? currentLocation;
  final String? currentTrayNo;
  final OnlinePickBarcodeContent? barcodeContent;
  final num? pendingQuantity;
  final OnlinePickScanType nextExpectedScanType;
  final int focusSequence;
  final String scannerPlaceholder;
  final List<OnlinePickLocationOption> locationOptions;
  final List<OnlinePickCollectionStock> collectedStocks;
  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final String expectedErpStore;
  final OnlinePickCollectionModeType currentMode;
  final List<OnlinePickTaskItem> taskItems;
  final Map<String, double> collectedQtyByItemId;
  final List<OnlinePickInventoryRecord> inventoryRecords;
  final String roomMatControl;
  final bool forceSiteCheck;
  final bool forceBatchCheck;
  final Map<String, OnlinePickMaterialControl> materialControls;
  final OnlinePickMaterialControl? currentMaterialControl;

  OnlinePickCollectionState copyWith({
    CollectionStatus? status,
    String? currentStepLabel,
    Object? task = _unset,
    Object? currentLocation = _unset,
    Object? currentTrayNo = _unset,
    Object? barcodeContent = _unset,
    Object? pendingQuantity = _unset,
    OnlinePickScanType? nextExpectedScanType,
    int? focusSequence,
    String? scannerPlaceholder,
    List<OnlinePickLocationOption>? locationOptions,
    List<OnlinePickCollectionStock>? collectedStocks,
    Map<String, String>? serialMap,
    Map<String, List<double>>? materialQtyMap,
    Map<String, double>? inventoryQtyMap,
    String? expectedErpStore,
    OnlinePickCollectionModeType? currentMode,
    List<OnlinePickTaskItem>? taskItems,
    Map<String, double>? collectedQtyByItemId,
    List<OnlinePickInventoryRecord>? inventoryRecords,
    String? roomMatControl,
    bool? forceSiteCheck,
    bool? forceBatchCheck,
    Map<String, OnlinePickMaterialControl>? materialControls,
    Object? currentMaterialControl = _unset,
  }) {
    return OnlinePickCollectionState(
      status: status ?? this.status,
      currentStepLabel: currentStepLabel ?? this.currentStepLabel,
      task: task == _unset ? this.task : task as OnlinePickTask?,
      currentLocation: currentLocation == _unset
          ? this.currentLocation
          : currentLocation as String?,
      currentTrayNo: currentTrayNo == _unset
          ? this.currentTrayNo
          : currentTrayNo as String?,
      barcodeContent: barcodeContent == _unset
          ? this.barcodeContent
          : barcodeContent as OnlinePickBarcodeContent?,
      pendingQuantity: pendingQuantity == _unset
          ? this.pendingQuantity
          : pendingQuantity as num?,
      nextExpectedScanType:
          nextExpectedScanType ?? this.nextExpectedScanType,
      focusSequence: focusSequence ?? this.focusSequence,
      scannerPlaceholder: scannerPlaceholder ?? this.scannerPlaceholder,
      locationOptions: locationOptions ?? this.locationOptions,
      collectedStocks: collectedStocks ?? this.collectedStocks,
      serialMap: serialMap ?? this.serialMap,
      materialQtyMap: materialQtyMap ?? this.materialQtyMap,
      inventoryQtyMap: inventoryQtyMap ?? this.inventoryQtyMap,
      expectedErpStore: expectedErpStore ?? this.expectedErpStore,
      currentMode: currentMode ?? this.currentMode,
      taskItems: taskItems ?? this.taskItems,
      collectedQtyByItemId:
          collectedQtyByItemId ?? this.collectedQtyByItemId,
      inventoryRecords: inventoryRecords ?? this.inventoryRecords,
      roomMatControl: roomMatControl ?? this.roomMatControl,
      forceSiteCheck: forceSiteCheck ?? this.forceSiteCheck,
      forceBatchCheck: forceBatchCheck ?? this.forceBatchCheck,
      materialControls: materialControls ?? this.materialControls,
      currentMaterialControl: currentMaterialControl == _unset
          ? this.currentMaterialControl
          : currentMaterialControl as OnlinePickMaterialControl?,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentStepLabel,
        task,
        currentLocation,
        currentTrayNo,
        barcodeContent,
        pendingQuantity,
        nextExpectedScanType,
        focusSequence,
        scannerPlaceholder,
        locationOptions,
        collectedStocks,
        serialMap,
        materialQtyMap,
        inventoryQtyMap,
        expectedErpStore,
        currentMode,
        taskItems,
        collectedQtyByItemId,
        inventoryRecords,
        roomMatControl,
        forceSiteCheck,
        forceBatchCheck,
        materialControls,
        currentMaterialControl,
      ];
}
