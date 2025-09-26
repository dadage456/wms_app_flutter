import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';

class CollectionState {
  final List<OutTaskItem> detailList;
  final List<OutTaskItem> collectionList;
  final List<CollectionStock> stocks;
  final BarcodeContent? currentBarcode;
  final String storeSite;
  final double repQty;
  final double collectQty;
  final String placeholder;
  final bool isLoading;
  final String? error;
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
    this.detailList = const [],
    this.collectionList = const [],
    this.stocks = const [],
    this.currentBarcode,
    this.storeSite = '',
    this.repQty = 0,
    this.collectQty = 0,
    this.placeholder = '请扫描库位',
    this.isLoading = false,
    this.error,
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
    List<OutTaskItem>? detailList,
    List<OutTaskItem>? collectionList,
    List<CollectionStock>? stocks,
    BarcodeContent? currentBarcode,
    String? storeSite,
    double? repQty,
    double? collectQty,
    String? placeholder,
    bool? isLoading,
    String? error,
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
      detailList: detailList ?? this.detailList,
      collectionList: collectionList ?? this.collectionList,
      stocks: stocks ?? this.stocks,
      currentBarcode: currentBarcode ?? this.currentBarcode,
      storeSite: storeSite ?? this.storeSite,
      repQty: repQty ?? this.repQty,
      collectQty: collectQty ?? this.collectQty,
      placeholder: placeholder ?? this.placeholder,
      isLoading: isLoading ?? this.isLoading,
      error: error,
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
