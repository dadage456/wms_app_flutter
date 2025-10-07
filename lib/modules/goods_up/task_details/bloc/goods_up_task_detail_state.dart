import 'package:equatable/equatable.dart';

class GoodsUpTaskDetailState extends Equatable {
  const GoodsUpTaskDetailState({
    this.inTaskId,
    this.workStation,
    this.isLoading = false,
    this.errorMessage,
  });

  final int? inTaskId;
  final String? workStation;
  final bool isLoading;
  final String? errorMessage;

  GoodsUpTaskDetailState copyWith({
    int? inTaskId,
    String? workStation,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GoodsUpTaskDetailState(
      inTaskId: inTaskId ?? this.inTaskId,
      workStation: workStation ?? this.workStation,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [inTaskId, workStation, isLoading, errorMessage];
}
