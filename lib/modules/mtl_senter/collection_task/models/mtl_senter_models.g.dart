// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mtl_senter_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MtlSenterTaskImpl _$$MtlSenterTaskImplFromJson(Map<String, dynamic> json) =>
    _$MtlSenterTaskImpl(
      taskId: json['taskId'] as String,
      workOrderNo: json['workOrderNo'] as String?,
      productionLine: json['productionLine'] as String?,
      workshop: json['workshop'] as String?,
      planQty: (json['planQty'] as num?)?.toDouble(),
      requiredDate: json['requiredDate'] == null
          ? null
          : DateTime.parse(json['requiredDate'] as String),
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$$MtlSenterTaskImplToJson(_$MtlSenterTaskImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'workOrderNo': instance.workOrderNo,
      'productionLine': instance.productionLine,
      'workshop': instance.workshop,
      'planQty': instance.planQty,
      'requiredDate': instance.requiredDate?.toIso8601String(),
      'remark': instance.remark,
    };

_$MtlSenterMaterialImpl _$$MtlSenterMaterialImplFromJson(
        Map<String, dynamic> json) =>
    _$MtlSenterMaterialImpl(
      materialCode: json['materialCode'] as String,
      materialName: json['materialName'] as String?,
      specification: json['specification'] as String?,
      controlType: json['controlType'] as String?,
      storeRoomNo: json['storeRoomNo'] as String?,
      storeSiteNo: json['storeSiteNo'] as String?,
      availableQty: (json['availableQty'] as num?)?.toDouble(),
      minPackageQty: (json['minPackageQty'] as num?)?.toDouble(),
      defaultDeliveryQty: (json['defaultDeliveryQty'] as num?)?.toDouble(),
      batchNo: json['batchNo'] as String?,
      serialNo: json['serialNo'] as String?,
    );

Map<String, dynamic> _$$MtlSenterMaterialImplToJson(
        _$MtlSenterMaterialImpl instance) =>
    <String, dynamic>{
      'materialCode': instance.materialCode,
      'materialName': instance.materialName,
      'specification': instance.specification,
      'controlType': instance.controlType,
      'storeRoomNo': instance.storeRoomNo,
      'storeSiteNo': instance.storeSiteNo,
      'availableQty': instance.availableQty,
      'minPackageQty': instance.minPackageQty,
      'defaultDeliveryQty': instance.defaultDeliveryQty,
      'batchNo': instance.batchNo,
      'serialNo': instance.serialNo,
    };

_$MtlSenterCollectItemImpl _$$MtlSenterCollectItemImplFromJson(
        Map<String, dynamic> json) =>
    _$MtlSenterCollectItemImpl(
      id: json['id'] as String,
      storeSiteNo: json['storeSiteNo'] as String,
      storeRoomNo: json['storeRoomNo'] as String?,
      materialCode: json['materialCode'] as String,
      materialName: json['materialName'] as String?,
      batchNo: json['batchNo'] as String?,
      serialNo: json['serialNo'] as String?,
      productionDate: json['productionDate'] == null
          ? null
          : DateTime.parse(json['productionDate'] as String),
      validDays: (json['validDays'] as num?)?.toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      availableQty: (json['availableQty'] as num?)?.toDouble(),
      minPackageQty: (json['minPackageQty'] as num?)?.toDouble(),
      defaultDeliveryQty: (json['defaultDeliveryQty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MtlSenterCollectItemImplToJson(
        _$MtlSenterCollectItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeSiteNo': instance.storeSiteNo,
      'storeRoomNo': instance.storeRoomNo,
      'materialCode': instance.materialCode,
      'materialName': instance.materialName,
      'batchNo': instance.batchNo,
      'serialNo': instance.serialNo,
      'productionDate': instance.productionDate?.toIso8601String(),
      'validDays': instance.validDays,
      'quantity': instance.quantity,
      'availableQty': instance.availableQty,
      'minPackageQty': instance.minPackageQty,
      'defaultDeliveryQty': instance.defaultDeliveryQty,
    };

_$MtlSenterSubmitRequestImpl _$$MtlSenterSubmitRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MtlSenterSubmitRequestImpl(
      mtlSenderInfos: (json['mtlSenderInfos'] as List<dynamic>?)
              ?.map((e) =>
                  MtlSenterCollectItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MtlSenterCollectItem>[],
      taskNo: json['taskNo'] as String?,
      operatorId: json['operatorId'] as String?,
    );

Map<String, dynamic> _$$MtlSenterSubmitRequestImplToJson(
        _$MtlSenterSubmitRequestImpl instance) =>
    <String, dynamic>{
      'mtlSenderInfos': instance.mtlSenderInfos,
      'taskNo': instance.taskNo,
      'operatorId': instance.operatorId,
    };

_$MtlSenterSubmitResponseImpl _$$MtlSenterSubmitResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MtlSenterSubmitResponseImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$$MtlSenterSubmitResponseImplToJson(
        _$MtlSenterSubmitResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
    };
