import 'package:freezed_annotation/freezed_annotation.dart';

import '../../task_list/models/inventory_task.dart';
import '../models/inventory_collect_models.dart';

part 'inventory_collect_event.freezed.dart';

@freezed
class InventoryCollectEvent with _$InventoryCollectEvent {
  const factory InventoryCollectEvent.started(InventoryTask task) = _Started;
  const factory InventoryCollectEvent.storeSiteScanned(String storeSite) =
      _StoreSiteScanned;
  const factory InventoryCollectEvent.materialScanned(String barcode) =
      _MaterialScanned;
  const factory InventoryCollectEvent.quantitySubmitted(double quantity) =
      _QuantitySubmitted;
  const factory InventoryCollectEvent.tabChanged(int index) = _TabChanged;
  const factory InventoryCollectEvent.recordsRemoved(
    List<InventoryCollectRecord> removed,
  ) = _RecordsRemoved;
  const factory InventoryCollectEvent.submitRequested() = _SubmitRequested;
  const factory InventoryCollectEvent.refreshRequested() = _RefreshRequested;
}
