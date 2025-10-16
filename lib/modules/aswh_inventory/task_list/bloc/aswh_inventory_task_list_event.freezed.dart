// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aswh_inventory_task_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AswhInventoryTaskListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhInventoryTaskListEventCopyWith<$Res> {
  factory $AswhInventoryTaskListEventCopyWith(AswhInventoryTaskListEvent value,
          $Res Function(AswhInventoryTaskListEvent) then) =
      _$AswhInventoryTaskListEventCopyWithImpl<$Res,
          AswhInventoryTaskListEvent>;
}

/// @nodoc
class _$AswhInventoryTaskListEventCopyWithImpl<$Res,
        $Val extends AswhInventoryTaskListEvent>
    implements $AswhInventoryTaskListEventCopyWith<$Res> {
  _$AswhInventoryTaskListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'AswhInventoryTaskListEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AswhInventoryTaskListEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$FilterSubmittedImplCopyWith<$Res> {
  factory _$$FilterSubmittedImplCopyWith(_$FilterSubmittedImpl value,
          $Res Function(_$FilterSubmittedImpl) then) =
      __$$FilterSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String searchKey});
}

/// @nodoc
class __$$FilterSubmittedImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListEventCopyWithImpl<$Res,
        _$FilterSubmittedImpl> implements _$$FilterSubmittedImplCopyWith<$Res> {
  __$$FilterSubmittedImplCopyWithImpl(
      _$FilterSubmittedImpl _value, $Res Function(_$FilterSubmittedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchKey = null,
  }) {
    return _then(_$FilterSubmittedImpl(
      null == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FilterSubmittedImpl implements _FilterSubmitted {
  const _$FilterSubmittedImpl(this.searchKey);

  @override
  final String searchKey;

  @override
  String toString() {
    return 'AswhInventoryTaskListEvent.filterSubmitted(searchKey: $searchKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterSubmittedImpl &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterSubmittedImplCopyWith<_$FilterSubmittedImpl> get copyWith =>
      __$$FilterSubmittedImplCopyWithImpl<_$FilterSubmittedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) {
    return filterSubmitted(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) {
    return filterSubmitted?.call(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (filterSubmitted != null) {
      return filterSubmitted(searchKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return filterSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return filterSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (filterSubmitted != null) {
      return filterSubmitted(this);
    }
    return orElse();
  }
}

abstract class _FilterSubmitted implements AswhInventoryTaskListEvent {
  const factory _FilterSubmitted(final String searchKey) =
      _$FilterSubmittedImpl;

  String get searchKey;
  @JsonKey(ignore: true)
  _$$FilterSubmittedImplCopyWith<_$FilterSubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScanContentReceivedImplCopyWith<$Res> {
  factory _$$ScanContentReceivedImplCopyWith(_$ScanContentReceivedImpl value,
          $Res Function(_$ScanContentReceivedImpl) then) =
      __$$ScanContentReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String scanContent});
}

/// @nodoc
class __$$ScanContentReceivedImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListEventCopyWithImpl<$Res,
        _$ScanContentReceivedImpl>
    implements _$$ScanContentReceivedImplCopyWith<$Res> {
  __$$ScanContentReceivedImplCopyWithImpl(_$ScanContentReceivedImpl _value,
      $Res Function(_$ScanContentReceivedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scanContent = null,
  }) {
    return _then(_$ScanContentReceivedImpl(
      null == scanContent
          ? _value.scanContent
          : scanContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScanContentReceivedImpl implements _ScanContentReceived {
  const _$ScanContentReceivedImpl(this.scanContent);

  @override
  final String scanContent;

  @override
  String toString() {
    return 'AswhInventoryTaskListEvent.scanContentReceived(scanContent: $scanContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanContentReceivedImpl &&
            (identical(other.scanContent, scanContent) ||
                other.scanContent == scanContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, scanContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanContentReceivedImplCopyWith<_$ScanContentReceivedImpl> get copyWith =>
      __$$ScanContentReceivedImplCopyWithImpl<_$ScanContentReceivedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) {
    return scanContentReceived(scanContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) {
    return scanContentReceived?.call(scanContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (scanContentReceived != null) {
      return scanContentReceived(scanContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return scanContentReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return scanContentReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (scanContentReceived != null) {
      return scanContentReceived(this);
    }
    return orElse();
  }
}

abstract class _ScanContentReceived implements AswhInventoryTaskListEvent {
  const factory _ScanContentReceived(final String scanContent) =
      _$ScanContentReceivedImpl;

  String get scanContent;
  @JsonKey(ignore: true)
  _$$ScanContentReceivedImplCopyWith<_$ScanContentReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskCancelRequestedImplCopyWith<$Res> {
  factory _$$TaskCancelRequestedImplCopyWith(_$TaskCancelRequestedImpl value,
          $Res Function(_$TaskCancelRequestedImpl) then) =
      __$$TaskCancelRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InventoryTaskSummary task});

  $InventoryTaskSummaryCopyWith<$Res> get task;
}

/// @nodoc
class __$$TaskCancelRequestedImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListEventCopyWithImpl<$Res,
        _$TaskCancelRequestedImpl>
    implements _$$TaskCancelRequestedImplCopyWith<$Res> {
  __$$TaskCancelRequestedImplCopyWithImpl(_$TaskCancelRequestedImpl _value,
      $Res Function(_$TaskCancelRequestedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$TaskCancelRequestedImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as InventoryTaskSummary,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryTaskSummaryCopyWith<$Res> get task {
    return $InventoryTaskSummaryCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$TaskCancelRequestedImpl implements _TaskCancelRequested {
  const _$TaskCancelRequestedImpl(this.task);

  @override
  final InventoryTaskSummary task;

  @override
  String toString() {
    return 'AswhInventoryTaskListEvent.taskCancelRequested(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCancelRequestedImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCancelRequestedImplCopyWith<_$TaskCancelRequestedImpl> get copyWith =>
      __$$TaskCancelRequestedImplCopyWithImpl<_$TaskCancelRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) {
    return taskCancelRequested(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) {
    return taskCancelRequested?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (taskCancelRequested != null) {
      return taskCancelRequested(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return taskCancelRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return taskCancelRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (taskCancelRequested != null) {
      return taskCancelRequested(this);
    }
    return orElse();
  }
}

abstract class _TaskCancelRequested implements AswhInventoryTaskListEvent {
  const factory _TaskCancelRequested(final InventoryTaskSummary task) =
      _$TaskCancelRequestedImpl;

  InventoryTaskSummary get task;
  @JsonKey(ignore: true)
  _$$TaskCancelRequestedImplCopyWith<_$TaskCancelRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PageChangedImplCopyWith<$Res> {
  factory _$$PageChangedImplCopyWith(
          _$PageChangedImpl value, $Res Function(_$PageChangedImpl) then) =
      __$$PageChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int pageIndex});
}

/// @nodoc
class __$$PageChangedImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListEventCopyWithImpl<$Res, _$PageChangedImpl>
    implements _$$PageChangedImplCopyWith<$Res> {
  __$$PageChangedImplCopyWithImpl(
      _$PageChangedImpl _value, $Res Function(_$PageChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageIndex = null,
  }) {
    return _then(_$PageChangedImpl(
      null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PageChangedImpl implements _PageChanged {
  const _$PageChangedImpl(this.pageIndex);

  @override
  final int pageIndex;

  @override
  String toString() {
    return 'AswhInventoryTaskListEvent.pageChanged(pageIndex: $pageIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageChangedImpl &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PageChangedImplCopyWith<_$PageChangedImpl> get copyWith =>
      __$$PageChangedImplCopyWithImpl<_$PageChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) {
    return pageChanged(pageIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) {
    return pageChanged?.call(pageIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (pageChanged != null) {
      return pageChanged(pageIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return pageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return pageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (pageChanged != null) {
      return pageChanged(this);
    }
    return orElse();
  }
}

abstract class _PageChanged implements AswhInventoryTaskListEvent {
  const factory _PageChanged(final int pageIndex) = _$PageChangedImpl;

  int get pageIndex;
  @JsonKey(ignore: true)
  _$$PageChangedImplCopyWith<_$PageChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(_$RefreshRequestedImpl value,
          $Res Function(_$RefreshRequestedImpl) then) =
      __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$AswhInventoryTaskListEventCopyWithImpl<$Res,
        _$RefreshRequestedImpl>
    implements _$$RefreshRequestedImplCopyWith<$Res> {
  __$$RefreshRequestedImplCopyWithImpl(_$RefreshRequestedImpl _value,
      $Res Function(_$RefreshRequestedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RefreshRequestedImpl implements _RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString() {
    return 'AswhInventoryTaskListEvent.refreshRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String searchKey) filterSubmitted,
    required TResult Function(String scanContent) scanContentReceived,
    required TResult Function(InventoryTaskSummary task) taskCancelRequested,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String searchKey)? filterSubmitted,
    TResult? Function(String scanContent)? scanContentReceived,
    TResult? Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String searchKey)? filterSubmitted,
    TResult Function(String scanContent)? scanContentReceived,
    TResult Function(InventoryTaskSummary task)? taskCancelRequested,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_FilterSubmitted value) filterSubmitted,
    required TResult Function(_ScanContentReceived value) scanContentReceived,
    required TResult Function(_TaskCancelRequested value) taskCancelRequested,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_FilterSubmitted value)? filterSubmitted,
    TResult? Function(_ScanContentReceived value)? scanContentReceived,
    TResult? Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_FilterSubmitted value)? filterSubmitted,
    TResult Function(_ScanContentReceived value)? scanContentReceived,
    TResult Function(_TaskCancelRequested value)? taskCancelRequested,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements AswhInventoryTaskListEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}
