// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aswh_up_collection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AswhUpBarcodeContent _$AswhUpBarcodeContentFromJson(Map<String, dynamic> json) {
  return _AswhUpBarcodeContent.fromJson(json);
}

/// @nodoc
mixin _$AswhUpBarcodeContent {
  @JsonKey(name: 'matcode')
  @HiveField(0)
  String? get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  @HiveField(1)
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  @HiveField(2)
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  @HiveField(3)
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'seqctrl')
  @HiveField(4)
  String? get seqCtrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'id_old')
  @HiveField(5)
  String? get idOld => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  @HiveField(6)
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'vdays')
  @HiveField(7)
  String? get expireDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'pdate')
  @HiveField(8)
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'dgFlg')
  @HiveField(9)
  String? get dangerousFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'suppliercode')
  @HiveField(10)
  String? get supplierCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'suppliername')
  @HiveField(11)
  String? get supplierName => throw _privateConstructorUsedError;
  @JsonKey(name: 'erpstore')
  @HiveField(12)
  String? get erpStore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AswhUpBarcodeContentCopyWith<AswhUpBarcodeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhUpBarcodeContentCopyWith<$Res> {
  factory $AswhUpBarcodeContentCopyWith(AswhUpBarcodeContent value,
          $Res Function(AswhUpBarcodeContent) then) =
      _$AswhUpBarcodeContentCopyWithImpl<$Res, AswhUpBarcodeContent>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') @HiveField(0) String? materialCode,
      @JsonKey(name: 'matname') @HiveField(1) String? materialName,
      @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
      @JsonKey(name: 'sn') @HiveField(3) String? serialNo,
      @JsonKey(name: 'seqctrl') @HiveField(4) String? seqCtrl,
      @JsonKey(name: 'id_old') @HiveField(5) String? idOld,
      @JsonKey(name: 'qty') @HiveField(6) double quantity,
      @JsonKey(name: 'vdays') @HiveField(7) String? expireDays,
      @JsonKey(name: 'pdate') @HiveField(8) String? productionDate,
      @JsonKey(name: 'dgFlg') @HiveField(9) String? dangerousFlag,
      @JsonKey(name: 'suppliercode') @HiveField(10) String? supplierCode,
      @JsonKey(name: 'suppliername') @HiveField(11) String? supplierName,
      @JsonKey(name: 'erpstore') @HiveField(12) String? erpStore});
}

/// @nodoc
class _$AswhUpBarcodeContentCopyWithImpl<$Res,
        $Val extends AswhUpBarcodeContent>
    implements $AswhUpBarcodeContentCopyWith<$Res> {
  _$AswhUpBarcodeContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? seqCtrl = freezed,
    Object? idOld = freezed,
    Object? quantity = null,
    Object? expireDays = freezed,
    Object? productionDate = freezed,
    Object? dangerousFlag = freezed,
    Object? supplierCode = freezed,
    Object? supplierName = freezed,
    Object? erpStore = freezed,
  }) {
    return _then(_value.copyWith(
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
      seqCtrl: freezed == seqCtrl
          ? _value.seqCtrl
          : seqCtrl // ignore: cast_nullable_to_non_nullable
              as String?,
      idOld: freezed == idOld
          ? _value.idOld
          : idOld // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      expireDays: freezed == expireDays
          ? _value.expireDays
          : expireDays // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dangerousFlag: freezed == dangerousFlag
          ? _value.dangerousFlag
          : dangerousFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierCode: freezed == supplierCode
          ? _value.supplierCode
          : supplierCode // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStore: freezed == erpStore
          ? _value.erpStore
          : erpStore // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AswhUpBarcodeContentImplCopyWith<$Res>
    implements $AswhUpBarcodeContentCopyWith<$Res> {
  factory _$$AswhUpBarcodeContentImplCopyWith(_$AswhUpBarcodeContentImpl value,
          $Res Function(_$AswhUpBarcodeContentImpl) then) =
      __$$AswhUpBarcodeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') @HiveField(0) String? materialCode,
      @JsonKey(name: 'matname') @HiveField(1) String? materialName,
      @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
      @JsonKey(name: 'sn') @HiveField(3) String? serialNo,
      @JsonKey(name: 'seqctrl') @HiveField(4) String? seqCtrl,
      @JsonKey(name: 'id_old') @HiveField(5) String? idOld,
      @JsonKey(name: 'qty') @HiveField(6) double quantity,
      @JsonKey(name: 'vdays') @HiveField(7) String? expireDays,
      @JsonKey(name: 'pdate') @HiveField(8) String? productionDate,
      @JsonKey(name: 'dgFlg') @HiveField(9) String? dangerousFlag,
      @JsonKey(name: 'suppliercode') @HiveField(10) String? supplierCode,
      @JsonKey(name: 'suppliername') @HiveField(11) String? supplierName,
      @JsonKey(name: 'erpstore') @HiveField(12) String? erpStore});
}

/// @nodoc
class __$$AswhUpBarcodeContentImplCopyWithImpl<$Res>
    extends _$AswhUpBarcodeContentCopyWithImpl<$Res, _$AswhUpBarcodeContentImpl>
    implements _$$AswhUpBarcodeContentImplCopyWith<$Res> {
  __$$AswhUpBarcodeContentImplCopyWithImpl(_$AswhUpBarcodeContentImpl _value,
      $Res Function(_$AswhUpBarcodeContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? seqCtrl = freezed,
    Object? idOld = freezed,
    Object? quantity = null,
    Object? expireDays = freezed,
    Object? productionDate = freezed,
    Object? dangerousFlag = freezed,
    Object? supplierCode = freezed,
    Object? supplierName = freezed,
    Object? erpStore = freezed,
  }) {
    return _then(_$AswhUpBarcodeContentImpl(
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
      seqCtrl: freezed == seqCtrl
          ? _value.seqCtrl
          : seqCtrl // ignore: cast_nullable_to_non_nullable
              as String?,
      idOld: freezed == idOld
          ? _value.idOld
          : idOld // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      expireDays: freezed == expireDays
          ? _value.expireDays
          : expireDays // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      dangerousFlag: freezed == dangerousFlag
          ? _value.dangerousFlag
          : dangerousFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierCode: freezed == supplierCode
          ? _value.supplierCode
          : supplierCode // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStore: freezed == erpStore
          ? _value.erpStore
          : erpStore // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AswhUpBarcodeContentImpl extends _AswhUpBarcodeContent {
  _$AswhUpBarcodeContentImpl(
      {@JsonKey(name: 'matcode') @HiveField(0) this.materialCode,
      @JsonKey(name: 'matname') @HiveField(1) this.materialName,
      @JsonKey(name: 'batchno') @HiveField(2) this.batchNo,
      @JsonKey(name: 'sn') @HiveField(3) this.serialNo,
      @JsonKey(name: 'seqctrl') @HiveField(4) this.seqCtrl,
      @JsonKey(name: 'id_old') @HiveField(5) this.idOld,
      @JsonKey(name: 'qty') @HiveField(6) this.quantity = 0.0,
      @JsonKey(name: 'vdays') @HiveField(7) this.expireDays,
      @JsonKey(name: 'pdate') @HiveField(8) this.productionDate,
      @JsonKey(name: 'dgFlg') @HiveField(9) this.dangerousFlag,
      @JsonKey(name: 'suppliercode') @HiveField(10) this.supplierCode,
      @JsonKey(name: 'suppliername') @HiveField(11) this.supplierName,
      @JsonKey(name: 'erpstore') @HiveField(12) this.erpStore})
      : super._();

  factory _$AswhUpBarcodeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AswhUpBarcodeContentImplFromJson(json);

  @override
  @JsonKey(name: 'matcode')
  @HiveField(0)
  final String? materialCode;
  @override
  @JsonKey(name: 'matname')
  @HiveField(1)
  final String? materialName;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(2)
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(3)
  final String? serialNo;
  @override
  @JsonKey(name: 'seqctrl')
  @HiveField(4)
  final String? seqCtrl;
  @override
  @JsonKey(name: 'id_old')
  @HiveField(5)
  final String? idOld;
  @override
  @JsonKey(name: 'qty')
  @HiveField(6)
  final double quantity;
  @override
  @JsonKey(name: 'vdays')
  @HiveField(7)
  final String? expireDays;
  @override
  @JsonKey(name: 'pdate')
  @HiveField(8)
  final String? productionDate;
  @override
  @JsonKey(name: 'dgFlg')
  @HiveField(9)
  final String? dangerousFlag;
  @override
  @JsonKey(name: 'suppliercode')
  @HiveField(10)
  final String? supplierCode;
  @override
  @JsonKey(name: 'suppliername')
  @HiveField(11)
  final String? supplierName;
  @override
  @JsonKey(name: 'erpstore')
  @HiveField(12)
  final String? erpStore;

  @override
  String toString() {
    return 'AswhUpBarcodeContent(materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, seqCtrl: $seqCtrl, idOld: $idOld, quantity: $quantity, expireDays: $expireDays, productionDate: $productionDate, dangerousFlag: $dangerousFlag, supplierCode: $supplierCode, supplierName: $supplierName, erpStore: $erpStore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhUpBarcodeContentImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.seqCtrl, seqCtrl) || other.seqCtrl == seqCtrl) &&
            (identical(other.idOld, idOld) || other.idOld == idOld) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.expireDays, expireDays) ||
                other.expireDays == expireDays) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.dangerousFlag, dangerousFlag) ||
                other.dangerousFlag == dangerousFlag) &&
            (identical(other.supplierCode, supplierCode) ||
                other.supplierCode == supplierCode) &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.erpStore, erpStore) ||
                other.erpStore == erpStore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      seqCtrl,
      idOld,
      quantity,
      expireDays,
      productionDate,
      dangerousFlag,
      supplierCode,
      supplierName,
      erpStore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AswhUpBarcodeContentImplCopyWith<_$AswhUpBarcodeContentImpl>
      get copyWith =>
          __$$AswhUpBarcodeContentImplCopyWithImpl<_$AswhUpBarcodeContentImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AswhUpBarcodeContentImplToJson(
      this,
    );
  }
}

abstract class _AswhUpBarcodeContent extends AswhUpBarcodeContent {
  factory _AswhUpBarcodeContent(
      {@JsonKey(name: 'matcode') @HiveField(0) final String? materialCode,
      @JsonKey(name: 'matname') @HiveField(1) final String? materialName,
      @JsonKey(name: 'batchno') @HiveField(2) final String? batchNo,
      @JsonKey(name: 'sn') @HiveField(3) final String? serialNo,
      @JsonKey(name: 'seqctrl') @HiveField(4) final String? seqCtrl,
      @JsonKey(name: 'id_old') @HiveField(5) final String? idOld,
      @JsonKey(name: 'qty') @HiveField(6) final double quantity,
      @JsonKey(name: 'vdays') @HiveField(7) final String? expireDays,
      @JsonKey(name: 'pdate') @HiveField(8) final String? productionDate,
      @JsonKey(name: 'dgFlg') @HiveField(9) final String? dangerousFlag,
      @JsonKey(name: 'suppliercode') @HiveField(10) final String? supplierCode,
      @JsonKey(name: 'suppliername') @HiveField(11) final String? supplierName,
      @JsonKey(name: 'erpstore')
      @HiveField(12)
      final String? erpStore}) = _$AswhUpBarcodeContentImpl;
  _AswhUpBarcodeContent._() : super._();

  factory _AswhUpBarcodeContent.fromJson(Map<String, dynamic> json) =
      _$AswhUpBarcodeContentImpl.fromJson;

  @override
  @JsonKey(name: 'matcode')
  @HiveField(0)
  String? get materialCode;
  @override
  @JsonKey(name: 'matname')
  @HiveField(1)
  String? get materialName;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(2)
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(3)
  String? get serialNo;
  @override
  @JsonKey(name: 'seqctrl')
  @HiveField(4)
  String? get seqCtrl;
  @override
  @JsonKey(name: 'id_old')
  @HiveField(5)
  String? get idOld;
  @override
  @JsonKey(name: 'qty')
  @HiveField(6)
  double get quantity;
  @override
  @JsonKey(name: 'vdays')
  @HiveField(7)
  String? get expireDays;
  @override
  @JsonKey(name: 'pdate')
  @HiveField(8)
  String? get productionDate;
  @override
  @JsonKey(name: 'dgFlg')
  @HiveField(9)
  String? get dangerousFlag;
  @override
  @JsonKey(name: 'suppliercode')
  @HiveField(10)
  String? get supplierCode;
  @override
  @JsonKey(name: 'suppliername')
  @HiveField(11)
  String? get supplierName;
  @override
  @JsonKey(name: 'erpstore')
  @HiveField(12)
  String? get erpStore;
  @override
  @JsonKey(ignore: true)
  _$$AswhUpBarcodeContentImplCopyWith<_$AswhUpBarcodeContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AswhUpCollectionStock _$AswhUpCollectionStockFromJson(
    Map<String, dynamic> json) {
  return _AswhUpCollectionStock.fromJson(json);
}

/// @nodoc
mixin _$AswhUpCollectionStock {
  @HiveField(0)
  String get stockId => throw _privateConstructorUsedError;
  @HiveField(1)
  String get trayNo => throw _privateConstructorUsedError;
  @HiveField(2)
  String get materialCode => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get materialName => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get batchNo => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get serialNo => throw _privateConstructorUsedError;
  @HiveField(6)
  double get taskQty => throw _privateConstructorUsedError;
  @HiveField(7)
  double get collectQty => throw _privateConstructorUsedError;
  @HiveField(8)
  String get taskItemId => throw _privateConstructorUsedError;
  @HiveField(9)
  String get taskId => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get storeRoom => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get storeSite => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get erpStore => throw _privateConstructorUsedError;
  @HiveField(13)
  String? get supplierCode => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get supplierName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AswhUpCollectionStockCopyWith<AswhUpCollectionStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhUpCollectionStockCopyWith<$Res> {
  factory $AswhUpCollectionStockCopyWith(AswhUpCollectionStock value,
          $Res Function(AswhUpCollectionStock) then) =
      _$AswhUpCollectionStockCopyWithImpl<$Res, AswhUpCollectionStock>;
  @useResult
  $Res call(
      {@HiveField(0) String stockId,
      @HiveField(1) String trayNo,
      @HiveField(2) String materialCode,
      @HiveField(3) String? materialName,
      @HiveField(4) String? batchNo,
      @HiveField(5) String? serialNo,
      @HiveField(6) double taskQty,
      @HiveField(7) double collectQty,
      @HiveField(8) String taskItemId,
      @HiveField(9) String taskId,
      @HiveField(10) String? storeRoom,
      @HiveField(11) String? storeSite,
      @HiveField(12) String? erpStore,
      @HiveField(13) String? supplierCode,
      @HiveField(14) String? supplierName});
}

/// @nodoc
class _$AswhUpCollectionStockCopyWithImpl<$Res,
        $Val extends AswhUpCollectionStock>
    implements $AswhUpCollectionStockCopyWith<$Res> {
  _$AswhUpCollectionStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? trayNo = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? taskQty = null,
    Object? collectQty = null,
    Object? taskItemId = null,
    Object? taskId = null,
    Object? storeRoom = freezed,
    Object? storeSite = freezed,
    Object? erpStore = freezed,
    Object? supplierCode = freezed,
    Object? supplierName = freezed,
  }) {
    return _then(_value.copyWith(
      stockId: null == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
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
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as double,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      taskItemId: null == taskItemId
          ? _value.taskItemId
          : taskItemId // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoom: freezed == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: freezed == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStore: freezed == erpStore
          ? _value.erpStore
          : erpStore // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierCode: freezed == supplierCode
          ? _value.supplierCode
          : supplierCode // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AswhUpCollectionStockImplCopyWith<$Res>
    implements $AswhUpCollectionStockCopyWith<$Res> {
  factory _$$AswhUpCollectionStockImplCopyWith(
          _$AswhUpCollectionStockImpl value,
          $Res Function(_$AswhUpCollectionStockImpl) then) =
      __$$AswhUpCollectionStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String stockId,
      @HiveField(1) String trayNo,
      @HiveField(2) String materialCode,
      @HiveField(3) String? materialName,
      @HiveField(4) String? batchNo,
      @HiveField(5) String? serialNo,
      @HiveField(6) double taskQty,
      @HiveField(7) double collectQty,
      @HiveField(8) String taskItemId,
      @HiveField(9) String taskId,
      @HiveField(10) String? storeRoom,
      @HiveField(11) String? storeSite,
      @HiveField(12) String? erpStore,
      @HiveField(13) String? supplierCode,
      @HiveField(14) String? supplierName});
}

/// @nodoc
class __$$AswhUpCollectionStockImplCopyWithImpl<$Res>
    extends _$AswhUpCollectionStockCopyWithImpl<$Res,
        _$AswhUpCollectionStockImpl>
    implements _$$AswhUpCollectionStockImplCopyWith<$Res> {
  __$$AswhUpCollectionStockImplCopyWithImpl(_$AswhUpCollectionStockImpl _value,
      $Res Function(_$AswhUpCollectionStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? trayNo = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? taskQty = null,
    Object? collectQty = null,
    Object? taskItemId = null,
    Object? taskId = null,
    Object? storeRoom = freezed,
    Object? storeSite = freezed,
    Object? erpStore = freezed,
    Object? supplierCode = freezed,
    Object? supplierName = freezed,
  }) {
    return _then(_$AswhUpCollectionStockImpl(
      stockId: null == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
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
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as double,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      taskItemId: null == taskItemId
          ? _value.taskItemId
          : taskItemId // ignore: cast_nullable_to_non_nullable
              as String,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoom: freezed == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: freezed == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStore: freezed == erpStore
          ? _value.erpStore
          : erpStore // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierCode: freezed == supplierCode
          ? _value.supplierCode
          : supplierCode // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierName: freezed == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AswhUpCollectionStockImpl extends _AswhUpCollectionStock {
  _$AswhUpCollectionStockImpl(
      {@HiveField(0) this.stockId = '',
      @HiveField(1) this.trayNo = '',
      @HiveField(2) this.materialCode = '',
      @HiveField(3) this.materialName,
      @HiveField(4) this.batchNo,
      @HiveField(5) this.serialNo,
      @HiveField(6) this.taskQty = 0.0,
      @HiveField(7) this.collectQty = 0.0,
      @HiveField(8) this.taskItemId = '',
      @HiveField(9) this.taskId = '',
      @HiveField(10) this.storeRoom,
      @HiveField(11) this.storeSite,
      @HiveField(12) this.erpStore,
      @HiveField(13) this.supplierCode,
      @HiveField(14) this.supplierName})
      : super._();

  factory _$AswhUpCollectionStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$AswhUpCollectionStockImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String stockId;
  @override
  @JsonKey()
  @HiveField(1)
  final String trayNo;
  @override
  @JsonKey()
  @HiveField(2)
  final String materialCode;
  @override
  @HiveField(3)
  final String? materialName;
  @override
  @HiveField(4)
  final String? batchNo;
  @override
  @HiveField(5)
  final String? serialNo;
  @override
  @JsonKey()
  @HiveField(6)
  final double taskQty;
  @override
  @JsonKey()
  @HiveField(7)
  final double collectQty;
  @override
  @JsonKey()
  @HiveField(8)
  final String taskItemId;
  @override
  @JsonKey()
  @HiveField(9)
  final String taskId;
  @override
  @HiveField(10)
  final String? storeRoom;
  @override
  @HiveField(11)
  final String? storeSite;
  @override
  @HiveField(12)
  final String? erpStore;
  @override
  @HiveField(13)
  final String? supplierCode;
  @override
  @HiveField(14)
  final String? supplierName;

  @override
  String toString() {
    return 'AswhUpCollectionStock(stockId: $stockId, trayNo: $trayNo, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, taskQty: $taskQty, collectQty: $collectQty, taskItemId: $taskItemId, taskId: $taskId, storeRoom: $storeRoom, storeSite: $storeSite, erpStore: $erpStore, supplierCode: $supplierCode, supplierName: $supplierName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhUpCollectionStockImpl &&
            (identical(other.stockId, stockId) || other.stockId == stockId) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.collectQty, collectQty) ||
                other.collectQty == collectQty) &&
            (identical(other.taskItemId, taskItemId) ||
                other.taskItemId == taskItemId) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.erpStore, erpStore) ||
                other.erpStore == erpStore) &&
            (identical(other.supplierCode, supplierCode) ||
                other.supplierCode == supplierCode) &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stockId,
      trayNo,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      taskQty,
      collectQty,
      taskItemId,
      taskId,
      storeRoom,
      storeSite,
      erpStore,
      supplierCode,
      supplierName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AswhUpCollectionStockImplCopyWith<_$AswhUpCollectionStockImpl>
      get copyWith => __$$AswhUpCollectionStockImplCopyWithImpl<
          _$AswhUpCollectionStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AswhUpCollectionStockImplToJson(
      this,
    );
  }
}

abstract class _AswhUpCollectionStock extends AswhUpCollectionStock {
  factory _AswhUpCollectionStock(
      {@HiveField(0) final String stockId,
      @HiveField(1) final String trayNo,
      @HiveField(2) final String materialCode,
      @HiveField(3) final String? materialName,
      @HiveField(4) final String? batchNo,
      @HiveField(5) final String? serialNo,
      @HiveField(6) final double taskQty,
      @HiveField(7) final double collectQty,
      @HiveField(8) final String taskItemId,
      @HiveField(9) final String taskId,
      @HiveField(10) final String? storeRoom,
      @HiveField(11) final String? storeSite,
      @HiveField(12) final String? erpStore,
      @HiveField(13) final String? supplierCode,
      @HiveField(14) final String? supplierName}) = _$AswhUpCollectionStockImpl;
  _AswhUpCollectionStock._() : super._();

  factory _AswhUpCollectionStock.fromJson(Map<String, dynamic> json) =
      _$AswhUpCollectionStockImpl.fromJson;

  @override
  @HiveField(0)
  String get stockId;
  @override
  @HiveField(1)
  String get trayNo;
  @override
  @HiveField(2)
  String get materialCode;
  @override
  @HiveField(3)
  String? get materialName;
  @override
  @HiveField(4)
  String? get batchNo;
  @override
  @HiveField(5)
  String? get serialNo;
  @override
  @HiveField(6)
  double get taskQty;
  @override
  @HiveField(7)
  double get collectQty;
  @override
  @HiveField(8)
  String get taskItemId;
  @override
  @HiveField(9)
  String get taskId;
  @override
  @HiveField(10)
  String? get storeRoom;
  @override
  @HiveField(11)
  String? get storeSite;
  @override
  @HiveField(12)
  String? get erpStore;
  @override
  @HiveField(13)
  String? get supplierCode;
  @override
  @HiveField(14)
  String? get supplierName;
  @override
  @JsonKey(ignore: true)
  _$$AswhUpCollectionStockImplCopyWith<_$AswhUpCollectionStockImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AswhUpDicSeqEntry _$AswhUpDicSeqEntryFromJson(Map<String, dynamic> json) {
  return _AswhUpDicSeqEntry.fromJson(json);
}

/// @nodoc
mixin _$AswhUpDicSeqEntry {
  @HiveField(0)
  int get taskItemId => throw _privateConstructorUsedError;
  @HiveField(1)
  List<String> get serialNumbers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AswhUpDicSeqEntryCopyWith<AswhUpDicSeqEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhUpDicSeqEntryCopyWith<$Res> {
  factory $AswhUpDicSeqEntryCopyWith(
          AswhUpDicSeqEntry value, $Res Function(AswhUpDicSeqEntry) then) =
      _$AswhUpDicSeqEntryCopyWithImpl<$Res, AswhUpDicSeqEntry>;
  @useResult
  $Res call(
      {@HiveField(0) int taskItemId, @HiveField(1) List<String> serialNumbers});
}

/// @nodoc
class _$AswhUpDicSeqEntryCopyWithImpl<$Res, $Val extends AswhUpDicSeqEntry>
    implements $AswhUpDicSeqEntryCopyWith<$Res> {
  _$AswhUpDicSeqEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskItemId = null,
    Object? serialNumbers = null,
  }) {
    return _then(_value.copyWith(
      taskItemId: null == taskItemId
          ? _value.taskItemId
          : taskItemId // ignore: cast_nullable_to_non_nullable
              as int,
      serialNumbers: null == serialNumbers
          ? _value.serialNumbers
          : serialNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AswhUpDicSeqEntryImplCopyWith<$Res>
    implements $AswhUpDicSeqEntryCopyWith<$Res> {
  factory _$$AswhUpDicSeqEntryImplCopyWith(_$AswhUpDicSeqEntryImpl value,
          $Res Function(_$AswhUpDicSeqEntryImpl) then) =
      __$$AswhUpDicSeqEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int taskItemId, @HiveField(1) List<String> serialNumbers});
}

/// @nodoc
class __$$AswhUpDicSeqEntryImplCopyWithImpl<$Res>
    extends _$AswhUpDicSeqEntryCopyWithImpl<$Res, _$AswhUpDicSeqEntryImpl>
    implements _$$AswhUpDicSeqEntryImplCopyWith<$Res> {
  __$$AswhUpDicSeqEntryImplCopyWithImpl(_$AswhUpDicSeqEntryImpl _value,
      $Res Function(_$AswhUpDicSeqEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskItemId = null,
    Object? serialNumbers = null,
  }) {
    return _then(_$AswhUpDicSeqEntryImpl(
      taskItemId: null == taskItemId
          ? _value.taskItemId
          : taskItemId // ignore: cast_nullable_to_non_nullable
              as int,
      serialNumbers: null == serialNumbers
          ? _value._serialNumbers
          : serialNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AswhUpDicSeqEntryImpl extends _AswhUpDicSeqEntry {
  _$AswhUpDicSeqEntryImpl(
      {@HiveField(0) this.taskItemId = 0,
      @HiveField(1) final List<String> serialNumbers = const <String>[]})
      : _serialNumbers = serialNumbers,
        super._();

  factory _$AswhUpDicSeqEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AswhUpDicSeqEntryImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final int taskItemId;
  final List<String> _serialNumbers;
  @override
  @JsonKey()
  @HiveField(1)
  List<String> get serialNumbers {
    if (_serialNumbers is EqualUnmodifiableListView) return _serialNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serialNumbers);
  }

  @override
  String toString() {
    return 'AswhUpDicSeqEntry(taskItemId: $taskItemId, serialNumbers: $serialNumbers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhUpDicSeqEntryImpl &&
            (identical(other.taskItemId, taskItemId) ||
                other.taskItemId == taskItemId) &&
            const DeepCollectionEquality()
                .equals(other._serialNumbers, _serialNumbers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskItemId,
      const DeepCollectionEquality().hash(_serialNumbers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AswhUpDicSeqEntryImplCopyWith<_$AswhUpDicSeqEntryImpl> get copyWith =>
      __$$AswhUpDicSeqEntryImplCopyWithImpl<_$AswhUpDicSeqEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AswhUpDicSeqEntryImplToJson(
      this,
    );
  }
}

abstract class _AswhUpDicSeqEntry extends AswhUpDicSeqEntry {
  factory _AswhUpDicSeqEntry(
          {@HiveField(0) final int taskItemId,
          @HiveField(1) final List<String> serialNumbers}) =
      _$AswhUpDicSeqEntryImpl;
  _AswhUpDicSeqEntry._() : super._();

  factory _AswhUpDicSeqEntry.fromJson(Map<String, dynamic> json) =
      _$AswhUpDicSeqEntryImpl.fromJson;

  @override
  @HiveField(0)
  int get taskItemId;
  @override
  @HiveField(1)
  List<String> get serialNumbers;
  @override
  @JsonKey(ignore: true)
  _$$AswhUpDicSeqEntryImplCopyWith<_$AswhUpDicSeqEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
