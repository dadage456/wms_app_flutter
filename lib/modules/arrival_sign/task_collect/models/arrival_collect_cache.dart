import 'package:freezed_annotation/freezed_annotation.dart';

import 'arrival_collect_progress.dart';

part 'arrival_collect_cache.freezed.dart';
part 'arrival_collect_cache.g.dart';

/// Hive 缓存模型（后续可扩展为 HiveType）。
@freezed
class ArrivalCollectCache with _$ArrivalCollectCache {
  @JsonSerializable(explicitToJson: true)
  const factory ArrivalCollectCache({
    @Default(<ArrivalCollectProgress>[])
    List<ArrivalCollectProgress> progresses,
    @Default(false) bool hasPendingSubmit,
    String? arrivalsBillId,
  }) = _ArrivalCollectCache;

  factory ArrivalCollectCache.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectCacheFromJson(json);
}
