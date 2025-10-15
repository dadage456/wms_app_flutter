import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'aswh_up_task_item.freezed.dart';
part 'aswh_up_task_item.g.dart';

@freezed
@HiveType(typeId: 21)
class AswhUpTaskItem extends HiveObject with _$AswhUpTaskItem {
  AswhUpTaskItem._();

  factory AswhUpTaskItem({
    @JsonKey(name: 'intaskitemid') @HiveField(0) @Default(0) int inTaskItemId,
    @JsonKey(name: 'intaskid') @HiveField(1) @Default(0) int inTaskId,
    @JsonKey(name: 'matcode') @HiveField(2) @Default('') String materialCode,
    @JsonKey(name: 'matname') @HiveField(3) String? materialName,
    @JsonKey(name: 'storesiteno') @HiveField(4) String? storeSiteNo,
    @JsonKey(name: 'storeroomno') @HiveField(5) String? storeRoomNo,
    @JsonKey(name: 'subinventoryCode') @HiveField(6) String? subInventoryCode,
    @JsonKey(name: 'batchno') @HiveField(7) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(8) String? serialNo,
    @JsonKey(name: 'qty') @HiveField(9) @Default(0.0) double planQty,
    @JsonKey(name: 'collectedqty')
    @HiveField(10)
    @Default(0.0)
    double collectedQty,
    @JsonKey(name: 'repqty') @HiveField(11) @Default(0.0) double repertoryQty,
    @JsonKey(name: 'unit') @HiveField(12) String? unit,
    @JsonKey(name: 'vdays') @HiveField(13) int? expireDays,
    @JsonKey(name: 'pdate') @HiveField(14) String? productionDate,
    @JsonKey(name: 'protype') @HiveField(15) String? proType,
    @JsonKey(name: 'erpstore') @HiveField(16) String? erpStore,
    @JsonKey(name: 'suppliername') @HiveField(17) String? supplierName,
  }) = _AswhUpTaskItem;

  factory AswhUpTaskItem.fromJson(Map<String, dynamic> json) =>
      _$AswhUpTaskItemFromJson(json);
}
