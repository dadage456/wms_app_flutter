// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_collect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InventoryCollectState {
  InventoryCollectStatus get status => throw _privateConstructorUsedError;
  InventoryTask? get task => throw _privateConstructorUsedError;
  String get currentStoreSite => throw _privateConstructorUsedError;
  InventoryBarcodeContent? get barcodeContent =>
      throw _privateConstructorUsedError;
  InventoryCollectStep get step => throw _privateConstructorUsedError;
  InventoryCollectTab get activeTab => throw _privateConstructorUsedError;
  List<InventoryTaskItem> get taskItems => throw _privateConstructorUsedError;
  List<InventoryCollectRecord> get collectingRecords =>
      throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool get hasUnsubmittedData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InventoryCollectStateCopyWith<InventoryCollectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectStateCopyWith<$Res> {
  factory $InventoryCollectStateCopyWith(InventoryCollectState value,
          $Res Function(InventoryCollectState) then) =
      _$InventoryCollectStateCopyWithImpl<$Res, InventoryCollectState>;
  @useResult
  $Res call(
      {InventoryCollectStatus status,
      InventoryTask? task,
      String currentStoreSite,
      InventoryBarcodeContent? barcodeContent,
      InventoryCollectStep step,
      InventoryCollectTab activeTab,
      List<InventoryTaskItem> taskItems,
      List<InventoryCollectRecord> collectingRecords,
      String? message,
      bool hasUnsubmittedData});

  $InventoryTaskCopyWith<$Res>? get task;
  $InventoryBarcodeContentCopyWith<$Res>? get barcodeContent;
}

/// @nodoc
class _$InventoryCollectStateCopyWithImpl<$Res,
        $Val extends InventoryCollectState>
    implements $InventoryCollectStateCopyWith<$Res> {
  _$InventoryCollectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? task = freezed,
    Object? currentStoreSite = null,
    Object? barcodeContent = freezed,
    Object? step = null,
    Object? activeTab = null,
    Object? taskItems = null,
    Object? collectingRecords = null,
    Object? message = freezed,
    Object? hasUnsubmittedData = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InventoryCollectStatus,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as InventoryTask?,
      currentStoreSite: null == currentStoreSite
          ? _value.currentStoreSite
          : currentStoreSite // ignore: cast_nullable_to_non_nullable
              as String,
      barcodeContent: freezed == barcodeContent
          ? _value.barcodeContent
          : barcodeContent // ignore: cast_nullable_to_non_nullable
              as InventoryBarcodeContent?,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as InventoryCollectStep,
      activeTab: null == activeTab
          ? _value.activeTab
          : activeTab // ignore: cast_nullable_to_non_nullable
              as InventoryCollectTab,
      taskItems: null == taskItems
          ? _value.taskItems
          : taskItems // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskItem>,
      collectingRecords: null == collectingRecords
          ? _value.collectingRecords
          : collectingRecords // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectRecord>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      hasUnsubmittedData: null == hasUnsubmittedData
          ? _value.hasUnsubmittedData
          : hasUnsubmittedData // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryTaskCopyWith<$Res>? get task {
    if (_value.task == null) {
      return null;
    }

    return $InventoryTaskCopyWith<$Res>(_value.task!, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryBarcodeContentCopyWith<$Res>? get barcodeContent {
    if (_value.barcodeContent == null) {
      return null;
    }

    return $InventoryBarcodeContentCopyWith<$Res>(_value.barcodeContent!,
        (value) {
      return _then(_value.copyWith(barcodeContent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InventoryCollectStateImplCopyWith<$Res>
    implements $InventoryCollectStateCopyWith<$Res> {
  factory _$$InventoryCollectStateImplCopyWith(
          _$InventoryCollectStateImpl value,
          $Res Function(_$InventoryCollectStateImpl) then) =
      __$$InventoryCollectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InventoryCollectStatus status,
      InventoryTask? task,
      String currentStoreSite,
      InventoryBarcodeContent? barcodeContent,
      InventoryCollectStep step,
      InventoryCollectTab activeTab,
      List<InventoryTaskItem> taskItems,
      List<InventoryCollectRecord> collectingRecords,
      String? message,
      bool hasUnsubmittedData});

  @override
  $InventoryTaskCopyWith<$Res>? get task;
  @override
  $InventoryBarcodeContentCopyWith<$Res>? get barcodeContent;
}

/// @nodoc
class __$$InventoryCollectStateImplCopyWithImpl<$Res>
    extends _$InventoryCollectStateCopyWithImpl<$Res,
        _$InventoryCollectStateImpl>
    implements _$$InventoryCollectStateImplCopyWith<$Res> {
  __$$InventoryCollectStateImplCopyWithImpl(_$InventoryCollectStateImpl _value,
      $Res Function(_$InventoryCollectStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? task = freezed,
    Object? currentStoreSite = null,
    Object? barcodeContent = freezed,
    Object? step = null,
    Object? activeTab = null,
    Object? taskItems = null,
    Object? collectingRecords = null,
    Object? message = freezed,
    Object? hasUnsubmittedData = null,
  }) {
    return _then(_$InventoryCollectStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InventoryCollectStatus,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as InventoryTask?,
      currentStoreSite: null == currentStoreSite
          ? _value.currentStoreSite
          : currentStoreSite // ignore: cast_nullable_to_non_nullable
              as String,
      barcodeContent: freezed == barcodeContent
          ? _value.barcodeContent
          : barcodeContent // ignore: cast_nullable_to_non_nullable
              as InventoryBarcodeContent?,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as InventoryCollectStep,
      activeTab: null == activeTab
          ? _value.activeTab
          : activeTab // ignore: cast_nullable_to_non_nullable
              as InventoryCollectTab,
      taskItems: null == taskItems
          ? _value._taskItems
          : taskItems // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskItem>,
      collectingRecords: null == collectingRecords
          ? _value._collectingRecords
          : collectingRecords // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectRecord>,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      hasUnsubmittedData: null == hasUnsubmittedData
          ? _value.hasUnsubmittedData
          : hasUnsubmittedData // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InventoryCollectStateImpl implements _InventoryCollectState {
  const _$InventoryCollectStateImpl(
      {this.status = InventoryCollectStatus.initial,
      this.task,
      this.currentStoreSite = '',
      this.barcodeContent,
      this.step = InventoryCollectStep.scanLocation,
      this.activeTab = InventoryCollectTab.pending,
      final List<InventoryTaskItem> taskItems = const <InventoryTaskItem>[],
      final List<InventoryCollectRecord> collectingRecords =
          const <InventoryCollectRecord>[],
      this.message,
      this.hasUnsubmittedData = false})
      : _taskItems = taskItems,
        _collectingRecords = collectingRecords;

  @override
  @JsonKey()
  final InventoryCollectStatus status;
  @override
  final InventoryTask? task;
  @override
  @JsonKey()
  final String currentStoreSite;
  @override
  final InventoryBarcodeContent? barcodeContent;
  @override
  @JsonKey()
  final InventoryCollectStep step;
  @override
  @JsonKey()
  final InventoryCollectTab activeTab;
  final List<InventoryTaskItem> _taskItems;
  @override
  @JsonKey()
  List<InventoryTaskItem> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  final List<InventoryCollectRecord> _collectingRecords;
  @override
  @JsonKey()
  List<InventoryCollectRecord> get collectingRecords {
    if (_collectingRecords is EqualUnmodifiableListView)
      return _collectingRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectingRecords);
  }

  @override
  final String? message;
  @override
  @JsonKey()
  final bool hasUnsubmittedData;

  @override
  String toString() {
    return 'InventoryCollectState(status: $status, task: $task, currentStoreSite: $currentStoreSite, barcodeContent: $barcodeContent, step: $step, activeTab: $activeTab, taskItems: $taskItems, collectingRecords: $collectingRecords, message: $message, hasUnsubmittedData: $hasUnsubmittedData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCollectStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.currentStoreSite, currentStoreSite) ||
                other.currentStoreSite == currentStoreSite) &&
            (identical(other.barcodeContent, barcodeContent) ||
                other.barcodeContent == barcodeContent) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.activeTab, activeTab) ||
                other.activeTab == activeTab) &&
            const DeepCollectionEquality()
                .equals(other._taskItems, _taskItems) &&
            const DeepCollectionEquality()
                .equals(other._collectingRecords, _collectingRecords) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.hasUnsubmittedData, hasUnsubmittedData) ||
                other.hasUnsubmittedData == hasUnsubmittedData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      task,
      currentStoreSite,
      barcodeContent,
      step,
      activeTab,
      const DeepCollectionEquality().hash(_taskItems),
      const DeepCollectionEquality().hash(_collectingRecords),
      message,
      hasUnsubmittedData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCollectStateImplCopyWith<_$InventoryCollectStateImpl>
      get copyWith => __$$InventoryCollectStateImplCopyWithImpl<
          _$InventoryCollectStateImpl>(this, _$identity);
}

abstract class _InventoryCollectState implements InventoryCollectState {
  const factory _InventoryCollectState(
      {final InventoryCollectStatus status,
      final InventoryTask? task,
      final String currentStoreSite,
      final InventoryBarcodeContent? barcodeContent,
      final InventoryCollectStep step,
      final InventoryCollectTab activeTab,
      final List<InventoryTaskItem> taskItems,
      final List<InventoryCollectRecord> collectingRecords,
      final String? message,
      final bool hasUnsubmittedData}) = _$InventoryCollectStateImpl;

  @override
  InventoryCollectStatus get status;
  @override
  InventoryTask? get task;
  @override
  String get currentStoreSite;
  @override
  InventoryBarcodeContent? get barcodeContent;
  @override
  InventoryCollectStep get step;
  @override
  InventoryCollectTab get activeTab;
  @override
  List<InventoryTaskItem> get taskItems;
  @override
  List<InventoryCollectRecord> get collectingRecords;
  @override
  String? get message;
  @override
  bool get hasUnsubmittedData;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCollectStateImplCopyWith<_$InventoryCollectStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
