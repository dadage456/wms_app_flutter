// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_barcode_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryBarcodeMaterialImpl _$$InventoryBarcodeMaterialImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryBarcodeMaterialImpl(
  matcode: json['matcode'] as String? ?? '',
  matname: json['matname'] as String? ?? '',
  qty: json['qty'] as String? ?? '',
  batchno: json['batchno'] as String? ?? '',
  sn: json['sn'] as String? ?? '',
  pdate: json['pdate'] as String? ?? '',
  vdays: json['vdays'] as String? ?? '',
  seqctrl: json['seqctrl'] as String? ?? '',
  idOld: json['id_old'] as String? ?? '',
);

Map<String, dynamic> _$$InventoryBarcodeMaterialImplToJson(
  _$InventoryBarcodeMaterialImpl instance,
) => <String, dynamic>{
  'matcode': instance.matcode,
  'matname': instance.matname,
  'qty': instance.qty,
  'batchno': instance.batchno,
  'sn': instance.sn,
  'pdate': instance.pdate,
  'vdays': instance.vdays,
  'seqctrl': instance.seqctrl,
  'id_old': instance.idOld,
};
