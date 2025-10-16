// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_collect_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryTaskItemQueryImpl _$$InventoryTaskItemQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskItemQueryImpl(
      taskId: json['taskId'] as String,
      roomTag: json['roomTag'] as String? ?? '0',
    );

Map<String, dynamic> _$$InventoryTaskItemQueryImplToJson(
        _$InventoryTaskItemQueryImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'roomTag': instance.roomTag,
    };

_$InventoryTaskItemImpl _$$InventoryTaskItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskItemImpl(
      itemId: json['itemid'] as String,
      checkTaskNo: json['checktaskno'] as String?,
      materialCode: json['matcode'] as String,
      materialName: json['matname'] as String?,
      storeSiteNo: json['storesiteno'] as String,
      storeRoomNo: json['storeroomno'] as String?,
      storeRoomName: json['storeroomname'] as String?,
      systemQuantity: (json['systemquantity'] as num?)?.toDouble() ?? 0,
      actualQuantity: (json['actualquantity'] as num?)?.toDouble() ?? 0,
      difference: (json['difference'] as num?)?.toDouble() ?? 0,
      collectedQuantity: (json['collectdataqty'] as num?)?.toDouble() ?? 0,
      checkMethodName: json['checkmethod_nm'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$InventoryTaskItemImplToJson(
        _$InventoryTaskItemImpl instance) =>
    <String, dynamic>{
      'itemid': instance.itemId,
      'checktaskno': instance.checkTaskNo,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'storesiteno': instance.storeSiteNo,
      'storeroomno': instance.storeRoomNo,
      'storeroomname': instance.storeRoomName,
      'systemquantity': instance.systemQuantity,
      'actualquantity': instance.actualQuantity,
      'difference': instance.difference,
      'collectdataqty': instance.collectedQuantity,
      'checkmethod_nm': instance.checkMethodName,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'unit': instance.unit,
    };

_$InventoryBarcodeContentImpl _$$InventoryBarcodeContentImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryBarcodeContentImpl(
      materialCode: json['matcode'] as String?,
      materialName: json['matname'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      quantity: (json['qty'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$InventoryBarcodeContentImplToJson(
        _$InventoryBarcodeContentImpl instance) =>
    <String, dynamic>{
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'qty': instance.quantity,
      'unit': instance.unit,
    };

_$InventoryCollectRecordImpl _$$InventoryCollectRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryCollectRecordImpl(
      itemId: json['itemid'] as String,
      materialCode: json['matcode'] as String,
      materialName: json['matname'] as String?,
      storeSiteNo: json['storesiteno'] as String,
      storeRoomNo: json['storeroomno'] as String?,
      systemQuantity: (json['systemquantity'] as num?)?.toDouble() ?? 0,
      actualQuantity: (json['actualquantity'] as num?)?.toDouble() ?? 0,
      difference: (json['difference'] as num?)?.toDouble() ?? 0,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      unit: json['unit'] as String?,
      taskComment: json['taskComment'] as String?,
    );

Map<String, dynamic> _$$InventoryCollectRecordImplToJson(
        _$InventoryCollectRecordImpl instance) =>
    <String, dynamic>{
      'itemid': instance.itemId,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'storesiteno': instance.storeSiteNo,
      'storeroomno': instance.storeRoomNo,
      'systemquantity': instance.systemQuantity,
      'actualquantity': instance.actualQuantity,
      'difference': instance.difference,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'unit': instance.unit,
      'taskComment': instance.taskComment,
    };

_$InventoryCommitRequestImpl _$$InventoryCommitRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryCommitRequestImpl(
      records: (json['inventoryInfos'] as List<dynamic>?)
              ?.map((e) =>
                  InventoryCollectRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <InventoryCollectRecord>[],
      taskComment: json['taskComment'] as String,
    );

Map<String, dynamic> _$$InventoryCommitRequestImplToJson(
        _$InventoryCommitRequestImpl instance) =>
    <String, dynamic>{
      'inventoryInfos': instance.records,
      'taskComment': instance.taskComment,
    };
