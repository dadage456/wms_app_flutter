import 'package:equatable/equatable.dart';

import '../../models/inventory_collect_models.dart';
import '../../models/inventory_collect_detail_models.dart';

enum AswhInventoryCollectDetailStatus { initial, loading, ready, updating, success, failure }

class AswhInventoryCollectDetailState extends Equatable {
  const AswhInventoryCollectDetailState({
    this.status = AswhInventoryCollectDetailStatus.initial,
    this.items = const <InventoryCollectedItem>[],
    this.taskItems = const <InventoryTaskItem>[],
    this.selectedIds = const <String>{},
    this.pendingDeletion = false,
    this.isAllSelected = false,
    this.message,
    this.taskId,
    this.taskComment,
    this.hasChanges = false,
    this.activeTrayNo,
    this.activeStoreSiteNo,
    this.lastScannedCode,
  });

  final AswhInventoryCollectDetailStatus status;
  final List<InventoryCollectedItem> items;
  final List<InventoryTaskItem> taskItems;
  final Set<String> selectedIds;
  final bool pendingDeletion;
  final bool isAllSelected;
  final String? message;
  final String? taskId;
  final String? taskComment;
  final bool hasChanges;
  final String? activeTrayNo;
  final String? activeStoreSiteNo;
  final String? lastScannedCode;

  AswhInventoryCollectDetailState copyWith({
    AswhInventoryCollectDetailStatus? status,
    List<InventoryCollectedItem>? items,
    List<InventoryTaskItem>? taskItems,
    Set<String>? selectedIds,
    bool? pendingDeletion,
    bool? isAllSelected,
    String? message,
    String? taskId,
    String? taskComment,
    bool? hasChanges,
    String? activeTrayNo,
    String? activeStoreSiteNo,
    String? lastScannedCode,
  }) {
    return AswhInventoryCollectDetailState(
      status: status ?? this.status,
      items: items ?? this.items,
      taskItems: taskItems ?? this.taskItems,
      selectedIds: selectedIds ?? this.selectedIds,
      pendingDeletion: pendingDeletion ?? this.pendingDeletion,
      isAllSelected: isAllSelected ??
          ((selectedIds ?? this.selectedIds).length ==
                  (items ?? this.items).length &&
              (items ?? this.items).isNotEmpty),
      message: message,
      taskId: taskId ?? this.taskId,
      taskComment: taskComment ?? this.taskComment,
      hasChanges: hasChanges ?? this.hasChanges,
      activeTrayNo: activeTrayNo ?? this.activeTrayNo,
      activeStoreSiteNo: activeStoreSiteNo ?? this.activeStoreSiteNo,
      lastScannedCode: lastScannedCode ?? this.lastScannedCode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        taskItems,
        selectedIds,
        pendingDeletion,
        isAllSelected,
        message,
        taskId,
        taskComment,
        hasChanges,
        activeTrayNo,
        activeStoreSiteNo,
        lastScannedCode,
      ];
}
