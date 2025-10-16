// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_receive_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InventoryReceiveEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function(InventoryTask task) receiveRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function(InventoryTask task)? receiveRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function(InventoryTask task)? receiveRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_SearchSubmitted value) searchSubmitted,
    required TResult Function(_PageChanged value) pageChanged,
    required TResult Function(_ReceiveRequested value) receiveRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_ReceiveRequested value)? receiveRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_ReceiveRequested value)? receiveRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryReceiveEventCopyWith<$Res> {
  factory $InventoryReceiveEventCopyWith(InventoryReceiveEvent value,
          $Res Function(InventoryReceiveEvent) then) =
      _$InventoryReceiveEventCopyWithImpl<$Res, InventoryReceiveEvent>;
}

/// @nodoc
class _$InventoryReceiveEventCopyWithImpl<$Res,
        $Val extends InventoryReceiveEvent>
    implements $InventoryReceiveEventCopyWith<$Res> {
  _$InventoryReceiveEventCopyWithImpl(this._value, this._then);

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
    extends _$InventoryReceiveEventCopyWithImpl<$Res, _$StartedImpl>
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
    return 'InventoryReceiveEvent.started()';
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
    required TResult Function(InventoryTask task) receiveRequested,
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
    TResult? Function(InventoryTask task)? receiveRequested,
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
    TResult Function(InventoryTask task)? receiveRequested,
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
    required TResult Function(_ReceiveRequested value) receiveRequested,
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
    TResult? Function(_ReceiveRequested value)? receiveRequested,
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
    TResult Function(_ReceiveRequested value)? receiveRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements InventoryReceiveEvent {
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
    extends _$InventoryReceiveEventCopyWithImpl<$Res, _$ScannedImpl>
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
    return 'InventoryReceiveEvent.scanned(content: $content)';
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
    required TResult Function(InventoryTask task) receiveRequested,
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
    TResult? Function(InventoryTask task)? receiveRequested,
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
    TResult Function(InventoryTask task)? receiveRequested,
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
    required TResult Function(_ReceiveRequested value) receiveRequested,
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
    TResult? Function(_ReceiveRequested value)? receiveRequested,
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
    TResult Function(_ReceiveRequested value)? receiveRequested,
    required TResult orElse(),
  }) {
    if (scanned != null) {
      return scanned(this);
    }
    return orElse();
  }
}

abstract class _Scanned implements InventoryReceiveEvent {
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
    extends _$InventoryReceiveEventCopyWithImpl<$Res, _$SearchSubmittedImpl>
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
    return 'InventoryReceiveEvent.searchSubmitted(keyword: $keyword)';
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
    required TResult Function(InventoryTask task) receiveRequested,
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
    TResult? Function(InventoryTask task)? receiveRequested,
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
    TResult Function(InventoryTask task)? receiveRequested,
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
    required TResult Function(_ReceiveRequested value) receiveRequested,
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
    TResult? Function(_ReceiveRequested value)? receiveRequested,
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
    TResult Function(_ReceiveRequested value)? receiveRequested,
    required TResult orElse(),
  }) {
    if (searchSubmitted != null) {
      return searchSubmitted(this);
    }
    return orElse();
  }
}

abstract class _SearchSubmitted implements InventoryReceiveEvent {
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
    extends _$InventoryReceiveEventCopyWithImpl<$Res, _$PageChangedImpl>
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
    return 'InventoryReceiveEvent.pageChanged(pageIndex: $pageIndex)';
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
    required TResult Function(InventoryTask task) receiveRequested,
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
    TResult? Function(InventoryTask task)? receiveRequested,
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
    TResult Function(InventoryTask task)? receiveRequested,
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
    required TResult Function(_ReceiveRequested value) receiveRequested,
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
    TResult? Function(_ReceiveRequested value)? receiveRequested,
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
    TResult Function(_ReceiveRequested value)? receiveRequested,
    required TResult orElse(),
  }) {
    if (pageChanged != null) {
      return pageChanged(this);
    }
    return orElse();
  }
}

abstract class _PageChanged implements InventoryReceiveEvent {
  const factory _PageChanged(final int pageIndex) = _$PageChangedImpl;

  int get pageIndex;
  @JsonKey(ignore: true)
  _$$PageChangedImplCopyWith<_$PageChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReceiveRequestedImplCopyWith<$Res> {
  factory _$$ReceiveRequestedImplCopyWith(_$ReceiveRequestedImpl value,
          $Res Function(_$ReceiveRequestedImpl) then) =
      __$$ReceiveRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InventoryTask task});

  $InventoryTaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$ReceiveRequestedImplCopyWithImpl<$Res>
    extends _$InventoryReceiveEventCopyWithImpl<$Res, _$ReceiveRequestedImpl>
    implements _$$ReceiveRequestedImplCopyWith<$Res> {
  __$$ReceiveRequestedImplCopyWithImpl(_$ReceiveRequestedImpl _value,
      $Res Function(_$ReceiveRequestedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$ReceiveRequestedImpl(
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

class _$ReceiveRequestedImpl implements _ReceiveRequested {
  const _$ReceiveRequestedImpl(this.task);

  @override
  final InventoryTask task;

  @override
  String toString() {
    return 'InventoryReceiveEvent.receiveRequested(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiveRequestedImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiveRequestedImplCopyWith<_$ReceiveRequestedImpl> get copyWith =>
      __$$ReceiveRequestedImplCopyWithImpl<_$ReceiveRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String content) scanned,
    required TResult Function(String keyword) searchSubmitted,
    required TResult Function(int pageIndex) pageChanged,
    required TResult Function(InventoryTask task) receiveRequested,
  }) {
    return receiveRequested(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String content)? scanned,
    TResult? Function(String keyword)? searchSubmitted,
    TResult? Function(int pageIndex)? pageChanged,
    TResult? Function(InventoryTask task)? receiveRequested,
  }) {
    return receiveRequested?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String content)? scanned,
    TResult Function(String keyword)? searchSubmitted,
    TResult Function(int pageIndex)? pageChanged,
    TResult Function(InventoryTask task)? receiveRequested,
    required TResult orElse(),
  }) {
    if (receiveRequested != null) {
      return receiveRequested(task);
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
    required TResult Function(_ReceiveRequested value) receiveRequested,
  }) {
    return receiveRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_SearchSubmitted value)? searchSubmitted,
    TResult? Function(_PageChanged value)? pageChanged,
    TResult? Function(_ReceiveRequested value)? receiveRequested,
  }) {
    return receiveRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_SearchSubmitted value)? searchSubmitted,
    TResult Function(_PageChanged value)? pageChanged,
    TResult Function(_ReceiveRequested value)? receiveRequested,
    required TResult orElse(),
  }) {
    if (receiveRequested != null) {
      return receiveRequested(this);
    }
    return orElse();
  }
}

abstract class _ReceiveRequested implements InventoryReceiveEvent {
  const factory _ReceiveRequested(final InventoryTask task) =
      _$ReceiveRequestedImpl;

  InventoryTask get task;
  @JsonKey(ignore: true)
  _$$ReceiveRequestedImplCopyWith<_$ReceiveRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
