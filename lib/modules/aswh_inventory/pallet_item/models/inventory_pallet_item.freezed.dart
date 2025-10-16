// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'inventory_pallet_item.dart';

// **************************************************************************
// FreezedGenerator (manually crafted stub)
// **************************************************************************

// ignore: unnecessary_import
import 'package:collection/collection.dart';

T _$identity<T>(T value) => value;

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
  factory $InventoryPalletItemCopyWith(InventoryPalletItem value,
          $Res Function(InventoryPalletItem) then) =
      _$InventoryPalletItemCopyWithImpl<$Res>;
  $Res call({
    @JsonKey(name: 'palletNo') String? palletNo,
    @JsonKey(name: 'matcode') String? materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'itemBatch') String? batchNo,
    @JsonKey(name: 'itemSn') String? serialNo,
    @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
    double? quantity,
    @JsonKey(name: 'proofno') String? proofNo,
    @JsonKey(name: 'proofNo') String? proofNoAlt,
    @JsonKey(name: 'storesite') String? storeSite,
    @JsonKey(name: 'storeroomno') String? storeRoom,
  });
}

/// @nodoc
class _$InventoryPalletItemCopyWithImpl<$Res>
    implements $InventoryPalletItemCopyWith<$Res> {
  _$InventoryPalletItemCopyWithImpl(this._value, this._then);

  final InventoryPalletItem _value;
  final $Res Function(InventoryPalletItem) _then;

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
      palletNo: palletNo == freezed
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: materialCode == freezed
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: materialName == freezed
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: batchNo == freezed
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: serialNo == freezed
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      proofNo: proofNo == freezed
          ? _value.proofNo
          : proofNo // ignore: cast_nullable_to_non_nullable
              as String?,
      proofNoAlt: proofNoAlt == freezed
          ? _value.proofNoAlt
          : proofNoAlt // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: storeSite == freezed
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoom: storeRoom == freezed
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_InventoryPalletItemCopyWith<$Res>
    implements $InventoryPalletItemCopyWith<$Res> {
  factory _$$_InventoryPalletItemCopyWith(_$_InventoryPalletItem value,
          $Res Function(_$_InventoryPalletItem) then) =
      __$$_InventoryPalletItemCopyWithImpl<$Res>;
  @override
  $Res call({
    @JsonKey(name: 'palletNo') String? palletNo,
    @JsonKey(name: 'matcode') String? materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'itemBatch') String? batchNo,
    @JsonKey(name: 'itemSn') String? serialNo,
    @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
    double? quantity,
    @JsonKey(name: 'proofno') String? proofNo,
    @JsonKey(name: 'proofNo') String? proofNoAlt,
    @JsonKey(name: 'storesite') String? storeSite,
    @JsonKey(name: 'storeroomno') String? storeRoom,
  });
}

/// @nodoc
class __$$_InventoryPalletItemCopyWithImpl<$Res>
    extends _$InventoryPalletItemCopyWithImpl<$Res>
    implements _$$_InventoryPalletItemCopyWith<$Res> {
  __$$_InventoryPalletItemCopyWithImpl(_$_InventoryPalletItem _value,
      $Res Function(_$_InventoryPalletItem) _then)
      : super(_value, (v) => _then(v as _$_InventoryPalletItem));

  @override
  _$_InventoryPalletItem get _value => super._value as _$_InventoryPalletItem;

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
    return _then(_$_InventoryPalletItem(
      palletNo: palletNo == freezed
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: materialCode == freezed
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: materialName == freezed
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: batchNo == freezed
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: serialNo == freezed
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      proofNo: proofNo == freezed
          ? _value.proofNo
          : proofNo // ignore: cast_nullable_to_non_nullable
              as String?,
      proofNoAlt: proofNoAlt == freezed
          ? _value.proofNoAlt
          : proofNoAlt // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: storeSite == freezed
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoom: storeRoom == freezed
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InventoryPalletItem extends _InventoryPalletItem {
  const _$_InventoryPalletItem({
    @JsonKey(name: 'palletNo') this.palletNo,
    @JsonKey(name: 'matcode') this.materialCode,
    @JsonKey(name: 'matname') this.materialName,
    @JsonKey(name: 'itemBatch') this.batchNo,
    @JsonKey(name: 'itemSn') this.serialNo,
    @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
    this.quantity,
    @JsonKey(name: 'proofno') this.proofNo,
    @JsonKey(name: 'proofNo') this.proofNoAlt,
    @JsonKey(name: 'storesite') this.storeSite,
    @JsonKey(name: 'storeroomno') this.storeRoom,
  }) : super._();

  factory _$_InventoryPalletItem.fromJson(Map<String, dynamic> json) =>
      _$$_InventoryPalletItemFromJson(json);

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
            other is _$_InventoryPalletItem &&
            const DeepCollectionEquality().equals(other.palletNo, palletNo) &&
            const DeepCollectionEquality()
                .equals(other.materialCode, materialCode) &&
            const DeepCollectionEquality()
                .equals(other.materialName, materialName) &&
            const DeepCollectionEquality().equals(other.batchNo, batchNo) &&
            const DeepCollectionEquality().equals(other.serialNo, serialNo) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.proofNo, proofNo) &&
            const DeepCollectionEquality().equals(other.proofNoAlt, proofNoAlt) &&
            const DeepCollectionEquality().equals(other.storeSite, storeSite) &&
            const DeepCollectionEquality().equals(other.storeRoom, storeRoom));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(palletNo),
        const DeepCollectionEquality().hash(materialCode),
        const DeepCollectionEquality().hash(materialName),
        const DeepCollectionEquality().hash(batchNo),
        const DeepCollectionEquality().hash(serialNo),
        const DeepCollectionEquality().hash(quantity),
        const DeepCollectionEquality().hash(proofNo),
        const DeepCollectionEquality().hash(proofNoAlt),
        const DeepCollectionEquality().hash(storeSite),
        const DeepCollectionEquality().hash(storeRoom),
      );

  @JsonKey(ignore: true)
  @override
  _$$_InventoryPalletItemCopyWith<_$_InventoryPalletItem> get copyWith =>
      __$$_InventoryPalletItemCopyWithImpl<_$_InventoryPalletItem>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InventoryPalletItemToJson(
      this,
    );
  }
}

/// @nodoc
abstract class _InventoryPalletItem extends InventoryPalletItem {
  const factory _InventoryPalletItem({
    @JsonKey(name: 'palletNo') final String? palletNo,
    @JsonKey(name: 'matcode') final String? materialCode,
    @JsonKey(name: 'matname') final String? materialName,
    @JsonKey(name: 'itemBatch') final String? batchNo,
    @JsonKey(name: 'itemSn') final String? serialNo,
    @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
    final double? quantity,
    @JsonKey(name: 'proofno') final String? proofNo,
    @JsonKey(name: 'proofNo') final String? proofNoAlt,
    @JsonKey(name: 'storesite') final String? storeSite,
    @JsonKey(name: 'storeroomno') final String? storeRoom,
  }) = _$_InventoryPalletItem;
  const _InventoryPalletItem._() : super._();

  factory _InventoryPalletItem.fromJson(Map<String, dynamic> json) =
      _$_InventoryPalletItem.fromJson;
}

const _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.
Please check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');
