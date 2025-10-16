import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';

part 'arrival_sign_detail_state.freezed.dart';

@freezed
class ArrivalSignDetailState with _$ArrivalSignDetailState {
  const factory ArrivalSignDetailState({
    @Default(false) bool isLoading,
    @Default(<ArrivalSignDetail>[]) List<ArrivalSignDetail> details,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    String? errorMessage,
  }) = _ArrivalSignDetailState;
}
