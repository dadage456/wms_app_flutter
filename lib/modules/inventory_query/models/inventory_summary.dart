import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_summary.freezed.dart';
part 'inventory_summary.g.dart';

/// 页面顶部汇总信息。
@freezed
class InventorySummary with _$InventorySummary {
  const factory InventorySummary({
    @Default('') String materialCode,
    @Default('') String materialName,
    @Default('') String storeSite,
    @Default('') String trayNo,
    @Default(0.0) double totalQuantity,
  }) = _InventorySummary;

  factory InventorySummary.fromJson(Map<String, dynamic> json) =>
      _$InventorySummaryFromJson(json);
}
