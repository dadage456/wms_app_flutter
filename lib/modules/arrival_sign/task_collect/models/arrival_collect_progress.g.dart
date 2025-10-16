// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_collect_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalCollectProgressImpl _$$ArrivalCollectProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalCollectProgressImpl(
      id: json['id'] as String,
      task: ArrivalCollectTask.fromJson(json['task'] as Map<String, dynamic>),
      collectQty: (json['collectQty'] as num).toDouble(),
      batchNo: json['batchNo'] as String?,
      serialNumber: json['serialNumber'] as String?,
      productionDate: json['productionDate'] as String?,
      validDays: json['validDays'] as String?,
      submitted: json['submitted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ArrivalCollectProgressImplToJson(
        _$ArrivalCollectProgressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': _taskToJson(instance.task),
      'collectQty': instance.collectQty,
      'batchNo': instance.batchNo,
      'serialNumber': instance.serialNumber,
      'productionDate': instance.productionDate,
      'validDays': instance.validDays,
      'submitted': instance.submitted,
    };

_$ArrivalCollectSummaryImpl _$$ArrivalCollectSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalCollectSummaryImpl(
      id: json['id'] as String,
      materialCode: json['materialCode'] as String,
      materialName: json['materialName'] as String?,
      batchNo: json['batchNo'] as String?,
      serialNumber: json['serialNumber'] as String?,
      collectQty: (json['collectQty'] as num?)?.toDouble(),
      taskQty: (json['taskQty'] as num?)?.toDouble(),
      productionDate: json['productionDate'] as String?,
      validDays: json['validDays'] as String?,
      committed: json['committed'] as bool? ?? false,
    );

Map<String, dynamic> _$$ArrivalCollectSummaryImplToJson(
        _$ArrivalCollectSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'materialCode': instance.materialCode,
      'materialName': instance.materialName,
      'batchNo': instance.batchNo,
      'serialNumber': instance.serialNumber,
      'collectQty': instance.collectQty,
      'taskQty': instance.taskQty,
      'productionDate': instance.productionDate,
      'validDays': instance.validDays,
      'committed': instance.committed,
    };
