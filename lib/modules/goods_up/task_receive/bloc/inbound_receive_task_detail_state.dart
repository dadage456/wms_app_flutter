import 'package:equatable/equatable.dart';

class InboundReceiveTaskDetailState extends Equatable {
  const InboundReceiveTaskDetailState({
    this.isSubmitting = false,
    this.errorMessage,
  });

  final bool isSubmitting;
  final String? errorMessage;

  InboundReceiveTaskDetailState copyWith({
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return InboundReceiveTaskDetailState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isSubmitting, errorMessage];
}
