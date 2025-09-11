import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/outbound_collect_models.dart';
import '../models/outbound_task.dart';

part 'outbound_collect_event.freezed.dart';

/// 出库采集事件
@freezed
class OutboundCollectEvent with _$OutboundCollectEvent {
  /// 初始化采集页面
  const factory OutboundCollectEvent.initialize({
    required OutboundTask task,
    required String userId,
    required String workStation,
  }) = InitializeCollectEvent;

  /// 加载任务明细列表
  const factory OutboundCollectEvent.loadTaskItems() = LoadTaskItemsEvent;

  /// 刷新任务明细列表
  const factory OutboundCollectEvent.refreshTaskItems() = RefreshTaskItemsEvent;

  /// 搜索任务明细
  const factory OutboundCollectEvent.searchTaskItems({
    required String searchKey,
  }) = SearchTaskItemsEvent;

  /// 处理扫码内容
  const factory OutboundCollectEvent.processScanCode({
    required String content,
  }) = ProcessScanCodeEvent;

  /// 验证库位
  const factory OutboundCollectEvent.validateSite({
    required String siteCode,
  }) = ValidateSiteEvent;

  /// 验证物料
  const factory OutboundCollectEvent.validateMaterial({
    required BarcodeContent barcodeContent,
    required String siteCode,
  }) = ValidateMaterialEvent;

  /// 查询库存
  const factory OutboundCollectEvent.queryInventory({
    required InventoryQuery query,
  }) = QueryInventoryEvent;

  /// 确认采集数量
  const factory OutboundCollectEvent.confirmQuantity({
    required int quantity,
  }) = ConfirmQuantityEvent;

  /// 添加采集记录
  const factory OutboundCollectEvent.addCollectRecord({
    required CollectRecord record,
  }) = AddCollectRecordEvent;

  /// 删除采集记录
  const factory OutboundCollectEvent.removeCollectRecord({
    required int index,
  }) = RemoveCollectRecordEvent;

  /// 清空采集记录
  const factory OutboundCollectEvent.clearCollectRecords() = ClearCollectRecordsEvent;

  /// 提交采集数据
  const factory OutboundCollectEvent.submitCollectData() = SubmitCollectDataEvent;

  /// 报缺任务明细
  const factory OutboundCollectEvent.reportShortage({
    required String outTaskItemId,
  }) = ReportShortageEvent;

  /// 切换Tab
  const factory OutboundCollectEvent.switchTab({
    required int tabIndex,
  }) = SwitchTabEvent;

  /// 重置扫码状态
  const factory OutboundCollectEvent.resetScanState() = ResetScanStateEvent;

  /// 设置当前扫码步骤
  const factory OutboundCollectEvent.setScanStep({
    required ScanStep step,
  }) = SetScanStepEvent;

  /// 设置当前库位
  const factory OutboundCollectEvent.setCurrentSite({
    required String siteCode,
  }) = SetCurrentSiteEvent;

  /// 设置当前物料信息
  const factory OutboundCollectEvent.setCurrentMaterial({
    required BarcodeContent barcodeContent,
  }) = SetCurrentMaterialEvent;

  /// 异常采集
  const factory OutboundCollectEvent.exceptionCollect({
    required CollectRecord record,
    required String reason,
  }) = ExceptionCollectEvent;
}