import 'package:freezed_annotation/freezed_annotation.dart';

import '../../task_list/models/inventory_task.dart';
import '../models/inventory_collect_models.dart';
import 'inventory_collect_enums.dart';

part 'inventory_collect_state.freezed.dart';

enum InventoryCollectTab { pending, collecting }

@freezed
class InventoryCollectState with _$InventoryCollectState {
  const factory InventoryCollectState({
    @Default(InventoryCollectStatus.initial) InventoryCollectStatus status,
    InventoryTask? task,
    @Default('') String currentStoreSite,
    InventoryBarcodeContent? barcodeContent,
    @Default(InventoryCollectStep.scanLocation) InventoryCollectStep step,
    @Default(InventoryCollectTab.pending) InventoryCollectTab activeTab,
    @Default(<InventoryTaskItem>[]) List<InventoryTaskItem> taskItems,
    @Default(<InventoryCollectRecord>[])
    List<InventoryCollectRecord> collectingRecords,
    String? message,
    @Default(false) bool hasUnsubmittedData,
  }) = _InventoryCollectState;
}
