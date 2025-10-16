// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_collect_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InventoryCollectEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectEventCopyWith<$Res> {
  factory $InventoryCollectEventCopyWith(InventoryCollectEvent value,
          $Res Function(InventoryCollectEvent) then) =
      _$InventoryCollectEventCopyWithImpl<$Res, InventoryCollectEvent>;
}

/// @nodoc
class _$InventoryCollectEventCopyWithImpl<$Res,
        $Val extends InventoryCollectEvent>
    implements $InventoryCollectEventCopyWith<$Res> {
  _$InventoryCollectEventCopyWithImpl(this._value, this._then);

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
  @useResult
  $Res call({InventoryTask task});

  $InventoryTaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$StartedImpl(
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

class _$StartedImpl implements _Started {
  const _$StartedImpl(this.task);

  @override
  final InventoryTask task;

  @override
  String toString() {
    return 'InventoryCollectEvent.started(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartedImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith =>
      __$$StartedImplCopyWithImpl<_$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return started(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return started?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements InventoryCollectEvent {
  const factory _Started(final InventoryTask task) = _$StartedImpl;

  InventoryTask get task;
  @JsonKey(ignore: true)
  _$$StartedImplCopyWith<_$StartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StoreSiteScannedImplCopyWith<$Res> {
  factory _$$StoreSiteScannedImplCopyWith(_$StoreSiteScannedImpl value,
          $Res Function(_$StoreSiteScannedImpl) then) =
      __$$StoreSiteScannedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String storeSite});
}

/// @nodoc
class __$$StoreSiteScannedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$StoreSiteScannedImpl>
    implements _$$StoreSiteScannedImplCopyWith<$Res> {
  __$$StoreSiteScannedImplCopyWithImpl(_$StoreSiteScannedImpl _value,
      $Res Function(_$StoreSiteScannedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeSite = null,
  }) {
    return _then(_$StoreSiteScannedImpl(
      null == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StoreSiteScannedImpl implements _StoreSiteScanned {
  const _$StoreSiteScannedImpl(this.storeSite);

  @override
  final String storeSite;

  @override
  String toString() {
    return 'InventoryCollectEvent.storeSiteScanned(storeSite: $storeSite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreSiteScannedImpl &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite));
  }

  @override
  int get hashCode => Object.hash(runtimeType, storeSite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreSiteScannedImplCopyWith<_$StoreSiteScannedImpl> get copyWith =>
      __$$StoreSiteScannedImplCopyWithImpl<_$StoreSiteScannedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return storeSiteScanned(storeSite);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return storeSiteScanned?.call(storeSite);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (storeSiteScanned != null) {
      return storeSiteScanned(storeSite);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return storeSiteScanned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return storeSiteScanned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (storeSiteScanned != null) {
      return storeSiteScanned(this);
    }
    return orElse();
  }
}

abstract class _StoreSiteScanned implements InventoryCollectEvent {
  const factory _StoreSiteScanned(final String storeSite) =
      _$StoreSiteScannedImpl;

  String get storeSite;
  @JsonKey(ignore: true)
  _$$StoreSiteScannedImplCopyWith<_$StoreSiteScannedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MaterialScannedImplCopyWith<$Res> {
  factory _$$MaterialScannedImplCopyWith(_$MaterialScannedImpl value,
          $Res Function(_$MaterialScannedImpl) then) =
      __$$MaterialScannedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String barcode});
}

/// @nodoc
class __$$MaterialScannedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$MaterialScannedImpl>
    implements _$$MaterialScannedImplCopyWith<$Res> {
  __$$MaterialScannedImplCopyWithImpl(
      _$MaterialScannedImpl _value, $Res Function(_$MaterialScannedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
  }) {
    return _then(_$MaterialScannedImpl(
      null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MaterialScannedImpl implements _MaterialScanned {
  const _$MaterialScannedImpl(this.barcode);

  @override
  final String barcode;

  @override
  String toString() {
    return 'InventoryCollectEvent.materialScanned(barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialScannedImpl &&
            (identical(other.barcode, barcode) || other.barcode == barcode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, barcode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialScannedImplCopyWith<_$MaterialScannedImpl> get copyWith =>
      __$$MaterialScannedImplCopyWithImpl<_$MaterialScannedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return materialScanned(barcode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return materialScanned?.call(barcode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (materialScanned != null) {
      return materialScanned(barcode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return materialScanned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return materialScanned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (materialScanned != null) {
      return materialScanned(this);
    }
    return orElse();
  }
}

abstract class _MaterialScanned implements InventoryCollectEvent {
  const factory _MaterialScanned(final String barcode) = _$MaterialScannedImpl;

  String get barcode;
  @JsonKey(ignore: true)
  _$$MaterialScannedImplCopyWith<_$MaterialScannedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuantitySubmittedImplCopyWith<$Res> {
  factory _$$QuantitySubmittedImplCopyWith(_$QuantitySubmittedImpl value,
          $Res Function(_$QuantitySubmittedImpl) then) =
      __$$QuantitySubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double quantity});
}

/// @nodoc
class __$$QuantitySubmittedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$QuantitySubmittedImpl>
    implements _$$QuantitySubmittedImplCopyWith<$Res> {
  __$$QuantitySubmittedImplCopyWithImpl(_$QuantitySubmittedImpl _value,
      $Res Function(_$QuantitySubmittedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
  }) {
    return _then(_$QuantitySubmittedImpl(
      null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$QuantitySubmittedImpl implements _QuantitySubmitted {
  const _$QuantitySubmittedImpl(this.quantity);

  @override
  final double quantity;

  @override
  String toString() {
    return 'InventoryCollectEvent.quantitySubmitted(quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuantitySubmittedImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuantitySubmittedImplCopyWith<_$QuantitySubmittedImpl> get copyWith =>
      __$$QuantitySubmittedImplCopyWithImpl<_$QuantitySubmittedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return quantitySubmitted(quantity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return quantitySubmitted?.call(quantity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (quantitySubmitted != null) {
      return quantitySubmitted(quantity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return quantitySubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return quantitySubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (quantitySubmitted != null) {
      return quantitySubmitted(this);
    }
    return orElse();
  }
}

abstract class _QuantitySubmitted implements InventoryCollectEvent {
  const factory _QuantitySubmitted(final double quantity) =
      _$QuantitySubmittedImpl;

  double get quantity;
  @JsonKey(ignore: true)
  _$$QuantitySubmittedImplCopyWith<_$QuantitySubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TabChangedImplCopyWith<$Res> {
  factory _$$TabChangedImplCopyWith(
          _$TabChangedImpl value, $Res Function(_$TabChangedImpl) then) =
      __$$TabChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$TabChangedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$TabChangedImpl>
    implements _$$TabChangedImplCopyWith<$Res> {
  __$$TabChangedImplCopyWithImpl(
      _$TabChangedImpl _value, $Res Function(_$TabChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$TabChangedImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TabChangedImpl implements _TabChanged {
  const _$TabChangedImpl(this.index);

  @override
  final int index;

  @override
  String toString() {
    return 'InventoryCollectEvent.tabChanged(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabChangedImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TabChangedImplCopyWith<_$TabChangedImpl> get copyWith =>
      __$$TabChangedImplCopyWithImpl<_$TabChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return tabChanged(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return tabChanged?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (tabChanged != null) {
      return tabChanged(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return tabChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return tabChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (tabChanged != null) {
      return tabChanged(this);
    }
    return orElse();
  }
}

abstract class _TabChanged implements InventoryCollectEvent {
  const factory _TabChanged(final int index) = _$TabChangedImpl;

  int get index;
  @JsonKey(ignore: true)
  _$$TabChangedImplCopyWith<_$TabChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecordsRemovedImplCopyWith<$Res> {
  factory _$$RecordsRemovedImplCopyWith(_$RecordsRemovedImpl value,
          $Res Function(_$RecordsRemovedImpl) then) =
      __$$RecordsRemovedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<InventoryCollectRecord> removed});
}

/// @nodoc
class __$$RecordsRemovedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$RecordsRemovedImpl>
    implements _$$RecordsRemovedImplCopyWith<$Res> {
  __$$RecordsRemovedImplCopyWithImpl(
      _$RecordsRemovedImpl _value, $Res Function(_$RecordsRemovedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? removed = null,
  }) {
    return _then(_$RecordsRemovedImpl(
      null == removed
          ? _value._removed
          : removed // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectRecord>,
    ));
  }
}

/// @nodoc

class _$RecordsRemovedImpl implements _RecordsRemoved {
  const _$RecordsRemovedImpl(final List<InventoryCollectRecord> removed)
      : _removed = removed;

  final List<InventoryCollectRecord> _removed;
  @override
  List<InventoryCollectRecord> get removed {
    if (_removed is EqualUnmodifiableListView) return _removed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_removed);
  }

  @override
  String toString() {
    return 'InventoryCollectEvent.recordsRemoved(removed: $removed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordsRemovedImpl &&
            const DeepCollectionEquality().equals(other._removed, _removed));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_removed));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordsRemovedImplCopyWith<_$RecordsRemovedImpl> get copyWith =>
      __$$RecordsRemovedImplCopyWithImpl<_$RecordsRemovedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return recordsRemoved(removed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return recordsRemoved?.call(removed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (recordsRemoved != null) {
      return recordsRemoved(removed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return recordsRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return recordsRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (recordsRemoved != null) {
      return recordsRemoved(this);
    }
    return orElse();
  }
}

abstract class _RecordsRemoved implements InventoryCollectEvent {
  const factory _RecordsRemoved(final List<InventoryCollectRecord> removed) =
      _$RecordsRemovedImpl;

  List<InventoryCollectRecord> get removed;
  @JsonKey(ignore: true)
  _$$RecordsRemovedImplCopyWith<_$RecordsRemovedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitRequestedImplCopyWith<$Res> {
  factory _$$SubmitRequestedImplCopyWith(_$SubmitRequestedImpl value,
          $Res Function(_$SubmitRequestedImpl) then) =
      __$$SubmitRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitRequestedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$SubmitRequestedImpl>
    implements _$$SubmitRequestedImplCopyWith<$Res> {
  __$$SubmitRequestedImplCopyWithImpl(
      _$SubmitRequestedImpl _value, $Res Function(_$SubmitRequestedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubmitRequestedImpl implements _SubmitRequested {
  const _$SubmitRequestedImpl();

  @override
  String toString() {
    return 'InventoryCollectEvent.submitRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return submitRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return submitRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
    TResult Function()? refreshRequested,
    required TResult orElse(),
  }) {
    if (submitRequested != null) {
      return submitRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return submitRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return submitRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (submitRequested != null) {
      return submitRequested(this);
    }
    return orElse();
  }
}

abstract class _SubmitRequested implements InventoryCollectEvent {
  const factory _SubmitRequested() = _$SubmitRequestedImpl;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(_$RefreshRequestedImpl value,
          $Res Function(_$RefreshRequestedImpl) then) =
      __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$InventoryCollectEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
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
    return 'InventoryCollectEvent.refreshRequested()';
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
    required TResult Function(InventoryTask task) started,
    required TResult Function(String storeSite) storeSiteScanned,
    required TResult Function(String barcode) materialScanned,
    required TResult Function(double quantity) quantitySubmitted,
    required TResult Function(int index) tabChanged,
    required TResult Function(List<InventoryCollectRecord> removed)
        recordsRemoved,
    required TResult Function() submitRequested,
    required TResult Function() refreshRequested,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(InventoryTask task)? started,
    TResult? Function(String storeSite)? storeSiteScanned,
    TResult? Function(String barcode)? materialScanned,
    TResult? Function(double quantity)? quantitySubmitted,
    TResult? Function(int index)? tabChanged,
    TResult? Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult? Function()? submitRequested,
    TResult? Function()? refreshRequested,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(InventoryTask task)? started,
    TResult Function(String storeSite)? storeSiteScanned,
    TResult Function(String barcode)? materialScanned,
    TResult Function(double quantity)? quantitySubmitted,
    TResult Function(int index)? tabChanged,
    TResult Function(List<InventoryCollectRecord> removed)? recordsRemoved,
    TResult Function()? submitRequested,
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
    required TResult Function(_StoreSiteScanned value) storeSiteScanned,
    required TResult Function(_MaterialScanned value) materialScanned,
    required TResult Function(_QuantitySubmitted value) quantitySubmitted,
    required TResult Function(_TabChanged value) tabChanged,
    required TResult Function(_RecordsRemoved value) recordsRemoved,
    required TResult Function(_SubmitRequested value) submitRequested,
    required TResult Function(_RefreshRequested value) refreshRequested,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult? Function(_MaterialScanned value)? materialScanned,
    TResult? Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult? Function(_TabChanged value)? tabChanged,
    TResult? Function(_RecordsRemoved value)? recordsRemoved,
    TResult? Function(_SubmitRequested value)? submitRequested,
    TResult? Function(_RefreshRequested value)? refreshRequested,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_StoreSiteScanned value)? storeSiteScanned,
    TResult Function(_MaterialScanned value)? materialScanned,
    TResult Function(_QuantitySubmitted value)? quantitySubmitted,
    TResult Function(_TabChanged value)? tabChanged,
    TResult Function(_RecordsRemoved value)? recordsRemoved,
    TResult Function(_SubmitRequested value)? submitRequested,
    TResult Function(_RefreshRequested value)? refreshRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements InventoryCollectEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}
