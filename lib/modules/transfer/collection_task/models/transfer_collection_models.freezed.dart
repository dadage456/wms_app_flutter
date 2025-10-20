// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_collection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransferScanContext {
  TransferMode get mode => throw _privateConstructorUsedError;
  TransferScanStep get step => throw _privateConstructorUsedError;
  String get storeRoom => throw _privateConstructorUsedError;
  String get erpStoreRoom => throw _privateConstructorUsedError;
  String get sourceSite => throw _privateConstructorUsedError;
  String get targetSite => throw _privateConstructorUsedError;
  String get materialCode => throw _privateConstructorUsedError;
  String get materialName => throw _privateConstructorUsedError;
  String get batchNo => throw _privateConstructorUsedError;
  String get serialNo => throw _privateConstructorUsedError;
  String get supplier => throw _privateConstructorUsedError;
  String get projectNumber => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  String get placeholder => throw _privateConstructorUsedError;
  bool get focus => throw _privateConstructorUsedError;
  bool get isFrozenSite => throw _privateConstructorUsedError;
  TransferInventoryRow? get currentInventory =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransferScanContextCopyWith<TransferScanContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferScanContextCopyWith<$Res> {
  factory $TransferScanContextCopyWith(
          TransferScanContext value, $Res Function(TransferScanContext) then) =
      _$TransferScanContextCopyWithImpl<$Res, TransferScanContext>;
  @useResult
  $Res call(
      {TransferMode mode,
      TransferScanStep step,
      String storeRoom,
      String erpStoreRoom,
      String sourceSite,
      String targetSite,
      String materialCode,
      String materialName,
      String batchNo,
      String serialNo,
      String supplier,
      String projectNumber,
      double? quantity,
      String placeholder,
      bool focus,
      bool isFrozenSite,
      TransferInventoryRow? currentInventory});

  $TransferInventoryRowCopyWith<$Res>? get currentInventory;
}

/// @nodoc
class _$TransferScanContextCopyWithImpl<$Res, $Val extends TransferScanContext>
    implements $TransferScanContextCopyWith<$Res> {
  _$TransferScanContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? step = null,
    Object? storeRoom = null,
    Object? erpStoreRoom = null,
    Object? sourceSite = null,
    Object? targetSite = null,
    Object? materialCode = null,
    Object? materialName = null,
    Object? batchNo = null,
    Object? serialNo = null,
    Object? supplier = null,
    Object? projectNumber = null,
    Object? quantity = freezed,
    Object? placeholder = null,
    Object? focus = null,
    Object? isFrozenSite = null,
    Object? currentInventory = freezed,
  }) {
    return _then(_value.copyWith(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as TransferMode,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as TransferScanStep,
      storeRoom: null == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String,
      erpStoreRoom: null == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String,
      sourceSite: null == sourceSite
          ? _value.sourceSite
          : sourceSite // ignore: cast_nullable_to_non_nullable
              as String,
      targetSite: null == targetSite
          ? _value.targetSite
          : targetSite // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: null == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String,
      batchNo: null == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String,
      serialNo: null == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String,
      supplier: null == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String,
      projectNumber: null == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      placeholder: null == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String,
      focus: null == focus
          ? _value.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as bool,
      isFrozenSite: null == isFrozenSite
          ? _value.isFrozenSite
          : isFrozenSite // ignore: cast_nullable_to_non_nullable
              as bool,
      currentInventory: freezed == currentInventory
          ? _value.currentInventory
          : currentInventory // ignore: cast_nullable_to_non_nullable
              as TransferInventoryRow?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransferInventoryRowCopyWith<$Res>? get currentInventory {
    if (_value.currentInventory == null) {
      return null;
    }

    return $TransferInventoryRowCopyWith<$Res>(_value.currentInventory!,
        (value) {
      return _then(_value.copyWith(currentInventory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransferScanContextImplCopyWith<$Res>
    implements $TransferScanContextCopyWith<$Res> {
  factory _$$TransferScanContextImplCopyWith(_$TransferScanContextImpl value,
          $Res Function(_$TransferScanContextImpl) then) =
      __$$TransferScanContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransferMode mode,
      TransferScanStep step,
      String storeRoom,
      String erpStoreRoom,
      String sourceSite,
      String targetSite,
      String materialCode,
      String materialName,
      String batchNo,
      String serialNo,
      String supplier,
      String projectNumber,
      double? quantity,
      String placeholder,
      bool focus,
      bool isFrozenSite,
      TransferInventoryRow? currentInventory});

  @override
  $TransferInventoryRowCopyWith<$Res>? get currentInventory;
}

/// @nodoc
class __$$TransferScanContextImplCopyWithImpl<$Res>
    extends _$TransferScanContextCopyWithImpl<$Res, _$TransferScanContextImpl>
    implements _$$TransferScanContextImplCopyWith<$Res> {
  __$$TransferScanContextImplCopyWithImpl(_$TransferScanContextImpl _value,
      $Res Function(_$TransferScanContextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? step = null,
    Object? storeRoom = null,
    Object? erpStoreRoom = null,
    Object? sourceSite = null,
    Object? targetSite = null,
    Object? materialCode = null,
    Object? materialName = null,
    Object? batchNo = null,
    Object? serialNo = null,
    Object? supplier = null,
    Object? projectNumber = null,
    Object? quantity = freezed,
    Object? placeholder = null,
    Object? focus = null,
    Object? isFrozenSite = null,
    Object? currentInventory = freezed,
  }) {
    return _then(_$TransferScanContextImpl(
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as TransferMode,
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as TransferScanStep,
      storeRoom: null == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String,
      erpStoreRoom: null == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String,
      sourceSite: null == sourceSite
          ? _value.sourceSite
          : sourceSite // ignore: cast_nullable_to_non_nullable
              as String,
      targetSite: null == targetSite
          ? _value.targetSite
          : targetSite // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: null == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String,
      batchNo: null == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String,
      serialNo: null == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String,
      supplier: null == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String,
      projectNumber: null == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      placeholder: null == placeholder
          ? _value.placeholder
          : placeholder // ignore: cast_nullable_to_non_nullable
              as String,
      focus: null == focus
          ? _value.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as bool,
      isFrozenSite: null == isFrozenSite
          ? _value.isFrozenSite
          : isFrozenSite // ignore: cast_nullable_to_non_nullable
              as bool,
      currentInventory: freezed == currentInventory
          ? _value.currentInventory
          : currentInventory // ignore: cast_nullable_to_non_nullable
              as TransferInventoryRow?,
    ));
  }
}

/// @nodoc

class _$TransferScanContextImpl extends _TransferScanContext {
  const _$TransferScanContextImpl(
      {this.mode = TransferMode.moveOut,
      this.step = TransferScanStep.sourceSite,
      this.storeRoom = '',
      this.erpStoreRoom = '',
      this.sourceSite = '',
      this.targetSite = '',
      this.materialCode = '',
      this.materialName = '',
      this.batchNo = '',
      this.serialNo = '',
      this.supplier = '',
      this.projectNumber = '',
      this.quantity,
      this.placeholder = '请扫描来源库位',
      this.focus = true,
      this.isFrozenSite = false,
      this.currentInventory})
      : super._();

  @override
  @JsonKey()
  final TransferMode mode;
  @override
  @JsonKey()
  final TransferScanStep step;
  @override
  @JsonKey()
  final String storeRoom;
  @override
  @JsonKey()
  final String erpStoreRoom;
  @override
  @JsonKey()
  final String sourceSite;
  @override
  @JsonKey()
  final String targetSite;
  @override
  @JsonKey()
  final String materialCode;
  @override
  @JsonKey()
  final String materialName;
  @override
  @JsonKey()
  final String batchNo;
  @override
  @JsonKey()
  final String serialNo;
  @override
  @JsonKey()
  final String supplier;
  @override
  @JsonKey()
  final String projectNumber;
  @override
  final double? quantity;
  @override
  @JsonKey()
  final String placeholder;
  @override
  @JsonKey()
  final bool focus;
  @override
  @JsonKey()
  final bool isFrozenSite;
  @override
  final TransferInventoryRow? currentInventory;

  @override
  String toString() {
    return 'TransferScanContext(mode: $mode, step: $step, storeRoom: $storeRoom, erpStoreRoom: $erpStoreRoom, sourceSite: $sourceSite, targetSite: $targetSite, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, supplier: $supplier, projectNumber: $projectNumber, quantity: $quantity, placeholder: $placeholder, focus: $focus, isFrozenSite: $isFrozenSite, currentInventory: $currentInventory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferScanContextImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom) &&
            (identical(other.erpStoreRoom, erpStoreRoom) ||
                other.erpStoreRoom == erpStoreRoom) &&
            (identical(other.sourceSite, sourceSite) ||
                other.sourceSite == sourceSite) &&
            (identical(other.targetSite, targetSite) ||
                other.targetSite == targetSite) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.projectNumber, projectNumber) ||
                other.projectNumber == projectNumber) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.placeholder, placeholder) ||
                other.placeholder == placeholder) &&
            (identical(other.focus, focus) || other.focus == focus) &&
            (identical(other.isFrozenSite, isFrozenSite) ||
                other.isFrozenSite == isFrozenSite) &&
            (identical(other.currentInventory, currentInventory) ||
                other.currentInventory == currentInventory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mode,
      step,
      storeRoom,
      erpStoreRoom,
      sourceSite,
      targetSite,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      supplier,
      projectNumber,
      quantity,
      placeholder,
      focus,
      isFrozenSite,
      currentInventory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferScanContextImplCopyWith<_$TransferScanContextImpl> get copyWith =>
      __$$TransferScanContextImplCopyWithImpl<_$TransferScanContextImpl>(
          this, _$identity);
}

abstract class _TransferScanContext extends TransferScanContext {
  const factory _TransferScanContext(
          {final TransferMode mode,
          final TransferScanStep step,
          final String storeRoom,
          final String erpStoreRoom,
          final String sourceSite,
          final String targetSite,
          final String materialCode,
          final String materialName,
          final String batchNo,
          final String serialNo,
          final String supplier,
          final String projectNumber,
          final double? quantity,
          final String placeholder,
          final bool focus,
          final bool isFrozenSite,
          final TransferInventoryRow? currentInventory}) =
      _$TransferScanContextImpl;
  const _TransferScanContext._() : super._();

  @override
  TransferMode get mode;
  @override
  TransferScanStep get step;
  @override
  String get storeRoom;
  @override
  String get erpStoreRoom;
  @override
  String get sourceSite;
  @override
  String get targetSite;
  @override
  String get materialCode;
  @override
  String get materialName;
  @override
  String get batchNo;
  @override
  String get serialNo;
  @override
  String get supplier;
  @override
  String get projectNumber;
  @override
  double? get quantity;
  @override
  String get placeholder;
  @override
  bool get focus;
  @override
  bool get isFrozenSite;
  @override
  TransferInventoryRow? get currentInventory;
  @override
  @JsonKey(ignore: true)
  _$$TransferScanContextImplCopyWith<_$TransferScanContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferCollectedItem _$TransferCollectedItemFromJson(
    Map<String, dynamic> json) {
  return _TransferCollectedItem.fromJson(json);
}

/// @nodoc
mixin _$TransferCollectedItem {
  String get id => throw _privateConstructorUsedError;
  String get sourceSite => throw _privateConstructorUsedError;
  String get targetSite => throw _privateConstructorUsedError;
  String get materialCode => throw _privateConstructorUsedError;
  String? get materialName => throw _privateConstructorUsedError;
  String? get batchNo => throw _privateConstructorUsedError;
  String? get serialNo => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String? get supplier => throw _privateConstructorUsedError;
  String? get erpRoom => throw _privateConstructorUsedError;
  String? get projectNumber => throw _privateConstructorUsedError;
  String? get ownerCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferCollectedItemCopyWith<TransferCollectedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCollectedItemCopyWith<$Res> {
  factory $TransferCollectedItemCopyWith(TransferCollectedItem value,
          $Res Function(TransferCollectedItem) then) =
      _$TransferCollectedItemCopyWithImpl<$Res, TransferCollectedItem>;
  @useResult
  $Res call(
      {String id,
      String sourceSite,
      String targetSite,
      String materialCode,
      String? materialName,
      String? batchNo,
      String? serialNo,
      double quantity,
      String? supplier,
      String? erpRoom,
      String? projectNumber,
      String? ownerCode});
}

/// @nodoc
class _$TransferCollectedItemCopyWithImpl<$Res,
        $Val extends TransferCollectedItem>
    implements $TransferCollectedItemCopyWith<$Res> {
  _$TransferCollectedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceSite = null,
    Object? targetSite = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = null,
    Object? supplier = freezed,
    Object? erpRoom = freezed,
    Object? projectNumber = freezed,
    Object? ownerCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceSite: null == sourceSite
          ? _value.sourceSite
          : sourceSite // ignore: cast_nullable_to_non_nullable
              as String,
      targetSite: null == targetSite
          ? _value.targetSite
          : targetSite // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String?,
      erpRoom: freezed == erpRoom
          ? _value.erpRoom
          : erpRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: freezed == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerCode: freezed == ownerCode
          ? _value.ownerCode
          : ownerCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferCollectedItemImplCopyWith<$Res>
    implements $TransferCollectedItemCopyWith<$Res> {
  factory _$$TransferCollectedItemImplCopyWith(
          _$TransferCollectedItemImpl value,
          $Res Function(_$TransferCollectedItemImpl) then) =
      __$$TransferCollectedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceSite,
      String targetSite,
      String materialCode,
      String? materialName,
      String? batchNo,
      String? serialNo,
      double quantity,
      String? supplier,
      String? erpRoom,
      String? projectNumber,
      String? ownerCode});
}

/// @nodoc
class __$$TransferCollectedItemImplCopyWithImpl<$Res>
    extends _$TransferCollectedItemCopyWithImpl<$Res,
        _$TransferCollectedItemImpl>
    implements _$$TransferCollectedItemImplCopyWith<$Res> {
  __$$TransferCollectedItemImplCopyWithImpl(_$TransferCollectedItemImpl _value,
      $Res Function(_$TransferCollectedItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceSite = null,
    Object? targetSite = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = null,
    Object? supplier = freezed,
    Object? erpRoom = freezed,
    Object? projectNumber = freezed,
    Object? ownerCode = freezed,
  }) {
    return _then(_$TransferCollectedItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceSite: null == sourceSite
          ? _value.sourceSite
          : sourceSite // ignore: cast_nullable_to_non_nullable
              as String,
      targetSite: null == targetSite
          ? _value.targetSite
          : targetSite // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String?,
      erpRoom: freezed == erpRoom
          ? _value.erpRoom
          : erpRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: freezed == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerCode: freezed == ownerCode
          ? _value.ownerCode
          : ownerCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferCollectedItemImpl extends _TransferCollectedItem {
  const _$TransferCollectedItemImpl(
      {required this.id,
      required this.sourceSite,
      required this.targetSite,
      required this.materialCode,
      this.materialName,
      this.batchNo,
      this.serialNo,
      required this.quantity,
      this.supplier,
      this.erpRoom,
      this.projectNumber,
      this.ownerCode})
      : super._();

  factory _$TransferCollectedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferCollectedItemImplFromJson(json);

  @override
  final String id;
  @override
  final String sourceSite;
  @override
  final String targetSite;
  @override
  final String materialCode;
  @override
  final String? materialName;
  @override
  final String? batchNo;
  @override
  final String? serialNo;
  @override
  final double quantity;
  @override
  final String? supplier;
  @override
  final String? erpRoom;
  @override
  final String? projectNumber;
  @override
  final String? ownerCode;

  @override
  String toString() {
    return 'TransferCollectedItem(id: $id, sourceSite: $sourceSite, targetSite: $targetSite, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, quantity: $quantity, supplier: $supplier, erpRoom: $erpRoom, projectNumber: $projectNumber, ownerCode: $ownerCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferCollectedItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceSite, sourceSite) ||
                other.sourceSite == sourceSite) &&
            (identical(other.targetSite, targetSite) ||
                other.targetSite == targetSite) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.erpRoom, erpRoom) || other.erpRoom == erpRoom) &&
            (identical(other.projectNumber, projectNumber) ||
                other.projectNumber == projectNumber) &&
            (identical(other.ownerCode, ownerCode) ||
                other.ownerCode == ownerCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceSite,
      targetSite,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      quantity,
      supplier,
      erpRoom,
      projectNumber,
      ownerCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferCollectedItemImplCopyWith<_$TransferCollectedItemImpl>
      get copyWith => __$$TransferCollectedItemImplCopyWithImpl<
          _$TransferCollectedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferCollectedItemImplToJson(
      this,
    );
  }
}

abstract class _TransferCollectedItem extends TransferCollectedItem {
  const factory _TransferCollectedItem(
      {required final String id,
      required final String sourceSite,
      required final String targetSite,
      required final String materialCode,
      final String? materialName,
      final String? batchNo,
      final String? serialNo,
      required final double quantity,
      final String? supplier,
      final String? erpRoom,
      final String? projectNumber,
      final String? ownerCode}) = _$TransferCollectedItemImpl;
  const _TransferCollectedItem._() : super._();

  factory _TransferCollectedItem.fromJson(Map<String, dynamic> json) =
      _$TransferCollectedItemImpl.fromJson;

  @override
  String get id;
  @override
  String get sourceSite;
  @override
  String get targetSite;
  @override
  String get materialCode;
  @override
  String? get materialName;
  @override
  String? get batchNo;
  @override
  String? get serialNo;
  @override
  double get quantity;
  @override
  String? get supplier;
  @override
  String? get erpRoom;
  @override
  String? get projectNumber;
  @override
  String? get ownerCode;
  @override
  @JsonKey(ignore: true)
  _$$TransferCollectedItemImplCopyWith<_$TransferCollectedItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransferInventoryRow _$TransferInventoryRowFromJson(Map<String, dynamic> json) {
  return _TransferInventoryRow.fromJson(json);
}

/// @nodoc
mixin _$TransferInventoryRow {
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'repqty')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'projectNum')
  String? get projectNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'erpStoreroom')
  String? get erpStoreRoom => throw _privateConstructorUsedError;
  @JsonKey(name: 'palletno')
  String? get palletNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomname')
  String? get storeRoomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'erpOwnerCode')
  String? get ownerCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferInventoryRowCopyWith<TransferInventoryRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferInventoryRowCopyWith<$Res> {
  factory $TransferInventoryRowCopyWith(TransferInventoryRow value,
          $Res Function(TransferInventoryRow) then) =
      _$TransferInventoryRowCopyWithImpl<$Res, TransferInventoryRow>;
  @useResult
  $Res call(
      {@JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'repqty') double quantity,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'projectNum') String? projectNumber,
      @JsonKey(name: 'erpStoreroom') String? erpStoreRoom,
      @JsonKey(name: 'palletno') String? palletNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'storeroomname') String? storeRoomName,
      @JsonKey(name: 'erpOwnerCode') String? ownerCode});
}

/// @nodoc
class _$TransferInventoryRowCopyWithImpl<$Res,
        $Val extends TransferInventoryRow>
    implements $TransferInventoryRowCopyWith<$Res> {
  _$TransferInventoryRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeSiteNo = null,
    Object? materialCode = null,
    Object? quantity = null,
    Object? batchNo = freezed,
    Object? projectNumber = freezed,
    Object? erpStoreRoom = freezed,
    Object? palletNo = freezed,
    Object? serialNo = freezed,
    Object? storeRoomName = freezed,
    Object? ownerCode = freezed,
  }) {
    return _then(_value.copyWith(
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: freezed == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreRoom: freezed == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomName: freezed == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerCode: freezed == ownerCode
          ? _value.ownerCode
          : ownerCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferInventoryRowImplCopyWith<$Res>
    implements $TransferInventoryRowCopyWith<$Res> {
  factory _$$TransferInventoryRowImplCopyWith(_$TransferInventoryRowImpl value,
          $Res Function(_$TransferInventoryRowImpl) then) =
      __$$TransferInventoryRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'repqty') double quantity,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'projectNum') String? projectNumber,
      @JsonKey(name: 'erpStoreroom') String? erpStoreRoom,
      @JsonKey(name: 'palletno') String? palletNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'storeroomname') String? storeRoomName,
      @JsonKey(name: 'erpOwnerCode') String? ownerCode});
}

/// @nodoc
class __$$TransferInventoryRowImplCopyWithImpl<$Res>
    extends _$TransferInventoryRowCopyWithImpl<$Res, _$TransferInventoryRowImpl>
    implements _$$TransferInventoryRowImplCopyWith<$Res> {
  __$$TransferInventoryRowImplCopyWithImpl(_$TransferInventoryRowImpl _value,
      $Res Function(_$TransferInventoryRowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeSiteNo = null,
    Object? materialCode = null,
    Object? quantity = null,
    Object? batchNo = freezed,
    Object? projectNumber = freezed,
    Object? erpStoreRoom = freezed,
    Object? palletNo = freezed,
    Object? serialNo = freezed,
    Object? storeRoomName = freezed,
    Object? ownerCode = freezed,
  }) {
    return _then(_$TransferInventoryRowImpl(
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: freezed == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreRoom: freezed == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomName: freezed == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerCode: freezed == ownerCode
          ? _value.ownerCode
          : ownerCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferInventoryRowImpl implements _TransferInventoryRow {
  const _$TransferInventoryRowImpl(
      {@JsonKey(name: 'storesiteno') required this.storeSiteNo,
      @JsonKey(name: 'matcode') required this.materialCode,
      @JsonKey(name: 'repqty') this.quantity = 0,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'projectNum') this.projectNumber,
      @JsonKey(name: 'erpStoreroom') this.erpStoreRoom,
      @JsonKey(name: 'palletno') this.palletNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'storeroomname') this.storeRoomName,
      @JsonKey(name: 'erpOwnerCode') this.ownerCode});

  factory _$TransferInventoryRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferInventoryRowImplFromJson(json);

  @override
  @JsonKey(name: 'storesiteno')
  final String storeSiteNo;
  @override
  @JsonKey(name: 'matcode')
  final String materialCode;
  @override
  @JsonKey(name: 'repqty')
  final double quantity;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'projectNum')
  final String? projectNumber;
  @override
  @JsonKey(name: 'erpStoreroom')
  final String? erpStoreRoom;
  @override
  @JsonKey(name: 'palletno')
  final String? palletNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;
  @override
  @JsonKey(name: 'storeroomname')
  final String? storeRoomName;
  @override
  @JsonKey(name: 'erpOwnerCode')
  final String? ownerCode;

  @override
  String toString() {
    return 'TransferInventoryRow(storeSiteNo: $storeSiteNo, materialCode: $materialCode, quantity: $quantity, batchNo: $batchNo, projectNumber: $projectNumber, erpStoreRoom: $erpStoreRoom, palletNo: $palletNo, serialNo: $serialNo, storeRoomName: $storeRoomName, ownerCode: $ownerCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferInventoryRowImpl &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.projectNumber, projectNumber) ||
                other.projectNumber == projectNumber) &&
            (identical(other.erpStoreRoom, erpStoreRoom) ||
                other.erpStoreRoom == erpStoreRoom) &&
            (identical(other.palletNo, palletNo) ||
                other.palletNo == palletNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.storeRoomName, storeRoomName) ||
                other.storeRoomName == storeRoomName) &&
            (identical(other.ownerCode, ownerCode) ||
                other.ownerCode == ownerCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      storeSiteNo,
      materialCode,
      quantity,
      batchNo,
      projectNumber,
      erpStoreRoom,
      palletNo,
      serialNo,
      storeRoomName,
      ownerCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferInventoryRowImplCopyWith<_$TransferInventoryRowImpl>
      get copyWith =>
          __$$TransferInventoryRowImplCopyWithImpl<_$TransferInventoryRowImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferInventoryRowImplToJson(
      this,
    );
  }
}

abstract class _TransferInventoryRow implements TransferInventoryRow {
  const factory _TransferInventoryRow(
          {@JsonKey(name: 'storesiteno') required final String storeSiteNo,
          @JsonKey(name: 'matcode') required final String materialCode,
          @JsonKey(name: 'repqty') final double quantity,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'projectNum') final String? projectNumber,
          @JsonKey(name: 'erpStoreroom') final String? erpStoreRoom,
          @JsonKey(name: 'palletno') final String? palletNo,
          @JsonKey(name: 'sn') final String? serialNo,
          @JsonKey(name: 'storeroomname') final String? storeRoomName,
          @JsonKey(name: 'erpOwnerCode') final String? ownerCode}) =
      _$TransferInventoryRowImpl;

  factory _TransferInventoryRow.fromJson(Map<String, dynamic> json) =
      _$TransferInventoryRowImpl.fromJson;

  @override
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo;
  @override
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override
  @JsonKey(name: 'repqty')
  double get quantity;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'projectNum')
  String? get projectNumber;
  @override
  @JsonKey(name: 'erpStoreroom')
  String? get erpStoreRoom;
  @override
  @JsonKey(name: 'palletno')
  String? get palletNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override
  @JsonKey(name: 'storeroomname')
  String? get storeRoomName;
  @override
  @JsonKey(name: 'erpOwnerCode')
  String? get ownerCode;
  @override
  @JsonKey(ignore: true)
  _$$TransferInventoryRowImplCopyWith<_$TransferInventoryRowImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransferSubmitEntry _$TransferSubmitEntryFromJson(Map<String, dynamic> json) {
  return _TransferSubmitEntry.fromJson(json);
}

/// @nodoc
mixin _$TransferSubmitEntry {
  @JsonKey(name: 'outSite')
  String get outSite => throw _privateConstructorUsedError;
  @JsonKey(name: 'inSite')
  String get inSite => throw _privateConstructorUsedError;
  @JsonKey(name: 'materialCode')
  String get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchNo')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'moveDesc')
  String get moveDesc => throw _privateConstructorUsedError;
  @JsonKey(name: 'supplier')
  String? get supplier => throw _privateConstructorUsedError;
  @JsonKey(name: 'erpRoom')
  String? get erpRoom => throw _privateConstructorUsedError;
  @JsonKey(name: 'projectNum')
  String? get projectNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferSubmitEntryCopyWith<TransferSubmitEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferSubmitEntryCopyWith<$Res> {
  factory $TransferSubmitEntryCopyWith(
          TransferSubmitEntry value, $Res Function(TransferSubmitEntry) then) =
      _$TransferSubmitEntryCopyWithImpl<$Res, TransferSubmitEntry>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outSite') String outSite,
      @JsonKey(name: 'inSite') String inSite,
      @JsonKey(name: 'materialCode') String materialCode,
      @JsonKey(name: 'batchNo') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'qty') double quantity,
      @JsonKey(name: 'moveDesc') String moveDesc,
      @JsonKey(name: 'supplier') String? supplier,
      @JsonKey(name: 'erpRoom') String? erpRoom,
      @JsonKey(name: 'projectNum') String? projectNumber});
}

/// @nodoc
class _$TransferSubmitEntryCopyWithImpl<$Res, $Val extends TransferSubmitEntry>
    implements $TransferSubmitEntryCopyWith<$Res> {
  _$TransferSubmitEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outSite = null,
    Object? inSite = null,
    Object? materialCode = null,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = null,
    Object? moveDesc = null,
    Object? supplier = freezed,
    Object? erpRoom = freezed,
    Object? projectNumber = freezed,
  }) {
    return _then(_value.copyWith(
      outSite: null == outSite
          ? _value.outSite
          : outSite // ignore: cast_nullable_to_non_nullable
              as String,
      inSite: null == inSite
          ? _value.inSite
          : inSite // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      moveDesc: null == moveDesc
          ? _value.moveDesc
          : moveDesc // ignore: cast_nullable_to_non_nullable
              as String,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String?,
      erpRoom: freezed == erpRoom
          ? _value.erpRoom
          : erpRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: freezed == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferSubmitEntryImplCopyWith<$Res>
    implements $TransferSubmitEntryCopyWith<$Res> {
  factory _$$TransferSubmitEntryImplCopyWith(_$TransferSubmitEntryImpl value,
          $Res Function(_$TransferSubmitEntryImpl) then) =
      __$$TransferSubmitEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outSite') String outSite,
      @JsonKey(name: 'inSite') String inSite,
      @JsonKey(name: 'materialCode') String materialCode,
      @JsonKey(name: 'batchNo') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'qty') double quantity,
      @JsonKey(name: 'moveDesc') String moveDesc,
      @JsonKey(name: 'supplier') String? supplier,
      @JsonKey(name: 'erpRoom') String? erpRoom,
      @JsonKey(name: 'projectNum') String? projectNumber});
}

/// @nodoc
class __$$TransferSubmitEntryImplCopyWithImpl<$Res>
    extends _$TransferSubmitEntryCopyWithImpl<$Res, _$TransferSubmitEntryImpl>
    implements _$$TransferSubmitEntryImplCopyWith<$Res> {
  __$$TransferSubmitEntryImplCopyWithImpl(_$TransferSubmitEntryImpl _value,
      $Res Function(_$TransferSubmitEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outSite = null,
    Object? inSite = null,
    Object? materialCode = null,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = null,
    Object? moveDesc = null,
    Object? supplier = freezed,
    Object? erpRoom = freezed,
    Object? projectNumber = freezed,
  }) {
    return _then(_$TransferSubmitEntryImpl(
      outSite: null == outSite
          ? _value.outSite
          : outSite // ignore: cast_nullable_to_non_nullable
              as String,
      inSite: null == inSite
          ? _value.inSite
          : inSite // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      moveDesc: null == moveDesc
          ? _value.moveDesc
          : moveDesc // ignore: cast_nullable_to_non_nullable
              as String,
      supplier: freezed == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String?,
      erpRoom: freezed == erpRoom
          ? _value.erpRoom
          : erpRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      projectNumber: freezed == projectNumber
          ? _value.projectNumber
          : projectNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferSubmitEntryImpl implements _TransferSubmitEntry {
  const _$TransferSubmitEntryImpl(
      {@JsonKey(name: 'outSite') required this.outSite,
      @JsonKey(name: 'inSite') required this.inSite,
      @JsonKey(name: 'materialCode') required this.materialCode,
      @JsonKey(name: 'batchNo') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'qty') required this.quantity,
      @JsonKey(name: 'moveDesc') this.moveDesc = '',
      @JsonKey(name: 'supplier') this.supplier,
      @JsonKey(name: 'erpRoom') this.erpRoom,
      @JsonKey(name: 'projectNum') this.projectNumber});

  factory _$TransferSubmitEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferSubmitEntryImplFromJson(json);

  @override
  @JsonKey(name: 'outSite')
  final String outSite;
  @override
  @JsonKey(name: 'inSite')
  final String inSite;
  @override
  @JsonKey(name: 'materialCode')
  final String materialCode;
  @override
  @JsonKey(name: 'batchNo')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;
  @override
  @JsonKey(name: 'qty')
  final double quantity;
  @override
  @JsonKey(name: 'moveDesc')
  final String moveDesc;
  @override
  @JsonKey(name: 'supplier')
  final String? supplier;
  @override
  @JsonKey(name: 'erpRoom')
  final String? erpRoom;
  @override
  @JsonKey(name: 'projectNum')
  final String? projectNumber;

  @override
  String toString() {
    return 'TransferSubmitEntry(outSite: $outSite, inSite: $inSite, materialCode: $materialCode, batchNo: $batchNo, serialNo: $serialNo, quantity: $quantity, moveDesc: $moveDesc, supplier: $supplier, erpRoom: $erpRoom, projectNumber: $projectNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferSubmitEntryImpl &&
            (identical(other.outSite, outSite) || other.outSite == outSite) &&
            (identical(other.inSite, inSite) || other.inSite == inSite) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.moveDesc, moveDesc) ||
                other.moveDesc == moveDesc) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.erpRoom, erpRoom) || other.erpRoom == erpRoom) &&
            (identical(other.projectNumber, projectNumber) ||
                other.projectNumber == projectNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, outSite, inSite, materialCode,
      batchNo, serialNo, quantity, moveDesc, supplier, erpRoom, projectNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferSubmitEntryImplCopyWith<_$TransferSubmitEntryImpl> get copyWith =>
      __$$TransferSubmitEntryImplCopyWithImpl<_$TransferSubmitEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferSubmitEntryImplToJson(
      this,
    );
  }
}

abstract class _TransferSubmitEntry implements TransferSubmitEntry {
  const factory _TransferSubmitEntry(
          {@JsonKey(name: 'outSite') required final String outSite,
          @JsonKey(name: 'inSite') required final String inSite,
          @JsonKey(name: 'materialCode') required final String materialCode,
          @JsonKey(name: 'batchNo') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNo,
          @JsonKey(name: 'qty') required final double quantity,
          @JsonKey(name: 'moveDesc') final String moveDesc,
          @JsonKey(name: 'supplier') final String? supplier,
          @JsonKey(name: 'erpRoom') final String? erpRoom,
          @JsonKey(name: 'projectNum') final String? projectNumber}) =
      _$TransferSubmitEntryImpl;

  factory _TransferSubmitEntry.fromJson(Map<String, dynamic> json) =
      _$TransferSubmitEntryImpl.fromJson;

  @override
  @JsonKey(name: 'outSite')
  String get outSite;
  @override
  @JsonKey(name: 'inSite')
  String get inSite;
  @override
  @JsonKey(name: 'materialCode')
  String get materialCode;
  @override
  @JsonKey(name: 'batchNo')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override
  @JsonKey(name: 'qty')
  double get quantity;
  @override
  @JsonKey(name: 'moveDesc')
  String get moveDesc;
  @override
  @JsonKey(name: 'supplier')
  String? get supplier;
  @override
  @JsonKey(name: 'erpRoom')
  String? get erpRoom;
  @override
  @JsonKey(name: 'projectNum')
  String? get projectNumber;
  @override
  @JsonKey(ignore: true)
  _$$TransferSubmitEntryImplCopyWith<_$TransferSubmitEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferSubmitPayload _$TransferSubmitPayloadFromJson(
    Map<String, dynamic> json) {
  return _TransferSubmitPayload.fromJson(json);
}

/// @nodoc
mixin _$TransferSubmitPayload {
  @JsonKey(name: 'transferInfos')
  List<TransferSubmitEntry> get entries => throw _privateConstructorUsedError;
  @JsonKey(name: 'filter')
  String get filter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferSubmitPayloadCopyWith<TransferSubmitPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferSubmitPayloadCopyWith<$Res> {
  factory $TransferSubmitPayloadCopyWith(TransferSubmitPayload value,
          $Res Function(TransferSubmitPayload) then) =
      _$TransferSubmitPayloadCopyWithImpl<$Res, TransferSubmitPayload>;
  @useResult
  $Res call(
      {@JsonKey(name: 'transferInfos') List<TransferSubmitEntry> entries,
      @JsonKey(name: 'filter') String filter});
}

/// @nodoc
class _$TransferSubmitPayloadCopyWithImpl<$Res,
        $Val extends TransferSubmitPayload>
    implements $TransferSubmitPayloadCopyWith<$Res> {
  _$TransferSubmitPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? filter = null,
  }) {
    return _then(_value.copyWith(
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<TransferSubmitEntry>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferSubmitPayloadImplCopyWith<$Res>
    implements $TransferSubmitPayloadCopyWith<$Res> {
  factory _$$TransferSubmitPayloadImplCopyWith(
          _$TransferSubmitPayloadImpl value,
          $Res Function(_$TransferSubmitPayloadImpl) then) =
      __$$TransferSubmitPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'transferInfos') List<TransferSubmitEntry> entries,
      @JsonKey(name: 'filter') String filter});
}

/// @nodoc
class __$$TransferSubmitPayloadImplCopyWithImpl<$Res>
    extends _$TransferSubmitPayloadCopyWithImpl<$Res,
        _$TransferSubmitPayloadImpl>
    implements _$$TransferSubmitPayloadImplCopyWith<$Res> {
  __$$TransferSubmitPayloadImplCopyWithImpl(_$TransferSubmitPayloadImpl _value,
      $Res Function(_$TransferSubmitPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? filter = null,
  }) {
    return _then(_$TransferSubmitPayloadImpl(
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<TransferSubmitEntry>,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferSubmitPayloadImpl extends _TransferSubmitPayload {
  const _$TransferSubmitPayloadImpl(
      {@JsonKey(name: 'transferInfos')
      required final List<TransferSubmitEntry> entries,
      @JsonKey(name: 'filter') this.filter = ''})
      : _entries = entries,
        super._();

  factory _$TransferSubmitPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferSubmitPayloadImplFromJson(json);

  final List<TransferSubmitEntry> _entries;
  @override
  @JsonKey(name: 'transferInfos')
  List<TransferSubmitEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey(name: 'filter')
  final String filter;

  @override
  String toString() {
    return 'TransferSubmitPayload(entries: $entries, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferSubmitPayloadImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_entries), filter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferSubmitPayloadImplCopyWith<_$TransferSubmitPayloadImpl>
      get copyWith => __$$TransferSubmitPayloadImplCopyWithImpl<
          _$TransferSubmitPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferSubmitPayloadImplToJson(
      this,
    );
  }
}

abstract class _TransferSubmitPayload extends TransferSubmitPayload {
  const factory _TransferSubmitPayload(
          {@JsonKey(name: 'transferInfos')
          required final List<TransferSubmitEntry> entries,
          @JsonKey(name: 'filter') final String filter}) =
      _$TransferSubmitPayloadImpl;
  const _TransferSubmitPayload._() : super._();

  factory _TransferSubmitPayload.fromJson(Map<String, dynamic> json) =
      _$TransferSubmitPayloadImpl.fromJson;

  @override
  @JsonKey(name: 'transferInfos')
  List<TransferSubmitEntry> get entries;
  @override
  @JsonKey(name: 'filter')
  String get filter;
  @override
  @JsonKey(ignore: true)
  _$$TransferSubmitPayloadImplCopyWith<_$TransferSubmitPayloadImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransferUiMessage _$TransferUiMessageFromJson(Map<String, dynamic> json) {
  return _TransferUiMessage.fromJson(json);
}

/// @nodoc
mixin _$TransferUiMessage {
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferUiMessageCopyWith<TransferUiMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferUiMessageCopyWith<$Res> {
  factory $TransferUiMessageCopyWith(
          TransferUiMessage value, $Res Function(TransferUiMessage) then) =
      _$TransferUiMessageCopyWithImpl<$Res, TransferUiMessage>;
  @useResult
  $Res call({String title, String message, bool isError});
}

/// @nodoc
class _$TransferUiMessageCopyWithImpl<$Res, $Val extends TransferUiMessage>
    implements $TransferUiMessageCopyWith<$Res> {
  _$TransferUiMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? isError = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferUiMessageImplCopyWith<$Res>
    implements $TransferUiMessageCopyWith<$Res> {
  factory _$$TransferUiMessageImplCopyWith(_$TransferUiMessageImpl value,
          $Res Function(_$TransferUiMessageImpl) then) =
      __$$TransferUiMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String message, bool isError});
}

/// @nodoc
class __$$TransferUiMessageImplCopyWithImpl<$Res>
    extends _$TransferUiMessageCopyWithImpl<$Res, _$TransferUiMessageImpl>
    implements _$$TransferUiMessageImplCopyWith<$Res> {
  __$$TransferUiMessageImplCopyWithImpl(_$TransferUiMessageImpl _value,
      $Res Function(_$TransferUiMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? message = null,
    Object? isError = null,
  }) {
    return _then(_$TransferUiMessageImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferUiMessageImpl implements _TransferUiMessage {
  const _$TransferUiMessageImpl(
      {required this.title, required this.message, this.isError = false});

  factory _$TransferUiMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferUiMessageImplFromJson(json);

  @override
  final String title;
  @override
  final String message;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString() {
    return 'TransferUiMessage(title: $title, message: $message, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferUiMessageImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, message, isError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferUiMessageImplCopyWith<_$TransferUiMessageImpl> get copyWith =>
      __$$TransferUiMessageImplCopyWithImpl<_$TransferUiMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferUiMessageImplToJson(
      this,
    );
  }
}

abstract class _TransferUiMessage implements TransferUiMessage {
  const factory _TransferUiMessage(
      {required final String title,
      required final String message,
      final bool isError}) = _$TransferUiMessageImpl;

  factory _TransferUiMessage.fromJson(Map<String, dynamic> json) =
      _$TransferUiMessageImpl.fromJson;

  @override
  String get title;
  @override
  String get message;
  @override
  bool get isError;
  @override
  @JsonKey(ignore: true)
  _$$TransferUiMessageImplCopyWith<_$TransferUiMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
