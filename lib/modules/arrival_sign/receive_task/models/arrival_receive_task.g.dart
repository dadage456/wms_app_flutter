// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_receive_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalReceiveTaskImpl _$$ArrivalReceiveTaskImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalReceiveTaskImpl(
      arrivalsBillId: json['arrivalsBillid'] as String,
      arrivalsBillNo: json['arrivalsBillno'] as String,
      orderNo: json['orderno'] as String,
      poNumber: json['poNumber'] as String,
      createDate: json['createdate'] as String,
      plant: json['werks'] as String,
      supplierName: json['parname'] as String,
    );

Map<String, dynamic> _$$ArrivalReceiveTaskImplToJson(
        _$ArrivalReceiveTaskImpl instance) =>
    <String, dynamic>{
      'arrivalsBillid': instance.arrivalsBillId,
      'arrivalsBillno': instance.arrivalsBillNo,
      'orderno': instance.orderNo,
      'poNumber': instance.poNumber,
      'createdate': instance.createDate,
      'werks': instance.plant,
      'parname': instance.supplierName,
    };

_$ArrivalReceiveTaskPageImpl _$$ArrivalReceiveTaskPageImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalReceiveTaskPageImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      rows: (json['rows'] as List<dynamic>?)
              ?.map(
                  (e) => ArrivalReceiveTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ArrivalReceiveTask>[],
    );

Map<String, dynamic> _$$ArrivalReceiveTaskPageImplToJson(
        _$ArrivalReceiveTaskPageImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };
