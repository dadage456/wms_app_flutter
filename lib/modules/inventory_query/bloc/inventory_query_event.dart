import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/inventory_query_request.dart';

part 'inventory_query_event.freezed.dart';

@freezed
class InventoryQueryEvent with _$InventoryQueryEvent {
  const factory InventoryQueryEvent.initialized() = _Initialized;

  const factory InventoryQueryEvent.barcodeScanned(String raw) =
      _BarcodeScanned;

  const factory InventoryQueryEvent.manualSubmitted({required String input}) =
      _ManualSubmitted;

  const factory InventoryQueryEvent.pageChanged(int pageIndex) = _PageChanged;

  const factory InventoryQueryEvent.resetRequested() = _ResetRequested;

  const factory InventoryQueryEvent.modeChanged(InventoryQueryMode mode) =
      _ModeChanged;
}
