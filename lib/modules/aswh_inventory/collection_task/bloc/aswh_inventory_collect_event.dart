import 'package:equatable/equatable.dart';

import '../models/inventory_collect_models.dart';
import 'aswh_inventory_collect_enums.dart';

abstract class AswhInventoryCollectEvent extends Equatable {
  const AswhInventoryCollectEvent();

  @override
  List<Object?> get props => [];
}

class AswhInventoryCollectStarted extends AswhInventoryCollectEvent {
  const AswhInventoryCollectStarted({
    required this.query,
    this.taskKey,
  });

  final InventoryTaskItemQuery query;
  final String? taskKey;

  @override
  List<Object?> get props => [query, taskKey];
}

class AswhInventoryCollectScanCaptured extends AswhInventoryCollectEvent {
  const AswhInventoryCollectScanCaptured(this.code, {this.scannedAt});

  final String code;
  final DateTime? scannedAt;

  @override
  List<Object?> get props => [code, scannedAt];
}

class AswhInventoryCollectTrayConfirmed extends AswhInventoryCollectEvent {
  const AswhInventoryCollectTrayConfirmed(this.trayCode);

  final String trayCode;

  @override
  List<Object?> get props => [trayCode];
}

class AswhInventoryCollectSiteValidated extends AswhInventoryCollectEvent {
  const AswhInventoryCollectSiteValidated(this.siteCode);

  final String siteCode;

  @override
  List<Object?> get props => [siteCode];
}

class AswhInventoryCollectMaterialDecoded extends AswhInventoryCollectEvent {
  const AswhInventoryCollectMaterialDecoded(this.materialCode);

  final String materialCode;

  @override
  List<Object?> get props => [materialCode];
}

class AswhInventoryCollectQuantityEntered extends AswhInventoryCollectEvent {
  const AswhInventoryCollectQuantityEntered(this.quantity);

  final double quantity;

  @override
  List<Object?> get props => [quantity];
}

class AswhInventoryCollectTaskItemSelected extends AswhInventoryCollectEvent {
  const AswhInventoryCollectTaskItemSelected(this.taskItem);

  final InventoryTaskItem taskItem;

  @override
  List<Object?> get props => [taskItem];
}

class AswhInventoryCollectSwitchTabRequested extends AswhInventoryCollectEvent {
  const AswhInventoryCollectSwitchTabRequested(this.tab);

  final AswhInventoryCollectTab tab;

  @override
  List<Object?> get props => [tab];
}

class AswhInventoryCollectSubmitRequested extends AswhInventoryCollectEvent {
  const AswhInventoryCollectSubmitRequested();
}

class AswhInventoryCollectCommandActionTriggered
    extends AswhInventoryCollectEvent {
  const AswhInventoryCollectCommandActionTriggered(this.command);

  final InventoryCollectCommand command;

  @override
  List<Object?> get props => [command];
}

class AswhInventoryCollectPopupClosed extends AswhInventoryCollectEvent {
  const AswhInventoryCollectPopupClosed();
}

class AswhInventoryCollectSelectionChanged extends AswhInventoryCollectEvent {
  const AswhInventoryCollectSelectionChanged(this.selectedIds);

  final Set<String> selectedIds;

  @override
  List<Object?> get props => [selectedIds];
}

class AswhInventoryCollectResetRequested extends AswhInventoryCollectEvent {
  const AswhInventoryCollectResetRequested();
}

class AswhInventoryCollectPickLocationChanged extends AswhInventoryCollectEvent {
  const AswhInventoryCollectPickLocationChanged(this.location);

  final InventoryPickLocation location;

  @override
  List<Object?> get props => [location];
}

class AswhInventoryCollectCommandMenuVisibilityChanged
    extends AswhInventoryCollectEvent {
  const AswhInventoryCollectCommandMenuVisibilityChanged(this.isOpen);

  final bool isOpen;

  @override
  List<Object?> get props => [isOpen];
}

class AswhInventoryCollectSingleTrayRequested
    extends AswhInventoryCollectEvent {
  const AswhInventoryCollectSingleTrayRequested();
}

class AswhInventoryCollectBulkTrayRequested extends AswhInventoryCollectEvent {
  const AswhInventoryCollectBulkTrayRequested(this.quantity);

  final int quantity;

  @override
  List<Object?> get props => [quantity];
}

class AswhInventoryCollectReturnTrayRequested
    extends AswhInventoryCollectEvent {
  const AswhInventoryCollectReturnTrayRequested();
}

class AswhInventoryCollectResultsPatched extends AswhInventoryCollectEvent {
  const AswhInventoryCollectResultsPatched({
    required this.records,
    required this.taskItems,
    this.message,
  });

  final List<InventoryCollectingRecord> records;
  final List<InventoryTaskItem> taskItems;
  final String? message;

  @override
  List<Object?> get props => [records, taskItems, message];
}
