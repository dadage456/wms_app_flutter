import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

class OnlinePickCollectionState {
  final CollectionStatus status;
  final OnlinePickTask? task;
  final List<OnlinePickTaskItem> taskItems;
  final List<OnlinePickTaskItem> currentTrayItems;
  final List<OnlinePickTaskItem> pendingCheckItems;
  final List<OnlinePickCollectionStock> collectedStocks;
  final OnlinePickBarcodeContent? currentBarcode;
  final OnlinePickCollectionStep step;
  final String placeholder;
  final String currentTrayCode;
  final int currentTab;
  final List<int> selectedItemIds;
  final bool focus;
  final OnlinePickCollectionModeType mode;
  final List<OnlinePickCollectionMode> availableModes;
  final String selectedLocation;
  final List<OnlinePickLocationOption> locationOptions;
  final bool loadingLocations;
  final Map<String, String> dicSeq;
  final Map<String, List<double>> dicMtlQty;
  final Map<String, double> dicInvMtlQty;
  final List<String> issuedTrayNos;

  const OnlinePickCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.task,
    this.taskItems = const [],
    this.currentTrayItems = const [],
    this.pendingCheckItems = const [],
    this.collectedStocks = const [],
    this.currentBarcode,
    this.step = OnlinePickCollectionStep.location,
    this.placeholder = '请扫描库位',
    this.currentTrayCode = '',
    this.currentTab = 0,
    this.selectedItemIds = const [],
    this.focus = false,
    this.mode = OnlinePickCollectionModeType.outbound,
    this.availableModes = const [
      OnlinePickCollectionMode(
        code: 'outbound',
        label: '出库采集',
        type: OnlinePickCollectionModeType.outbound,
      ),
      OnlinePickCollectionMode(
        code: 'inventory',
        label: '库存核对',
        type: OnlinePickCollectionModeType.inventory,
      ),
      OnlinePickCollectionMode(
        code: 'exception',
        label: '异常采集',
        type: OnlinePickCollectionModeType.exception,
      ),
    ],
    this.selectedLocation = '',
    this.locationOptions = const [],
    this.loadingLocations = false,
    this.dicSeq = const {},
    this.dicMtlQty = const {},
    this.dicInvMtlQty = const {},
    this.issuedTrayNos = const [],
  });

  OnlinePickCollectionState copyWith({
    CollectionStatus? status,
    OnlinePickTask? task,
    List<OnlinePickTaskItem>? taskItems,
    List<OnlinePickTaskItem>? currentTrayItems,
    List<OnlinePickTaskItem>? pendingCheckItems,
    List<OnlinePickCollectionStock>? collectedStocks,
    OnlinePickBarcodeContent? currentBarcode,
    OnlinePickCollectionStep? step,
    String? placeholder,
    String? currentTrayCode,
    int? currentTab,
    List<int>? selectedItemIds,
    bool? focus,
    bool resetBarcode = false,
    OnlinePickCollectionModeType? mode,
    List<OnlinePickCollectionMode>? availableModes,
    String? selectedLocation,
    List<OnlinePickLocationOption>? locationOptions,
    bool? loadingLocations,
    Map<String, String>? dicSeq,
    Map<String, List<double>>? dicMtlQty,
    Map<String, double>? dicInvMtlQty,
    List<String>? issuedTrayNos,
  }) {
    return OnlinePickCollectionState(
      status: status ?? this.status,
      task: task ?? this.task,
      taskItems: taskItems ?? this.taskItems,
      currentTrayItems: currentTrayItems ?? this.currentTrayItems,
      pendingCheckItems: pendingCheckItems ?? this.pendingCheckItems,
      collectedStocks: collectedStocks ?? this.collectedStocks,
      currentBarcode: resetBarcode ? null : currentBarcode ?? this.currentBarcode,
      step: step ?? this.step,
      placeholder: placeholder ?? this.placeholder,
      currentTrayCode: currentTrayCode ?? this.currentTrayCode,
      currentTab: currentTab ?? this.currentTab,
      selectedItemIds: selectedItemIds ?? this.selectedItemIds,
      focus: focus ?? this.focus,
      mode: mode ?? this.mode,
      availableModes: availableModes ?? this.availableModes,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      locationOptions: locationOptions ?? this.locationOptions,
      loadingLocations: loadingLocations ?? this.loadingLocations,
      dicSeq: dicSeq ?? this.dicSeq,
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      dicInvMtlQty: dicInvMtlQty ?? this.dicInvMtlQty,
      issuedTrayNos: issuedTrayNos ?? this.issuedTrayNos,
    );
  }
}
