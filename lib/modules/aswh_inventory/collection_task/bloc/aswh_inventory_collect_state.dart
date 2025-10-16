import 'package:equatable/equatable.dart';

import '../models/inventory_collect_models.dart';
import 'aswh_inventory_collect_enums.dart';

const _messageNoChange = Object();
const _popupNoChange = Object();
const _taskIdNoChange = Object();
const _taskCommentNoChange = Object();

enum AswhInventoryCollectStatus {
  initial,
  loading,
  ready,
  submitting,
  success,
  failure,
}

enum AswhCollectPopupType { info, confirm, trayQuantity }

class AswhCollectPopupAction extends Equatable {
  const AswhCollectPopupAction({
    required this.key,
    required this.label,
    this.isPrimary = false,
  });

  final String key;
  final String label;
  final bool isPrimary;

  @override
  List<Object?> get props => [key, label, isPrimary];
}

class AswhCollectPopup extends Equatable {
  const AswhCollectPopup({
    required this.type,
    required this.title,
    required this.message,
    this.actions = const [],
  });

  final AswhCollectPopupType type;
  final String title;
  final String message;
  final List<AswhCollectPopupAction> actions;

  @override
  List<Object?> get props => [type, title, message, actions];
}

class AswhCollectCommandMenu extends Equatable {
  const AswhCollectCommandMenu({this.isOpen = false});

  final bool isOpen;

  AswhCollectCommandMenu copyWith({bool? isOpen}) {
    return AswhCollectCommandMenu(
      isOpen: isOpen ?? this.isOpen,
    );
  }

  @override
  List<Object?> get props => [isOpen];
}

class AswhInventoryCollectState extends Equatable {
  const AswhInventoryCollectState({
    this.status = AswhInventoryCollectStatus.initial,
    this.currentStep = AswhInventoryCollectStep.trayScan,
    this.activeTab = AswhInventoryCollectTab.taskList,
    this.taskItems = const <InventoryTaskItem>[],
    this.collectingItems = const <InventoryCollectingRecord>[],
    this.collectedItems = const <InventoryCollectingRecord>[],
    this.selectedIds = const <String>{},
    this.pickLocations = const <InventoryPickLocation>[],
    this.isLoading = false,
    this.isSubmitting = false,
    this.message,
    this.currentTrayCode,
    this.currentSiteCode,
    this.activeTask,
    this.popup,
    this.commandMenu = const AswhCollectCommandMenu(),
    this.lastScannedCode,
    this.restoredSnapshot,
    this.selectedPickLocation,
    this.materialControls = const {},
    this.taskId,
    this.taskComment,
  });

  final AswhInventoryCollectStatus status;
  final AswhInventoryCollectStep currentStep;
  final AswhInventoryCollectTab activeTab;
  final List<InventoryTaskItem> taskItems;
  final List<InventoryCollectingRecord> collectingItems;
  final List<InventoryCollectingRecord> collectedItems;
  final Set<String> selectedIds;
  final List<InventoryPickLocation> pickLocations;
  final bool isLoading;
  final bool isSubmitting;
  final String? message;
  final String? currentTrayCode;
  final String? currentSiteCode;
  final InventoryTaskItem? activeTask;
  final AswhCollectPopup? popup;
  final AswhCollectCommandMenu commandMenu;
  final String? lastScannedCode;
  final InventoryCollectStateSnapshot? restoredSnapshot;
  final InventoryPickLocation? selectedPickLocation;
  final Map<String, InventoryMatControl> materialControls;
  final String? taskId;
  final String? taskComment;

  AswhInventoryCollectState copyWith({
    AswhInventoryCollectStatus? status,
    AswhInventoryCollectStep? currentStep,
    AswhInventoryCollectTab? activeTab,
    List<InventoryTaskItem>? taskItems,
    List<InventoryCollectingRecord>? collectingItems,
    List<InventoryCollectingRecord>? collectedItems,
    Set<String>? selectedIds,
    List<InventoryPickLocation>? pickLocations,
    bool? isLoading,
    bool? isSubmitting,
    Object? message = _messageNoChange,
    String? currentTrayCode,
    String? currentSiteCode,
    InventoryTaskItem? activeTask,
    Object? popup = _popupNoChange,
    AswhCollectCommandMenu? commandMenu,
    String? lastScannedCode,
    InventoryCollectStateSnapshot? restoredSnapshot,
    InventoryPickLocation? selectedPickLocation,
    Map<String, InventoryMatControl>? materialControls,
    Object? taskId = _taskIdNoChange,
    Object? taskComment = _taskCommentNoChange,
  }) {
    return AswhInventoryCollectState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      activeTab: activeTab ?? this.activeTab,
      taskItems: taskItems ?? this.taskItems,
      collectingItems: collectingItems ?? this.collectingItems,
      collectedItems: collectedItems ?? this.collectedItems,
      selectedIds: selectedIds ?? this.selectedIds,
      pickLocations: pickLocations ?? this.pickLocations,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      message:
          identical(message, _messageNoChange) ? this.message : message as String?,
      currentTrayCode: currentTrayCode ?? this.currentTrayCode,
      currentSiteCode: currentSiteCode ?? this.currentSiteCode,
      activeTask: activeTask ?? this.activeTask,
      popup: identical(popup, _popupNoChange)
          ? this.popup
          : popup as AswhCollectPopup?,
      commandMenu: commandMenu ?? this.commandMenu,
      lastScannedCode: lastScannedCode ?? this.lastScannedCode,
      restoredSnapshot: restoredSnapshot ?? this.restoredSnapshot,
      selectedPickLocation: selectedPickLocation ?? this.selectedPickLocation,
      materialControls: materialControls ?? this.materialControls,
      taskId: identical(taskId, _taskIdNoChange)
          ? this.taskId
          : taskId as String?,
      taskComment: identical(taskComment, _taskCommentNoChange)
          ? this.taskComment
          : taskComment as String?,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentStep,
        activeTab,
        taskItems,
        collectingItems,
        collectedItems,
        selectedIds.toList(),
        pickLocations,
        isLoading,
        isSubmitting,
        message,
        currentTrayCode,
        currentSiteCode,
        activeTask,
        popup,
        commandMenu,
        lastScannedCode,
        restoredSnapshot,
        selectedPickLocation,
        materialControls,
        taskId,
        taskComment,
      ];
}
