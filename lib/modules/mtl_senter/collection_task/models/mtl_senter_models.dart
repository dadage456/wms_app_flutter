import 'package:freezed_annotation/freezed_annotation.dart';

part 'mtl_senter_models.freezed.dart';
part 'mtl_senter_models.g.dart';

/// 扫码步骤
enum MtlSenterScanStep {
  /// 待扫描库位
  location,

  /// 待扫描物料二维码
  material,

  /// 待输入数量
  quantity,

  /// 初始/空闲状态
  idle,
}

@freezed
class MtlSenterTask with _$MtlSenterTask {
  const factory MtlSenterTask({
    /// 任务 ID
    required String taskId,

    /// 工单号
    String? workOrderNo,

    /// 产线/班组
    String? productionLine,

    /// 需求车间
    String? workshop,

    /// 计划数量
    double? planQty,

    /// 需求日期
    DateTime? requiredDate,

    /// 备注
    String? remark,
  }) = _MtlSenterTask;

  factory MtlSenterTask.fromJson(Map<String, dynamic> json) =>
      _$MtlSenterTaskFromJson(json);
}

@freezed
class MtlSenterMaterial with _$MtlSenterMaterial {
  const factory MtlSenterMaterial({
    /// 物料编码
    required String materialCode,

    /// 物料名称
    String? materialName,

    /// 规格型号
    String? specification,

    /// 控制方式（批次/序列）
    String? controlType,

    /// 默认库房
    String? storeRoomNo,

    /// 默认库位
    String? storeSiteNo,

    /// 可用库存
    double? availableQty,

    /// 最小包装数
    double? minPackageQty,

    /// 默认配送量
    double? defaultDeliveryQty,

    /// 生产批次
    String? batchNo,

    /// 序列号
    String? serialNo,
  }) = _MtlSenterMaterial;

  factory MtlSenterMaterial.fromJson(Map<String, dynamic> json) =>
      _$MtlSenterMaterialFromJson(json);
}

@freezed
class MtlSenterCollectItem with _$MtlSenterCollectItem {
  const factory MtlSenterCollectItem({
    /// 行内唯一标识
    required String id,

    /// 库位编码
    required String storeSiteNo,

    /// 库房编码
    String? storeRoomNo,

    /// 物料编码
    required String materialCode,

    /// 物料名称
    String? materialName,

    /// 批次号
    String? batchNo,

    /// 序列号
    String? serialNo,

    /// 生产日期
    DateTime? productionDate,

    /// 失效天数
    int? validDays,

    /// 采集数量
    required double quantity,

    /// 当前库位可用库存
    double? availableQty,

    /// 最小包装
    double? minPackageQty,

    /// 默认配送量
    double? defaultDeliveryQty,
  }) = _MtlSenterCollectItem;

  factory MtlSenterCollectItem.fromJson(Map<String, dynamic> json) =>
      _$MtlSenterCollectItemFromJson(json);
}

@freezed
class MtlSenterSubmitRequest with _$MtlSenterSubmitRequest {
  const factory MtlSenterSubmitRequest({
    /// 采集提交列表
    @Default(<MtlSenterCollectItem>[]) List<MtlSenterCollectItem> mtlSenderInfos,

    /// 提交任务号
    String? taskNo,

    /// 操作人工号
    String? operatorId,
  }) = _MtlSenterSubmitRequest;

  factory MtlSenterSubmitRequest.fromJson(Map<String, dynamic> json) =>
      _$MtlSenterSubmitRequestFromJson(json);
}

@freezed
class MtlSenterSubmitResponse with _$MtlSenterSubmitResponse {
  const factory MtlSenterSubmitResponse({
    /// 接口状态码
    String? code,

    /// 提示信息
    String? message,

    /// 是否成功
    bool? success,
  }) = _MtlSenterSubmitResponse;

  factory MtlSenterSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$MtlSenterSubmitResponseFromJson(json);
}

extension MtlSenterScanStepX on MtlSenterScanStep {
  String get placeholder {
    switch (this) {
      case MtlSenterScanStep.location:
        return '请扫描货架号';
      case MtlSenterScanStep.material:
        return '请扫描二维码';
      case MtlSenterScanStep.quantity:
        return '请输入数量';
      case MtlSenterScanStep.idle:
        return '请开始采集';
    }
  }
}
