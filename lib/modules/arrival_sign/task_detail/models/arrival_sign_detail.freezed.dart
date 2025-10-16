// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_sign_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ArrivalSignDetail _$ArrivalSignDetailFromJson(Map<String, dynamic> json) {
  return _ArrivalSignDetail.fromJson(json);
}

/// @nodoc
mixin _$ArrivalSignDetail {
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  String get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'parname')
  String? get supplierName => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  num get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'goodqty')
  num get goodQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'subinventoryCode')
  String? get subInventoryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'posnr')
  String? get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcodecontrol')
  String? get controlType => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderno')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'arrivalsBillno')
  String? get arrivalsBillNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'pdate')
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vdays')
  String? get validDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalSignDetailCopyWith<ArrivalSignDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalSignDetailCopyWith<$Res> {
  factory $ArrivalSignDetailCopyWith(
          ArrivalSignDetail value, $Res Function(ArrivalSignDetail) then) =
      _$ArrivalSignDetailCopyWithImpl<$Res, ArrivalSignDetail>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String materialName,
      @JsonKey(name: 'parname') String? supplierName,
      @JsonKey(name: 'qty') num quantity,
      @JsonKey(name: 'goodqty') num goodQuantity,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNumber,
      @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
      @JsonKey(name: 'posnr') String? position,
      @JsonKey(name: 'matcodecontrol') String? controlType,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'arrivalsBillno') String? arrivalsBillNo,
      @JsonKey(name: 'pdate') String? productionDate,
      @JsonKey(name: 'vdays') String? validDays});
}

/// @nodoc
class _$ArrivalSignDetailCopyWithImpl<$Res, $Val extends ArrivalSignDetail>
    implements $ArrivalSignDetailCopyWith<$Res> {
  _$ArrivalSignDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = null,
    Object? supplierName = freezed,
    Object? quantity = null,
    Object? goodQuantity = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? subInventoryCode = freezed,
    Object? position = freezed,
    Object? controlType = freezed,
    Object? orderNo = freezed,
    Object? arrivalsBillNo = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
  }) {
    return _then(_value.copyWith(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: null == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      goodQuantity: null == goodQuantity
          ? _value.goodQuantity
          : goodQuantity // ignore: cast_nullable_to_non_nullable
              as num,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      subInventoryCode: freezed == subInventoryCode
          ? _value.subInventoryCode
          : subInventoryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      controlType: freezed == controlType
          ? _value.controlType
          : controlType // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalsBillNo: freezed == arrivalsBillNo
          ? _value.arrivalsBillNo
          : arrivalsBillNo // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArrivalSignDetailImplCopyWith<$Res>
    implements $ArrivalSignDetailCopyWith<$Res> {
  factory _$$ArrivalSignDetailImplCopyWith(_$ArrivalSignDetailImpl value,
          $Res Function(_$ArrivalSignDetailImpl) then) =
      __$$ArrivalSignDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String materialName,
      @JsonKey(name: 'parname') String? supplierName,
      @JsonKey(name: 'qty') num quantity,
      @JsonKey(name: 'goodqty') num goodQuantity,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNumber,
      @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
      @JsonKey(name: 'posnr') String? position,
      @JsonKey(name: 'matcodecontrol') String? controlType,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'arrivalsBillno') String? arrivalsBillNo,
      @JsonKey(name: 'pdate') String? productionDate,
      @JsonKey(name: 'vdays') String? validDays});
}

/// @nodoc
class __$$ArrivalSignDetailImplCopyWithImpl<$Res>
    extends _$ArrivalSignDetailCopyWithImpl<$Res, _$ArrivalSignDetailImpl>
    implements _$$ArrivalSignDetailImplCopyWith<$Res> {
  __$$ArrivalSignDetailImplCopyWithImpl(_$ArrivalSignDetailImpl _value,
      $Res Function(_$ArrivalSignDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = null,
    Object? supplierName = freezed,
    Object? quantity = null,
    Object? goodQuantity = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? subInventoryCode = freezed,
    Object? position = freezed,
    Object? controlType = freezed,
    Object? orderNo = freezed,
    Object? arrivalsBillNo = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
  }) {
    return _then(_$ArrivalSignDetailImpl(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: null == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      goodQuantity: null == goodQuantity
          ? _value.goodQuantity
          : goodQuantity // ignore: cast_nullable_to_non_nullable
              as num,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      subInventoryCode: freezed == subInventoryCode
          ? _value.subInventoryCode
          : subInventoryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      controlType: freezed == controlType
          ? _value.controlType
          : controlType // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalsBillNo: freezed == arrivalsBillNo
          ? _value.arrivalsBillNo
          : arrivalsBillNo // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArrivalSignDetailImpl implements _ArrivalSignDetail {
  const _$ArrivalSignDetailImpl(
      {@JsonKey(name: 'matcode') required this.materialCode,
      @JsonKey(name: 'matname') required this.materialName,
      @JsonKey(name: 'parname') this.supplierName,
      @JsonKey(name: 'qty') this.quantity = 0,
      @JsonKey(name: 'goodqty') this.goodQuantity = 0,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNumber,
      @JsonKey(name: 'subinventoryCode') this.subInventoryCode,
      @JsonKey(name: 'posnr') this.position,
      @JsonKey(name: 'matcodecontrol') this.controlType,
      @JsonKey(name: 'orderno') this.orderNo,
      @JsonKey(name: 'arrivalsBillno') this.arrivalsBillNo,
      @JsonKey(name: 'pdate') this.productionDate,
      @JsonKey(name: 'vdays') this.validDays});

  factory _$ArrivalSignDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalSignDetailImplFromJson(json);

  @override
  @JsonKey(name: 'matcode')
  final String materialCode;
  @override
  @JsonKey(name: 'matname')
  final String materialName;
  @override
  @JsonKey(name: 'parname')
  final String? supplierName;
  @override
  @JsonKey(name: 'qty')
  final num quantity;
  @override
  @JsonKey(name: 'goodqty')
  final num goodQuantity;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNumber;
  @override
  @JsonKey(name: 'subinventoryCode')
  final String? subInventoryCode;
  @override
  @JsonKey(name: 'posnr')
  final String? position;
  @override
  @JsonKey(name: 'matcodecontrol')
  final String? controlType;
  @override
  @JsonKey(name: 'orderno')
  final String? orderNo;
  @override
  @JsonKey(name: 'arrivalsBillno')
  final String? arrivalsBillNo;
  @override
  @JsonKey(name: 'pdate')
  final String? productionDate;
  @override
  @JsonKey(name: 'vdays')
  final String? validDays;

  @override
  String toString() {
    return 'ArrivalSignDetail(materialCode: $materialCode, materialName: $materialName, supplierName: $supplierName, quantity: $quantity, goodQuantity: $goodQuantity, batchNo: $batchNo, serialNumber: $serialNumber, subInventoryCode: $subInventoryCode, position: $position, controlType: $controlType, orderNo: $orderNo, arrivalsBillNo: $arrivalsBillNo, productionDate: $productionDate, validDays: $validDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalSignDetailImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.goodQuantity, goodQuantity) ||
                other.goodQuantity == goodQuantity) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.subInventoryCode, subInventoryCode) ||
                other.subInventoryCode == subInventoryCode) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.controlType, controlType) ||
                other.controlType == controlType) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.arrivalsBillNo, arrivalsBillNo) ||
                other.arrivalsBillNo == arrivalsBillNo) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      materialCode,
      materialName,
      supplierName,
      quantity,
      goodQuantity,
      batchNo,
      serialNumber,
      subInventoryCode,
      position,
      controlType,
      orderNo,
      arrivalsBillNo,
      productionDate,
      validDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalSignDetailImplCopyWith<_$ArrivalSignDetailImpl> get copyWith =>
      __$$ArrivalSignDetailImplCopyWithImpl<_$ArrivalSignDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalSignDetailImplToJson(
      this,
    );
  }
}

abstract class _ArrivalSignDetail implements ArrivalSignDetail {
  const factory _ArrivalSignDetail(
          {@JsonKey(name: 'matcode') required final String materialCode,
          @JsonKey(name: 'matname') required final String materialName,
          @JsonKey(name: 'parname') final String? supplierName,
          @JsonKey(name: 'qty') final num quantity,
          @JsonKey(name: 'goodqty') final num goodQuantity,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNumber,
          @JsonKey(name: 'subinventoryCode') final String? subInventoryCode,
          @JsonKey(name: 'posnr') final String? position,
          @JsonKey(name: 'matcodecontrol') final String? controlType,
          @JsonKey(name: 'orderno') final String? orderNo,
          @JsonKey(name: 'arrivalsBillno') final String? arrivalsBillNo,
          @JsonKey(name: 'pdate') final String? productionDate,
          @JsonKey(name: 'vdays') final String? validDays}) =
      _$ArrivalSignDetailImpl;

  factory _ArrivalSignDetail.fromJson(Map<String, dynamic> json) =
      _$ArrivalSignDetailImpl.fromJson;

  @override
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override
  @JsonKey(name: 'matname')
  String get materialName;
  @override
  @JsonKey(name: 'parname')
  String? get supplierName;
  @override
  @JsonKey(name: 'qty')
  num get quantity;
  @override
  @JsonKey(name: 'goodqty')
  num get goodQuantity;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNumber;
  @override
  @JsonKey(name: 'subinventoryCode')
  String? get subInventoryCode;
  @override
  @JsonKey(name: 'posnr')
  String? get position;
  @override
  @JsonKey(name: 'matcodecontrol')
  String? get controlType;
  @override
  @JsonKey(name: 'orderno')
  String? get orderNo;
  @override
  @JsonKey(name: 'arrivalsBillno')
  String? get arrivalsBillNo;
  @override
  @JsonKey(name: 'pdate')
  String? get productionDate;
  @override
  @JsonKey(name: 'vdays')
  String? get validDays;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalSignDetailImplCopyWith<_$ArrivalSignDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArrivalSignDetailPage _$ArrivalSignDetailPageFromJson(
    Map<String, dynamic> json) {
  return _ArrivalSignDetailPage.fromJson(json);
}

/// @nodoc
mixin _$ArrivalSignDetailPage {
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'rows')
  List<ArrivalSignDetail> get rows => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalSignDetailPageCopyWith<ArrivalSignDetailPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalSignDetailPageCopyWith<$Res> {
  factory $ArrivalSignDetailPageCopyWith(ArrivalSignDetailPage value,
          $Res Function(ArrivalSignDetailPage) then) =
      _$ArrivalSignDetailPageCopyWithImpl<$Res, ArrivalSignDetailPage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total') int total,
      @JsonKey(name: 'rows') List<ArrivalSignDetail> rows});
}

/// @nodoc
class _$ArrivalSignDetailPageCopyWithImpl<$Res,
        $Val extends ArrivalSignDetailPage>
    implements $ArrivalSignDetailPageCopyWith<$Res> {
  _$ArrivalSignDetailPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? rows = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ArrivalSignDetail>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArrivalSignDetailPageImplCopyWith<$Res>
    implements $ArrivalSignDetailPageCopyWith<$Res> {
  factory _$$ArrivalSignDetailPageImplCopyWith(
          _$ArrivalSignDetailPageImpl value,
          $Res Function(_$ArrivalSignDetailPageImpl) then) =
      __$$ArrivalSignDetailPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total') int total,
      @JsonKey(name: 'rows') List<ArrivalSignDetail> rows});
}

/// @nodoc
class __$$ArrivalSignDetailPageImplCopyWithImpl<$Res>
    extends _$ArrivalSignDetailPageCopyWithImpl<$Res,
        _$ArrivalSignDetailPageImpl>
    implements _$$ArrivalSignDetailPageImplCopyWith<$Res> {
  __$$ArrivalSignDetailPageImplCopyWithImpl(_$ArrivalSignDetailPageImpl _value,
      $Res Function(_$ArrivalSignDetailPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? rows = null,
  }) {
    return _then(_$ArrivalSignDetailPageImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<ArrivalSignDetail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArrivalSignDetailPageImpl implements _ArrivalSignDetailPage {
  const _$ArrivalSignDetailPageImpl(
      {@JsonKey(name: 'total') this.total = 0,
      @JsonKey(name: 'rows')
      final List<ArrivalSignDetail> rows = const <ArrivalSignDetail>[]})
      : _rows = rows;

  factory _$ArrivalSignDetailPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalSignDetailPageImplFromJson(json);

  @override
  @JsonKey(name: 'total')
  final int total;
  final List<ArrivalSignDetail> _rows;
  @override
  @JsonKey(name: 'rows')
  List<ArrivalSignDetail> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'ArrivalSignDetailPage(total: $total, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalSignDetailPageImpl &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_rows));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalSignDetailPageImplCopyWith<_$ArrivalSignDetailPageImpl>
      get copyWith => __$$ArrivalSignDetailPageImplCopyWithImpl<
          _$ArrivalSignDetailPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalSignDetailPageImplToJson(
      this,
    );
  }
}

abstract class _ArrivalSignDetailPage implements ArrivalSignDetailPage {
  const factory _ArrivalSignDetailPage(
          {@JsonKey(name: 'total') final int total,
          @JsonKey(name: 'rows') final List<ArrivalSignDetail> rows}) =
      _$ArrivalSignDetailPageImpl;

  factory _ArrivalSignDetailPage.fromJson(Map<String, dynamic> json) =
      _$ArrivalSignDetailPageImpl.fromJson;

  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'rows')
  List<ArrivalSignDetail> get rows;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalSignDetailPageImplCopyWith<_$ArrivalSignDetailPageImpl>
      get copyWith => throw _privateConstructorUsedError;
}
