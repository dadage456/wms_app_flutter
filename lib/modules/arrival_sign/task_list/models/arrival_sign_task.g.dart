// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_sign_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalSignTaskImpl _$$ArrivalSignTaskImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalSignTaskImpl(
      arrivalsBillId: json['arrivalsBillid'] as String,
      arrivalsBillNo: json['arrivalsBillno'] as String,
      orderNo: json['orderno'] as String,
      poNumber: json['poNumber'] as String,
      createDate: json['createdate'] as String,
      plant: json['werks'] as String,
      supplierName: json['parname'] as String,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$ArrivalSignTaskImplToJson(
        _$ArrivalSignTaskImpl instance) =>
    <String, dynamic>{
      'arrivalsBillid': instance.arrivalsBillId,
      'arrivalsBillno': instance.arrivalsBillNo,
      'orderno': instance.orderNo,
      'poNumber': instance.poNumber,
      'createdate': instance.createDate,
      'werks': instance.plant,
      'parname': instance.supplierName,
      'status': instance.status,
    };

_$ArrivalSignTaskPageImpl _$$ArrivalSignTaskPageImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalSignTaskPageImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      rows: (json['rows'] as List<dynamic>?)
              ?.map((e) => ArrivalSignTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ArrivalSignTask>[],
    );

Map<String, dynamic> _$$ArrivalSignTaskPageImplToJson(
        _$ArrivalSignTaskPageImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };
