part of 'aswh_up_collection_bloc.dart';

enum AswhUpCollectionScanStep { tray, material, quantity }

class AswhUpCollectionState extends Equatable {
  const AswhUpCollectionState({
    required this.task,
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.detailList = const [],
    this.visibleDetails = const [],
    this.stocks = const [],
    this.currentBarcode,
    this.currentItem,
    this.trayNo = '',
    this.storeSite = '',
    this.trayCapacity = 0,
    this.trayUsed = 0,
    this.trayMaxWeight = 0,
    this.trayCurrentWeight = 0,
    this.placeholder = '请扫描托盘条码',
    this.scanStep = AswhUpCollectionScanStep.tray,
    this.currentTab = 0,
    this.selectedDetailIds = const [],
    this.collectedByItem = const {},
    this.serialRecord = const {},
    this.dicMtlQty = const {},
    this.capacityUsageByStock = const {},
    this.weightUsageByStock = const {},
    this.currentMaterialCapacity = 0,
    this.currentMaterialWeight = 0,
    this.shouldCheckBatch = true,
    this.shouldCheckSupplier = false,
    this.restrictMaterialMixing = true,
    this.trayMaterialKey,
    this.pendingTrayNo,
    this.showTrayChangeDialog = false,
    this.focus = false,
    this.message,
  });

  factory AswhUpCollectionState.initial(AswhUpTask task) {
    return AswhUpCollectionState(task: task);
  }

  final AswhUpTask task;
  final CollectionStatus status;
  final List<AswhUpTaskDetailItem> detailList;
  final List<AswhUpTaskDetailItem> visibleDetails;
  final List<AswhUpCollectionStock> stocks;
  final AswhUpBarcodeContent? currentBarcode;
  final AswhUpTaskDetailItem? currentItem;
  final String trayNo;
  final String storeSite;
  final double trayCapacity;
  final double trayUsed;
  final double trayMaxWeight;
  final double trayCurrentWeight;
  final String placeholder;
  final AswhUpCollectionScanStep scanStep;
  final int currentTab;
  final List<int> selectedDetailIds;
  final Map<int, double> collectedByItem;
  final Map<int, Set<String>> serialRecord;
  final Map<int, List<dynamic>> dicMtlQty;
  final Map<String, double> capacityUsageByStock;
  final Map<String, double> weightUsageByStock;
  final double currentMaterialCapacity;
  final double currentMaterialWeight;
  final bool shouldCheckBatch;
  final bool shouldCheckSupplier;
  final bool restrictMaterialMixing;
  final String? trayMaterialKey;
  final String? pendingTrayNo;
  final bool showTrayChangeDialog;
  final bool focus;
  final String? message;

  AswhUpCollectionState copyWith({
    CollectionStatus? status,
    List<AswhUpTaskDetailItem>? detailList,
    List<AswhUpTaskDetailItem>? visibleDetails,
    List<AswhUpCollectionStock>? stocks,
    AswhUpBarcodeContent? currentBarcode,
    AswhUpTaskDetailItem? currentItem,
    String? trayNo,
    String? storeSite,
    double? trayCapacity,
    double? trayUsed,
    double? trayMaxWeight,
    double? trayCurrentWeight,
    String? placeholder,
    AswhUpCollectionScanStep? scanStep,
    int? currentTab,
    List<int>? selectedDetailIds,
    Map<int, double>? collectedByItem,
    Map<int, Set<String>>? serialRecord,
    Map<int, List<dynamic>>? dicMtlQty,
    Map<String, double>? capacityUsageByStock,
    Map<String, double>? weightUsageByStock,
    double? currentMaterialCapacity,
    double? currentMaterialWeight,
    bool? shouldCheckBatch,
    bool? shouldCheckSupplier,
    bool? restrictMaterialMixing,
    String? trayMaterialKey,
    String? pendingTrayNo,
    bool? showTrayChangeDialog,
    bool? focus,
    String? message,
  }) {
    return AswhUpCollectionState(
      task: task,
      status: status ?? this.status,
      detailList: detailList ?? this.detailList,
      visibleDetails: visibleDetails ?? this.visibleDetails,
      stocks: stocks ?? this.stocks,
      currentBarcode: currentBarcode ?? this.currentBarcode,
      currentItem: currentItem ?? this.currentItem,
      trayNo: trayNo ?? this.trayNo,
      storeSite: storeSite ?? this.storeSite,
      trayCapacity: trayCapacity ?? this.trayCapacity,
      trayUsed: trayUsed ?? this.trayUsed,
      trayMaxWeight: trayMaxWeight ?? this.trayMaxWeight,
      trayCurrentWeight: trayCurrentWeight ?? this.trayCurrentWeight,
      placeholder: placeholder ?? this.placeholder,
      scanStep: scanStep ?? this.scanStep,
      currentTab: currentTab ?? this.currentTab,
      selectedDetailIds: selectedDetailIds ?? this.selectedDetailIds,
      collectedByItem: collectedByItem ?? this.collectedByItem,
      serialRecord: serialRecord ?? this.serialRecord,
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      capacityUsageByStock: capacityUsageByStock ?? this.capacityUsageByStock,
      weightUsageByStock: weightUsageByStock ?? this.weightUsageByStock,
      currentMaterialCapacity:
          currentMaterialCapacity ?? this.currentMaterialCapacity,
      currentMaterialWeight: currentMaterialWeight ?? this.currentMaterialWeight,
      shouldCheckBatch: shouldCheckBatch ?? this.shouldCheckBatch,
      shouldCheckSupplier: shouldCheckSupplier ?? this.shouldCheckSupplier,
      restrictMaterialMixing:
          restrictMaterialMixing ?? this.restrictMaterialMixing,
      trayMaterialKey: trayMaterialKey ?? this.trayMaterialKey,
      pendingTrayNo: pendingTrayNo ?? this.pendingTrayNo,
      showTrayChangeDialog: showTrayChangeDialog ?? this.showTrayChangeDialog,
      focus: focus ?? this.focus,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        task,
        status,
        detailList,
        visibleDetails,
        stocks,
        currentBarcode,
        currentItem,
        trayNo,
        storeSite,
        trayCapacity,
        trayUsed,
        trayMaxWeight,
        trayCurrentWeight,
        placeholder,
        scanStep,
        currentTab,
        selectedDetailIds,
        collectedByItem,
        serialRecord,
        dicMtlQty,
        capacityUsageByStock,
        weightUsageByStock,
        currentMaterialCapacity,
        currentMaterialWeight,
        shouldCheckBatch,
        shouldCheckSupplier,
        restrictMaterialMixing,
        trayMaterialKey,
        pendingTrayNo,
        showTrayChangeDialog,
        focus,
        message,
      ];
}
