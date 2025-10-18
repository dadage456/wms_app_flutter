// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_collection_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferCollectedItemImpl _$$TransferCollectedItemImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferCollectedItemImpl(
      id: json['id'] as String,
      sourceSite: json['sourceSite'] as String,
      targetSite: json['targetSite'] as String,
      materialCode: json['materialCode'] as String,
      materialName: json['materialName'] as String?,
      batchNo: json['batchNo'] as String?,
      serialNo: json['serialNo'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      supplier: json['supplier'] as String?,
      erpRoom: json['erpRoom'] as String?,
      projectNumber: json['projectNumber'] as String?,
      ownerCode: json['ownerCode'] as String?,
    );

Map<String, dynamic> _$$TransferCollectedItemImplToJson(
        _$TransferCollectedItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceSite': instance.sourceSite,
      'targetSite': instance.targetSite,
      'materialCode': instance.materialCode,
      'materialName': instance.materialName,
      'batchNo': instance.batchNo,
      'serialNo': instance.serialNo,
      'quantity': instance.quantity,
      'supplier': instance.supplier,
      'erpRoom': instance.erpRoom,
      'projectNumber': instance.projectNumber,
      'ownerCode': instance.ownerCode,
    };

_$TransferInventoryRowImpl _$$TransferInventoryRowImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferInventoryRowImpl(
      storeSiteNo: json['storesiteno'] as String,
      materialCode: json['matcode'] as String,
      quantity: (json['repqty'] as num?)?.toDouble() ?? 0,
      batchNo: json['batchno'] as String?,
      projectNumber: json['projectNum'] as String?,
      erpStoreRoom: json['erpStoreroom'] as String?,
      palletNo: json['palletno'] as String?,
      serialNo: json['sn'] as String?,
      storeRoomName: json['storeroomname'] as String?,
      ownerCode: json['erpOwnerCode'] as String?,
    );

Map<String, dynamic> _$$TransferInventoryRowImplToJson(
        _$TransferInventoryRowImpl instance) =>
    <String, dynamic>{
      'storesiteno': instance.storeSiteNo,
      'matcode': instance.materialCode,
      'repqty': instance.quantity,
      'batchno': instance.batchNo,
      'projectNum': instance.projectNumber,
      'erpStoreroom': instance.erpStoreRoom,
      'palletno': instance.palletNo,
      'sn': instance.serialNo,
      'storeroomname': instance.storeRoomName,
      'erpOwnerCode': instance.ownerCode,
    };

_$TransferSubmitEntryImpl _$$TransferSubmitEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferSubmitEntryImpl(
      outSite: json['outSite'] as String,
      inSite: json['inSite'] as String,
      materialCode: json['materialCode'] as String,
      batchNo: json['batchNo'] as String?,
      serialNo: json['sn'] as String?,
      quantity: (json['qty'] as num).toDouble(),
      moveDesc: json['moveDesc'] as String? ?? '',
      supplier: json['supplier'] as String?,
      erpRoom: json['erpRoom'] as String?,
      projectNumber: json['projectNum'] as String?,
    );

Map<String, dynamic> _$$TransferSubmitEntryImplToJson(
        _$TransferSubmitEntryImpl instance) =>
    <String, dynamic>{
      'outSite': instance.outSite,
      'inSite': instance.inSite,
      'materialCode': instance.materialCode,
      'batchNo': instance.batchNo,
      'sn': instance.serialNo,
      'qty': instance.quantity,
      'moveDesc': instance.moveDesc,
      'supplier': instance.supplier,
      'erpRoom': instance.erpRoom,
      'projectNum': instance.projectNumber,
    };

_$TransferSubmitPayloadImpl _$$TransferSubmitPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferSubmitPayloadImpl(
      entries: (json['transferInfos'] as List<dynamic>)
          .map((e) => TransferSubmitEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      filter: json['filter'] as String? ?? '',
    );

Map<String, dynamic> _$$TransferSubmitPayloadImplToJson(
        _$TransferSubmitPayloadImpl instance) =>
    <String, dynamic>{
      'transferInfos': instance.entries,
      'filter': instance.filter,
    };

_$TransferUiMessageImpl _$$TransferUiMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferUiMessageImpl(
      title: json['title'] as String,
      message: json['message'] as String,
      isError: json['isError'] as bool? ?? false,
    );

Map<String, dynamic> _$$TransferUiMessageImplToJson(
        _$TransferUiMessageImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'isError': instance.isError,
    };
