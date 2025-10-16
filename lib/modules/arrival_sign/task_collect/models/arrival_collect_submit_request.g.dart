// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_collect_submit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalCollectSubmitRequestImpl _$$ArrivalCollectSubmitRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ArrivalCollectSubmitRequestImpl(
  upShelvesInfos:
      (json['upShelvesInfos'] as List<dynamic>?)
          ?.map(
            (e) => ArrivalCollectSubmitItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ArrivalCollectSubmitItem>[],
  itemListInfos:
      (json['itemListInfos'] as List<dynamic>?)
          ?.map(
            (e) => ArrivalCollectSubmitItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ArrivalCollectSubmitItem>[],
  filter: json['filter'] == null
      ? null
      : ArrivalCollectSubmitFilter.fromJson(
          json['filter'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$ArrivalCollectSubmitRequestImplToJson(
  _$ArrivalCollectSubmitRequestImpl instance,
) => <String, dynamic>{
  'upShelvesInfos': instance.upShelvesInfos,
  'itemListInfos': instance.itemListInfos,
  'filter': instance.filter,
};

_$ArrivalCollectSubmitItemImpl _$$ArrivalCollectSubmitItemImplFromJson(
  Map<String, dynamic> json,
) => _$ArrivalCollectSubmitItemImpl(
  matCode: json['matcode'] as String,
  batchNo: json['batchno'] as String?,
  serialNumber: json['sn'] as String?,
  quantity: (json['qty'] as num).toDouble(),
);

Map<String, dynamic> _$$ArrivalCollectSubmitItemImplToJson(
  _$ArrivalCollectSubmitItemImpl instance,
) => <String, dynamic>{
  'matcode': instance.matCode,
  'batchno': instance.batchNo,
  'sn': instance.serialNumber,
  'qty': instance.quantity,
};

_$ArrivalCollectSubmitFilterImpl _$$ArrivalCollectSubmitFilterImplFromJson(
  Map<String, dynamic> json,
) => _$ArrivalCollectSubmitFilterImpl(
  userCode: json['userCode'] as String,
  arrivalsBillId: json['arrivalsBillid'] as String,
);

Map<String, dynamic> _$$ArrivalCollectSubmitFilterImplToJson(
  _$ArrivalCollectSubmitFilterImpl instance,
) => <String, dynamic>{
  'userCode': instance.userCode,
  'arrivalsBillid': instance.arrivalsBillId,
};
