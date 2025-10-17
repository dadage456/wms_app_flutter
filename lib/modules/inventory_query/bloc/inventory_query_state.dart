import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/inventory_barcode_material.dart';
import '../models/inventory_query_request.dart';
import '../models/inventory_record.dart';
import '../models/inventory_summary.dart';

part 'inventory_query_state.freezed.dart';
part 'inventory_query_state.g.dart';

enum PageStatus { initial, loading, success, failure }

@freezed
class InventoryQueryState with _$InventoryQueryState {
  const factory InventoryQueryState({
    @Default(PageStatus.initial) PageStatus status,
    InventoryBarcodeMaterial? barcodeMaterial,
    @Default(InventorySummary()) InventorySummary summary,
    @Default(<InventoryRecord>[]) List<InventoryRecord> records,
    @Default(InventoryQueryMode.material) InventoryQueryMode selectedMode,
    String? queryValue,
    @Default(1) int currentPage,
    @Default(10000) int pageSize,
    @Default(0) int total,
    String? errorMessage,
    @Default(0) int focusTick,
  }) = _InventoryQueryState;

  const InventoryQueryState._();

  factory InventoryQueryState.fromJson(Map<String, dynamic> json) =>
      _$InventoryQueryStateFromJson(json);

  int get totalPages {
    if (total <= 0 || pageSize <= 0) return 1;
    final pages = total ~/ pageSize;
    final remainder = total % pageSize;
    return remainder == 0 ? (pages == 0 ? 1 : pages) : pages + 1;
  }
}
