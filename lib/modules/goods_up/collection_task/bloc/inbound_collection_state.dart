import 'package:equatable/equatable.dart';

import '../../../../models/page_status.dart';
import '../models/inbound_collection_models.dart';

enum InboundScanStep { site, material, quantity }

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
    this.dicMtlQty = const {},
    this.dicSeq = const {},
    this.dicInvMtlQty = const {},
    this.focus = false,
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
  final Map<String, List<dynamic>> dicMtlQty;
  final Map<String, String> dicSeq;
  final Map<String, double> dicInvMtlQty;
  final bool focus;

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
    Map<String, List<dynamic>>? dicMtlQty,
    Map<String, String>? dicSeq,
    Map<String, double>? dicInvMtlQty,
    bool? focus,
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
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      dicSeq: dicSeq ?? this.dicSeq,
      dicInvMtlQty: dicInvMtlQty ?? this.dicInvMtlQty,
      focus: focus ?? this.focus,
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
        dicMtlQty,
        dicSeq,
        dicInvMtlQty,
        focus,
      ];
}
