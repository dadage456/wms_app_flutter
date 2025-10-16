import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_sign_list_event.freezed.dart';

@freezed
class ArrivalSignListEvent with _$ArrivalSignListEvent {
  const factory ArrivalSignListEvent.initialized() = _Initialized;
  const factory ArrivalSignListEvent.search(String keyword) = _Search;
  const factory ArrivalSignListEvent.refresh() = _Refresh;
  const factory ArrivalSignListEvent.cancel(String arrivalsBillId) = _Cancel;
}
