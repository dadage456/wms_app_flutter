// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbound_collect_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectRecordImpl _$$CollectRecordImplFromJson(Map<String, dynamic> json) =>
    _$CollectRecordImpl(
      matCode: json['matcode'] as String,
      matName: json['matname'] as String,
      storeSiteNo: json['storesiteno'] as String,
      qty: (json['qty'] as num).toInt(),
      batchNo: json['batchno'] as String?,
      sn: json['sn'] as String?,
      pdate: json['pdate'] as String?,
      vdays: json['vdays'] as String?,
      seqCtrl: json['seqctrl'] as String?,
      idOld: json['id_old'] as String?,
      outTaskItemId: (json['outtaskitemid'] as num?)?.toInt(),
      collectTime: json['collecttime'] as String?,
    );

Map<String, dynamic> _$$CollectRecordImplToJson(_$CollectRecordImpl instance) =>
    <String, dynamic>{
      'matcode': instance.matCode,
      'matname': instance.matName,
      'storesiteno': instance.storeSiteNo,
      'qty': instance.qty,
      'batchno': instance.batchNo,
      'sn': instance.sn,
      'pdate': instance.pdate,
      'vdays': instance.vdays,
      'seqctrl': instance.seqCtrl,
      'id_old': instance.idOld,
      'outtaskitemid': instance.outTaskItemId,
      'collecttime': instance.collectTime,
    };

_$InventoryInfoImpl _$$InventoryInfoImplFromJson(Map<String, dynamic> json) =>
    _$InventoryInfoImpl(
      matCode: json['matcode'] as String,
      matName: json['matname'] as String,
      storeSiteNo: json['storesiteno'] as String,
      qty: (json['qty'] as num).toInt(),
      batchNo: json['batchno'] as String?,
      sn: json['sn'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      subInventoryCode: json['subinventorycode'] as String?,
    );

Map<String, dynamic> _$$InventoryInfoImplToJson(_$InventoryInfoImpl instance) =>
    <String, dynamic>{
      'matcode': instance.matCode,
      'matname': instance.matName,
      'storesiteno': instance.storeSiteNo,
      'qty': instance.qty,
      'batchno': instance.batchNo,
      'sn': instance.sn,
      'storeroomno': instance.storeRoomNo,
      'subinventorycode': instance.subInventoryCode,
    };

_$InventoryQueryImpl _$$InventoryQueryImplFromJson(Map<String, dynamic> json) =>
    _$InventoryQueryImpl(
      storeSite: json['storesite'] as String,
      matCode: json['matcode'] as String?,
      batchNo: json['batchno'] as String?,
      sn: json['sn'] as String?,
    );

Map<String, dynamic> _$$InventoryQueryImplToJson(
  _$InventoryQueryImpl instance,
) => <String, dynamic>{
  'storesite': instance.storeSite,
  'matcode': instance.matCode,
  'batchno': instance.batchNo,
  'sn': instance.sn,
};

_$InventoryResponseImpl _$$InventoryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryResponseImpl(
  code: json['code'] as String,
  message: json['msg'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => InventoryInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$InventoryResponseImplToJson(
  _$InventoryResponseImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

_$BarcodeContentImpl _$$BarcodeContentImplFromJson(Map<String, dynamic> json) =>
    _$BarcodeContentImpl(
      matCode: json['matCode'] as String,
      batchNo: json['batchNo'] as String?,
      sn: json['sn'] as String?,
      pdate: json['pdate'] as String?,
      vdays: json['vdays'] as String?,
      originalContent: json['originalContent'] as String,
      needsApiParsing: json['needsApiParsing'] as bool? ?? false,
    );

Map<String, dynamic> _$$BarcodeContentImplToJson(
  _$BarcodeContentImpl instance,
) => <String, dynamic>{
  'matCode': instance.matCode,
  'batchNo': instance.batchNo,
  'sn': instance.sn,
  'pdate': instance.pdate,
  'vdays': instance.vdays,
  'originalContent': instance.originalContent,
  'needsApiParsing': instance.needsApiParsing,
};

_$SubmitCollectResponseImpl _$$SubmitCollectResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SubmitCollectResponseImpl(
  code: json['code'] as String,
  message: json['msg'] as String,
  data: json['data'],
);

Map<String, dynamic> _$$SubmitCollectResponseImplToJson(
  _$SubmitCollectResponseImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

_$ReportShortageResponseImpl _$$ReportShortageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ReportShortageResponseImpl(
  code: json['code'] as String,
  message: json['msg'] as String,
  data: json['data'],
);

Map<String, dynamic> _$$ReportShortageResponseImplToJson(
  _$ReportShortageResponseImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};
