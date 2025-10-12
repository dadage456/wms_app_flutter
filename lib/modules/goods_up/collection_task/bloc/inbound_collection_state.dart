import 'package:equatable/equatable.dart';

import '../../../../models/page_status.dart';
import '../models/inbound_collection_models.dart';

enum InboundScanStep { site, material, dangerousSupplement, quantity }

class InboundCollectionState extends Equatable {
  const InboundCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.detailList = const [],
    this.collectionList = const [],
    this.stocks = const [],
    this.currentBarcode,
    this.currentItem,
    this.storeSite = '',
    this.storeRoom = '',
    this.repQty = 0,
    this.collectQty = 0,
    this.placeholder = '请扫描库位',
    this.scanStep = InboundScanStep.site,
    this.currentTab = 0,
    this.checkedIds = const [],
    this.candidateItemIds = const [],
    this.dicMtlQty = const {},
    this.dicSeq = const {},
    this.dicInvMtlQty = const {},
    this.focus = false,
    this.isDangerous = false,
    this.requireDangerousSupplement = false,
    this.shouldCheckBatch = true,
    this.allowErpStoreBypass = false,
  });

  final CollectionStatus status;
  final List<InboundCollectTaskItem> detailList;
  final List<InboundCollectTaskItem> collectionList;
  final List<InboundCollectionStock> stocks;
  final InboundBarcodeContent? currentBarcode;
  final InboundCollectTaskItem? currentItem;
  final String storeSite;
  final String storeRoom;
  final double repQty;
  final double collectQty;
  final String placeholder;
  final InboundScanStep scanStep;
  final int currentTab;
  final List<int> checkedIds;
  final List<int> candidateItemIds;
  final Map<String, List<dynamic>> dicMtlQty;
  final Map<String, String> dicSeq;
  final Map<String, double> dicInvMtlQty;
  final bool focus;
  final bool isDangerous;
  final bool requireDangerousSupplement;
  final bool shouldCheckBatch;
  final bool allowErpStoreBypass;

  InboundCollectionState copyWith({
    CollectionStatus? status,
    List<InboundCollectTaskItem>? detailList,
    List<InboundCollectTaskItem>? collectionList,
    List<InboundCollectionStock>? stocks,
    InboundBarcodeContent? currentBarcode,
    InboundCollectTaskItem? currentItem,
    String? storeSite,
    String? storeRoom,
    double? repQty,
    double? collectQty,
    String? placeholder,
    InboundScanStep? scanStep,
    int? currentTab,
    List<int>? checkedIds,
    List<int>? candidateItemIds,
    Map<String, List<dynamic>>? dicMtlQty,
    Map<String, String>? dicSeq,
    Map<String, double>? dicInvMtlQty,
    bool? focus,
    bool? isDangerous,
    bool? requireDangerousSupplement,
    bool? shouldCheckBatch,
    bool? allowErpStoreBypass,
  }) {
    return InboundCollectionState(
      status: status ?? this.status,
      detailList: detailList ?? this.detailList,
      collectionList: collectionList ?? this.collectionList,
      stocks: stocks ?? this.stocks,
      currentBarcode: currentBarcode ?? this.currentBarcode,
      currentItem: currentItem ?? this.currentItem,
      storeSite: storeSite ?? this.storeSite,
      storeRoom: storeRoom ?? this.storeRoom,
      repQty: repQty ?? this.repQty,
      collectQty: collectQty ?? this.collectQty,
      placeholder: placeholder ?? this.placeholder,
      scanStep: scanStep ?? this.scanStep,
      currentTab: currentTab ?? this.currentTab,
      checkedIds: checkedIds ?? this.checkedIds,
      candidateItemIds: candidateItemIds ?? this.candidateItemIds,
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      dicSeq: dicSeq ?? this.dicSeq,
      dicInvMtlQty: dicInvMtlQty ?? this.dicInvMtlQty,
      focus: focus ?? this.focus,
      isDangerous: isDangerous ?? this.isDangerous,
      requireDangerousSupplement:
          requireDangerousSupplement ?? this.requireDangerousSupplement,
      shouldCheckBatch: shouldCheckBatch ?? this.shouldCheckBatch,
      allowErpStoreBypass: allowErpStoreBypass ?? this.allowErpStoreBypass,
    );
  }

  @override
  List<Object?> get props => [
        status,
        detailList,
        collectionList,
        stocks,
        currentBarcode,
        currentItem,
        storeSite,
        storeRoom,
        repQty,
        collectQty,
        placeholder,
        scanStep,
        currentTab,
        checkedIds,
        candidateItemIds,
        dicMtlQty,
        dicSeq,
        dicInvMtlQty,
        focus,
        isDangerous,
        requireDangerousSupplement,
        shouldCheckBatch,
        allowErpStoreBypass,
      ];
}
