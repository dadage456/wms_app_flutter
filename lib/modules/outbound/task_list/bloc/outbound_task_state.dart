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



/// 加载失败状态
class OutboundTaskError extends OutboundTaskState {
  const OutboundTaskError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}



/// 查询参数更新状态
class OutboundTaskQueryUpdated extends OutboundTaskState {
  const OutboundTaskQueryUpdated(this.query);

  final OutboundTaskQuery query;

  @override
  List<Object?> get props => [query];
}
