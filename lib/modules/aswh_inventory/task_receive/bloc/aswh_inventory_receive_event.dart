import 'package:equatable/equatable.dart';

import '../../task_list/models/inventory_task.dart';

/// 立库盘点接收页事件定义
abstract class AswhInventoryReceiveEvent extends Equatable {
  const AswhInventoryReceiveEvent();

  @override
  List<Object?> get props => [];
}

/// 页面初始化
class AswhInventoryReceiveStarted extends AswhInventoryReceiveEvent {
  const AswhInventoryReceiveStarted();
}

/// 文本框提交查询
class AswhInventoryReceiveSearchSubmitted extends AswhInventoryReceiveEvent {
  const AswhInventoryReceiveSearchSubmitted(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

/// 扫码回调
class AswhInventoryReceiveScanCaptured extends AswhInventoryReceiveEvent {
  const AswhInventoryReceiveScanCaptured(this.scanContent);

  final String scanContent;

  @override
  List<Object?> get props => [scanContent];
}

/// 分页切换
class AswhInventoryReceivePageChanged extends AswhInventoryReceiveEvent {
  const AswhInventoryReceivePageChanged(this.pageIndex);

  final int pageIndex;

  @override
  List<Object?> get props => [pageIndex];
}

/// 执行接收确认
class AswhInventoryReceiveConfirmed extends AswhInventoryReceiveEvent {
  const AswhInventoryReceiveConfirmed(this.task);

  final InventoryTaskSummary task;

  @override
  List<Object?> get props => [task];
}
