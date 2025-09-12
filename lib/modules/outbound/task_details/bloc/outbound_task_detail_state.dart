import 'package:equatable/equatable.dart';
import '../models/outbound_task_item.dart';

/// 出库任务明细状态
class OutboundTaskDetailState extends Equatable {
  const OutboundTaskDetailState({
    this.searchKey = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final String searchKey;
  final bool isLoading;
  final String? errorMessage;

  OutboundTaskDetailState copyWith({
    String? searchKey,
    bool? isLoading,
    String? errorMessage,
  }) {
    return OutboundTaskDetailState(
      searchKey: searchKey ?? this.searchKey,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [searchKey, isLoading, errorMessage];
}
