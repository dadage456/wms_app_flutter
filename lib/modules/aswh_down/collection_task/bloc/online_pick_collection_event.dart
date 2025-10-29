import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

abstract class OnlinePickCollectionEvent extends Equatable {
  const OnlinePickCollectionEvent();

  @override
  List<Object?> get props => [];
}

/// 初始化采集页面
class OnlinePickCollectionInitialized extends OnlinePickCollectionEvent {
  const OnlinePickCollectionInitialized(this.task);

  final OnlinePickTask task;

  @override
  List<Object?> get props => [task];
}

/// 扫码或手输提交
class OnlinePickCollectionScanSubmitted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionScanSubmitted(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

/// 外部同步采集结果，例如从采集结果页返回
class OnlinePickCollectionStocksSynced extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStocksSynced(this.payload, {this.shouldReplace = false});

  final List<dynamic> payload;
  final bool shouldReplace;

  @override
  List<Object?> get props => [payload, shouldReplace];
}

/// 删除采集记录
class OnlinePickCollectionStocksDeleted extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStocksDeleted(this.deletedStocks);

  final List<OnlinePickCollectionStock> deletedStocks;

  @override
  List<Object?> get props => [deletedStocks];
}

/// 任务列表勾选变化
class OnlinePickCollectionTaskSelectionChanged
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionTaskSelectionChanged({this.selectedItemId});

  final int? selectedItemId;

  @override
  List<Object?> get props => [selectedItemId];
}

/// 正在采集列表勾选变化
class OnlinePickCollectionCollectingSelectionChanged
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionCollectingSelectionChanged({this.selectedItemId});

  final int? selectedItemId;

  @override
  List<Object?> get props => [selectedItemId];
}

/// 新增或更新库存核对记录
class OnlinePickCollectionInventoryRecorded extends OnlinePickCollectionEvent {
  const OnlinePickCollectionInventoryRecorded({
    required this.materialCode,
    required this.storeSite,
    this.batchNo,
    this.trayNo,
    required this.quantity,
  });

  final String materialCode;
  final String storeSite;
  final String? batchNo;
  final String? trayNo;
  final num quantity;

  @override
  List<Object?> get props => [materialCode, storeSite, batchNo, trayNo, quantity];
}

/// 更新拣选口位置
class OnlinePickCollectionDestinationUpdated extends OnlinePickCollectionEvent {
  const OnlinePickCollectionDestinationUpdated(this.destination);

  final String destination;

  @override
  List<Object?> get props => [destination];
}

/// 下发空托盘出库指令
class OnlinePickCollectionEmptyTrayOutRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionEmptyTrayOutRequested();
}

/// 下发空托盘入库指令
class OnlinePickCollectionEmptyTrayInRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionEmptyTrayInRequested();
}

/// 请求单个托盘指令
class OnlinePickCollectionSingleTrayRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionSingleTrayRequested();
}

/// 请求全部托盘指令
class OnlinePickCollectionAllTrayRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionAllTrayRequested(this.limit);

  final int limit;

  @override
  List<Object?> get props => [limit];
}

/// 托盘回库指令
class OnlinePickCollectionReturnTrayRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionReturnTrayRequested();
}

/// 切换采集模式
class OnlinePickCollectionModeChanged extends OnlinePickCollectionEvent {
  const OnlinePickCollectionModeChanged(this.mode);

  final OnlinePickCollectionMode mode;

  @override
  List<Object?> get props => [mode];
}

/// 请求提交采集结果
class OnlinePickCollectionCommitRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionCommitRequested();
}

/// 手动切换页签
class OnlinePickCollectionTabChanged extends OnlinePickCollectionEvent {
  const OnlinePickCollectionTabChanged(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

/// 重置提示状态
class OnlinePickCollectionStatusResetRequested
    extends OnlinePickCollectionEvent {
  const OnlinePickCollectionStatusResetRequested();
}

/// 请求聚焦扫码框
class OnlinePickCollectionFocusRequested extends OnlinePickCollectionEvent {
  const OnlinePickCollectionFocusRequested(this.focused);

  final bool focused;

  @override
  List<Object?> get props => [focused];
}

