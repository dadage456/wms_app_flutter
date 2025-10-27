import 'package:equatable/equatable.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

abstract class OnlinePickReceiveDetailEvent extends Equatable {
  const OnlinePickReceiveDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnlinePickReceiveDetailStarted extends OnlinePickReceiveDetailEvent {
  const OnlinePickReceiveDetailStarted({required this.outTaskId, this.task});

  final int outTaskId;
  final OnlinePickTask? task;

  @override
  List<Object?> get props => [outTaskId, task];
}

class OnlinePickReceiveDetailSearchSubmitted
    extends OnlinePickReceiveDetailEvent {
  const OnlinePickReceiveDetailSearchSubmitted(this.keyword);

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}

class OnlinePickReceiveDetailRefreshRequested
    extends OnlinePickReceiveDetailEvent {
  const OnlinePickReceiveDetailRefreshRequested();
}

class OnlinePickReceiveDetailCommitRequested
    extends OnlinePickReceiveDetailEvent {
  final List<int> indexes;
  const OnlinePickReceiveDetailCommitRequested(this.indexes);
}
