import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

class OnlinePickTaskDetailState extends Equatable {
  const OnlinePickTaskDetailState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.task,
    this.query,
  });

  final CollectionStatus status;
  final OnlinePickTask? task;
  final OnlinePickTaskItemQuery? query;

  OnlinePickTaskDetailState copyWith({
    CollectionStatus? status,
    OnlinePickTask? task,
    OnlinePickTaskItemQuery? query,
  }) {
    return OnlinePickTaskDetailState(
      status: status ?? this.status,
      task: task ?? this.task,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [status, task, query];
}
