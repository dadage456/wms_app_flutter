import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'aswh_up_collection_models.freezed.dart';
part 'aswh_up_collection_models.g.dart';

@freezed
@HiveType(typeId: 22)
class AswhUpBarcodeContent extends HiveObject with _$AswhUpBarcodeContent {
  AswhUpBarcodeContent._();

  factory AswhUpBarcodeContent({
    @JsonKey(name: 'matcode') @HiveField(0) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(1) String? materialName,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNo,
    @JsonKey(name: 'seqctrl') @HiveField(4) String? seqCtrl,
    @JsonKey(name: 'id_old') @HiveField(5) String? idOld,
    @JsonKey(name: 'qty') @HiveField(6) @Default(0.0) double quantity,
    @JsonKey(name: 'vdays') @HiveField(7) int? expireDays,
    @JsonKey(name: 'pdate') @HiveField(8) String? productionDate,
    @JsonKey(name: 'dgFlg') @HiveField(9) String? dangerousFlag,
    @JsonKey(name: 'suppliercode') @HiveField(10) String? supplierCode,
    @JsonKey(name: 'suppliername') @HiveField(11) String? supplierName,
    @JsonKey(name: 'erpstore') @HiveField(12) String? erpStore,
  }) = _AswhUpBarcodeContent;

  factory AswhUpBarcodeContent.fromJson(Map<String, dynamic> json) =>
      _$AswhUpBarcodeContentFromJson(json);

  bool get isEmpty => (materialCode ?? '').isEmpty;

  bool get isNotEmpty => !isEmpty;
}

@freezed
@HiveType(typeId: 23)
class AswhUpCollectionStock extends HiveObject with _$AswhUpCollectionStock {
  AswhUpCollectionStock._();

  factory AswhUpCollectionStock({
    @HiveField(0) @Default('') String stockId,
    @HiveField(1) @Default('') String trayNo,
    @HiveField(2) @Default('') String materialCode,
    @HiveField(3) String? materialName,
    @HiveField(4) String? batchNo,
    @HiveField(5) String? serialNo,
    @HiveField(6) @Default(0.0) double taskQty,
    @HiveField(7) @Default(0.0) double collectQty,
    @HiveField(8) @Default('') String taskItemId,
    @HiveField(9) @Default('') String taskId,
    @HiveField(10) String? storeRoom,
    @HiveField(11) String? storeSite,
    @HiveField(12) String? erpStore,
    @HiveField(13) String? supplierCode,
    @HiveField(14) String? supplierName,
  }) = _AswhUpCollectionStock;

  factory AswhUpCollectionStock.fromJson(Map<String, dynamic> json) =>
      _$AswhUpCollectionStockFromJson(json);
}

@freezed
@HiveType(typeId: 24)
class AswhUpDicSeqEntry extends HiveObject with _$AswhUpDicSeqEntry {
  AswhUpDicSeqEntry._();

  factory AswhUpDicSeqEntry({
    @HiveField(0) @Default(0) int taskItemId,
    @HiveField(1) @Default(<String>[]) List<String> serialNumbers,
  }) = _AswhUpDicSeqEntry;

  factory AswhUpDicSeqEntry.fromJson(Map<String, dynamic> json) =>
      _$AswhUpDicSeqEntryFromJson(json);
}
