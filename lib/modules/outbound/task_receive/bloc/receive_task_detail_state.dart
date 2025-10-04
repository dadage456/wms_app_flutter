import 'package:equatable/equatable.dart';

class ReceiveTaskDetailState extends Equatable {
  final bool isReceiving;
  final String? errorMessage;

  const ReceiveTaskDetailState({
    this.isReceiving = false,
    this.errorMessage,
  });

  ReceiveTaskDetailState copyWith({
    bool? isReceiving,
    String? errorMessage,
  }) {
    return ReceiveTaskDetailState(
      isReceiving: isReceiving ?? this.isReceiving,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isReceiving, errorMessage];
}
