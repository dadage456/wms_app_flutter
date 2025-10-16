import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

class OnlinePickReceiveDetailState extends Equatable {
  const OnlinePickReceiveDetailState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.task,
    this.query,
    this.searchKeyword = '',
    this.recordCount = 0,
    this.shouldNotifyParent = false,
  });

  final CollectionStatus status;
  final OnlinePickTask? task;
  final OnlinePickTaskItemQuery? query;
  final String searchKeyword;
  final int recordCount;
  final bool shouldNotifyParent;

  OnlinePickReceiveDetailState copyWith({
    CollectionStatus? status,
    OnlinePickTask? task,
    OnlinePickTaskItemQuery? query,
    String? searchKeyword,
    int? recordCount,
    bool? shouldNotifyParent,
  }) {
    return OnlinePickReceiveDetailState(
      status: status ?? this.status,
      task: task ?? this.task,
      query: query ?? this.query,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      recordCount: recordCount ?? this.recordCount,
      shouldNotifyParent: shouldNotifyParent ?? this.shouldNotifyParent,
    );
  }

  @override
  List<Object?> get props => [
    status,
    task,
    query,
    searchKeyword,
    recordCount,
    shouldNotifyParent,
  ];
}
