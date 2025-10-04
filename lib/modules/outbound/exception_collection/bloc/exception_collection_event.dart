import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';

abstract class ExceptionCollectionEvent extends Equatable {
  const ExceptionCollectionEvent();

  @override
  List<Object?> get props => [];
}

class InitializeExceptionCollectionEvent extends ExceptionCollectionEvent {
  final OutboundTask task;
  final String trayNo;
  final String initialStoreSite;

  const InitializeExceptionCollectionEvent({
    required this.task,
    this.trayNo = '',
    this.initialStoreSite = '',
  });

  @override
  List<Object?> get props => [task, trayNo, initialStoreSite];
}

class ExceptionTypeChangedEvent extends ExceptionCollectionEvent {
  final String type;
  final String name;

  const ExceptionTypeChangedEvent({required this.type, required this.name});

  @override
  List<Object?> get props => [type, name];
}

class ExceptionPerformScanEvent extends ExceptionCollectionEvent {
  final String barcode;

  const ExceptionPerformScanEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class ExceptionSelectionChangedEvent extends ExceptionCollectionEvent {
  final List<String> selectedIds;

  const ExceptionSelectionChangedEvent(this.selectedIds);

  @override
  List<Object?> get props => [selectedIds];
}

class ExceptionDeleteSelectedEvent extends ExceptionCollectionEvent {
  const ExceptionDeleteSelectedEvent();
}

class ExceptionCommitRequestedEvent extends ExceptionCollectionEvent {
  const ExceptionCommitRequestedEvent();
}

class ExceptionClearErrorEvent extends ExceptionCollectionEvent {
  const ExceptionClearErrorEvent();
}

class ExceptionClearMessageEvent extends ExceptionCollectionEvent {
  const ExceptionClearMessageEvent();
}
