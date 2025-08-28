import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/outbound_task_item.dart';

part 'outbound_task_detail_event.freezed.dart';

/// 出库任务明细事件
@freezed
class OutboundTaskDetailEvent with _$OutboundTaskDetailEvent {
  /// 加载出库任务明细列表
  const factory OutboundTaskDetailEvent.loadTaskItems({
    required OutboundTaskItemQuery query,
  }) = LoadTaskItemsEvent;

  /// 搜索出库任务明细
  const factory OutboundTaskDetailEvent.searchTaskItems({
    required OutboundTaskItemQuery query,
  }) = SearchTaskItemsEvent;

  /// 扫码搜索物料
  const factory OutboundTaskDetailEvent.scanQRCode({
    required String qrContent,
  }) = ScanQRCodeEvent;

  /// 选择任务明细项
  const factory OutboundTaskDetailEvent.selectTaskItem({
    required String taskItemId,
    required bool isSelected,
  }) = SelectTaskItemEvent;

  /// 全选/取消全选
  const factory OutboundTaskDetailEvent.selectAll({
    required bool isSelectAll,
  }) = SelectAllEvent;

  /// 撤销选中的任务明细
  const factory OutboundTaskDetailEvent.cancelSelectedItems() = CancelSelectedItemsEvent;

  /// 清除选择状态
  const factory OutboundTaskDetailEvent.clearSelection() = ClearSelectionEvent;

  /// 刷新列表
  const factory OutboundTaskDetailEvent.refresh() = RefreshEvent;

  /// 加载更多数据
  const factory OutboundTaskDetailEvent.loadMore() = LoadMoreEvent;
}