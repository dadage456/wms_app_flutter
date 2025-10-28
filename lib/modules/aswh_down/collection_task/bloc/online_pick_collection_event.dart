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

