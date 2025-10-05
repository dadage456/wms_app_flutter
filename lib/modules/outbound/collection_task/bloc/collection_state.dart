import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';

enum CollectionStatusType {
  normal,
  // 加载中
  loading,
  // 错误
  error,
  // 成功
  success,
}

class CollectionStatus {
  final CollectionStatusType type;
  final String? message;

  const CollectionStatus(this.type, [this.message]);

  factory CollectionStatus.normal() {
    return const CollectionStatus(CollectionStatusType.normal);
  }

  factory CollectionStatus.loading() {
    return const CollectionStatus(CollectionStatusType.loading);
  }

  factory CollectionStatus.error([String? message]) {
    return CollectionStatus(CollectionStatusType.error, message);
  }

  factory CollectionStatus.success([String? message]) {
    return CollectionStatus(CollectionStatusType.success, message);
  }

  CollectionStatus copyWith({CollectionStatusType? type, String? message}) {
    return CollectionStatus(type ?? this.type, message ?? this.message);
  }

  bool get isNormal => type == CollectionStatusType.normal;
  bool get isLoading => type == CollectionStatusType.loading;
  bool get isError => type == CollectionStatusType.error;
  bool get isSuccess => type == CollectionStatusType.success;
}

class CollectionState {
  final CollectionStatus status;
  final List<OutTaskItem> detailList;
  final List<OutTaskItem> collectionList;
  final List<CollectionStock> stocks;
  final BarcodeContent? currentBarcode;
  final String storeSite;
  final double repQty;
  final double collectQty;
  final String placeholder;
  final int currentTab;
  final List<String> checkedIds;
  final Map<String, List<double>> dicMtlQty;
  final Map<String, String> dicSeq;
  final Map<String, double> dicInvMtlQty;
  final String matControlFlag;
  final String erpRoom;
  final String erpStoreInv;
  final MtlCheckMode mtlCheckMode;
  final String roomMatControl;
  final String matSendControl;
  final bool focus;

  const CollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.detailList = const [],
    this.collectionList = const [],
    this.stocks = const [],
    this.currentBarcode,
    this.storeSite = '',
    this.repQty = 0,
    this.collectQty = 0,
    this.placeholder = '请扫描库位',
    this.currentTab = 0,
    this.checkedIds = const [],
    this.dicMtlQty = const {},
    this.dicSeq = const {},
    this.dicInvMtlQty = const {},
    this.matControlFlag = '',
    this.erpRoom = '',
    this.erpStoreInv = '',
    this.mtlCheckMode = MtlCheckMode.mtl,
    this.roomMatControl = '0',
    this.matSendControl = '0',
    this.focus = false,
  });

  CollectionState copyWith({
    CollectionStatus? status,
    List<OutTaskItem>? detailList,
    List<OutTaskItem>? collectionList,
    List<CollectionStock>? stocks,
    BarcodeContent? currentBarcode,
    String? storeSite,
    double? repQty,
    double? collectQty,
    String? placeholder,
    int? currentTab,
    List<String>? checkedIds,
    Map<String, List<double>>? dicMtlQty,
    Map<String, String>? dicSeq,
    Map<String, double>? dicInvMtlQty,
    String? matControlFlag,
    String? erpRoom,
    String? erpStoreInv,
    MtlCheckMode? mtlCheckMode,
    String? roomMatControl,
    String? matSendControl,
    bool? focus,
  }) {
    return CollectionState(
      status: status ?? this.status,
      detailList: detailList ?? this.detailList,
      collectionList: collectionList ?? this.collectionList,
      stocks: stocks ?? this.stocks,
      currentBarcode: currentBarcode ?? this.currentBarcode,
      storeSite: storeSite ?? this.storeSite,
      repQty: repQty ?? this.repQty,
      collectQty: collectQty ?? this.collectQty,
      placeholder: placeholder ?? this.placeholder,
      currentTab: currentTab ?? this.currentTab,
      checkedIds: checkedIds ?? this.checkedIds,
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      dicSeq: dicSeq ?? this.dicSeq,
      dicInvMtlQty: dicInvMtlQty ?? this.dicInvMtlQty,
      matControlFlag: matControlFlag ?? this.matControlFlag,
      erpRoom: erpRoom ?? this.erpRoom,
      erpStoreInv: erpStoreInv ?? this.erpStoreInv,
      mtlCheckMode: mtlCheckMode ?? this.mtlCheckMode,
      roomMatControl: roomMatControl ?? this.roomMatControl,
      matSendControl: matSendControl ?? this.matSendControl,
      focus: focus ?? this.focus,
    );
  }
}
