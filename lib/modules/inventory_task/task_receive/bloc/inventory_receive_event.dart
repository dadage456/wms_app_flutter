import 'package:freezed_annotation/freezed_annotation.dart';

import '../../task_list/models/inventory_task.dart';

part 'inventory_receive_event.freezed.dart';

@freezed
class InventoryReceiveEvent with _$InventoryReceiveEvent {
  const factory InventoryReceiveEvent.started() = _Started;
  const factory InventoryReceiveEvent.scanned(String content) = _Scanned;
  const factory InventoryReceiveEvent.searchSubmitted(String keyword) =
      _SearchSubmitted;
  const factory InventoryReceiveEvent.pageChanged(int pageIndex) =
      _PageChanged;
  const factory InventoryReceiveEvent.receiveRequested(InventoryTask task) =
      _ReceiveRequested;
}
