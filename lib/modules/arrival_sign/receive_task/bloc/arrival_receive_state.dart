import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_receive_state.freezed.dart';

@freezed
class ArrivalReceiveState with _$ArrivalReceiveState {
  const factory ArrivalReceiveState({
    @Default(false) bool isProcessing,
    String? errorMessage,
    String? successMessage,
  }) = _ArrivalReceiveState;
}
