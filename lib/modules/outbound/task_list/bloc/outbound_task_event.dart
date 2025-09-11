import 'package:equatable/equatable.dart';
import '../models/outbound_task.dart';

/// 出库任务事件基类
abstract class OutboundTaskEvent extends Equatable {
  const OutboundTaskEvent();

  @override
  List<Object?> get props => [];
}

/// 加载出库任务列表事件
class LoadOutboundTasksEvent extends OutboundTaskEvent {
  const LoadOutboundTasksEvent(this.query);

  final OutboundTaskQuery query;

  @override
  List<Object?> get props => [query];
}

/// 刷新出库任务列表事件
class RefreshOutboundTasksEvent extends OutboundTaskEvent {
  const RefreshOutboundTasksEvent();
}

/// 搜索出库任务事件
class SearchOutboundTasksEvent extends OutboundTaskEvent {
  const SearchOutboundTasksEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

/// 筛选出库任务事件
class FilterOutboundTasksEvent extends OutboundTaskEvent {
  const FilterOutboundTasksEvent(this.finishFlag);

  final String finishFlag;

  @override
  List<Object?> get props => [finishFlag];
}

/// 分页加载事件
class LoadPageEvent extends OutboundTaskEvent {
  const LoadPageEvent(this.pageIndex);

  final int pageIndex;

  @override
  List<Object?> get props => [pageIndex];
}

/// 排序事件
class SortOutboundTasksEvent extends OutboundTaskEvent {
  const SortOutboundTasksEvent({
    required this.sortColumn,
    required this.sortType,
  });

  final String sortColumn;
  final String sortType;

  @override
  List<Object?> get props => [sortColumn, sortType];
}
