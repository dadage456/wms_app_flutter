import 'package:equatable/equatable.dart';

import '../../models/inventory_collect_models.dart';

abstract class AswhInventoryCollectDetailEvent extends Equatable {
  const AswhInventoryCollectDetailEvent();

  @override
  List<Object?> get props => [];
}

class AswhInventoryCollectDetailStarted
    extends AswhInventoryCollectDetailEvent {
  const AswhInventoryCollectDetailStarted({
    required this.taskId,
    required this.taskComment,
    required this.records,
    required this.taskItems,
    this.activeTrayNo,
    this.activeStoreSiteNo,
    this.lastScannedCode,
  });

  final String taskId;
  final String taskComment;
  final List<InventoryCollectingRecord> records;
  final List<InventoryTaskItem> taskItems;
  final String? activeTrayNo;
  final String? activeStoreSiteNo;
  final String? lastScannedCode;

  @override
  List<Object?> get props => [
        taskId,
        taskComment,
        records,
        taskItems,
        activeTrayNo,
        activeStoreSiteNo,
        lastScannedCode,
      ];
}

class AswhInventoryCollectDetailSelectionChanged
    extends AswhInventoryCollectDetailEvent {
  const AswhInventoryCollectDetailSelectionChanged(this.selectedIds);

  final Set<String> selectedIds;

  @override
  List<Object?> get props => [selectedIds];
}

class AswhInventoryCollectDetailSelectAllToggled
    extends AswhInventoryCollectDetailEvent {
  const AswhInventoryCollectDetailSelectAllToggled(this.selectAll);

  final bool selectAll;

  @override
  List<Object?> get props => [selectAll];
}

class AswhInventoryCollectDetailDeleteRequested
    extends AswhInventoryCollectDetailEvent {
  const AswhInventoryCollectDetailDeleteRequested();
}

class AswhInventoryCollectDetailDeletionConfirmed
    extends AswhInventoryCollectDetailEvent {
  const AswhInventoryCollectDetailDeletionConfirmed();
}

class AswhInventoryCollectDetailDeletionCancelled
    extends AswhInventoryCollectDetailEvent {
  const AswhInventoryCollectDetailDeletionCancelled();
}
