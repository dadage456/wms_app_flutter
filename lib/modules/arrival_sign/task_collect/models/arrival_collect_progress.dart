import 'package:freezed_annotation/freezed_annotation.dart';

import 'arrival_collect_task.dart';

part 'arrival_collect_progress.freezed.dart';
part 'arrival_collect_progress.g.dart';

/// 描述采集中临时记录
@freezed
class ArrivalCollectProgress with _$ArrivalCollectProgress {
  @JsonSerializable(explicitToJson: true)
  const factory ArrivalCollectProgress({
    required String id,
    @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
    required ArrivalCollectTask task,
    required double collectQty,
    String? batchNo,
    String? serialNumber,
    String? productionDate,
    String? validDays,
    @Default(false) bool submitted,
  }) = _ArrivalCollectProgress;

  factory ArrivalCollectProgress.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectProgressFromJson(json);
}

/// 多步扫码流程
enum ArrivalCollectScanStep { materialQRCode, quantity, location }

/// 采集结果摘要
@freezed
class ArrivalCollectSummary with _$ArrivalCollectSummary {
  const factory ArrivalCollectSummary({
    required String id,
    required String materialCode,
    String? materialName,
    String? batchNo,
    String? serialNumber,
    double? collectQty,
    double? taskQty,
    String? productionDate,
    String? validDays,
    @Default(false) bool committed,
  }) = _ArrivalCollectSummary;

  factory ArrivalCollectSummary.fromProgress(ArrivalCollectProgress progress) {
    return ArrivalCollectSummary(
      id: progress.id,
      materialCode: progress.task.materialCode,
      materialName: progress.task.materialName,
      batchNo: progress.batchNo ?? progress.task.batchNo,
      serialNumber: progress.serialNumber ?? progress.task.serialNumber,
      collectQty: progress.collectQty,
      taskQty: progress.task.plannedQuantity,
      productionDate: progress.productionDate ?? progress.task.productionDate,
      validDays: progress.validDays ?? progress.task.validDays,
    );
  }

  factory ArrivalCollectSummary.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectSummaryFromJson(json);
}

Map<String, dynamic> _taskToJson(ArrivalCollectTask task) => task.toJson();
