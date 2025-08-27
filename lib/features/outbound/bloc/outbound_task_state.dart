import 'package:equatable/equatable.dart';
import '../models/outbound_task.dart';

/// 出库任务状态基类
abstract class OutboundTaskState extends Equatable {
  const OutboundTaskState();

  @override
  List<Object?> get props => [];
}

/// 初始状态
class OutboundTaskInitial extends OutboundTaskState {
  const OutboundTaskInitial();
}

/// 加载中状态
class OutboundTaskLoading extends OutboundTaskState {
  const OutboundTaskLoading();
}

/// 加载成功状态
class OutboundTaskLoaded extends OutboundTaskState {
  const OutboundTaskLoaded({
    required this.tasks,
    required this.total,
    required this.currentPage,
    required this.query,
    this.hasReachedMax = false,
  });

  final List<OutboundTask> tasks;
  final int total;
  final int currentPage;
  final OutboundTaskQuery query;
  final bool hasReachedMax;

  @override
  List<Object?> get props => [
        tasks,
        total,
        currentPage,
        query,
        hasReachedMax,
      ];

  OutboundTaskLoaded copyWith({
    List<OutboundTask>? tasks,
    int? total,
    int? currentPage,
    OutboundTaskQuery? query,
    bool? hasReachedMax,
  }) {
    return OutboundTaskLoaded(
      tasks: tasks ?? this.tasks,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      query: query ?? this.query,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

/// 加载失败状态
class OutboundTaskError extends OutboundTaskState {
  const OutboundTaskError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// 刷新中状态
class OutboundTaskRefreshing extends OutboundTaskState {
  const OutboundTaskRefreshing({
    required this.tasks,
    required this.total,
    required this.currentPage,
    required this.query,
  });

  final List<OutboundTask> tasks;
  final int total;
  final int currentPage;
  final OutboundTaskQuery query;

  @override
  List<Object?> get props => [tasks, total, currentPage, query];
}

/// 分页加载中状态
class OutboundTaskPageLoading extends OutboundTaskState {
  const OutboundTaskPageLoading({
    required this.tasks,
    required this.total,
    required this.currentPage,
    required this.query,
  });

  final List<OutboundTask> tasks;
  final int total;
  final int currentPage;
  final OutboundTaskQuery query;

  @override
  List<Object?> get props => [tasks, total, currentPage, query];
}