// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_query_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryQueryStateImpl _$$InventoryQueryStateImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryQueryStateImpl(
  status:
      $enumDecodeNullable(_$PageStatusEnumMap, json['status']) ??
      PageStatus.initial,
  barcodeMaterial: json['barcodeMaterial'] == null
      ? null
      : InventoryBarcodeMaterial.fromJson(
          json['barcodeMaterial'] as Map<String, dynamic>,
        ),
  summary: json['summary'] == null
      ? const InventorySummary()
      : InventorySummary.fromJson(json['summary'] as Map<String, dynamic>),
  records:
      (json['records'] as List<dynamic>?)
          ?.map((e) => InventoryRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <InventoryRecord>[],
  selectedMode:
      $enumDecodeNullable(_$InventoryQueryModeEnumMap, json['selectedMode']) ??
      InventoryQueryMode.material,
  queryValue: json['queryValue'] as String?,
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 10000,
  total: (json['total'] as num?)?.toInt() ?? 0,
  errorMessage: json['errorMessage'] as String?,
  focusTick: (json['focusTick'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$InventoryQueryStateImplToJson(
  _$InventoryQueryStateImpl instance,
) => <String, dynamic>{
  'status': _$PageStatusEnumMap[instance.status]!,
  'barcodeMaterial': instance.barcodeMaterial,
  'summary': instance.summary,
  'records': instance.records,
  'selectedMode': _$InventoryQueryModeEnumMap[instance.selectedMode]!,
  'queryValue': instance.queryValue,
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
  'total': instance.total,
  'errorMessage': instance.errorMessage,
  'focusTick': instance.focusTick,
};

const _$PageStatusEnumMap = {
  PageStatus.initial: 'initial',
  PageStatus.loading: 'loading',
  PageStatus.success: 'success',
  PageStatus.failure: 'failure',
};

const _$InventoryQueryModeEnumMap = {
  InventoryQueryMode.material: 'material',
  InventoryQueryMode.storeSite: 'storeSite',
  InventoryQueryMode.tray: 'tray',
};
