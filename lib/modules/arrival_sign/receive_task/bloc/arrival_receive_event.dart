import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_receive_event.freezed.dart';

@freezed
class ArrivalReceiveEvent with _$ArrivalReceiveEvent {
  const factory ArrivalReceiveEvent.initialized() = _Initialized;
  const factory ArrivalReceiveEvent.search(String keyword) = _Search;
  const factory ArrivalReceiveEvent.refresh() = _Refresh;
  const factory ArrivalReceiveEvent.receive(String arrivalsBillId) = _Receive;
}
