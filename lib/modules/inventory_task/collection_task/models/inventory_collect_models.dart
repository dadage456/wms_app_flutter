import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_collect_models.freezed.dart';
part 'inventory_collect_models.g.dart';

/// 盘点任务明细查询参数
@freezed
class InventoryTaskItemQuery with _$InventoryTaskItemQuery {
  const factory InventoryTaskItemQuery({
    @JsonKey(name: 'taskId') required String taskId,
    @JsonKey(name: 'roomTag') @Default('0') String roomTag,
  }) = _InventoryTaskItemQuery;

  factory InventoryTaskItemQuery.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskItemQueryFromJson(json);
}

/// 盘点任务明细项
@freezed
class InventoryTaskItem with _$InventoryTaskItem {
  const factory InventoryTaskItem({
    @JsonKey(name: 'itemid') required String itemId,
    @JsonKey(name: 'checktaskno') String? checkTaskNo,
    @JsonKey(name: 'matcode') required String materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'storesiteno') required String storeSiteNo,
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    @JsonKey(name: 'storeroomname') String? storeRoomName,
    @JsonKey(name: 'systemquantity') @Default(0) double systemQuantity,
    @JsonKey(name: 'actualquantity') @Default(0) double actualQuantity,
    @JsonKey(name: 'difference') @Default(0) double difference,
    @JsonKey(name: 'collectdataqty') @Default(0) double collectedQuantity,
    @JsonKey(name: 'checkmethod_nm') String? checkMethodName,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNo,
    @JsonKey(name: 'unit') String? unit,
  }) = _InventoryTaskItem;

  factory InventoryTaskItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskItemFromJson(json);
}

/// 扫码解析结果
@freezed
class InventoryBarcodeContent with _$InventoryBarcodeContent {
  const factory InventoryBarcodeContent({
    @JsonKey(name: 'matcode') String? materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNo,
    @JsonKey(name: 'qty') @Default(0) double quantity,
    @JsonKey(name: 'unit') String? unit,
  }) = _InventoryBarcodeContent;

  factory InventoryBarcodeContent.fromJson(Map<String, dynamic> json) =>
      _$InventoryBarcodeContentFromJson(json);
}

/// 盘点采集记录
@freezed
class InventoryCollectRecord with _$InventoryCollectRecord {
  const factory InventoryCollectRecord({
    @JsonKey(name: 'itemid') required String itemId,
    @JsonKey(name: 'matcode') required String materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'storesiteno') required String storeSiteNo,
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    @JsonKey(name: 'systemquantity') @Default(0) double systemQuantity,
    @JsonKey(name: 'actualquantity') @Default(0) double actualQuantity,
    @JsonKey(name: 'difference') @Default(0) double difference,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNo,
    @JsonKey(name: 'unit') String? unit,
    @JsonKey(name: 'taskComment') String? taskComment,
  }) = _InventoryCollectRecord;

  factory InventoryCollectRecord.fromJson(Map<String, dynamic> json) =>
      _$InventoryCollectRecordFromJson(json);
}

/// 盘点采集提交请求
@freezed
class InventoryCommitRequest with _$InventoryCommitRequest {
  const factory InventoryCommitRequest({
    @JsonKey(name: 'inventoryInfos')
    @Default(<InventoryCollectRecord>[])
    List<InventoryCollectRecord> records,
    @JsonKey(name: 'taskComment') required String taskComment,
  }) = _InventoryCommitRequest;

  factory InventoryCommitRequest.fromJson(Map<String, dynamic> json) =>
      _$InventoryCommitRequestFromJson(json);
}
