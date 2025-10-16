// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'inventory_pallet_item.dart';

_$_InventoryPalletItem _$$_InventoryPalletItemFromJson(
        Map<String, dynamic> json) =>
    _$_InventoryPalletItem(
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

Map<String, dynamic> _$$_InventoryPalletItemToJson(
        _$_InventoryPalletItem instance) =>
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
