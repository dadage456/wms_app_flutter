import 'package:equatable/equatable.dart';

/// 平库出库接收任务事件
abstract class ReceiveTaskEvent extends Equatable {
  const ReceiveTaskEvent();

  @override
  List<Object?> get props => [];
}

/// 搜索任务
class SearchReceiveTasksEvent extends ReceiveTaskEvent {
  final String searchKey;

  const SearchReceiveTasksEvent(this.searchKey);

  @override
  List<Object?> get props => [searchKey];
}

/// 刷新任务
class RefreshReceiveTasksEvent extends ReceiveTaskEvent {
  const RefreshReceiveTasksEvent();

  @override
  List<Object?> get props => [];
}
