// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventorySummaryImpl _$$InventorySummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$InventorySummaryImpl(
      materialCode: json['materialCode'] as String? ?? '',
      materialName: json['materialName'] as String? ?? '',
      storeSite: json['storeSite'] as String? ?? '',
      trayNo: json['trayNo'] as String? ?? '',
      totalQuantity: (json['totalQuantity'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$InventorySummaryImplToJson(
        _$InventorySummaryImpl instance) =>
    <String, dynamic>{
      'materialCode': instance.materialCode,
      'materialName': instance.materialName,
      'storeSite': instance.storeSite,
      'trayNo': instance.trayNo,
      'totalQuantity': instance.totalQuantity,
    };
