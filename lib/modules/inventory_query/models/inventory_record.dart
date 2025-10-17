import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_record.freezed.dart';
part 'inventory_record.g.dart';

/// 单条库存记录。
@freezed
class InventoryRecord with _$InventoryRecord {
  const factory InventoryRecord({
    @Default('') String matcode,
    @Default('') String matname,
    @Default('') String batchno,
    @Default('') String sn,
    @Default('') String storesiteno,
    @JsonKey(name: 'erpStoreroom') @Default('') String erpStoreroom,
    @Default('') String storeroomno,
    @Default('') String storeroomname,
    @Default(0.0) double repqty,
  }) = _InventoryRecord;

  factory InventoryRecord.fromJson(Map<String, dynamic> json) =>
      _$InventoryRecordFromJson(json);
}

/// 分页响应体。
@freezed
class InventoryRecordPage with _$InventoryRecordPage {
  const factory InventoryRecordPage({
    @Default(<InventoryRecord>[]) List<InventoryRecord> rows,
    @Default(0) int total,
  }) = _InventoryRecordPage;

  factory InventoryRecordPage.fromJson(Map<String, dynamic> json) =>
      _$InventoryRecordPageFromJson(json);
}
