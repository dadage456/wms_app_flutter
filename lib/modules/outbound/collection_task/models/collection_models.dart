import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'collection_models.freezed.dart';
part 'collection_models.g.dart';

@freezed
@HiveType(typeId: 0)
class OutTaskItem extends HiveObject with _$OutTaskItem {
  OutTaskItem._();

  factory OutTaskItem({
    @HiveField(0) required int outtaskitemid,
    @HiveField(1) required String? matcode,
    @HiveField(2) required String? matname,
    @HiveField(3) required String? storesiteno,
    @HiveField(4) required double hintqty,
    @HiveField(5) required double collectedqty,
    @HiveField(6) required double repqty,
    @HiveField(7) required String? hintbatchno,
    @HiveField(8) required String? sn,
    @HiveField(9) required String? storeroomno,
    @HiveField(10) required String? subinventoryCode,
    @HiveField(11) required String? orderno,
    @HiveField(12) required String? matinnercode,
  }) = _OutTaskItem;

  factory OutTaskItem.fromJson(Map<String, dynamic> json) =>
      _$OutTaskItemFromJson(json);
}

@freezed
@HiveType(typeId: 1)
class BarcodeContent extends HiveObject with _$BarcodeContent {
  BarcodeContent._();

  factory BarcodeContent({
    @HiveField(0) String? matcode,
    @HiveField(1) String? matname,
    @HiveField(2) String? batchno,
    @HiveField(3) String? sn,
    @HiveField(4) String? seqctrl,
    @HiveField(5) String? id_old,
    @HiveField(6) double? qty,
  }) = _BarcodeContent;

  factory BarcodeContent.fromJson(Map<String, dynamic> json) =>
      _$BarcodeContentFromJson(json);

  bool get isEmpty {
    return (matcode == null || matcode!.isEmpty);
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}

@freezed
@HiveType(typeId: 2)
class CollectionStock extends HiveObject with _$CollectionStock {
  CollectionStock._();

  factory CollectionStock({
    @HiveField(0) required String stockid,
    @HiveField(1) required String matcode,
    @HiveField(2) required String batchno,
    @HiveField(3) required String sn,
    @HiveField(4) required double taskQty,
    @HiveField(5) required double collectQty,
    @HiveField(6) required String outtaskitemid,
    @HiveField(7) required String taskid,
    @HiveField(8) required String storeRoom,
    @HiveField(9) required String storeSite,
    @HiveField(10) required String erpStore,
    @HiveField(11) required String trayNo,
  }) = _CollectionStock;

  factory CollectionStock.fromJson(Map<String, dynamic> json) =>
      _$CollectionStockFromJson(json);
}

enum ScanStep {
  site, // 库位
  qrcode, // 物料

  quantity, // 数量
}

enum MtlCheckMode {
  mtl, // 检查物料
  mtlBatch, // 物料+批号
  mtlSite, // 物料+库位
  mtlSiteBatch, // 物料+批号+库位
}
