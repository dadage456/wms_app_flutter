import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';

abstract class InboundCollectionEvent extends Equatable {
  const InboundCollectionEvent();

  @override
  List<Object?> get props => [];
}

class InitializeInboundCollectionEvent extends InboundCollectionEvent {
  const InitializeInboundCollectionEvent({required this.task, required this.userId});

  final GoodsUpTask task;
  final int userId;

  @override
  List<Object?> get props => [task, userId];
}

class PerformInboundScanEvent extends InboundCollectionEvent {
  const PerformInboundScanEvent(this.barcode);

  final String barcode;

  @override
  List<Object?> get props => [barcode];
}

class ChangeInboundTabEvent extends InboundCollectionEvent {
  const ChangeInboundTabEvent(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class CommitInboundCollectionEvent extends InboundCollectionEvent {
  const CommitInboundCollectionEvent();
}

class ResetInboundStatusEvent extends InboundCollectionEvent {
  const ResetInboundStatusEvent();
}

class SetInboundFocusEvent extends InboundCollectionEvent {
  const SetInboundFocusEvent(this.focus);

  final bool focus;

  @override
  List<Object?> get props => [focus];
}

class DeleteInboundStocksEvent extends InboundCollectionEvent {
  const DeleteInboundStocksEvent(this.stockIds);

  final List<String> stockIds;

  @override
  List<Object?> get props => [stockIds];
}

class UpdateInboundResultEvent extends InboundCollectionEvent {
  const UpdateInboundResultEvent(this.deletedStocks);

  final List<InboundCollectionStock> deletedStocks;

  @override
  List<Object?> get props => [deletedStocks];
}

class UpdateInboundProductionDateEvent extends InboundCollectionEvent {
  const UpdateInboundProductionDateEvent(this.productionDate);

  final String productionDate;

  @override
  List<Object?> get props => [productionDate];
}

class UpdateInboundExpireDaysEvent extends InboundCollectionEvent {
  const UpdateInboundExpireDaysEvent(this.expireDays);

  final String expireDays;

  @override
  List<Object?> get props => [expireDays];
}
