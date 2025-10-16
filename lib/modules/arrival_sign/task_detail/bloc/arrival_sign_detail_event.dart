import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_sign_detail_event.freezed.dart';

@freezed
class ArrivalSignDetailEvent with _$ArrivalSignDetailEvent {
  const factory ArrivalSignDetailEvent.initialized(String arrivalsBillId) =
      _Initialized;
  const factory ArrivalSignDetailEvent.search(String keyword) = _Search;
  const factory ArrivalSignDetailEvent.refresh() = _Refresh;
  const factory ArrivalSignDetailEvent.pageChanged(int pageIndex) = _PageChanged;
}
