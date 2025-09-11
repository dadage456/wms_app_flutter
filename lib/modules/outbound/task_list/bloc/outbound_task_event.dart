import 'package:equatable/equatable.dart';

/// 出库任务事件基类
abstract class OutboundTaskEvent extends Equatable {
  const OutboundTaskEvent();

  @override
  List<Object?> get props => [];
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


