// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_collect_detail_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryCollectedItemImpl _$$InventoryCollectedItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryCollectedItemImpl(
      stockId: json['stockid'] as String,
      invTaskItemId: json['InvTaskItemid'] as String,
      sourceQty: (json['InventoryQty'] as num?)?.toDouble() ?? 0,
      materialCode: json['matcode'] as String,
      materialName: json['matname'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      storeRoomNo: json['storeRoom'] as String,
      storeSiteNo: json['storeSite'] as String,
      trayNo: json['TrayNo'] as String?,
      materialId: json['MatId'] as String?,
    );

Map<String, dynamic> _$$InventoryCollectedItemImplToJson(
        _$InventoryCollectedItemImpl instance) =>
    <String, dynamic>{
      'stockid': instance.stockId,
      'InvTaskItemid': instance.invTaskItemId,
      'InventoryQty': instance.sourceQty,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'storeRoom': instance.storeRoomNo,
      'storeSite': instance.storeSiteNo,
      'TrayNo': instance.trayNo,
      'MatId': instance.materialId,
    };
