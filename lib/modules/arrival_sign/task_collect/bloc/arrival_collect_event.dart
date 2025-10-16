import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';

import '../models/arrival_collect_progress.dart';
import '../models/arrival_collect_task.dart';

part 'arrival_collect_event.freezed.dart';

@freezed
class ArrivalCollectEvent with _$ArrivalCollectEvent {
  const factory ArrivalCollectEvent.initialized(ArrivalSignTask task) =
      _Initialized;

  const factory ArrivalCollectEvent.refreshDetails() = _RefreshDetails;

  const factory ArrivalCollectEvent.selectTask(ArrivalCollectTask task) =
      _SelectTask;

  const factory ArrivalCollectEvent.scanSubmitted(String value) =
      _ScanSubmitted;

  const factory ArrivalCollectEvent.quantitySubmitted(double quantity) =
      _QuantitySubmitted;

  const factory ArrivalCollectEvent.switchTab(int index) = _SwitchTab;

  const factory ArrivalCollectEvent.toggleCollectSelection(String id) =
      _ToggleCollectSelection;

  const factory ArrivalCollectEvent.deleteSelected() = _DeleteSelected;

  const factory ArrivalCollectEvent.submit() = _Submit;

  const factory ArrivalCollectEvent.restoreFromCache() = _RestoreFromCache;

  const factory ArrivalCollectEvent.persistCache() = _PersistCache;

  const factory ArrivalCollectEvent.resultPageClosed(
    List<ArrivalCollectProgress> progresses,
  ) = _ResultPageClosed;
}
