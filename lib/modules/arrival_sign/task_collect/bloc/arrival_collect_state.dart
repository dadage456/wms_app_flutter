import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';

import '../models/arrival_collect_cache.dart';
import '../models/arrival_collect_progress.dart';
import '../models/arrival_collect_task.dart';

part 'arrival_collect_state.freezed.dart';

@freezed
class ArrivalCollectState with _$ArrivalCollectState {
  const factory ArrivalCollectState({
    ArrivalSignTask? headerTask,
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    @Default(<ArrivalCollectTask>[]) List<ArrivalCollectTask> taskItems,
    ArrivalCollectTask? selectedTask,
    @Default(<ArrivalCollectProgress>[])
    List<ArrivalCollectProgress> progresses,
    @Default(ArrivalCollectScanStep.materialQRCode)
    ArrivalCollectScanStep currentStep,
    @Default(<String>{}) Set<String> selectedProgressIds,
    @Default(0) int activeTabIndex,
    String? successMessage,
    String? errorMessage,
    ArrivalCollectCache? cache,
  }) = _ArrivalCollectState;
}
