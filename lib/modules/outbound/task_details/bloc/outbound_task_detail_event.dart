import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/outbound_task_item.dart';

part 'outbound_task_detail_event.freezed.dart';

/// 出库任务明细事件
@freezed
class OutboundTaskDetailEvent with _$OutboundTaskDetailEvent {
  /// 搜索出库任务明细
  const factory OutboundTaskDetailEvent.search({
    required String searchKey,
  }) = SearchEvent;

  /// 扫码搜索物料
  const factory OutboundTaskDetailEvent.scanQRCode({
    required String qrContent,
  }) = ScanQRCodeEvent;

  /// 撤销选中的任务明细
  const factory OutboundTaskDetailEvent.cancelSelectedItems({
    required List<String> selectedItemIds,
  }) = CancelSelectedItemsEvent;

  /// 刷新列表
  const factory OutboundTaskDetailEvent.refresh() = RefreshEvent;
}
