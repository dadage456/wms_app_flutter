import 'package:equatable/equatable.dart';

import '../models/transfer_collection_models.dart';

abstract class TransferCollectionEvent extends Equatable {
  const TransferCollectionEvent();
}

/// 页面初始化
class TransferStarted extends TransferCollectionEvent {
  const TransferStarted({this.storeRoom = '', this.erpStoreRoom = ''});

  final String storeRoom;
  final String erpStoreRoom;

  @override
  List<Object?> get props => [storeRoom, erpStoreRoom];
}

/// 重置扫描上下文
class TransferResetRequested extends TransferCollectionEvent {
  const TransferResetRequested();

  @override
  List<Object?> get props => [];
}

/// 扫码或输入内容
class ScanInputSubmitted extends TransferCollectionEvent {
  const ScanInputSubmitted({required this.input, this.isManual = false});

  final String input;
  final bool isManual;

  @override
  List<Object?> get props => [input, isManual];
}

/// 数量确认
class QuantityConfirmed extends TransferCollectionEvent {
  const QuantityConfirmed(this.quantity);

  final double quantity;

  @override
  List<Object?> get props => [quantity];
}

/// 模式切换
class TransferModeToggled extends TransferCollectionEvent {
  const TransferModeToggled(this.mode);

  final TransferMode mode;

  @override
  List<Object?> get props => [mode];
}

/// 查询库存
class InventoryQueryRequested extends TransferCollectionEvent {
  const InventoryQueryRequested();

  @override
  List<Object?> get props => [];
}

/// 勾选采集项
class CollectedItemChecked extends TransferCollectionEvent {
  const CollectedItemChecked({required this.itemId, required this.checked});

  final String itemId;
  final bool checked;

  @override
  List<Object?> get props => [itemId, checked];
}

/// 删除选中采集项
class CollectedItemsDeleted extends TransferCollectionEvent {
  const CollectedItemsDeleted();

  @override
  List<Object?> get props => [];
}

/// 发起提交
class TransferSubmitRequested extends TransferCollectionEvent {
  const TransferSubmitRequested();

  @override
  List<Object?> get props => [];
}

/// Tab切换
class TransferTabChanged extends TransferCollectionEvent {
  const TransferTabChanged(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

/// 请求重新聚焦
class TransferFocusRequested extends TransferCollectionEvent {
  const TransferFocusRequested(this.shouldFocus);

  final bool shouldFocus;

  @override
  List<Object?> get props => [shouldFocus];
}

/// 清空状态提示
class TransferStatusCleared extends TransferCollectionEvent {
  const TransferStatusCleared();

  @override
  List<Object?> get props => [];
}
