// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_task_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferStoreSiteInfoImpl _$$TransferStoreSiteInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferStoreSiteInfoImpl(
      storeRoomNo: json['storeroomno'] as String?,
      storeRoomName: json['storeroomname'] as String?,
      erpStoreRoom: json['erpstoreroom'] as String?,
      erpStoreRoomUpper: json['erpStoreroom'] as String?,
      erpOwnerCode: json['erpOwnerCode'] as String?,
      projectNumber: json['projectNum'] as String?,
      frozenFlag: json['isfrozen'],
      frozenFlagUpper: json['isFrozen'],
    );

Map<String, dynamic> _$$TransferStoreSiteInfoImplToJson(
        _$TransferStoreSiteInfoImpl instance) =>
    <String, dynamic>{
      'storeroomno': instance.storeRoomNo,
      'storeroomname': instance.storeRoomName,
      'erpstoreroom': instance.erpStoreRoom,
      'erpStoreroom': instance.erpStoreRoomUpper,
      'erpOwnerCode': instance.erpOwnerCode,
      'projectNum': instance.projectNumber,
      'isfrozen': instance.frozenFlag,
      'isFrozen': instance.frozenFlagUpper,
    };

_$TransferMaterialDetailImpl _$$TransferMaterialDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferMaterialDetailImpl(
      materialCode: json['matcode'] as String?,
      materialCodeUpper: json['matCode'] as String?,
      materialName: json['matname'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      controlFlag: json['matcontrol'] as String?,
      controlFlagUpper: json['matControl'] as String?,
      quantity: json['qty'],
      projectNumber: json['projectNum'] as String?,
      erpStoreRoom: json['erpStoreroom'] as String?,
      ownerCode: json['erpOwnerCode'] as String?,
    );

Map<String, dynamic> _$$TransferMaterialDetailImplToJson(
        _$TransferMaterialDetailImpl instance) =>
    <String, dynamic>{
      'matcode': instance.materialCode,
      'matCode': instance.materialCodeUpper,
      'matname': instance.materialName,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'matcontrol': instance.controlFlag,
      'matControl': instance.controlFlagUpper,
      'qty': instance.quantity,
      'projectNum': instance.projectNumber,
      'erpStoreroom': instance.erpStoreRoom,
      'erpOwnerCode': instance.ownerCode,
    };
