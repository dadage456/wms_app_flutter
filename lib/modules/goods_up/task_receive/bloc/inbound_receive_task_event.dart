import 'package:equatable/equatable.dart';

/// 入库接收任务事件定义
abstract class InboundReceiveTaskEvent extends Equatable {
  const InboundReceiveTaskEvent();

  @override
  List<Object?> get props => [];
}

/// 搜索接收任务
class SearchInboundReceiveTasksEvent extends InboundReceiveTaskEvent {
  const SearchInboundReceiveTasksEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

/// 刷新接收任务
class RefreshInboundReceiveTasksEvent extends InboundReceiveTaskEvent {
  const RefreshInboundReceiveTasksEvent();
}
