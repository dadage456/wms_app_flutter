import 'package:equatable/equatable.dart';

abstract class OnlinePickTaskEvent extends Equatable {
  const OnlinePickTaskEvent();

  @override
  List<Object?> get props => [];
}

/// 初始化加载任务列表
class OnlinePickTaskInitialized extends OnlinePickTaskEvent {
  const OnlinePickTaskInitialized();
}

/// 搜索任务
class OnlinePickTaskSearchSubmitted extends OnlinePickTaskEvent {
  const OnlinePickTaskSearchSubmitted(this.keyword);

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}

/// 切换完成标识过滤
class OnlinePickTaskFinishFlagChanged extends OnlinePickTaskEvent {
  const OnlinePickTaskFinishFlagChanged(this.finishFlag);

  final String finishFlag;

  @override
  List<Object?> get props => [finishFlag];
}

/// 手动刷新
class OnlinePickTaskRefreshRequested extends OnlinePickTaskEvent {
  const OnlinePickTaskRefreshRequested();
}
