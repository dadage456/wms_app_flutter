// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_collect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ArrivalCollectState {
  ArrivalSignTask? get headerTask => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  List<ArrivalCollectTask> get taskItems => throw _privateConstructorUsedError;
  ArrivalCollectTask? get selectedTask => throw _privateConstructorUsedError;
  List<ArrivalCollectProgress> get progresses =>
      throw _privateConstructorUsedError;
  ArrivalCollectScanStep get currentStep => throw _privateConstructorUsedError;
  Set<String> get selectedProgressIds => throw _privateConstructorUsedError;
  int get activeTabIndex => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  ArrivalCollectCache? get cache => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArrivalCollectStateCopyWith<ArrivalCollectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectStateCopyWith<$Res> {
  factory $ArrivalCollectStateCopyWith(
    ArrivalCollectState value,
    $Res Function(ArrivalCollectState) then,
  ) = _$ArrivalCollectStateCopyWithImpl<$Res, ArrivalCollectState>;
  @useResult
  $Res call({
    ArrivalSignTask? headerTask,
    bool isLoading,
    bool isSubmitting,
    List<ArrivalCollectTask> taskItems,
    ArrivalCollectTask? selectedTask,
    List<ArrivalCollectProgress> progresses,
    ArrivalCollectScanStep currentStep,
    Set<String> selectedProgressIds,
    int activeTabIndex,
    String? successMessage,
    String? errorMessage,
    ArrivalCollectCache? cache,
  });

  $ArrivalSignTaskCopyWith<$Res>? get headerTask;
  $ArrivalCollectTaskCopyWith<$Res>? get selectedTask;
  $ArrivalCollectCacheCopyWith<$Res>? get cache;
}

/// @nodoc
class _$ArrivalCollectStateCopyWithImpl<$Res, $Val extends ArrivalCollectState>
    implements $ArrivalCollectStateCopyWith<$Res> {
  _$ArrivalCollectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headerTask = freezed,
    Object? isLoading = null,
    Object? isSubmitting = null,
    Object? taskItems = null,
    Object? selectedTask = freezed,
    Object? progresses = null,
    Object? currentStep = null,
    Object? selectedProgressIds = null,
    Object? activeTabIndex = null,
    Object? successMessage = freezed,
    Object? errorMessage = freezed,
    Object? cache = freezed,
  }) {
    return _then(
      _value.copyWith(
            headerTask: freezed == headerTask
                ? _value.headerTask
                : headerTask // ignore: cast_nullable_to_non_nullable
                      as ArrivalSignTask?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            taskItems: null == taskItems
                ? _value.taskItems
                : taskItems // ignore: cast_nullable_to_non_nullable
                      as List<ArrivalCollectTask>,
            selectedTask: freezed == selectedTask
                ? _value.selectedTask
                : selectedTask // ignore: cast_nullable_to_non_nullable
                      as ArrivalCollectTask?,
            progresses: null == progresses
                ? _value.progresses
                : progresses // ignore: cast_nullable_to_non_nullable
                      as List<ArrivalCollectProgress>,
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as ArrivalCollectScanStep,
            selectedProgressIds: null == selectedProgressIds
                ? _value.selectedProgressIds
                : selectedProgressIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            activeTabIndex: null == activeTabIndex
                ? _value.activeTabIndex
                : activeTabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            cache: freezed == cache
                ? _value.cache
                : cache // ignore: cast_nullable_to_non_nullable
                      as ArrivalCollectCache?,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $ArrivalSignTaskCopyWith<$Res>? get headerTask {
    if (_value.headerTask == null) {
      return null;
    }

    return $ArrivalSignTaskCopyWith<$Res>(_value.headerTask!, (value) {
      return _then(_value.copyWith(headerTask: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ArrivalCollectTaskCopyWith<$Res>? get selectedTask {
    if (_value.selectedTask == null) {
      return null;
    }

    return $ArrivalCollectTaskCopyWith<$Res>(_value.selectedTask!, (value) {
      return _then(_value.copyWith(selectedTask: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ArrivalCollectCacheCopyWith<$Res>? get cache {
    if (_value.cache == null) {
      return null;
    }

    return $ArrivalCollectCacheCopyWith<$Res>(_value.cache!, (value) {
      return _then(_value.copyWith(cache: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArrivalCollectStateImplCopyWith<$Res>
    implements $ArrivalCollectStateCopyWith<$Res> {
  factory _$$ArrivalCollectStateImplCopyWith(
    _$ArrivalCollectStateImpl value,
    $Res Function(_$ArrivalCollectStateImpl) then,
  ) = __$$ArrivalCollectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ArrivalSignTask? headerTask,
    bool isLoading,
    bool isSubmitting,
    List<ArrivalCollectTask> taskItems,
    ArrivalCollectTask? selectedTask,
    List<ArrivalCollectProgress> progresses,
    ArrivalCollectScanStep currentStep,
    Set<String> selectedProgressIds,
    int activeTabIndex,
    String? successMessage,
    String? errorMessage,
    ArrivalCollectCache? cache,
  });

  @override
  $ArrivalSignTaskCopyWith<$Res>? get headerTask;
  @override
  $ArrivalCollectTaskCopyWith<$Res>? get selectedTask;
  @override
  $ArrivalCollectCacheCopyWith<$Res>? get cache;
}

/// @nodoc
class __$$ArrivalCollectStateImplCopyWithImpl<$Res>
    extends _$ArrivalCollectStateCopyWithImpl<$Res, _$ArrivalCollectStateImpl>
    implements _$$ArrivalCollectStateImplCopyWith<$Res> {
  __$$ArrivalCollectStateImplCopyWithImpl(
    _$ArrivalCollectStateImpl _value,
    $Res Function(_$ArrivalCollectStateImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headerTask = freezed,
    Object? isLoading = null,
    Object? isSubmitting = null,
    Object? taskItems = null,
    Object? selectedTask = freezed,
    Object? progresses = null,
    Object? currentStep = null,
    Object? selectedProgressIds = null,
    Object? activeTabIndex = null,
    Object? successMessage = freezed,
    Object? errorMessage = freezed,
    Object? cache = freezed,
  }) {
    return _then(
      _$ArrivalCollectStateImpl(
        headerTask: freezed == headerTask
            ? _value.headerTask
            : headerTask // ignore: cast_nullable_to_non_nullable
                  as ArrivalSignTask?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        taskItems: null == taskItems
            ? _value._taskItems
            : taskItems // ignore: cast_nullable_to_non_nullable
                  as List<ArrivalCollectTask>,
        selectedTask: freezed == selectedTask
            ? _value.selectedTask
            : selectedTask // ignore: cast_nullable_to_non_nullable
                  as ArrivalCollectTask?,
        progresses: null == progresses
            ? _value._progresses
            : progresses // ignore: cast_nullable_to_non_nullable
                  as List<ArrivalCollectProgress>,
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as ArrivalCollectScanStep,
        selectedProgressIds: null == selectedProgressIds
            ? _value._selectedProgressIds
            : selectedProgressIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        activeTabIndex: null == activeTabIndex
            ? _value.activeTabIndex
            : activeTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        cache: freezed == cache
            ? _value.cache
            : cache // ignore: cast_nullable_to_non_nullable
                  as ArrivalCollectCache?,
      ),
    );
  }
}

/// @nodoc

class _$ArrivalCollectStateImpl implements _ArrivalCollectState {
  const _$ArrivalCollectStateImpl({
    this.headerTask,
    this.isLoading = false,
    this.isSubmitting = false,
    final List<ArrivalCollectTask> taskItems = const <ArrivalCollectTask>[],
    this.selectedTask,
    final List<ArrivalCollectProgress> progresses =
        const <ArrivalCollectProgress>[],
    this.currentStep = ArrivalCollectScanStep.materialQRCode,
    final Set<String> selectedProgressIds = const <String>{},
    this.activeTabIndex = 0,
    this.successMessage,
    this.errorMessage,
    this.cache,
  }) : _taskItems = taskItems,
       _progresses = progresses,
       _selectedProgressIds = selectedProgressIds;

  @override
  final ArrivalSignTask? headerTask;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSubmitting;
  final List<ArrivalCollectTask> _taskItems;
  @override
  @JsonKey()
  List<ArrivalCollectTask> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  @override
  final ArrivalCollectTask? selectedTask;
  final List<ArrivalCollectProgress> _progresses;
  @override
  @JsonKey()
  List<ArrivalCollectProgress> get progresses {
    if (_progresses is EqualUnmodifiableListView) return _progresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progresses);
  }

  @override
  @JsonKey()
  final ArrivalCollectScanStep currentStep;
  final Set<String> _selectedProgressIds;
  @override
  @JsonKey()
  Set<String> get selectedProgressIds {
    if (_selectedProgressIds is EqualUnmodifiableSetView)
      return _selectedProgressIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedProgressIds);
  }

  @override
  @JsonKey()
  final int activeTabIndex;
  @override
  final String? successMessage;
  @override
  final String? errorMessage;
  @override
  final ArrivalCollectCache? cache;

  @override
  String toString() {
    return 'ArrivalCollectState(headerTask: $headerTask, isLoading: $isLoading, isSubmitting: $isSubmitting, taskItems: $taskItems, selectedTask: $selectedTask, progresses: $progresses, currentStep: $currentStep, selectedProgressIds: $selectedProgressIds, activeTabIndex: $activeTabIndex, successMessage: $successMessage, errorMessage: $errorMessage, cache: $cache)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectStateImpl &&
            (identical(other.headerTask, headerTask) ||
                other.headerTask == headerTask) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            const DeepCollectionEquality().equals(
              other._taskItems,
              _taskItems,
            ) &&
            (identical(other.selectedTask, selectedTask) ||
                other.selectedTask == selectedTask) &&
            const DeepCollectionEquality().equals(
              other._progresses,
              _progresses,
            ) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            const DeepCollectionEquality().equals(
              other._selectedProgressIds,
              _selectedProgressIds,
            ) &&
            (identical(other.activeTabIndex, activeTabIndex) ||
                other.activeTabIndex == activeTabIndex) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.cache, cache) || other.cache == cache));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    headerTask,
    isLoading,
    isSubmitting,
    const DeepCollectionEquality().hash(_taskItems),
    selectedTask,
    const DeepCollectionEquality().hash(_progresses),
    currentStep,
    const DeepCollectionEquality().hash(_selectedProgressIds),
    activeTabIndex,
    successMessage,
    errorMessage,
    cache,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectStateImplCopyWith<_$ArrivalCollectStateImpl> get copyWith =>
      __$$ArrivalCollectStateImplCopyWithImpl<_$ArrivalCollectStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ArrivalCollectState implements ArrivalCollectState {
  const factory _ArrivalCollectState({
    final ArrivalSignTask? headerTask,
    final bool isLoading,
    final bool isSubmitting,
    final List<ArrivalCollectTask> taskItems,
    final ArrivalCollectTask? selectedTask,
    final List<ArrivalCollectProgress> progresses,
    final ArrivalCollectScanStep currentStep,
    final Set<String> selectedProgressIds,
    final int activeTabIndex,
    final String? successMessage,
    final String? errorMessage,
    final ArrivalCollectCache? cache,
  }) = _$ArrivalCollectStateImpl;

  @override
  ArrivalSignTask? get headerTask;
  @override
  bool get isLoading;
  @override
  bool get isSubmitting;
  @override
  List<ArrivalCollectTask> get taskItems;
  @override
  ArrivalCollectTask? get selectedTask;
  @override
  List<ArrivalCollectProgress> get progresses;
  @override
  ArrivalCollectScanStep get currentStep;
  @override
  Set<String> get selectedProgressIds;
  @override
  int get activeTabIndex;
  @override
  String? get successMessage;
  @override
  String? get errorMessage;
  @override
  ArrivalCollectCache? get cache;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectStateImplCopyWith<_$ArrivalCollectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
