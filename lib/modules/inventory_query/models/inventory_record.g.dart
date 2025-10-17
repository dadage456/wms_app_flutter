// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryRecordImpl _$$InventoryRecordImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryRecordImpl(
  matcode: json['matcode'] as String? ?? '',
  matname: json['matname'] as String? ?? '',
  batchno: json['batchno'] as String? ?? '',
  sn: json['sn'] as String? ?? '',
  storesiteno: json['storesiteno'] as String? ?? '',
  erpStoreroom: json['erpStoreroom'] as String? ?? '',
  storeroomno: json['storeroomno'] as String? ?? '',
  storeroomname: json['storeroomname'] as String? ?? '',
  repqty: (json['repqty'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$InventoryRecordImplToJson(
  _$InventoryRecordImpl instance,
) => <String, dynamic>{
  'matcode': instance.matcode,
  'matname': instance.matname,
  'batchno': instance.batchno,
  'sn': instance.sn,
  'storesiteno': instance.storesiteno,
  'erpStoreroom': instance.erpStoreroom,
  'storeroomno': instance.storeroomno,
  'storeroomname': instance.storeroomname,
  'repqty': instance.repqty,
};

_$InventoryRecordPageImpl _$$InventoryRecordPageImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryRecordPageImpl(
  rows:
      (json['rows'] as List<dynamic>?)
          ?.map((e) => InventoryRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <InventoryRecord>[],
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$InventoryRecordPageImplToJson(
  _$InventoryRecordPageImpl instance,
) => <String, dynamic>{'rows': instance.rows, 'total': instance.total};
