import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/outbound_collect_models.dart';
import '../../task_list/models/outbound_task.dart';
import '../../task_details/models/outbound_task_item.dart';

part 'outbound_collect_state.freezed.dart';

/// 出库采集状态
@freezed
class OutboundCollectState with _$OutboundCollectState {
  /// 初始状态
  const factory OutboundCollectState.initial() = OutboundCollectInitial;

  /// 加载中状态
  const factory OutboundCollectState.loading() = OutboundCollectLoading;

  /// 已加载状态
  const factory OutboundCollectState.loaded({
    required OutboundTask task,
    required List<OutboundTaskItem> taskItems,
    required List<CollectRecord> collectRecords,
    required int currentTabIndex,
    required ScanStep currentScanStep,
    required String userId,
    required String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
    @Default(false) bool isSubmitting,
    @Default(false) bool isValidating,
    String? errorMessage,
    String? successMessage,
  }) = OutboundCollectLoaded;

  /// 扫码处理中状态
  const factory OutboundCollectState.scanProcessing({
    required OutboundTask task,
    required List<OutboundTaskItem> taskItems,
    required List<CollectRecord> collectRecords,
    required int currentTabIndex,
    required ScanStep currentScanStep,
    required String userId,
    required String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
    required String scanContent,
  }) = OutboundCollectScanProcessing;

  /// 库存查询中状态
  const factory OutboundCollectState.inventoryQuerying({
    required OutboundTask task,
    required List<OutboundTaskItem> taskItems,
    required List<CollectRecord> collectRecords,
    required int currentTabIndex,
    required ScanStep currentScanStep,
    required String userId,
    required String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    required InventoryQuery query,
  }) = OutboundCollectInventoryQuerying;

  /// 提交中状态
  const factory OutboundCollectState.submitting({
    required OutboundTask task,
    required List<OutboundTaskItem> taskItems,
    required List<CollectRecord> collectRecords,
    required int currentTabIndex,
    required ScanStep currentScanStep,
    required String userId,
    required String workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
  }) = OutboundCollectSubmitting;

  /// 错误状态
  const factory OutboundCollectState.error({
    required String message,
    OutboundTask? task,
    List<OutboundTaskItem>? taskItems,
    List<CollectRecord>? collectRecords,
    int? currentTabIndex,
    ScanStep? currentScanStep,
    String? userId,
    String? workStation,
    String? currentSiteCode,
    BarcodeContent? currentBarcodeContent,
    List<InventoryInfo>? currentInventory,
  }) = OutboundCollectError;
}
