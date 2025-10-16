import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/inventory_task.dart';

part 'aswh_inventory_task_list_event.freezed.dart';

/// 立库盘点任务列表事件定义
@freezed
class AswhInventoryTaskListEvent with _$AswhInventoryTaskListEvent {
  /// 初始化页面
  const factory AswhInventoryTaskListEvent.started() = _Started;

  /// 提交筛选条件
  const factory AswhInventoryTaskListEvent.filterSubmitted(String searchKey) =
      _FilterSubmitted;

  /// 扫码回调
  const factory AswhInventoryTaskListEvent.scanContentReceived(
    String scanContent,
  ) = _ScanContentReceived;

  /// 撤销任务请求
  const factory AswhInventoryTaskListEvent.taskCancelRequested(
    InventoryTaskSummary task,
  ) = _TaskCancelRequested;

  /// 分页切换
  const factory AswhInventoryTaskListEvent.pageChanged(int pageIndex) =
      _PageChanged;

  /// 刷新当前页
  const factory AswhInventoryTaskListEvent.refreshRequested() =
      _RefreshRequested;
}
