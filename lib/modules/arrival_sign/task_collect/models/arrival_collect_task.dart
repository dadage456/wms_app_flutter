import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';

part 'arrival_collect_task.freezed.dart';
part 'arrival_collect_task.g.dart';

/// 采集页面的任务行模型。
@freezed
class ArrivalCollectTask with _$ArrivalCollectTask {
  const ArrivalCollectTask._();

  const factory ArrivalCollectTask({
    /// 物料编码
    @JsonKey(name: 'matcode') required String materialCode,

    /// 物料名称
    @JsonKey(name: 'matname') String? materialName,

    /// 到货单号
    @JsonKey(name: 'arrivalsBillno') String? arrivalsBillNo,

    /// 到货单行ID
    @JsonKey(name: 'arrivalsBillid') String? arrivalsBillId,

    /// 采购单号
    @JsonKey(name: 'orderno') String? orderNo,

    /// 计划数量
    @JsonKey(name: 'qty') required double plannedQuantity,

    /// 已良品数量
    @JsonKey(name: 'goodqty') required double collectedQuantity,

    /// 初始良品数量（用于删除/恢复时回写）
    @JsonKey(ignore: true) @Default(0) double baseCollectedQuantity,

    /// 单位
    @JsonKey(name: 'meins') String? unit,

    /// 批次号
    @JsonKey(name: 'batchno') String? batchNo,

    /// 序列号
    String? serialNumber,

    /// 库位编码
    @JsonKey(name: 'subinventoryCode') String? subInventoryCode,

    /// 物料控制类型（0 无、1 批次、2 序列）
    @JsonKey(name: 'matcodecontrol') int? materialControlType,

    /// 生产日期
    @JsonKey(name: 'pdate') String? productionDate,

    /// 有效天数
    @JsonKey(name: 'vdays') String? validDays,
  }) = _ArrivalCollectTask;

  factory ArrivalCollectTask.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectTaskFromJson(json);

  factory ArrivalCollectTask.fromDetail(
    ArrivalSignDetail detail, {
    String? arrivalsBillId,
  }) {
    final goodQty = detail.goodQuantity.toDouble();

    return ArrivalCollectTask(
      materialCode: detail.materialCode,
      materialName: detail.materialName,
      arrivalsBillNo: detail.arrivalsBillNo,
      arrivalsBillId: arrivalsBillId,
      orderNo: detail.orderNo,
      plannedQuantity: detail.quantity.toDouble(),
      collectedQuantity: goodQty,
      baseCollectedQuantity: goodQty,
      unit: detail.unit,
      batchNo: detail.batchNo,
      serialNumber: detail.serialNumber,
      subInventoryCode: detail.subInventoryCode,
      materialControlType: int.tryParse(detail.controlType ?? ''),
      productionDate: detail.productionDate,
      validDays: detail.validDays,
    );
  }

  double get remainingQuantity => plannedQuantity - collectedQuantity;
}
