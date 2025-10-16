import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

abstract class OnlinePickTaskDetailEvent extends Equatable {
  const OnlinePickTaskDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnlinePickTaskDetailInitialized extends OnlinePickTaskDetailEvent {
  const OnlinePickTaskDetailInitialized({
    required this.task,
  });

  final OnlinePickTask task;

  @override
  List<Object?> get props => [task];
}

class OnlinePickTaskDetailSearchSubmitted extends OnlinePickTaskDetailEvent {
  const OnlinePickTaskDetailSearchSubmitted(this.keyword);

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}

class OnlinePickTaskDetailScanRequested extends OnlinePickTaskDetailEvent {
  const OnlinePickTaskDetailScanRequested(this.scanContent);

  final String scanContent;

  @override
  List<Object?> get props => [scanContent];
}

class OnlinePickTaskDetailCancelSubmitted extends OnlinePickTaskDetailEvent {
  const OnlinePickTaskDetailCancelSubmitted();
}

class OnlinePickTaskDetailRefreshRequested extends OnlinePickTaskDetailEvent {
  const OnlinePickTaskDetailRefreshRequested();
}

class OnlinePickTaskDetailStatusReset extends OnlinePickTaskDetailEvent {
  const OnlinePickTaskDetailStatusReset();
}
