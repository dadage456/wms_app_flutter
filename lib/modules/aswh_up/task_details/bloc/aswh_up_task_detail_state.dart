import 'package:equatable/equatable.dart';

import 'aswh_up_task_detail_event.dart';

class AswhUpTaskDetailState extends Equatable {
  const AswhUpTaskDetailState({
    this.taskId,
    this.workStation,
    this.searchKey = '',
    this.message,
    this.messageType = AswhUpTaskDetailMessageType.info,
    this.messageId = 0,
  });

  final int? taskId;
  final String? workStation;
  final String searchKey;
  final String? message;
  final AswhUpTaskDetailMessageType messageType;
  final int messageId;

  AswhUpTaskDetailState copyWith({
    int? taskId,
    String? workStation,
    String? searchKey,
    String? message,
    AswhUpTaskDetailMessageType? messageType,
    int? messageId,
    bool clearMessage = false,
  }) {
    return AswhUpTaskDetailState(
      taskId: taskId ?? this.taskId,
      workStation: workStation ?? this.workStation,
      searchKey: searchKey ?? this.searchKey,
      message: clearMessage ? null : (message ?? this.message),
      messageType: messageType ?? this.messageType,
      messageId: messageId ?? this.messageId,
    );
  }

  @override
  List<Object?> get props => [
        taskId,
        workStation,
        searchKey,
        message,
        messageType,
        messageId,
      ];
}
