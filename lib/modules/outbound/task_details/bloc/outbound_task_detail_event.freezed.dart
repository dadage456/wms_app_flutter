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
    required TResult Function(String searchKey) search,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(List<String> selectedItemIds) cancelSelectedItems,
    required TResult Function() refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String searchKey)? search,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult? Function()? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String searchKey)? search,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult Function()? refresh,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchEvent value) search,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(RefreshEvent value) refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchEvent value)? search,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(RefreshEvent value)? refresh,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchEvent value)? search,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(RefreshEvent value)? refresh,
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
abstract class _$$SearchEventImplCopyWith<$Res> {
  factory _$$SearchEventImplCopyWith(
    _$SearchEventImpl value,
    $Res Function(_$SearchEventImpl) then,
  ) = __$$SearchEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String searchKey});
}

/// @nodoc
class __$$SearchEventImplCopyWithImpl<$Res>
    extends _$OutboundTaskDetailEventCopyWithImpl<$Res, _$SearchEventImpl>
    implements _$$SearchEventImplCopyWith<$Res> {
  __$$SearchEventImplCopyWithImpl(
    _$SearchEventImpl _value,
    $Res Function(_$SearchEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? searchKey = null}) {
    return _then(
      _$SearchEventImpl(
        searchKey: null == searchKey
            ? _value.searchKey
            : searchKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchEventImpl implements SearchEvent {
  const _$SearchEventImpl({required this.searchKey});

  @override
  final String searchKey;

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.search(searchKey: $searchKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchEventImpl &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchKey);

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchEventImplCopyWith<_$SearchEventImpl> get copyWith =>
      __$$SearchEventImplCopyWithImpl<_$SearchEventImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String searchKey) search,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(List<String> selectedItemIds) cancelSelectedItems,
    required TResult Function() refresh,
  }) {
    return search(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String searchKey)? search,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult? Function()? refresh,
  }) {
    return search?.call(searchKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String searchKey)? search,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(searchKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchEvent value) search,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(RefreshEvent value) refresh,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchEvent value)? search,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(RefreshEvent value)? refresh,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchEvent value)? search,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(RefreshEvent value)? refresh,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class SearchEvent implements OutboundTaskDetailEvent {
  const factory SearchEvent({required final String searchKey}) =
      _$SearchEventImpl;

  String get searchKey;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchEventImplCopyWith<_$SearchEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    required TResult Function(String searchKey) search,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(List<String> selectedItemIds) cancelSelectedItems,
    required TResult Function() refresh,
  }) {
    return scanQRCode(qrContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String searchKey)? search,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult? Function()? refresh,
  }) {
    return scanQRCode?.call(qrContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String searchKey)? search,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult Function()? refresh,
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
    required TResult Function(SearchEvent value) search,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(RefreshEvent value) refresh,
  }) {
    return scanQRCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchEvent value)? search,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(RefreshEvent value)? refresh,
  }) {
    return scanQRCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchEvent value)? search,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(RefreshEvent value)? refresh,
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
abstract class _$$CancelSelectedItemsEventImplCopyWith<$Res> {
  factory _$$CancelSelectedItemsEventImplCopyWith(
    _$CancelSelectedItemsEventImpl value,
    $Res Function(_$CancelSelectedItemsEventImpl) then,
  ) = __$$CancelSelectedItemsEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> selectedItemIds});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedItemIds = null}) {
    return _then(
      _$CancelSelectedItemsEventImpl(
        selectedItemIds: null == selectedItemIds
            ? _value._selectedItemIds
            : selectedItemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$CancelSelectedItemsEventImpl implements CancelSelectedItemsEvent {
  const _$CancelSelectedItemsEventImpl({
    required final List<String> selectedItemIds,
  }) : _selectedItemIds = selectedItemIds;

  final List<String> _selectedItemIds;
  @override
  List<String> get selectedItemIds {
    if (_selectedItemIds is EqualUnmodifiableListView) return _selectedItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedItemIds);
  }

  @override
  String toString() {
    return 'OutboundTaskDetailEvent.cancelSelectedItems(selectedItemIds: $selectedItemIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelSelectedItemsEventImpl &&
            const DeepCollectionEquality().equals(
              other._selectedItemIds,
              _selectedItemIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedItemIds),
  );

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelSelectedItemsEventImplCopyWith<_$CancelSelectedItemsEventImpl>
  get copyWith =>
      __$$CancelSelectedItemsEventImplCopyWithImpl<
        _$CancelSelectedItemsEventImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String searchKey) search,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(List<String> selectedItemIds) cancelSelectedItems,
    required TResult Function() refresh,
  }) {
    return cancelSelectedItems(selectedItemIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String searchKey)? search,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult? Function()? refresh,
  }) {
    return cancelSelectedItems?.call(selectedItemIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String searchKey)? search,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (cancelSelectedItems != null) {
      return cancelSelectedItems(selectedItemIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SearchEvent value) search,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(RefreshEvent value) refresh,
  }) {
    return cancelSelectedItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchEvent value)? search,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(RefreshEvent value)? refresh,
  }) {
    return cancelSelectedItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchEvent value)? search,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(RefreshEvent value)? refresh,
    required TResult orElse(),
  }) {
    if (cancelSelectedItems != null) {
      return cancelSelectedItems(this);
    }
    return orElse();
  }
}

abstract class CancelSelectedItemsEvent implements OutboundTaskDetailEvent {
  const factory CancelSelectedItemsEvent({
    required final List<String> selectedItemIds,
  }) = _$CancelSelectedItemsEventImpl;

  List<String> get selectedItemIds;

  /// Create a copy of OutboundTaskDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CancelSelectedItemsEventImplCopyWith<_$CancelSelectedItemsEventImpl>
  get copyWith => throw _privateConstructorUsedError;
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
    required TResult Function(String searchKey) search,
    required TResult Function(String qrContent) scanQRCode,
    required TResult Function(List<String> selectedItemIds) cancelSelectedItems,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String searchKey)? search,
    TResult? Function(String qrContent)? scanQRCode,
    TResult? Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String searchKey)? search,
    TResult Function(String qrContent)? scanQRCode,
    TResult Function(List<String> selectedItemIds)? cancelSelectedItems,
    TResult Function()? refresh,
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
    required TResult Function(SearchEvent value) search,
    required TResult Function(ScanQRCodeEvent value) scanQRCode,
    required TResult Function(CancelSelectedItemsEvent value)
    cancelSelectedItems,
    required TResult Function(RefreshEvent value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SearchEvent value)? search,
    TResult? Function(ScanQRCodeEvent value)? scanQRCode,
    TResult? Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult? Function(RefreshEvent value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SearchEvent value)? search,
    TResult Function(ScanQRCodeEvent value)? scanQRCode,
    TResult Function(CancelSelectedItemsEvent value)? cancelSelectedItems,
    TResult Function(RefreshEvent value)? refresh,
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
