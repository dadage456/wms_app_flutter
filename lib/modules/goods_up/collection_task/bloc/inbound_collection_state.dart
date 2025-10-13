import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';

class InboundCollectionState {
  const InboundCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.task,
    this.detailList = const [],
    this.collectionList = const [],
    this.stocks = const [],
    this.currentBarcode,
    this.storeSite = '',
    this.storeRoom = '',
    this.repQty = 0,
    this.collectQty = 0,
    this.placeholder = '请扫描库位',
    this.currentTab = 0,
    this.checkedIds = const [],
    this.dicMtlQty = const {},
    this.dicSeq = const {},
    this.dicInvMtlQty = const {},
    this.scanStep = InboundScanStep.site,
    this.focus = false,
    this.requireDangerousSupplement = false,
    this.userId = 0,
  });

  final CollectionStatus status;
  final GoodsUpTask? task;
  final List<InboundCollectTaskItem> detailList;
  final List<InboundCollectTaskItem> collectionList;
  final List<InboundCollectionStock> stocks;
  final InboundBarcodeContent? currentBarcode;
  final String storeSite;
  final String storeRoom;
  final double repQty;
  final double collectQty;
  final String placeholder;
  final int currentTab;
  final List<String> checkedIds;
  final Map<String, InboundCollectionQty> dicMtlQty;
  final Map<String, String> dicSeq;
  final Map<String, double> dicInvMtlQty;
  final InboundScanStep scanStep;
  final bool focus;
  final bool requireDangerousSupplement;
  final int userId;

  InboundCollectionState copyWith({
    CollectionStatus? status,
    GoodsUpTask? task,
    List<InboundCollectTaskItem>? detailList,
    List<InboundCollectTaskItem>? collectionList,
    List<InboundCollectionStock>? stocks,
    InboundBarcodeContent? currentBarcode,
    String? storeSite,
    String? storeRoom,
    double? repQty,
    double? collectQty,
    String? placeholder,
    int? currentTab,
    List<String>? checkedIds,
    Map<String, InboundCollectionQty>? dicMtlQty,
    Map<String, String>? dicSeq,
    Map<String, double>? dicInvMtlQty,
    InboundScanStep? scanStep,
    bool? focus,
    bool? requireDangerousSupplement,
    int? userId,
    bool resetBarcode = false,
  }) {
    return InboundCollectionState(
      status: status ?? this.status,
      task: task ?? this.task,
      detailList: detailList ?? this.detailList,
      collectionList: collectionList ?? this.collectionList,
      stocks: stocks ?? this.stocks,
      currentBarcode:
          resetBarcode ? null : (currentBarcode ?? this.currentBarcode),
      storeSite: storeSite ?? this.storeSite,
      storeRoom: storeRoom ?? this.storeRoom,
      repQty: repQty ?? this.repQty,
      collectQty: collectQty ?? this.collectQty,
      placeholder: placeholder ?? this.placeholder,
      currentTab: currentTab ?? this.currentTab,
      checkedIds: checkedIds ?? this.checkedIds,
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      dicSeq: dicSeq ?? this.dicSeq,
      dicInvMtlQty: dicInvMtlQty ?? this.dicInvMtlQty,
      scanStep: scanStep ?? this.scanStep,
      focus: focus ?? this.focus,
      requireDangerousSupplement:
          requireDangerousSupplement ?? this.requireDangerousSupplement,
      userId: userId ?? this.userId,
    );
  }
}
