// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbound_task_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OutboundTaskDetailEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskDetailEventCopyWith<$Res> {
  factory $OutboundTaskDetailEventCopyWith(
    OutboundTaskDetailEvent value,
    $Res Function(OutboundTaskDetailEvent) then,
  ) = _$OutboundTaskDetailEventCopyWithImpl<$Res, OutboundTaskDetailEvent>;
}

/// @nodoc
class _$OutboundTaskDetailEventCopyWithImpl<
  $Res,
  $Val extends OutboundTaskDetailEvent
>
    implements $OutboundTaskDetailEventCopyWith<$Res> {
  _$OutboundTaskDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadTaskItemsEventImplCopyWith<$Res> {
  factory _$$LoadTaskItemsEventImplCopyWith(
    _$LoadTaskItemsEventImpl value,
    $Res Function(_$LoadTaskItemsEventImpl) then,
  ) = __$$LoadTaskItemsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutboundTaskItemQuery query});

  $OutboundTaskItemQueryCopyWith<$Res> get query;
}

/// @nodoc
class __$$LoadTaskItemsEventImplCopyWithImpl<$Res>
    extends
        _$OutboundTaskDetailEventCopyWithImpl<$Res, _$LoadTaskItemsEventImpl>
    implements _$$LoadTaskItemsEventImplCopyWith<$Res> {
  __$$LoadTaskItemsEventImplCopyWithImpl(
    _$LoadTaskItemsEventImpl _value,
    $Res Function(_$LoadTaskItemsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$LoadTaskItemsEventImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as OutboundTaskItemQuery,
      ),
    );
  }

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskItemQueryCopyWith<$Res> get query {
    return $OutboundTaskItemQueryCopyWith<$Res>(_value.query, (value) {
      return _then(_value.copyWith(query: value));
    });
  }
}

/// @nodoc

class _$LoadTaskItemsEventImpl implements LoadTaskItemsEvent {
  const _$LoadTaskItemsEventImpl({required this.query});

  @override
  final OutboundTaskItemQuery query;

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.loadTaskItems(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTaskItemsEventImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTaskItemsEventImplCopyWith<_$LoadTaskItemsEventImpl> get copyWith =>
      __$$LoadTaskItemsEventImplCopyWithImpl<_$LoadTaskItemsEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return loadTaskItems(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return loadTaskItems?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (loadTaskItems != null) {
      return loadTaskItems(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return loadTaskItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return loadTaskItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (loadTaskItems != null) {
      return loadTaskItems(this);
    }
    return orElse();
  }
}

abstract class LoadTaskItemsEvent implements OutboundTaskDetailEvent {
  const factory LoadTaskItemsEvent({
    required final OutboundTaskItemQuery query,
  }) = _$LoadTaskItemsEventImpl;

  OutboundTaskItemQuery get query;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTaskItemsEventImplCopyWith<_$LoadTaskItemsEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchTaskItemsEventImplCopyWith<$Res> {
  factory _$$SearchTaskItemsEventImplCopyWith(
    _$SearchTaskItemsEventImpl value,
    $Res Function(_$SearchTaskItemsEventImpl) then,
  ) = __$$SearchTaskItemsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OutboundTaskItemQuery query});

  $OutboundTaskItemQueryCopyWith<$Res> get query;
}

/// @nodoc
class __$$SearchTaskItemsEventImplCopyWithImpl<$Res>
    extends
        _$OutboundTaskDetailEventCopyWithImpl<$Res, _$SearchTaskItemsEventImpl>
    implements _$$SearchTaskItemsEventImplCopyWith<$Res> {
  __$$SearchTaskItemsEventImplCopyWithImpl(
    _$SearchTaskItemsEventImpl _value,
    $Res Function(_$SearchTaskItemsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchTaskItemsEventImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as OutboundTaskItemQuery,
      ),
    );
  }

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskItemQueryCopyWith<$Res> get query {
    return $OutboundTaskItemQueryCopyWith<$Res>(_value.query, (value) {
      return _then(_value.copyWith(query: value));
    });
  }
}

/// @nodoc

class _$SearchTaskItemsEventImpl implements SearchTaskItemsEvent {
  const _$SearchTaskItemsEventImpl({required this.query});

  @override
  final OutboundTaskItemQuery query;

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.searchTaskItems(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTaskItemsEventImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTaskItemsEventImplCopyWith<_$SearchTaskItemsEventImpl>
  get copyWith =>
      __$$SearchTaskItemsEventImplCopyWithImpl<_$SearchTaskItemsEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return searchTaskItems(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return searchTaskItems?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (searchTaskItems != null) {
      return searchTaskItems(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return searchTaskItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return searchTaskItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (searchTaskItems != null) {
      return searchTaskItems(this);
    }
    return orElse();
  }
}

abstract class SearchTaskItemsEvent implements OutboundTaskDetailEvent {
  const factory SearchTaskItemsEvent({
    required final OutboundTaskItemQuery query,
  }) = _$SearchTaskItemsEventImpl;

  OutboundTaskItemQuery get query;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchTaskItemsEventImplCopyWith<_$SearchTaskItemsEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScanQRCodeEventImplCopyWith<$Res> {
  factory _$$ScanQRCodeEventImplCopyWith(
    _$ScanQRCodeEventImpl value,
    $Res Function(_$ScanQRCodeEventImpl) then,
  ) = __$$ScanQRCodeEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String qrContent});
}

/// @nodoc
class __$$ScanQRCodeEventImplCopyWithImpl<$Res>
    extends _$OutboundTaskDetailEventCopyWithImpl<$Res, _$ScanQRCodeEventImpl>
    implements _$$ScanQRCodeEventImplCopyWith<$Res> {
  __$$ScanQRCodeEventImplCopyWithImpl(
    _$ScanQRCodeEventImpl _value,
    $Res Function(_$ScanQRCodeEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? qrContent = null}) {
    return _then(
      _$ScanQRCodeEventImpl(
        qrContent: null == qrContent
            ? _value.qrContent
            : qrContent // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ScanQRCodeEventImpl implements ScanQRCodeEvent {
  const _$ScanQRCodeEventImpl({required this.qrContent});

  @override
  final String qrContent;

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.scanQRCode(qrContent: $qrContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanQRCodeEventImpl &&
            (identical(other.qrContent, qrContent) ||
                other.qrContent == qrContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, qrContent);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanQRCodeEventImplCopyWith<_$ScanQRCodeEventImpl> get copyWith =>
      __$$ScanQRCodeEventImplCopyWithImpl<_$ScanQRCodeEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return scanQRCode(qrContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return scanQRCode?.call(qrContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (scanQRCode != null) {
      return scanQRCode(qrContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return scanQRCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return scanQRCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (scanQRCode != null) {
      return scanQRCode(this);
    }
    return orElse();
  }
}

abstract class ScanQRCodeEvent implements OutboundTaskDetailEvent {
  const factory ScanQRCodeEvent({required final String qrContent}) =
      _$ScanQRCodeEventImpl;

  String get qrContent;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanQRCodeEventImplCopyWith<_$ScanQRCodeEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectTaskItemEventImplCopyWith<$Res> {
  factory _$$SelectTaskItemEventImplCopyWith(
    _$SelectTaskItemEventImpl value,
    $Res Function(_$SelectTaskItemEventImpl) then,
  ) = __$$SelectTaskItemEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskItemId, bool isSelected});
}

/// @nodoc
class __$$SelectTaskItemEventImplCopyWithImpl<$Res>
    extends
        _$OutboundTaskDetailEventCopyWithImpl<$Res, _$SelectTaskItemEventImpl>
    implements _$$SelectTaskItemEventImplCopyWith<$Res> {
  __$$SelectTaskItemEventImplCopyWithImpl(
    _$SelectTaskItemEventImpl _value,
    $Res Function(_$SelectTaskItemEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? taskItemId = null, Object? isSelected = null}) {
    return _then(
      _$SelectTaskItemEventImpl(
        taskItemId: null == taskItemId
            ? _value.taskItemId
            : taskItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        isSelected: null == isSelected
            ? _value.isSelected
            : isSelected // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SelectTaskItemEventImpl implements SelectTaskItemEvent {
  const _$SelectTaskItemEventImpl({
    required this.taskItemId,
    required this.isSelected,
  });

  @override
  final String taskItemId;
  @override
  final bool isSelected;

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.selectTaskItem(taskItemId: $taskItemId, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectTaskItemEventImpl &&
            (identical(other.taskItemId, taskItemId) ||
                other.taskItemId == taskItemId) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskItemId, isSelected);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectTaskItemEventImplCopyWith<_$SelectTaskItemEventImpl> get copyWith =>
      __$$SelectTaskItemEventImplCopyWithImpl<_$SelectTaskItemEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return selectTaskItem(taskItemId, isSelected);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return selectTaskItem?.call(taskItemId, isSelected);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (selectTaskItem != null) {
      return selectTaskItem(taskItemId, isSelected);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return selectTaskItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return selectTaskItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (selectTaskItem != null) {
      return selectTaskItem(this);
    }
    return orElse();
  }
}

abstract class SelectTaskItemEvent implements OutboundTaskDetailEvent {
  const factory SelectTaskItemEvent({
    required final String taskItemId,
    required final bool isSelected,
  }) = _$SelectTaskItemEventImpl;

  String get taskItemId;
  bool get isSelected;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectTaskItemEventImplCopyWith<_$SelectTaskItemEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectAllEventImplCopyWith<$Res> {
  factory _$$SelectAllEventImplCopyWith(
    _$SelectAllEventImpl value,
    $Res Function(_$SelectAllEventImpl) then,
  ) = __$$SelectAllEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isSelectAll});
}

/// @nodoc
class __$$SelectAllEventImplCopyWithImpl<$Res>
    extends _$OutboundTaskDetailEventCopyWithImpl<$Res, _$SelectAllEventImpl>
    implements _$$SelectAllEventImplCopyWith<$Res> {
  __$$SelectAllEventImplCopyWithImpl(
    _$SelectAllEventImpl _value,
    $Res Function(_$SelectAllEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isSelectAll = null}) {
    return _then(
      _$SelectAllEventImpl(
        isSelectAll: null == isSelectAll
            ? _value.isSelectAll
            : isSelectAll // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SelectAllEventImpl implements SelectAllEvent {
  const _$SelectAllEventImpl({required this.isSelectAll});

  @override
  final bool isSelectAll;

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.selectAll(isSelectAll: $isSelectAll)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectAllEventImpl &&
            (identical(other.isSelectAll, isSelectAll) ||
                other.isSelectAll == isSelectAll));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSelectAll);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectAllEventImplCopyWith<_$SelectAllEventImpl> get copyWith =>
      __$$SelectAllEventImplCopyWithImpl<_$SelectAllEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return selectAll(isSelectAll);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return selectAll?.call(isSelectAll);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (selectAll != null) {
      return selectAll(isSelectAll);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return selectAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return selectAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (selectAll != null) {
      return selectAll(this);
    }
    return orElse();
  }
}

abstract class SelectAllEvent implements OutboundTaskDetailEvent {
  const factory SelectAllEvent({required final bool isSelectAll}) =
      _$SelectAllEventImpl;

  bool get isSelectAll;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectAllEventImplCopyWith<_$SelectAllEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CancelSelectedItemsEventImplCopyWith<$Res> {
  factory _$$CancelSelectedItemsEventImplCopyWith(
    _$CancelSelectedItemsEventImpl value,
    $Res Function(_$CancelSelectedItemsEventImpl) then,
  ) = __$$CancelSelectedItemsEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CancelSelectedItemsEventImplCopyWithImpl<$Res>
    extends
        _$OutboundTaskDetailEventCopyWithImpl<
          $Res,
          _$CancelSelectedItemsEventImpl
        >
    implements _$$CancelSelectedItemsEventImplCopyWith<$Res> {
  __$$CancelSelectedItemsEventImplCopyWithImpl(
    _$CancelSelectedItemsEventImpl _value,
    $Res Function(_$CancelSelectedItemsEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CancelSelectedItemsEventImpl implements CancelSelectedItemsEvent {
  const _$CancelSelectedItemsEventImpl();

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.cancelSelectedItems()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelSelectedItemsEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return cancelSelectedItems();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return cancelSelectedItems?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (cancelSelectedItems != null) {
      return cancelSelectedItems();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return cancelSelectedItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return cancelSelectedItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (cancelSelectedItems != null) {
      return cancelSelectedItems(this);
    }
    return orElse();
  }
}

abstract class CancelSelectedItemsEvent implements OutboundTaskDetailEvent {
  const factory CancelSelectedItemsEvent() = _$CancelSelectedItemsEventImpl;
}

/// @nodoc
abstract class _$$ClearSelectionEventImplCopyWith<$Res> {
  factory _$$ClearSelectionEventImplCopyWith(
    _$ClearSelectionEventImpl value,
    $Res Function(_$ClearSelectionEventImpl) then,
  ) = __$$ClearSelectionEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSelectionEventImplCopyWithImpl<$Res>
    extends
        _$OutboundTaskDetailEventCopyWithImpl<$Res, _$ClearSelectionEventImpl>
    implements _$$ClearSelectionEventImplCopyWith<$Res> {
  __$$ClearSelectionEventImplCopyWithImpl(
    _$ClearSelectionEventImpl _value,
    $Res Function(_$ClearSelectionEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSelectionEventImpl implements ClearSelectionEvent {
  const _$ClearSelectionEventImpl();

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.clearSelection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClearSelectionEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return clearSelection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return clearSelection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (clearSelection != null) {
      return clearSelection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return clearSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return clearSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (clearSelection != null) {
      return clearSelection(this);
    }
    return orElse();
  }
}

abstract class ClearSelectionEvent implements OutboundTaskDetailEvent {
  const factory ClearSelectionEvent() = _$ClearSelectionEventImpl;
}

/// @nodoc
abstract class _$$RefreshEventImplCopyWith<$Res> {
  factory _$$RefreshEventImplCopyWith(
    _$RefreshEventImpl value,
    $Res Function(_$RefreshEventImpl) then,
  ) = __$$RefreshEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshEventImplCopyWithImpl<$Res>
    extends _$OutboundTaskDetailEventCopyWithImpl<$Res, _$RefreshEventImpl>
    implements _$$RefreshEventImplCopyWith<$Res> {
  __$$RefreshEventImplCopyWithImpl(
    _$RefreshEventImpl _value,
    $Res Function(_$RefreshEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshEventImpl implements RefreshEvent {
  const _$RefreshEventImpl();

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshEvent implements OutboundTaskDetailEvent {
  const factory RefreshEvent() = _$RefreshEventImpl;
}

/// @nodoc
abstract class _$$LoadMoreEventImplCopyWith<$Res> {
  factory _$$LoadMoreEventImplCopyWith(
    _$LoadMoreEventImpl value,
    $Res Function(_$LoadMoreEventImpl) then,
  ) = __$$LoadMoreEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreEventImplCopyWithImpl<$Res>
    extends _$OutboundTaskDetailEventCopyWithImpl<$Res, _$LoadMoreEventImpl>
    implements _$$LoadMoreEventImplCopyWith<$Res> {
  __$$LoadMoreEventImplCopyWithImpl(
    _$LoadMoreEventImpl _value,
    $Res Function(_$LoadMoreEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreEventImpl implements LoadMoreEvent {
  const _$LoadMoreEventImpl();

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OutboundTaskItemQuery query) loadTaskItems,
    required TResult Function(OutboundTaskItemQuery query) searchTaskItems,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(String taskItemId, bool isSelected)
    selectTaskItem,
    required TResult Function(bool isSelectAll) selectAll,
    required TResult Function() cancelSelectedItems,
    required TResult Function() clearSelection,
    required TResult Function() refresh,
    required TResult Function() loadMore,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult? Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult? Function(bool isSelectAll)? selectAll,
    TResult? Function()? cancelSelectedItems,
    TResult? Function()? clearSelection,
    TResult? Function()? refresh,
    TResult? Function()? loadMore,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OutboundTaskItemQuery query)? loadTaskItems,
    TResult Function(OutboundTaskItemQuery query)? searchTaskItems,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(String taskItemId, bool isSelected)? selectTaskItem,
    TResult Function(bool isSelectAll)? selectAll,
    TResult Function()? cancelSelectedItems,
    TResult Function()? clearSelection,
    TResult Function()? refresh,
    TResult Function()? loadMore,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTaskItemsEvent value) loadTaskItems,
    required TResult Function(SearchTaskItemsEvent value) searchTaskItems,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(SelectTaskItemEvent value) selectTaskItem,
    required TResult Function(SelectAllEvent value) selectAll,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(ClearSelectionEvent value) clearSelection,
    required TResult Function(RefreshEvent value) refresh,
    required TResult Function(LoadMoreEvent value) loadMore,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult? Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult? Function(SelectAllEvent value)? selectAll,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(ClearSelectionEvent value)? clearSelection,
    TResult? Function(RefreshEvent value)? refresh,
    TResult? Function(LoadMoreEvent value)? loadMore,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTaskItemsEvent value)? loadTaskItems,
    TResult Function(SearchTaskItemsEvent value)? searchTaskItems,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(SelectTaskItemEvent value)? selectTaskItem,
    TResult Function(SelectAllEvent value)? selectAll,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(ClearSelectionEvent value)? clearSelection,
    TResult Function(RefreshEvent value)? refresh,
    TResult Function(LoadMoreEvent value)? loadMore,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class LoadMoreEvent implements OutboundTaskDetailEvent {
  const factory LoadMoreEvent() = _$LoadMoreEventImpl;
}
