// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_pallet_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryPalletItemImpl _$$InventoryPalletItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryPalletItemImpl(
      palletNo: json['palletNo'] as String?,
      materialCode: json['matcode'] as String?,
      materialName: json['matname'] as String?,
      batchNo: json['itemBatch'] as String?,
      serialNo: json['itemSn'] as String?,
      quantity: _toDouble(json['itemQty']),
      proofNo: json['proofno'] as String?,
      proofNoAlt: json['proofNo'] as String?,
      storeSite: json['storesite'] as String?,
      storeRoom: json['storeroomno'] as String?,
    );

Map<String, dynamic> _$$InventoryPalletItemImplToJson(
        _$InventoryPalletItemImpl instance) =>
    <String, dynamic>{
      'palletNo': instance.palletNo,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'itemBatch': instance.batchNo,
      'itemSn': instance.serialNo,
      'itemQty': _doubleToJson(instance.quantity),
      'proofno': instance.proofNo,
      'proofNo': instance.proofNoAlt,
      'storesite': instance.storeSite,
      'storeroomno': instance.storeRoom,
    };
