import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'goods_up_models.freezed.dart';
part 'goods_up_models.g.dart';

@freezed
@HiveType(typeId: 3)
class InTaskItem extends HiveObject with _$InTaskItem {
  InTaskItem._();

  factory InTaskItem({
    @JsonKey(name: 'intaskitemid') @HiveField(0) required int inTaskItemId,
    @JsonKey(name: 'intaskid') @HiveField(1) required int inTaskId,
    @JsonKey(name: 'intaskno') @HiveField(2) String? inTaskNo,
    @JsonKey(name: 'matcode') @HiveField(3) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(4) String? materialName,
    @JsonKey(name: 'matinnercode') @HiveField(5) String? oldMaterialCode,
    @JsonKey(name: 'storeroomno') @HiveField(6) String? storeRoomNo,
    @JsonKey(name: 'storesiteno') @HiveField(7) String? storeSiteNo,
    @JsonKey(name: 'qty') @HiveField(8) required double quantity,
    @JsonKey(name: 'collectedqty')
    @HiveField(9)
    required double collectedQuantity,
    @JsonKey(name: 'batchno') @HiveField(10) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(11) String? serialNumber,
    @JsonKey(name: 'subinventoryCode') @HiveField(12) String? subInventoryCode,
    @JsonKey(name: 'orderno') @HiveField(13) String? inboundOrderNo,
    @JsonKey(name: 'taskcomment') @HiveField(14) String? taskComment,
  }) = _InTaskItem;

  factory InTaskItem.fromJson(Map<String, dynamic> json) =>
      _$InTaskItemFromJson(json);
}

@freezed
@HiveType(typeId: 4)
class UpBarcodeContent extends HiveObject with _$UpBarcodeContent {
  UpBarcodeContent._();

  factory UpBarcodeContent({
    @JsonKey(name: 'matcode') @HiveField(0) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(1) String? materialName,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNumber,
    @JsonKey(name: 'seqctrl') @HiveField(4) String? seqctrl,
    @JsonKey(name: 'idOld') @HiveField(5) String? idOld,
    @JsonKey(name: 'qty') @HiveField(6) double? quantity,
    @JsonKey(name: 'pdate') @HiveField(7) String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(8) String? validDays,
    @JsonKey(name: 'dgFlg') @HiveField(9) String? dgFlag,
  }) = _UpBarcodeContent;

  factory UpBarcodeContent.fromJson(Map<String, dynamic> json) =>
      _$UpBarcodeContentFromJson(json);

  bool get isEmpty => (materialCode == null || materialCode!.isEmpty);

  bool get isNotEmpty => !isEmpty;
}

@freezed
@HiveType(typeId: 5)
class UpCollectionStock extends HiveObject with _$UpCollectionStock {
  UpCollectionStock._();

  factory UpCollectionStock({
    @JsonKey(name: 'stockid') @HiveField(0) required String stockId,
    @JsonKey(name: 'matcode') @HiveField(1) required String materialCode,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNumber,
    @JsonKey(name: 'taskQty') @HiveField(4) double? taskQuantity,
    @JsonKey(name: 'collectQty') @HiveField(5) double? collectedQuantity,
    @JsonKey(name: 'taskNo') @HiveField(6) String? taskNo,
    @JsonKey(name: 'taskid') @HiveField(7) String? taskId,
    @JsonKey(name: 'storeRoom') @HiveField(8) String? storeRoom,
    @JsonKey(name: 'storeSite') @HiveField(9) String? storeSite,
    @JsonKey(name: 'pdate') @HiveField(10) String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(11) String? validDays,
    @JsonKey(name: 'erpStore') @HiveField(12) String? erpStore,
    @JsonKey(name: 'trayNo') @HiveField(13) String? trayNo,
  }) = _UpCollectionStock;

  factory UpCollectionStock.fromJson(Map<String, dynamic> json) =>
      _$UpCollectionStockFromJson(json);
}
