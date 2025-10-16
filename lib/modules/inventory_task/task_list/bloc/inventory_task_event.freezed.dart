// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_task_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InventoryTaskEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskEventCopyWith<$Res> {
  factory $InventoryTaskEventCopyWith(
          InventoryTaskEvent value, $Res Function(InventoryTaskEvent) then) =
      _$InventoryTaskEventCopyWithImpl<$Res, InventoryTaskEvent>;
}

/// @nodoc
class _$InventoryTaskEventCopyWithImpl<$Res, $Val extends InventoryTaskEvent>
    implements $InventoryTaskEventCopyWith<$Res> {
  _$InventoryTaskEventCopyWithImpl(this._value, this._then);

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
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'InventoryTaskEvent.started()';
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
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
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
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements InventoryTaskEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$ScannedImplCopyWith<$Res> {
  factory _$$ScannedImplCopyWith(
          _$ScannedImpl value, $Res Function(_$ScannedImpl) then) =
      __$$ScannedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$$ScannedImplCopyWithImpl<$Res>
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$ScannedImpl>
    implements _$$ScannedImplCopyWith<$Res> {
  __$$ScannedImplCopyWithImpl(
      _$ScannedImpl _value, $Res Function(_$ScannedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
  }) {
    return _then(_$ScannedImpl(
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScannedImpl implements _Scanned {
  const _$ScannedImpl(this.content);

  @override
  final String content;

  @override
  String toString() {
    return 'InventoryTaskEvent.scanned(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannedImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannedImplCopyWith<_$ScannedImpl> get copyWith =>
      __$$ScannedImplCopyWithImpl<_$ScannedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return scanned(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return scanned?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
    required TResult orElse(),
  }) {
    if (scanned != null) {
      return scanned(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return scanned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return scanned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (scanned != null) {
      return scanned(this);
    }
    return orElse();
  }
}

abstract class _Scanned implements InventoryTaskEvent {
  const factory _Scanned(final String content) = _$ScannedImpl;

  String get content;
  @JsonKey(ignore: true)
  _$$ScannedImplCopyWith<_$ScannedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSubmittedImplCopyWith<$Res> {
  factory _$$SearchSubmittedImplCopyWith(_$SearchSubmittedImpl value,
          $Res Function(_$SearchSubmittedImpl) then) =
      __$$SearchSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String keyword});
}

/// @nodoc
class __$$SearchSubmittedImplCopyWithImpl<$Res>
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$SearchSubmittedImpl>
    implements _$$SearchSubmittedImplCopyWith<$Res> {
  __$$SearchSubmittedImplCopyWithImpl(
      _$SearchSubmittedImpl _value, $Res Function(_$SearchSubmittedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
  }) {
    return _then(_$SearchSubmittedImpl(
      null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchSubmittedImpl implements _SearchSubmitted {
  const _$SearchSubmittedImpl(this.keyword);

  @override
  final String keyword;

  @override
  String toString() {
    return 'InventoryTaskEvent.searchSubmitted(keyword: $keyword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSubmittedImpl &&
            (identical(other.keyword, keyword) || other.keyword == keyword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, keyword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSubmittedImplCopyWith<_$SearchSubmittedImpl> get copyWith =>
      __$$SearchSubmittedImplCopyWithImpl<_$SearchSubmittedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return searchSubmitted(keyword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return searchSubmitted?.call(keyword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
    required TResult orElse(),
  }) {
    if (searchSubmitted != null) {
      return searchSubmitted(keyword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return searchSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return searchSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (searchSubmitted != null) {
      return searchSubmitted(this);
    }
    return orElse();
  }
}

abstract class _SearchSubmitted implements InventoryTaskEvent {
  const factory _SearchSubmitted(final String keyword) = _$SearchSubmittedImpl;

  String get keyword;
  @JsonKey(ignore: true)
  _$$SearchSubmittedImplCopyWith<_$SearchSubmittedImpl> get copyWith =>
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
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$PageChangedImpl>
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
    return 'InventoryTaskEvent.pageChanged(pageIndex: $pageIndex)';
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
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return pageChanged(pageIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return pageChanged?.call(pageIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
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
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return pageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return pageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (pageChanged != null) {
      return pageChanged(this);
    }
    return orElse();
  }
}

abstract class _PageChanged implements InventoryTaskEvent {
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
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
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
    return 'InventoryTaskEvent.refreshRequested()';
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
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
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
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements InventoryTaskEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$CancelTaskRequestedImplCopyWith<$Res> {
  factory _$$CancelTaskRequestedImplCopyWith(_$CancelTaskRequestedImpl value,
          $Res Function(_$CancelTaskRequestedImpl) then) =
      __$$CancelTaskRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InventoryTask task});

  $InventoryTaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$CancelTaskRequestedImplCopyWithImpl<$Res>
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$CancelTaskRequestedImpl>
    implements _$$CancelTaskRequestedImplCopyWith<$Res> {
  __$$CancelTaskRequestedImplCopyWithImpl(_$CancelTaskRequestedImpl _value,
      $Res Function(_$CancelTaskRequestedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$CancelTaskRequestedImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as InventoryTask,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $InventoryTaskCopyWith<$Res> get task {
    return $InventoryTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$CancelTaskRequestedImpl implements _CancelTaskRequested {
  const _$CancelTaskRequestedImpl(this.task);

  @override
  final InventoryTask task;

  @override
  String toString() {
    return 'InventoryTaskEvent.cancelTaskRequested(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelTaskRequestedImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelTaskRequestedImplCopyWith<_$CancelTaskRequestedImpl> get copyWith =>
      __$$CancelTaskRequestedImplCopyWithImpl<_$CancelTaskRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return cancelTaskRequested(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return cancelTaskRequested?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
    required TResult orElse(),
  }) {
    if (cancelTaskRequested != null) {
      return cancelTaskRequested(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return cancelTaskRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return cancelTaskRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (cancelTaskRequested != null) {
      return cancelTaskRequested(this);
    }
    return orElse();
  }
}

abstract class _CancelTaskRequested implements InventoryTaskEvent {
  const factory _CancelTaskRequested(final InventoryTask task) =
      _$CancelTaskRequestedImpl;

  InventoryTask get task;
  @JsonKey(ignore: true)
  _$$CancelTaskRequestedImplCopyWith<_$CancelTaskRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NavigateToReceiveImplCopyWith<$Res> {
  factory _$$NavigateToReceiveImplCopyWith(_$NavigateToReceiveImpl value,
          $Res Function(_$NavigateToReceiveImpl) then) =
      __$$NavigateToReceiveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateToReceiveImplCopyWithImpl<$Res>
    extends _$InventoryTaskEventCopyWithImpl<$Res, _$NavigateToReceiveImpl>
    implements _$$NavigateToReceiveImplCopyWith<$Res> {
  __$$NavigateToReceiveImplCopyWithImpl(_$NavigateToReceiveImpl _value,
      $Res Function(_$NavigateToReceiveImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NavigateToReceiveImpl implements _NavigateToReceive {
  const _$NavigateToReceiveImpl();

  @override
  String toString() {
    return 'InventoryTaskEvent.navigateToReceive()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NavigateToReceiveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function() refreshRequested,
    required TResult Function(InventoryTask task) cancelTaskRequested,
    required TResult Function() navigateToReceive,
  }) {
    return navigateToReceive();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function()? refreshRequested,
    TResult? Function(InventoryTask task)? cancelTaskRequested,
    TResult? Function()? navigateToReceive,
  }) {
    return navigateToReceive?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function()? refreshRequested,
    TResult Function(InventoryTask task)? cancelTaskRequested,
    TResult Function()? navigateToReceive,
    required TResult orElse(),
  }) {
    if (navigateToReceive != null) {
      return navigateToReceive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_CancelTaskRequested value) cancelTaskRequested,
    required TResult Function(_NavigateToReceive value) navigateToReceive,
  }) {
    return navigateToReceive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult? Function(_NavigateToReceive value)? navigateToReceive,
  }) {
    return navigateToReceive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_CancelTaskRequested value)? cancelTaskRequested,
    TResult Function(_NavigateToReceive value)? navigateToReceive,
    required TResult orElse(),
  }) {
    if (navigateToReceive != null) {
      return navigateToReceive(this);
    }
    return orElse();
  }
}

abstract class _NavigateToReceive implements InventoryTaskEvent {
  const factory _NavigateToReceive() = _$NavigateToReceiveImpl;
}
