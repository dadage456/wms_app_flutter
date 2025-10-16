// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_collect_cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArrivalCollectCacheImpl _$$ArrivalCollectCacheImplFromJson(
        Map<String, dynamic> json) =>
    _$ArrivalCollectCacheImpl(
      progresses: (json['progresses'] as List<dynamic>?)
              ?.map((e) =>
                  ArrivalCollectProgress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ArrivalCollectProgress>[],
      hasPendingSubmit: json['hasPendingSubmit'] as bool? ?? false,
      arrivalsBillId: json['arrivalsBillId'] as String?,
    );

Map<String, dynamic> _$$ArrivalCollectCacheImplToJson(
        _$ArrivalCollectCacheImpl instance) =>
    <String, dynamic>{
      'progresses': instance.progresses.map((e) => e.toJson()).toList(),
      'hasPendingSubmit': instance.hasPendingSubmit,
      'arrivalsBillId': instance.arrivalsBillId,
    };
