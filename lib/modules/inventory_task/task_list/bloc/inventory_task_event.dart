import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/inventory_task.dart';

part 'inventory_task_event.freezed.dart';

@freezed
class InventoryTaskEvent with _$InventoryTaskEvent {
  const factory InventoryTaskEvent.started() = _Started;
  const factory InventoryTaskEvent.scanned(String content) = _Scanned;
  const factory InventoryTaskEvent.searchSubmitted(String keyword) =
      _SearchSubmitted;
  const factory InventoryTaskEvent.pageChanged(int pageIndex) = _PageChanged;
  const factory InventoryTaskEvent.refreshRequested() = _RefreshRequested;
  const factory InventoryTaskEvent.cancelTaskRequested(InventoryTask task) =
      _CancelTaskRequested;
  const factory InventoryTaskEvent.navigateToReceive() = _NavigateToReceive;
}
