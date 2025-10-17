// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_pallet_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryPalletItem _$InventoryPalletItemFromJson(Map<String, dynamic> json) {
  return _InventoryPalletItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryPalletItem {
  @JsonKey(name: 'palletNo')
  String? get palletNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  String? get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'itemBatch')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'itemSn')
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'proofno')
  String? get proofNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'proofNo')
  String? get proofNoAlt => throw _privateConstructorUsedError;
  @JsonKey(name: 'storesite')
  String? get storeSite => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  String? get storeRoom => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryPalletItemCopyWith<InventoryPalletItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryPalletItemCopyWith<$Res> {
  factory $InventoryPalletItemCopyWith(
          InventoryPalletItem value, $Res Function(InventoryPalletItem) then) =
      _$InventoryPalletItemCopyWithImpl<$Res, InventoryPalletItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'palletNo') String? palletNo,
      @JsonKey(name: 'matcode') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'itemBatch') String? batchNo,
      @JsonKey(name: 'itemSn') String? serialNo,
      @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
      double? quantity,
      @JsonKey(name: 'proofno') String? proofNo,
      @JsonKey(name: 'proofNo') String? proofNoAlt,
      @JsonKey(name: 'storesite') String? storeSite,
      @JsonKey(name: 'storeroomno') String? storeRoom});
}

/// @nodoc
class _$InventoryPalletItemCopyWithImpl<$Res, $Val extends InventoryPalletItem>
    implements $InventoryPalletItemCopyWith<$Res> {
  _$InventoryPalletItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? palletNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = freezed,
    Object? proofNo = freezed,
    Object? proofNoAlt = freezed,
    Object? storeSite = freezed,
    Object? storeRoom = freezed,
  }) {
    return _then(_value.copyWith(
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      proofNo: freezed == proofNo
          ? _value.proofNo
          : proofNo // ignore: cast_nullable_to_non_nullable
              as String?,
      proofNoAlt: freezed == proofNoAlt
          ? _value.proofNoAlt
          : proofNoAlt // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: freezed == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoom: freezed == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryPalletItemImplCopyWith<$Res>
    implements $InventoryPalletItemCopyWith<$Res> {
  factory _$$InventoryPalletItemImplCopyWith(_$InventoryPalletItemImpl value,
          $Res Function(_$InventoryPalletItemImpl) then) =
      __$$InventoryPalletItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'palletNo') String? palletNo,
      @JsonKey(name: 'matcode') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'itemBatch') String? batchNo,
      @JsonKey(name: 'itemSn') String? serialNo,
      @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
      double? quantity,
      @JsonKey(name: 'proofno') String? proofNo,
      @JsonKey(name: 'proofNo') String? proofNoAlt,
      @JsonKey(name: 'storesite') String? storeSite,
      @JsonKey(name: 'storeroomno') String? storeRoom});
}

/// @nodoc
class __$$InventoryPalletItemImplCopyWithImpl<$Res>
    extends _$InventoryPalletItemCopyWithImpl<$Res, _$InventoryPalletItemImpl>
    implements _$$InventoryPalletItemImplCopyWith<$Res> {
  __$$InventoryPalletItemImplCopyWithImpl(_$InventoryPalletItemImpl _value,
      $Res Function(_$InventoryPalletItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? palletNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = freezed,
    Object? proofNo = freezed,
    Object? proofNoAlt = freezed,
    Object? storeSite = freezed,
    Object? storeRoom = freezed,
  }) {
    return _then(_$InventoryPalletItemImpl(
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      proofNo: freezed == proofNo
          ? _value.proofNo
          : proofNo // ignore: cast_nullable_to_non_nullable
              as String?,
      proofNoAlt: freezed == proofNoAlt
          ? _value.proofNoAlt
          : proofNoAlt // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: freezed == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoom: freezed == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryPalletItemImpl extends _InventoryPalletItem {
  const _$InventoryPalletItemImpl(
      {@JsonKey(name: 'palletNo') this.palletNo,
      @JsonKey(name: 'matcode') this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'itemBatch') this.batchNo,
      @JsonKey(name: 'itemSn') this.serialNo,
      @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
      this.quantity,
      @JsonKey(name: 'proofno') this.proofNo,
      @JsonKey(name: 'proofNo') this.proofNoAlt,
      @JsonKey(name: 'storesite') this.storeSite,
      @JsonKey(name: 'storeroomno') this.storeRoom})
      : super._();

  factory _$InventoryPalletItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryPalletItemImplFromJson(json);

  @override
  @JsonKey(name: 'palletNo')
  final String? palletNo;
  @override
  @JsonKey(name: 'matcode')
  final String? materialCode;
  @override
  @JsonKey(name: 'matname')
  final String? materialName;
  @override
  @JsonKey(name: 'itemBatch')
  final String? batchNo;
  @override
  @JsonKey(name: 'itemSn')
  final String? serialNo;
  @override
  @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
  final double? quantity;
  @override
  @JsonKey(name: 'proofno')
  final String? proofNo;
  @override
  @JsonKey(name: 'proofNo')
  final String? proofNoAlt;
  @override
  @JsonKey(name: 'storesite')
  final String? storeSite;
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoom;

  @override
  String toString() {
    return 'InventoryPalletItem(palletNo: $palletNo, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, quantity: $quantity, proofNo: $proofNo, proofNoAlt: $proofNoAlt, storeSite: $storeSite, storeRoom: $storeRoom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryPalletItemImpl &&
            (identical(other.palletNo, palletNo) ||
                other.palletNo == palletNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.proofNo, proofNo) || other.proofNo == proofNo) &&
            (identical(other.proofNoAlt, proofNoAlt) ||
                other.proofNoAlt == proofNoAlt) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      palletNo,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      quantity,
      proofNo,
      proofNoAlt,
      storeSite,
      storeRoom);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryPalletItemImplCopyWith<_$InventoryPalletItemImpl> get copyWith =>
      __$$InventoryPalletItemImplCopyWithImpl<_$InventoryPalletItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryPalletItemImplToJson(
      this,
    );
  }
}

abstract class _InventoryPalletItem extends InventoryPalletItem {
  const factory _InventoryPalletItem(
          {@JsonKey(name: 'palletNo') final String? palletNo,
          @JsonKey(name: 'matcode') final String? materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'itemBatch') final String? batchNo,
          @JsonKey(name: 'itemSn') final String? serialNo,
          @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
          final double? quantity,
          @JsonKey(name: 'proofno') final String? proofNo,
          @JsonKey(name: 'proofNo') final String? proofNoAlt,
          @JsonKey(name: 'storesite') final String? storeSite,
          @JsonKey(name: 'storeroomno') final String? storeRoom}) =
      _$InventoryPalletItemImpl;
  const _InventoryPalletItem._() : super._();

  factory _InventoryPalletItem.fromJson(Map<String, dynamic> json) =
      _$InventoryPalletItemImpl.fromJson;

  @override
  @JsonKey(name: 'palletNo')
  String? get palletNo;
  @override
  @JsonKey(name: 'matcode')
  String? get materialCode;
  @override
  @JsonKey(name: 'matname')
  String? get materialName;
  @override
  @JsonKey(name: 'itemBatch')
  String? get batchNo;
  @override
  @JsonKey(name: 'itemSn')
  String? get serialNo;
  @override
  @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
  double? get quantity;
  @override
  @JsonKey(name: 'proofno')
  String? get proofNo;
  @override
  @JsonKey(name: 'proofNo')
  String? get proofNoAlt;
  @override
  @JsonKey(name: 'storesite')
  String? get storeSite;
  @override
  @JsonKey(name: 'storeroomno')
  String? get storeRoom;
  @override
  @JsonKey(ignore: true)
  _$$InventoryPalletItemImplCopyWith<_$InventoryPalletItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
