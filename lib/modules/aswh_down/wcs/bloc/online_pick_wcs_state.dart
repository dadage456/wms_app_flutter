import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';

class OnlinePickWcsState extends Equatable {
  const OnlinePickWcsState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.taskId = '',
    this.taskNo = '',
    this.taskComment = '',
    this.trayNo = '',
    this.workStation = '',
    this.queryStr = '',
    this.recordCount = 0,
    this.shouldNotifyParent = false,
  });

  final CollectionStatus status;
  final String taskId;
  final String taskNo;
  final String taskComment;
  final String trayNo;
  final String workStation;
  final String queryStr;
  final int recordCount;
  final bool shouldNotifyParent;

  OnlinePickWcsState copyWith({
    CollectionStatus? status,
    String? taskId,
    String? taskNo,
    String? taskComment,
    String? trayNo,
    String? workStation,
    String? queryStr,
    int? recordCount,
    bool? shouldNotifyParent,
  }) {
    return OnlinePickWcsState(
      status: status ?? this.status,
      taskId: taskId ?? this.taskId,
      taskNo: taskNo ?? this.taskNo,
      taskComment: taskComment ?? this.taskComment,
      trayNo: trayNo ?? this.trayNo,
      workStation: workStation ?? this.workStation,
      queryStr: queryStr ?? this.queryStr,
      recordCount: recordCount ?? this.recordCount,
      shouldNotifyParent: shouldNotifyParent ?? this.shouldNotifyParent,
    );
  }

  bool get hasEssentialContext =>
      taskId.isNotEmpty && taskNo.isNotEmpty && trayNo.isNotEmpty;

  @override
  List<Object?> get props => [
    status,
    taskId,
    taskNo,
    taskComment,
    trayNo,
    workStation,
    queryStr,
    recordCount,
    shouldNotifyParent,
  ];
}
