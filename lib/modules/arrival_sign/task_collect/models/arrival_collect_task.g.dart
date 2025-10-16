// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_collect_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalCollectTaskImpl _$$ArrivalCollectTaskImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalCollectTaskImpl(
      materialCode: json['matcode'] as String,
      materialName: json['matname'] as String?,
      arrivalsBillNo: json['arrivalsBillno'] as String?,
      arrivalsBillId: json['arrivalsBillid'] as String?,
      orderNo: json['orderno'] as String?,
      plannedQuantity: (json['qty'] as num).toDouble(),
      collectedQuantity: (json['goodqty'] as num).toDouble(),
      unit: json['meins'] as String?,
      batchNo: json['batchno'] as String?,
      serialNumber: json['serialNumber'] as String?,
      subInventoryCode: json['subinventoryCode'] as String?,
      materialControlType: (json['matcodecontrol'] as num?)?.toInt(),
      productionDate: json['pdate'] as String?,
      validDays: json['vdays'] as String?,
    );

Map<String, dynamic> _$$ArrivalCollectTaskImplToJson(
        _$ArrivalCollectTaskImpl instance) =>
    <String, dynamic>{
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'arrivalsBillno': instance.arrivalsBillNo,
      'arrivalsBillid': instance.arrivalsBillId,
      'orderno': instance.orderNo,
      'qty': instance.plannedQuantity,
      'goodqty': instance.collectedQuantity,
      'meins': instance.unit,
      'batchno': instance.batchNo,
      'serialNumber': instance.serialNumber,
      'subinventoryCode': instance.subInventoryCode,
      'matcodecontrol': instance.materialControlType,
      'pdate': instance.productionDate,
      'vdays': instance.validDays,
    };
