import 'package:equatable/equatable.dart';

import '../../task_list/models/goods_up_task.dart';
import '../models/inbound_collection_models.dart';

abstract class InboundCollectionEvent extends Equatable {
  const InboundCollectionEvent();

  @override
  List<Object?> get props => [];
}

class InitializeInboundCollectionEvent extends InboundCollectionEvent {
  const InitializeInboundCollectionEvent({
    required this.task,
    required this.userId,
  });

  final GoodsUpTask task;
  final int userId;

  @override
  List<Object?> get props => [task, userId];
}

class PerformInboundScanEvent extends InboundCollectionEvent {
  const PerformInboundScanEvent(this.payload);

  final String payload;

  @override
  List<Object?> get props => [payload];
}

class ChangeInboundTabEvent extends InboundCollectionEvent {
  const ChangeInboundTabEvent(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class UpdateInboundSelectionEvent extends InboundCollectionEvent {
  const UpdateInboundSelectionEvent(this.selectedIds);

  final List<int> selectedIds;

  @override
  List<Object?> get props => [selectedIds];
}

class CommitInboundCollectionEvent extends InboundCollectionEvent {
  const CommitInboundCollectionEvent();
}

class ResetInboundStatusEvent extends InboundCollectionEvent {
  const ResetInboundStatusEvent();
}

class RequestInboundFocusEvent extends InboundCollectionEvent {
  const RequestInboundFocusEvent(this.focused);

  final bool focused;

  @override
  List<Object?> get props => [focused];
}

class DeleteInboundStocksEvent extends InboundCollectionEvent {
  const DeleteInboundStocksEvent(this.stockIds);

  final List<String> stockIds;

  @override
  List<Object?> get props => [stockIds];
}

class UpdateInboundFromResultEvent extends InboundCollectionEvent {
  const UpdateInboundFromResultEvent(this.deletedStocks);

  final List<InboundCollectionStock> deletedStocks;

  @override
  List<Object?> get props => [deletedStocks];
}

class ClearInboundCacheEvent extends InboundCollectionEvent {
  const ClearInboundCacheEvent();
}
