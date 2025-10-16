import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_sign_list_state.freezed.dart';

@freezed
class ArrivalSignListState with _$ArrivalSignListState {
  const factory ArrivalSignListState({
    @Default(false) bool isProcessing,
    String? errorMessage,
    String? successMessage,
  }) = _ArrivalSignListState;
}
