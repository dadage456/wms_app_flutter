// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_sign_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalSignDetailImpl _$$ArrivalSignDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalSignDetailImpl(
      materialCode: json['matcode'] as String,
      materialName: json['matname'] as String,
      supplierName: json['parname'] as String?,
      quantity: json['qty'] as num? ?? 0,
      goodQuantity: json['goodqty'] as num? ?? 0,
      batchNo: json['batchno'] as String?,
      serialNumber: json['sn'] as String?,
      subInventoryCode: json['subinventoryCode'] as String?,
      position: json['posnr'] as String?,
      controlType: json['matcodecontrol'] as String?,
      orderNo: json['orderno'] as String?,
      arrivalsBillNo: json['arrivalsBillno'] as String?,
      productionDate: json['pdate'] as String?,
      validDays: json['vdays'] as String?,
    );

Map<String, dynamic> _$$ArrivalSignDetailImplToJson(
        _$ArrivalSignDetailImpl instance) =>
    <String, dynamic>{
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'parname': instance.supplierName,
      'qty': instance.quantity,
      'goodqty': instance.goodQuantity,
      'batchno': instance.batchNo,
      'sn': instance.serialNumber,
      'subinventoryCode': instance.subInventoryCode,
      'posnr': instance.position,
      'matcodecontrol': instance.controlType,
      'orderno': instance.orderNo,
      'arrivalsBillno': instance.arrivalsBillNo,
      'pdate': instance.productionDate,
      'vdays': instance.validDays,
    };

_$ArrivalSignDetailPageImpl _$$ArrivalSignDetailPageImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalSignDetailPageImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      rows: (json['rows'] as List<dynamic>?)
              ?.map(
                  (e) => ArrivalSignDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ArrivalSignDetail>[],
    );

Map<String, dynamic> _$$ArrivalSignDetailPageImplToJson(
        _$ArrivalSignDetailPageImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };
