// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_query_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryQueryRequestImpl _$$InventoryQueryRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryQueryRequestImpl(
      barcode: json['barcode'] as String,
      queryType: json['currStep'] as String,
      pageIndex: (json['PageIndex'] as num?)?.toInt() ?? 1,
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 10000,
    );

Map<String, dynamic> _$$InventoryQueryRequestImplToJson(
        _$InventoryQueryRequestImpl instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'currStep': instance.queryType,
      'PageIndex': instance.pageIndex,
      'PageSize': instance.pageSize,
    };
