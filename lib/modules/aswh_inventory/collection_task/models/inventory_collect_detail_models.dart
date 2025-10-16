import 'package:freezed_annotation/freezed_annotation.dart';

import 'inventory_collect_models.dart';

part 'inventory_collect_detail_models.freezed.dart';
part 'inventory_collect_detail_models.g.dart';

/// 采集结果项，用于采集结果页展示与删除操作
@freezed
class InventoryCollectedItem with _$InventoryCollectedItem {
  const factory InventoryCollectedItem({
    /// 本地缓存记录ID
    @JsonKey(name: 'stockid') required String stockId,

    /// 对应的盘点任务明细ID
    @JsonKey(name: 'InvTaskItemid') required String invTaskItemId,

    /// 采集数量（源数量）
    @JsonKey(name: 'InventoryQty') @Default(0) double sourceQty,

    /// 物料编码
    @JsonKey(name: 'matcode') required String materialCode,

    /// 物料名称
    @JsonKey(name: 'matname') String? materialName,

    /// 批次号
    @JsonKey(name: 'batchno') String? batchNo,

    /// 序列号
    @JsonKey(name: 'sn') String? serialNo,

    /// 库房编码
    @JsonKey(name: 'storeRoom') required String storeRoomNo,

    /// 库位编码
    @JsonKey(name: 'storeSite') required String storeSiteNo,

    /// 托盘号
    @JsonKey(name: 'TrayNo') String? trayNo,

    /// 物料主数据ID
    @JsonKey(name: 'MatId') String? materialId,
  }) = _InventoryCollectedItem;

  factory InventoryCollectedItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryCollectedItemFromJson(json);

  factory InventoryCollectedItem.fromRecord(
    InventoryCollectingRecord record, {
    required String stockId,
    double? sourceQty,
  }) {
    return InventoryCollectedItem(
      stockId: stockId,
      invTaskItemId: record.taskItemId,
      sourceQty: sourceQty ?? record.collectQty,
      materialCode: record.materialCode,
      materialName: null,
      batchNo: record.batchNo,
      serialNo: record.serialNo,
      storeRoomNo: record.storeRoomNo,
      storeSiteNo: record.storeSiteNo,
      trayNo: record.trayNo,
      materialId: record.materialId,
    );
  }
}

extension InventoryCollectedItemX on InventoryCollectedItem {
  InventoryCollectingRecord toRecord({required String taskComment}) {
    return InventoryCollectingRecord(
      taskComment: taskComment,
      taskItemId: invTaskItemId,
      materialCode: materialCode,
      materialId: materialId,
      storeRoomNo: storeRoomNo,
      storeSiteNo: storeSiteNo,
      collectQty: sourceQty,
      batchNo: batchNo,
      serialNo: serialNo,
      trayNo: trayNo,
    );
  }
}
