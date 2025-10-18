import 'package:equatable/equatable.dart';

import '../../../../models/page_status.dart';
import '../models/transfer_collection_models.dart';

enum TransferTab { collection, inventory }

class TransferCollectionState extends Equatable {
  const TransferCollectionState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.submitStatus = const CollectionStatus(CollectionStatusType.normal),
    this.context = const TransferScanContext(),
    this.collectedItems = const [],
    this.selectedIds = const {},
    this.inventoryRows = const [],
    this.activeTab = TransferTab.collection,
    this.quantityDict = const {},
    this.serialDict = const {},
    this.message,
  });

  final CollectionStatus status;
  final CollectionStatus submitStatus;
  final TransferScanContext context;
  final List<TransferCollectedItem> collectedItems;
  final Set<String> selectedIds;
  final List<TransferInventoryRow> inventoryRows;
  final TransferTab activeTab;
  final Map<String, double> quantityDict;
  final Map<String, String> serialDict;
  final TransferUiMessage? message;

  bool get hasSelection => selectedIds.isNotEmpty;

  TransferCollectionState copyWith({
    CollectionStatus? status,
    CollectionStatus? submitStatus,
    TransferScanContext? context,
    List<TransferCollectedItem>? collectedItems,
    Set<String>? selectedIds,
    List<TransferInventoryRow>? inventoryRows,
    TransferTab? activeTab,
    Map<String, double>? quantityDict,
    Map<String, String>? serialDict,
    TransferUiMessage? message,
  }) {
    return TransferCollectionState(
      status: status ?? this.status,
      submitStatus: submitStatus ?? this.submitStatus,
      context: context ?? this.context,
      collectedItems: collectedItems ?? this.collectedItems,
      selectedIds: selectedIds ?? this.selectedIds,
      inventoryRows: inventoryRows ?? this.inventoryRows,
      activeTab: activeTab ?? this.activeTab,
      quantityDict: quantityDict ?? this.quantityDict,
      serialDict: serialDict ?? this.serialDict,
      message: message,
    );
  }

  TransferCollectionState clearStatus() {
    return copyWith(
      status: const CollectionStatus(CollectionStatusType.normal),
      submitStatus: const CollectionStatus(CollectionStatusType.normal),
      message: null,
    );
  }

  @override
  List<Object?> get props => [
        status,
        submitStatus,
        context,
        collectedItems,
        selectedIds,
        inventoryRows,
        activeTab,
        quantityDict,
        serialDict,
        message,
      ];
}
