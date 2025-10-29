// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_pick_collection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnlinePickBarcodeContent _$OnlinePickBarcodeContentFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickBarcodeContent.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickBarcodeContent {
  @HiveField(0)
  @JsonKey(name: 'matcode')
  String? get materialCode => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(name: 'sn')
  String? get serialNumber => throw _privateConstructorUsedError;
  @HiveField(4)
  @JsonKey(name: 'seqctrl')
  String? get sequenceControl => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(name: 'id_old')
  String? get legacyId => throw _privateConstructorUsedError;
  @HiveField(6)
  @JsonKey(name: 'qty')
  num? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickBarcodeContentCopyWith<OnlinePickBarcodeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickBarcodeContentCopyWith<$Res> {
  factory $OnlinePickBarcodeContentCopyWith(OnlinePickBarcodeContent value,
          $Res Function(OnlinePickBarcodeContent) then) =
      _$OnlinePickBarcodeContentCopyWithImpl<$Res, OnlinePickBarcodeContent>;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'matcode') String? materialCode,
      @HiveField(1) @JsonKey(name: 'matname') String? materialName,
      @HiveField(2) @JsonKey(name: 'batchno') String? batchNo,
      @HiveField(3) @JsonKey(name: 'sn') String? serialNumber,
      @HiveField(4) @JsonKey(name: 'seqctrl') String? sequenceControl,
      @HiveField(5) @JsonKey(name: 'id_old') String? legacyId,
      @HiveField(6) @JsonKey(name: 'qty') num? quantity});
}

/// @nodoc
class _$OnlinePickBarcodeContentCopyWithImpl<$Res,
        $Val extends OnlinePickBarcodeContent>
    implements $OnlinePickBarcodeContentCopyWith<$Res> {
  _$OnlinePickBarcodeContentCopyWithImpl(this._value, this._then);

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
    Object? serialNumber = freezed,
    Object? sequenceControl = freezed,
    Object? legacyId = freezed,
    Object? quantity = freezed,
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
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      sequenceControl: freezed == sequenceControl
          ? _value.sequenceControl
          : sequenceControl // ignore: cast_nullable_to_non_nullable
              as String?,
      legacyId: freezed == legacyId
          ? _value.legacyId
          : legacyId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickBarcodeContentImplCopyWith<$Res>
    implements $OnlinePickBarcodeContentCopyWith<$Res> {
  factory _$$OnlinePickBarcodeContentImplCopyWith(
          _$OnlinePickBarcodeContentImpl value,
          $Res Function(_$OnlinePickBarcodeContentImpl) then) =
      __$$OnlinePickBarcodeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'matcode') String? materialCode,
      @HiveField(1) @JsonKey(name: 'matname') String? materialName,
      @HiveField(2) @JsonKey(name: 'batchno') String? batchNo,
      @HiveField(3) @JsonKey(name: 'sn') String? serialNumber,
      @HiveField(4) @JsonKey(name: 'seqctrl') String? sequenceControl,
      @HiveField(5) @JsonKey(name: 'id_old') String? legacyId,
      @HiveField(6) @JsonKey(name: 'qty') num? quantity});
}

/// @nodoc
class __$$OnlinePickBarcodeContentImplCopyWithImpl<$Res>
    extends _$OnlinePickBarcodeContentCopyWithImpl<$Res,
        _$OnlinePickBarcodeContentImpl>
    implements _$$OnlinePickBarcodeContentImplCopyWith<$Res> {
  __$$OnlinePickBarcodeContentImplCopyWithImpl(
      _$OnlinePickBarcodeContentImpl _value,
      $Res Function(_$OnlinePickBarcodeContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? sequenceControl = freezed,
    Object? legacyId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$OnlinePickBarcodeContentImpl(
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
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      sequenceControl: freezed == sequenceControl
          ? _value.sequenceControl
          : sequenceControl // ignore: cast_nullable_to_non_nullable
              as String?,
      legacyId: freezed == legacyId
          ? _value.legacyId
          : legacyId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickBarcodeContentImpl extends _OnlinePickBarcodeContent {
  const _$OnlinePickBarcodeContentImpl(
      {@HiveField(0) @JsonKey(name: 'matcode') this.materialCode,
      @HiveField(1) @JsonKey(name: 'matname') this.materialName,
      @HiveField(2) @JsonKey(name: 'batchno') this.batchNo,
      @HiveField(3) @JsonKey(name: 'sn') this.serialNumber,
      @HiveField(4) @JsonKey(name: 'seqctrl') this.sequenceControl,
      @HiveField(5) @JsonKey(name: 'id_old') this.legacyId,
      @HiveField(6) @JsonKey(name: 'qty') this.quantity})
      : super._();

  factory _$OnlinePickBarcodeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickBarcodeContentImplFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: 'matcode')
  final String? materialCode;
  @override
  @HiveField(1)
  @JsonKey(name: 'matname')
  final String? materialName;
  @override
  @HiveField(2)
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @HiveField(3)
  @JsonKey(name: 'sn')
  final String? serialNumber;
  @override
  @HiveField(4)
  @JsonKey(name: 'seqctrl')
  final String? sequenceControl;
  @override
  @HiveField(5)
  @JsonKey(name: 'id_old')
  final String? legacyId;
  @override
  @HiveField(6)
  @JsonKey(name: 'qty')
  final num? quantity;

  @override
  String toString() {
    return 'OnlinePickBarcodeContent(materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNumber: $serialNumber, sequenceControl: $sequenceControl, legacyId: $legacyId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickBarcodeContentImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.sequenceControl, sequenceControl) ||
                other.sequenceControl == sequenceControl) &&
            (identical(other.legacyId, legacyId) ||
                other.legacyId == legacyId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, materialCode, materialName,
      batchNo, serialNumber, sequenceControl, legacyId, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickBarcodeContentImplCopyWith<_$OnlinePickBarcodeContentImpl>
      get copyWith => __$$OnlinePickBarcodeContentImplCopyWithImpl<
          _$OnlinePickBarcodeContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickBarcodeContentImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickBarcodeContent extends OnlinePickBarcodeContent {
  const factory _OnlinePickBarcodeContent(
          {@HiveField(0) @JsonKey(name: 'matcode') final String? materialCode,
          @HiveField(1) @JsonKey(name: 'matname') final String? materialName,
          @HiveField(2) @JsonKey(name: 'batchno') final String? batchNo,
          @HiveField(3) @JsonKey(name: 'sn') final String? serialNumber,
          @HiveField(4) @JsonKey(name: 'seqctrl') final String? sequenceControl,
          @HiveField(5) @JsonKey(name: 'id_old') final String? legacyId,
          @HiveField(6) @JsonKey(name: 'qty') final num? quantity}) =
      _$OnlinePickBarcodeContentImpl;
  const _OnlinePickBarcodeContent._() : super._();

  factory _OnlinePickBarcodeContent.fromJson(Map<String, dynamic> json) =
      _$OnlinePickBarcodeContentImpl.fromJson;

  @override
  @HiveField(0)
  @JsonKey(name: 'matcode')
  String? get materialCode;
  @override
  @HiveField(1)
  @JsonKey(name: 'matname')
  String? get materialName;
  @override
  @HiveField(2)
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @HiveField(3)
  @JsonKey(name: 'sn')
  String? get serialNumber;
  @override
  @HiveField(4)
  @JsonKey(name: 'seqctrl')
  String? get sequenceControl;
  @override
  @HiveField(5)
  @JsonKey(name: 'id_old')
  String? get legacyId;
  @override
  @HiveField(6)
  @JsonKey(name: 'qty')
  num? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickBarcodeContentImplCopyWith<_$OnlinePickBarcodeContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickCollectionStock _$OnlinePickCollectionStockFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickCollectionStock.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickCollectionStock {
  @HiveField(0)
  @JsonKey(name: 'stockid')
  String get stockId => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(name: 'sn')
  String? get serialNumber => throw _privateConstructorUsedError;
  @HiveField(4)
  @JsonKey(name: 'taskQty')
  num get taskQty => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(name: 'collectQty')
  num get collectQty => throw _privateConstructorUsedError;
  @HiveField(6)
  @JsonKey(name: 'outtaskitemid')
  String get outTaskItemId => throw _privateConstructorUsedError;
  @HiveField(7)
  @JsonKey(name: 'taskid')
  String get taskId => throw _privateConstructorUsedError;
  @HiveField(8)
  @JsonKey(name: 'storeRoom')
  String? get storeRoom => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(name: 'storeSite')
  String? get storeSite => throw _privateConstructorUsedError;
  @HiveField(10)
  @JsonKey(name: 'erpStore')
  String? get erpStore => throw _privateConstructorUsedError;
  @HiveField(11)
  @JsonKey(name: 'trayNo')
  String? get trayNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickCollectionStockCopyWith<OnlinePickCollectionStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickCollectionStockCopyWith<$Res> {
  factory $OnlinePickCollectionStockCopyWith(OnlinePickCollectionStock value,
          $Res Function(OnlinePickCollectionStock) then) =
      _$OnlinePickCollectionStockCopyWithImpl<$Res, OnlinePickCollectionStock>;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'stockid') String stockId,
      @HiveField(1) @JsonKey(name: 'matcode') String materialCode,
      @HiveField(2) @JsonKey(name: 'batchno') String? batchNo,
      @HiveField(3) @JsonKey(name: 'sn') String? serialNumber,
      @HiveField(4) @JsonKey(name: 'taskQty') num taskQty,
      @HiveField(5) @JsonKey(name: 'collectQty') num collectQty,
      @HiveField(6) @JsonKey(name: 'outtaskitemid') String outTaskItemId,
      @HiveField(7) @JsonKey(name: 'taskid') String taskId,
      @HiveField(8) @JsonKey(name: 'storeRoom') String? storeRoom,
      @HiveField(9) @JsonKey(name: 'storeSite') String? storeSite,
      @HiveField(10) @JsonKey(name: 'erpStore') String? erpStore,
      @HiveField(11) @JsonKey(name: 'trayNo') String? trayNo});
}

/// @nodoc
class _$OnlinePickCollectionStockCopyWithImpl<$Res,
        $Val extends OnlinePickCollectionStock>
    implements $OnlinePickCollectionStockCopyWith<$Res> {
  _$OnlinePickCollectionStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? materialCode = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? taskQty = null,
    Object? collectQty = null,
    Object? outTaskItemId = null,
    Object? taskId = null,
    Object? storeRoom = freezed,
    Object? storeSite = freezed,
    Object? erpStore = freezed,
    Object? trayNo = freezed,
  }) {
    return _then(_value.copyWith(
      stockId: null == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as num,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as num,
      outTaskItemId: null == outTaskItemId
          ? _value.outTaskItemId
          : outTaskItemId // ignore: cast_nullable_to_non_nullable
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
      trayNo: freezed == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickCollectionStockImplCopyWith<$Res>
    implements $OnlinePickCollectionStockCopyWith<$Res> {
  factory _$$OnlinePickCollectionStockImplCopyWith(
          _$OnlinePickCollectionStockImpl value,
          $Res Function(_$OnlinePickCollectionStockImpl) then) =
      __$$OnlinePickCollectionStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'stockid') String stockId,
      @HiveField(1) @JsonKey(name: 'matcode') String materialCode,
      @HiveField(2) @JsonKey(name: 'batchno') String? batchNo,
      @HiveField(3) @JsonKey(name: 'sn') String? serialNumber,
      @HiveField(4) @JsonKey(name: 'taskQty') num taskQty,
      @HiveField(5) @JsonKey(name: 'collectQty') num collectQty,
      @HiveField(6) @JsonKey(name: 'outtaskitemid') String outTaskItemId,
      @HiveField(7) @JsonKey(name: 'taskid') String taskId,
      @HiveField(8) @JsonKey(name: 'storeRoom') String? storeRoom,
      @HiveField(9) @JsonKey(name: 'storeSite') String? storeSite,
      @HiveField(10) @JsonKey(name: 'erpStore') String? erpStore,
      @HiveField(11) @JsonKey(name: 'trayNo') String? trayNo});
}

/// @nodoc
class __$$OnlinePickCollectionStockImplCopyWithImpl<$Res>
    extends _$OnlinePickCollectionStockCopyWithImpl<$Res,
        _$OnlinePickCollectionStockImpl>
    implements _$$OnlinePickCollectionStockImplCopyWith<$Res> {
  __$$OnlinePickCollectionStockImplCopyWithImpl(
      _$OnlinePickCollectionStockImpl _value,
      $Res Function(_$OnlinePickCollectionStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? materialCode = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? taskQty = null,
    Object? collectQty = null,
    Object? outTaskItemId = null,
    Object? taskId = null,
    Object? storeRoom = freezed,
    Object? storeSite = freezed,
    Object? erpStore = freezed,
    Object? trayNo = freezed,
  }) {
    return _then(_$OnlinePickCollectionStockImpl(
      stockId: null == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as num,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as num,
      outTaskItemId: null == outTaskItemId
          ? _value.outTaskItemId
          : outTaskItemId // ignore: cast_nullable_to_non_nullable
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
      trayNo: freezed == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickCollectionStockImpl implements _OnlinePickCollectionStock {
  const _$OnlinePickCollectionStockImpl(
      {@HiveField(0) @JsonKey(name: 'stockid') required this.stockId,
      @HiveField(1) @JsonKey(name: 'matcode') required this.materialCode,
      @HiveField(2) @JsonKey(name: 'batchno') this.batchNo,
      @HiveField(3) @JsonKey(name: 'sn') this.serialNumber,
      @HiveField(4) @JsonKey(name: 'taskQty') this.taskQty = 0,
      @HiveField(5) @JsonKey(name: 'collectQty') this.collectQty = 0,
      @HiveField(6) @JsonKey(name: 'outtaskitemid') required this.outTaskItemId,
      @HiveField(7) @JsonKey(name: 'taskid') required this.taskId,
      @HiveField(8) @JsonKey(name: 'storeRoom') this.storeRoom,
      @HiveField(9) @JsonKey(name: 'storeSite') this.storeSite,
      @HiveField(10) @JsonKey(name: 'erpStore') this.erpStore,
      @HiveField(11) @JsonKey(name: 'trayNo') this.trayNo});

  factory _$OnlinePickCollectionStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickCollectionStockImplFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: 'stockid')
  final String stockId;
  @override
  @HiveField(1)
  @JsonKey(name: 'matcode')
  final String materialCode;
  @override
  @HiveField(2)
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @HiveField(3)
  @JsonKey(name: 'sn')
  final String? serialNumber;
  @override
  @HiveField(4)
  @JsonKey(name: 'taskQty')
  final num taskQty;
  @override
  @HiveField(5)
  @JsonKey(name: 'collectQty')
  final num collectQty;
  @override
  @HiveField(6)
  @JsonKey(name: 'outtaskitemid')
  final String outTaskItemId;
  @override
  @HiveField(7)
  @JsonKey(name: 'taskid')
  final String taskId;
  @override
  @HiveField(8)
  @JsonKey(name: 'storeRoom')
  final String? storeRoom;
  @override
  @HiveField(9)
  @JsonKey(name: 'storeSite')
  final String? storeSite;
  @override
  @HiveField(10)
  @JsonKey(name: 'erpStore')
  final String? erpStore;
  @override
  @HiveField(11)
  @JsonKey(name: 'trayNo')
  final String? trayNo;

  @override
  String toString() {
    return 'OnlinePickCollectionStock(stockId: $stockId, materialCode: $materialCode, batchNo: $batchNo, serialNumber: $serialNumber, taskQty: $taskQty, collectQty: $collectQty, outTaskItemId: $outTaskItemId, taskId: $taskId, storeRoom: $storeRoom, storeSite: $storeSite, erpStore: $erpStore, trayNo: $trayNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickCollectionStockImpl &&
            (identical(other.stockId, stockId) || other.stockId == stockId) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.collectQty, collectQty) ||
                other.collectQty == collectQty) &&
            (identical(other.outTaskItemId, outTaskItemId) ||
                other.outTaskItemId == outTaskItemId) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.erpStore, erpStore) ||
                other.erpStore == erpStore) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stockId,
      materialCode,
      batchNo,
      serialNumber,
      taskQty,
      collectQty,
      outTaskItemId,
      taskId,
      storeRoom,
      storeSite,
      erpStore,
      trayNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickCollectionStockImplCopyWith<_$OnlinePickCollectionStockImpl>
      get copyWith => __$$OnlinePickCollectionStockImplCopyWithImpl<
          _$OnlinePickCollectionStockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickCollectionStockImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickCollectionStock implements OnlinePickCollectionStock {
  const factory _OnlinePickCollectionStock(
      {@HiveField(0) @JsonKey(name: 'stockid') required final String stockId,
      @HiveField(1)
      @JsonKey(name: 'matcode')
      required final String materialCode,
      @HiveField(2) @JsonKey(name: 'batchno') final String? batchNo,
      @HiveField(3) @JsonKey(name: 'sn') final String? serialNumber,
      @HiveField(4) @JsonKey(name: 'taskQty') final num taskQty,
      @HiveField(5) @JsonKey(name: 'collectQty') final num collectQty,
      @HiveField(6)
      @JsonKey(name: 'outtaskitemid')
      required final String outTaskItemId,
      @HiveField(7) @JsonKey(name: 'taskid') required final String taskId,
      @HiveField(8) @JsonKey(name: 'storeRoom') final String? storeRoom,
      @HiveField(9) @JsonKey(name: 'storeSite') final String? storeSite,
      @HiveField(10) @JsonKey(name: 'erpStore') final String? erpStore,
      @HiveField(11)
      @JsonKey(name: 'trayNo')
      final String? trayNo}) = _$OnlinePickCollectionStockImpl;

  factory _OnlinePickCollectionStock.fromJson(Map<String, dynamic> json) =
      _$OnlinePickCollectionStockImpl.fromJson;

  @override
  @HiveField(0)
  @JsonKey(name: 'stockid')
  String get stockId;
  @override
  @HiveField(1)
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override
  @HiveField(2)
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @HiveField(3)
  @JsonKey(name: 'sn')
  String? get serialNumber;
  @override
  @HiveField(4)
  @JsonKey(name: 'taskQty')
  num get taskQty;
  @override
  @HiveField(5)
  @JsonKey(name: 'collectQty')
  num get collectQty;
  @override
  @HiveField(6)
  @JsonKey(name: 'outtaskitemid')
  String get outTaskItemId;
  @override
  @HiveField(7)
  @JsonKey(name: 'taskid')
  String get taskId;
  @override
  @HiveField(8)
  @JsonKey(name: 'storeRoom')
  String? get storeRoom;
  @override
  @HiveField(9)
  @JsonKey(name: 'storeSite')
  String? get storeSite;
  @override
  @HiveField(10)
  @JsonKey(name: 'erpStore')
  String? get erpStore;
  @override
  @HiveField(11)
  @JsonKey(name: 'trayNo')
  String? get trayNo;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickCollectionStockImplCopyWith<_$OnlinePickCollectionStockImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OnlinePickCollectionMode {
  String get code => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  OnlinePickCollectionModeType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnlinePickCollectionModeCopyWith<OnlinePickCollectionMode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickCollectionModeCopyWith<$Res> {
  factory $OnlinePickCollectionModeCopyWith(OnlinePickCollectionMode value,
          $Res Function(OnlinePickCollectionMode) then) =
      _$OnlinePickCollectionModeCopyWithImpl<$Res, OnlinePickCollectionMode>;
  @useResult
  $Res call({String code, String label, OnlinePickCollectionModeType type});
}

/// @nodoc
class _$OnlinePickCollectionModeCopyWithImpl<$Res,
        $Val extends OnlinePickCollectionMode>
    implements $OnlinePickCollectionModeCopyWith<$Res> {
  _$OnlinePickCollectionModeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? label = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OnlinePickCollectionModeType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickCollectionModeImplCopyWith<$Res>
    implements $OnlinePickCollectionModeCopyWith<$Res> {
  factory _$$OnlinePickCollectionModeImplCopyWith(
          _$OnlinePickCollectionModeImpl value,
          $Res Function(_$OnlinePickCollectionModeImpl) then) =
      __$$OnlinePickCollectionModeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String label, OnlinePickCollectionModeType type});
}

/// @nodoc
class __$$OnlinePickCollectionModeImplCopyWithImpl<$Res>
    extends _$OnlinePickCollectionModeCopyWithImpl<$Res,
        _$OnlinePickCollectionModeImpl>
    implements _$$OnlinePickCollectionModeImplCopyWith<$Res> {
  __$$OnlinePickCollectionModeImplCopyWithImpl(
      _$OnlinePickCollectionModeImpl _value,
      $Res Function(_$OnlinePickCollectionModeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? label = null,
    Object? type = null,
  }) {
    return _then(_$OnlinePickCollectionModeImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OnlinePickCollectionModeType,
    ));
  }
}

/// @nodoc

class _$OnlinePickCollectionModeImpl implements _OnlinePickCollectionMode {
  const _$OnlinePickCollectionModeImpl(
      {required this.code,
      required this.label,
      this.type = OnlinePickCollectionModeType.outbound});

  @override
  final String code;
  @override
  final String label;
  @override
  @JsonKey()
  final OnlinePickCollectionModeType type;

  @override
  String toString() {
    return 'OnlinePickCollectionMode(code: $code, label: $label, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickCollectionModeImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, label, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickCollectionModeImplCopyWith<_$OnlinePickCollectionModeImpl>
      get copyWith => __$$OnlinePickCollectionModeImplCopyWithImpl<
          _$OnlinePickCollectionModeImpl>(this, _$identity);
}

abstract class _OnlinePickCollectionMode implements OnlinePickCollectionMode {
  const factory _OnlinePickCollectionMode(
          {required final String code,
          required final String label,
          final OnlinePickCollectionModeType type}) =
      _$OnlinePickCollectionModeImpl;

  @override
  String get code;
  @override
  String get label;
  @override
  OnlinePickCollectionModeType get type;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickCollectionModeImplCopyWith<_$OnlinePickCollectionModeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickLocationOption _$OnlinePickLocationOptionFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickLocationOption.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickLocationOption {
  @JsonKey(name: 'label')
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'value')
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickLocationOptionCopyWith<OnlinePickLocationOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickLocationOptionCopyWith<$Res> {
  factory $OnlinePickLocationOptionCopyWith(OnlinePickLocationOption value,
          $Res Function(OnlinePickLocationOption) then) =
      _$OnlinePickLocationOptionCopyWithImpl<$Res, OnlinePickLocationOption>;
  @useResult
  $Res call(
      {@JsonKey(name: 'label') String label,
      @JsonKey(name: 'value') String value});
}

/// @nodoc
class _$OnlinePickLocationOptionCopyWithImpl<$Res,
        $Val extends OnlinePickLocationOption>
    implements $OnlinePickLocationOptionCopyWith<$Res> {
  _$OnlinePickLocationOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickLocationOptionImplCopyWith<$Res>
    implements $OnlinePickLocationOptionCopyWith<$Res> {
  factory _$$OnlinePickLocationOptionImplCopyWith(
          _$OnlinePickLocationOptionImpl value,
          $Res Function(_$OnlinePickLocationOptionImpl) then) =
      __$$OnlinePickLocationOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'label') String label,
      @JsonKey(name: 'value') String value});
}

/// @nodoc
class __$$OnlinePickLocationOptionImplCopyWithImpl<$Res>
    extends _$OnlinePickLocationOptionCopyWithImpl<$Res,
        _$OnlinePickLocationOptionImpl>
    implements _$$OnlinePickLocationOptionImplCopyWith<$Res> {
  __$$OnlinePickLocationOptionImplCopyWithImpl(
      _$OnlinePickLocationOptionImpl _value,
      $Res Function(_$OnlinePickLocationOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_$OnlinePickLocationOptionImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickLocationOptionImpl implements _OnlinePickLocationOption {
  const _$OnlinePickLocationOptionImpl(
      {@JsonKey(name: 'label') required this.label,
      @JsonKey(name: 'value') required this.value});

  factory _$OnlinePickLocationOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickLocationOptionImplFromJson(json);

  @override
  @JsonKey(name: 'label')
  final String label;
  @override
  @JsonKey(name: 'value')
  final String value;

  @override
  String toString() {
    return 'OnlinePickLocationOption(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickLocationOptionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickLocationOptionImplCopyWith<_$OnlinePickLocationOptionImpl>
      get copyWith => __$$OnlinePickLocationOptionImplCopyWithImpl<
          _$OnlinePickLocationOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickLocationOptionImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickLocationOption implements OnlinePickLocationOption {
  const factory _OnlinePickLocationOption(
          {@JsonKey(name: 'label') required final String label,
          @JsonKey(name: 'value') required final String value}) =
      _$OnlinePickLocationOptionImpl;

  factory _OnlinePickLocationOption.fromJson(Map<String, dynamic> json) =
      _$OnlinePickLocationOptionImpl.fromJson;

  @override
  @JsonKey(name: 'label')
  String get label;
  @override
  @JsonKey(name: 'value')
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickLocationOptionImplCopyWith<_$OnlinePickLocationOptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickCollectionQuery _$OnlinePickCollectionQueryFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickCollectionQuery.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickCollectionQuery {
  @JsonKey(name: 'outtaskno')
  String get outTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'forcesite')
  String get forceSite => throw _privateConstructorUsedError;
  @JsonKey(name: 'forcebatch')
  String get forceBatch => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskcomment')
  String get taskComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'roomtag')
  String get roomTag => throw _privateConstructorUsedError;
  @JsonKey(name: 'workstation')
  String get workStation => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortType')
  String get sortType => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortColumn')
  String get sortColumn => throw _privateConstructorUsedError;
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'beatflag')
  String get beatFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'collecter')
  int get collector => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickCollectionQueryCopyWith<OnlinePickCollectionQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickCollectionQueryCopyWith<$Res> {
  factory $OnlinePickCollectionQueryCopyWith(OnlinePickCollectionQuery value,
          $Res Function(OnlinePickCollectionQuery) then) =
      _$OnlinePickCollectionQueryCopyWithImpl<$Res, OnlinePickCollectionQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'forcesite') String forceSite,
      @JsonKey(name: 'forcebatch') String forceBatch,
      @JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'roomtag') String roomTag,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'collecter') int collector});
}

/// @nodoc
class _$OnlinePickCollectionQueryCopyWithImpl<$Res,
        $Val extends OnlinePickCollectionQuery>
    implements $OnlinePickCollectionQueryCopyWith<$Res> {
  _$OnlinePickCollectionQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskNo = null,
    Object? storeRoomNo = null,
    Object? forceSite = null,
    Object? forceBatch = null,
    Object? taskComment = null,
    Object? finishFlag = null,
    Object? roomTag = null,
    Object? workStation = null,
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? beatFlag = null,
    Object? collector = null,
  }) {
    return _then(_value.copyWith(
      outTaskNo: null == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      forceSite: null == forceSite
          ? _value.forceSite
          : forceSite // ignore: cast_nullable_to_non_nullable
              as String,
      forceBatch: null == forceBatch
          ? _value.forceBatch
          : forceBatch // ignore: cast_nullable_to_non_nullable
              as String,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as String,
      sortColumn: null == sortColumn
          ? _value.sortColumn
          : sortColumn // ignore: cast_nullable_to_non_nullable
              as String,
      searchKey: null == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
      beatFlag: null == beatFlag
          ? _value.beatFlag
          : beatFlag // ignore: cast_nullable_to_non_nullable
              as String,
      collector: null == collector
          ? _value.collector
          : collector // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickCollectionQueryImplCopyWith<$Res>
    implements $OnlinePickCollectionQueryCopyWith<$Res> {
  factory _$$OnlinePickCollectionQueryImplCopyWith(
          _$OnlinePickCollectionQueryImpl value,
          $Res Function(_$OnlinePickCollectionQueryImpl) then) =
      __$$OnlinePickCollectionQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'forcesite') String forceSite,
      @JsonKey(name: 'forcebatch') String forceBatch,
      @JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'roomtag') String roomTag,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'collecter') int collector});
}

/// @nodoc
class __$$OnlinePickCollectionQueryImplCopyWithImpl<$Res>
    extends _$OnlinePickCollectionQueryCopyWithImpl<$Res,
        _$OnlinePickCollectionQueryImpl>
    implements _$$OnlinePickCollectionQueryImplCopyWith<$Res> {
  __$$OnlinePickCollectionQueryImplCopyWithImpl(
      _$OnlinePickCollectionQueryImpl _value,
      $Res Function(_$OnlinePickCollectionQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskNo = null,
    Object? storeRoomNo = null,
    Object? forceSite = null,
    Object? forceBatch = null,
    Object? taskComment = null,
    Object? finishFlag = null,
    Object? roomTag = null,
    Object? workStation = null,
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? beatFlag = null,
    Object? collector = null,
  }) {
    return _then(_$OnlinePickCollectionQueryImpl(
      outTaskNo: null == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      forceSite: null == forceSite
          ? _value.forceSite
          : forceSite // ignore: cast_nullable_to_non_nullable
              as String,
      forceBatch: null == forceBatch
          ? _value.forceBatch
          : forceBatch // ignore: cast_nullable_to_non_nullable
              as String,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      sortType: null == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as String,
      sortColumn: null == sortColumn
          ? _value.sortColumn
          : sortColumn // ignore: cast_nullable_to_non_nullable
              as String,
      searchKey: null == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
      beatFlag: null == beatFlag
          ? _value.beatFlag
          : beatFlag // ignore: cast_nullable_to_non_nullable
              as String,
      collector: null == collector
          ? _value.collector
          : collector // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickCollectionQueryImpl implements _OnlinePickCollectionQuery {
  const _$OnlinePickCollectionQueryImpl(
      {@JsonKey(name: 'outtaskno') this.outTaskNo = '',
      @JsonKey(name: 'storeroomno') this.storeRoomNo = '',
      @JsonKey(name: 'forcesite') this.forceSite = '',
      @JsonKey(name: 'forcebatch') this.forceBatch = '',
      @JsonKey(name: 'taskcomment') this.taskComment = '',
      @JsonKey(name: 'finshFlg') this.finishFlag = '0',
      @JsonKey(name: 'roomtag') this.roomTag = '1',
      @JsonKey(name: 'workstation') this.workStation = '',
      @JsonKey(name: 'sortType') this.sortType = '',
      @JsonKey(name: 'sortColumn') this.sortColumn = '',
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'beatflag') this.beatFlag = 'N',
      @JsonKey(name: 'collecter') this.collector = 0});

  factory _$OnlinePickCollectionQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickCollectionQueryImplFromJson(json);

  @override
  @JsonKey(name: 'outtaskno')
  final String outTaskNo;
  @override
  @JsonKey(name: 'storeroomno')
  final String storeRoomNo;
  @override
  @JsonKey(name: 'forcesite')
  final String forceSite;
  @override
  @JsonKey(name: 'forcebatch')
  final String forceBatch;
  @override
  @JsonKey(name: 'taskcomment')
  final String taskComment;
  @override
  @JsonKey(name: 'finshFlg')
  final String finishFlag;
  @override
  @JsonKey(name: 'roomtag')
  final String roomTag;
  @override
  @JsonKey(name: 'workstation')
  final String workStation;
  @override
  @JsonKey(name: 'sortType')
  final String sortType;
  @override
  @JsonKey(name: 'sortColumn')
  final String sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  final String searchKey;
  @override
  @JsonKey(name: 'beatflag')
  final String beatFlag;
  @override
  @JsonKey(name: 'collecter')
  final int collector;

  @override
  String toString() {
    return 'OnlinePickCollectionQuery(outTaskNo: $outTaskNo, storeRoomNo: $storeRoomNo, forceSite: $forceSite, forceBatch: $forceBatch, taskComment: $taskComment, finishFlag: $finishFlag, roomTag: $roomTag, workStation: $workStation, sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, beatFlag: $beatFlag, collector: $collector)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickCollectionQueryImpl &&
            (identical(other.outTaskNo, outTaskNo) ||
                other.outTaskNo == outTaskNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.forceSite, forceSite) ||
                other.forceSite == forceSite) &&
            (identical(other.forceBatch, forceBatch) ||
                other.forceBatch == forceBatch) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.finishFlag, finishFlag) ||
                other.finishFlag == finishFlag) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.sortColumn, sortColumn) ||
                other.sortColumn == sortColumn) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.beatFlag, beatFlag) ||
                other.beatFlag == beatFlag) &&
            (identical(other.collector, collector) ||
                other.collector == collector));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      outTaskNo,
      storeRoomNo,
      forceSite,
      forceBatch,
      taskComment,
      finishFlag,
      roomTag,
      workStation,
      sortType,
      sortColumn,
      searchKey,
      beatFlag,
      collector);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickCollectionQueryImplCopyWith<_$OnlinePickCollectionQueryImpl>
      get copyWith => __$$OnlinePickCollectionQueryImplCopyWithImpl<
          _$OnlinePickCollectionQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickCollectionQueryImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickCollectionQuery implements OnlinePickCollectionQuery {
  const factory _OnlinePickCollectionQuery(
          {@JsonKey(name: 'outtaskno') final String outTaskNo,
          @JsonKey(name: 'storeroomno') final String storeRoomNo,
          @JsonKey(name: 'forcesite') final String forceSite,
          @JsonKey(name: 'forcebatch') final String forceBatch,
          @JsonKey(name: 'taskcomment') final String taskComment,
          @JsonKey(name: 'finshFlg') final String finishFlag,
          @JsonKey(name: 'roomtag') final String roomTag,
          @JsonKey(name: 'workstation') final String workStation,
          @JsonKey(name: 'sortType') final String sortType,
          @JsonKey(name: 'sortColumn') final String sortColumn,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'beatflag') final String beatFlag,
          @JsonKey(name: 'collecter') final int collector}) =
      _$OnlinePickCollectionQueryImpl;

  factory _OnlinePickCollectionQuery.fromJson(Map<String, dynamic> json) =
      _$OnlinePickCollectionQueryImpl.fromJson;

  @override
  @JsonKey(name: 'outtaskno')
  String get outTaskNo;
  @override
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo;
  @override
  @JsonKey(name: 'forcesite')
  String get forceSite;
  @override
  @JsonKey(name: 'forcebatch')
  String get forceBatch;
  @override
  @JsonKey(name: 'taskcomment')
  String get taskComment;
  @override
  @JsonKey(name: 'finshFlg')
  String get finishFlag;
  @override
  @JsonKey(name: 'roomtag')
  String get roomTag;
  @override
  @JsonKey(name: 'workstation')
  String get workStation;
  @override
  @JsonKey(name: 'sortType')
  String get sortType;
  @override
  @JsonKey(name: 'sortColumn')
  String get sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  String get searchKey;
  @override
  @JsonKey(name: 'beatflag')
  String get beatFlag;
  @override
  @JsonKey(name: 'collecter')
  int get collector;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickCollectionQueryImplCopyWith<_$OnlinePickCollectionQueryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickTrayConfirm _$OnlinePickTrayConfirmFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickTrayConfirm.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTrayConfirm {
  String get trayNo => throw _privateConstructorUsedError;
  num get expectedQuantity => throw _privateConstructorUsedError;
  num get confirmedQuantity => throw _privateConstructorUsedError;
  String get operatorId => throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTrayConfirmCopyWith<OnlinePickTrayConfirm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTrayConfirmCopyWith<$Res> {
  factory $OnlinePickTrayConfirmCopyWith(OnlinePickTrayConfirm value,
          $Res Function(OnlinePickTrayConfirm) then) =
      _$OnlinePickTrayConfirmCopyWithImpl<$Res, OnlinePickTrayConfirm>;
  @useResult
  $Res call(
      {String trayNo,
      num expectedQuantity,
      num confirmedQuantity,
      String operatorId,
      DateTime? confirmedAt});
}

/// @nodoc
class _$OnlinePickTrayConfirmCopyWithImpl<$Res,
        $Val extends OnlinePickTrayConfirm>
    implements $OnlinePickTrayConfirmCopyWith<$Res> {
  _$OnlinePickTrayConfirmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trayNo = null,
    Object? expectedQuantity = null,
    Object? confirmedQuantity = null,
    Object? operatorId = null,
    Object? confirmedAt = freezed,
  }) {
    return _then(_value.copyWith(
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      expectedQuantity: null == expectedQuantity
          ? _value.expectedQuantity
          : expectedQuantity // ignore: cast_nullable_to_non_nullable
              as num,
      confirmedQuantity: null == confirmedQuantity
          ? _value.confirmedQuantity
          : confirmedQuantity // ignore: cast_nullable_to_non_nullable
              as num,
      operatorId: null == operatorId
          ? _value.operatorId
          : operatorId // ignore: cast_nullable_to_non_nullable
              as String,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTrayConfirmImplCopyWith<$Res>
    implements $OnlinePickTrayConfirmCopyWith<$Res> {
  factory _$$OnlinePickTrayConfirmImplCopyWith(
          _$OnlinePickTrayConfirmImpl value,
          $Res Function(_$OnlinePickTrayConfirmImpl) then) =
      __$$OnlinePickTrayConfirmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String trayNo,
      num expectedQuantity,
      num confirmedQuantity,
      String operatorId,
      DateTime? confirmedAt});
}

/// @nodoc
class __$$OnlinePickTrayConfirmImplCopyWithImpl<$Res>
    extends _$OnlinePickTrayConfirmCopyWithImpl<$Res,
        _$OnlinePickTrayConfirmImpl>
    implements _$$OnlinePickTrayConfirmImplCopyWith<$Res> {
  __$$OnlinePickTrayConfirmImplCopyWithImpl(_$OnlinePickTrayConfirmImpl _value,
      $Res Function(_$OnlinePickTrayConfirmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trayNo = null,
    Object? expectedQuantity = null,
    Object? confirmedQuantity = null,
    Object? operatorId = null,
    Object? confirmedAt = freezed,
  }) {
    return _then(_$OnlinePickTrayConfirmImpl(
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      expectedQuantity: null == expectedQuantity
          ? _value.expectedQuantity
          : expectedQuantity // ignore: cast_nullable_to_non_nullable
              as num,
      confirmedQuantity: null == confirmedQuantity
          ? _value.confirmedQuantity
          : confirmedQuantity // ignore: cast_nullable_to_non_nullable
              as num,
      operatorId: null == operatorId
          ? _value.operatorId
          : operatorId // ignore: cast_nullable_to_non_nullable
              as String,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTrayConfirmImpl implements _OnlinePickTrayConfirm {
  const _$OnlinePickTrayConfirmImpl(
      {required this.trayNo,
      this.expectedQuantity = 0,
      this.confirmedQuantity = 0,
      this.operatorId = '',
      this.confirmedAt});

  factory _$OnlinePickTrayConfirmImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickTrayConfirmImplFromJson(json);

  @override
  final String trayNo;
  @override
  @JsonKey()
  final num expectedQuantity;
  @override
  @JsonKey()
  final num confirmedQuantity;
  @override
  @JsonKey()
  final String operatorId;
  @override
  final DateTime? confirmedAt;

  @override
  String toString() {
    return 'OnlinePickTrayConfirm(trayNo: $trayNo, expectedQuantity: $expectedQuantity, confirmedQuantity: $confirmedQuantity, operatorId: $operatorId, confirmedAt: $confirmedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTrayConfirmImpl &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.expectedQuantity, expectedQuantity) ||
                other.expectedQuantity == expectedQuantity) &&
            (identical(other.confirmedQuantity, confirmedQuantity) ||
                other.confirmedQuantity == confirmedQuantity) &&
            (identical(other.operatorId, operatorId) ||
                other.operatorId == operatorId) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, trayNo, expectedQuantity,
      confirmedQuantity, operatorId, confirmedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickTrayConfirmImplCopyWith<_$OnlinePickTrayConfirmImpl>
      get copyWith => __$$OnlinePickTrayConfirmImplCopyWithImpl<
          _$OnlinePickTrayConfirmImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTrayConfirmImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTrayConfirm implements OnlinePickTrayConfirm {
  const factory _OnlinePickTrayConfirm(
      {required final String trayNo,
      final num expectedQuantity,
      final num confirmedQuantity,
      final String operatorId,
      final DateTime? confirmedAt}) = _$OnlinePickTrayConfirmImpl;

  factory _OnlinePickTrayConfirm.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTrayConfirmImpl.fromJson;

  @override
  String get trayNo;
  @override
  num get expectedQuantity;
  @override
  num get confirmedQuantity;
  @override
  String get operatorId;
  @override
  DateTime? get confirmedAt;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTrayConfirmImplCopyWith<_$OnlinePickTrayConfirmImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickCollectionCacheSnapshot _$OnlinePickCollectionCacheSnapshotFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickCollectionCacheSnapshot.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickCollectionCacheSnapshot {
  @HiveField(0)
  List<OnlinePickCollectionStock> get stocks =>
      throw _privateConstructorUsedError;
  @HiveField(1)
  Map<String, String> get dicSeq => throw _privateConstructorUsedError;
  @HiveField(2)
  Map<String, List<double>> get dicMtlQty => throw _privateConstructorUsedError;
  @HiveField(3)
  Map<String, double> get dicInvMtlQty => throw _privateConstructorUsedError;
  @HiveField(4)
  OnlinePickBarcodeContent? get lastBarcode =>
      throw _privateConstructorUsedError;
  @HiveField(5)
  String get location => throw _privateConstructorUsedError;
  @HiveField(6)
  String get trayNo => throw _privateConstructorUsedError;
  @HiveField(7)
  int get userId => throw _privateConstructorUsedError;
  @HiveField(8)
  num? get pendingQuantity => throw _privateConstructorUsedError;
  @HiveField(9)
  String get mode => throw _privateConstructorUsedError;
  @HiveField(10)
  String get expectedErpStore => throw _privateConstructorUsedError;
  @HiveField(11)
  List<Map<String, dynamic>> get inventoryChecks =>
      throw _privateConstructorUsedError;
  @HiveField(12)
  String get destination => throw _privateConstructorUsedError;
  @HiveField(13)
  bool get inventoryPending => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get pendingStoreSite => throw _privateConstructorUsedError;
  @HiveField(15)
  String? get pendingMaterialCode => throw _privateConstructorUsedError;
  @HiveField(16)
  String? get pendingBatchNo => throw _privateConstructorUsedError;
  @HiveField(17)
  String? get pendingTrayNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickCollectionCacheSnapshotCopyWith<OnlinePickCollectionCacheSnapshot>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickCollectionCacheSnapshotCopyWith<$Res> {
  factory $OnlinePickCollectionCacheSnapshotCopyWith(
          OnlinePickCollectionCacheSnapshot value,
          $Res Function(OnlinePickCollectionCacheSnapshot) then) =
      _$OnlinePickCollectionCacheSnapshotCopyWithImpl<$Res,
          OnlinePickCollectionCacheSnapshot>;
  @useResult
  $Res call(
      {@HiveField(0) List<OnlinePickCollectionStock> stocks,
      @HiveField(1) Map<String, String> dicSeq,
      @HiveField(2) Map<String, List<double>> dicMtlQty,
      @HiveField(3) Map<String, double> dicInvMtlQty,
      @HiveField(4) OnlinePickBarcodeContent? lastBarcode,
      @HiveField(5) String location,
      @HiveField(6) String trayNo,
      @HiveField(7) int userId,
      @HiveField(8) num? pendingQuantity,
      @HiveField(9) String mode,
      @HiveField(10) String expectedErpStore,
      @HiveField(11) List<Map<String, dynamic>> inventoryChecks,
      @HiveField(12) String destination,
      @HiveField(13) bool inventoryPending,
      @HiveField(14) String? pendingStoreSite,
      @HiveField(15) String? pendingMaterialCode,
      @HiveField(16) String? pendingBatchNo,
      @HiveField(17) String? pendingTrayNo});

  $OnlinePickBarcodeContentCopyWith<$Res>? get lastBarcode;
}

/// @nodoc
class _$OnlinePickCollectionCacheSnapshotCopyWithImpl<$Res,
        $Val extends OnlinePickCollectionCacheSnapshot>
    implements $OnlinePickCollectionCacheSnapshotCopyWith<$Res> {
  _$OnlinePickCollectionCacheSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
    Object? dicSeq = null,
    Object? dicMtlQty = null,
    Object? dicInvMtlQty = null,
    Object? lastBarcode = freezed,
    Object? location = null,
    Object? trayNo = null,
    Object? userId = null,
    Object? pendingQuantity = freezed,
    Object? mode = null,
    Object? expectedErpStore = null,
    Object? inventoryChecks = null,
    Object? destination = null,
    Object? inventoryPending = null,
    Object? pendingStoreSite = freezed,
    Object? pendingMaterialCode = freezed,
    Object? pendingBatchNo = freezed,
    Object? pendingTrayNo = freezed,
  }) {
    return _then(_value.copyWith(
      stocks: null == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<OnlinePickCollectionStock>,
      dicSeq: null == dicSeq
          ? _value.dicSeq
          : dicSeq // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      dicMtlQty: null == dicMtlQty
          ? _value.dicMtlQty
          : dicMtlQty // ignore: cast_nullable_to_non_nullable
              as Map<String, List<double>>,
      dicInvMtlQty: null == dicInvMtlQty
          ? _value.dicInvMtlQty
          : dicInvMtlQty // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      lastBarcode: freezed == lastBarcode
          ? _value.lastBarcode
          : lastBarcode // ignore: cast_nullable_to_non_nullable
              as OnlinePickBarcodeContent?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pendingQuantity: freezed == pendingQuantity
          ? _value.pendingQuantity
          : pendingQuantity // ignore: cast_nullable_to_non_nullable
              as num?,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      expectedErpStore: null == expectedErpStore
          ? _value.expectedErpStore
          : expectedErpStore // ignore: cast_nullable_to_non_nullable
              as String,
      inventoryChecks: null == inventoryChecks
          ? _value.inventoryChecks
          : inventoryChecks // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      inventoryPending: null == inventoryPending
          ? _value.inventoryPending
          : inventoryPending // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingStoreSite: freezed == pendingStoreSite
          ? _value.pendingStoreSite
          : pendingStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingMaterialCode: freezed == pendingMaterialCode
          ? _value.pendingMaterialCode
          : pendingMaterialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingBatchNo: freezed == pendingBatchNo
          ? _value.pendingBatchNo
          : pendingBatchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingTrayNo: freezed == pendingTrayNo
          ? _value.pendingTrayNo
          : pendingTrayNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OnlinePickBarcodeContentCopyWith<$Res>? get lastBarcode {
    if (_value.lastBarcode == null) {
      return null;
    }

    return $OnlinePickBarcodeContentCopyWith<$Res>(_value.lastBarcode!,
        (value) {
      return _then(_value.copyWith(lastBarcode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnlinePickCollectionCacheSnapshotImplCopyWith<$Res>
    implements $OnlinePickCollectionCacheSnapshotCopyWith<$Res> {
  factory _$$OnlinePickCollectionCacheSnapshotImplCopyWith(
          _$OnlinePickCollectionCacheSnapshotImpl value,
          $Res Function(_$OnlinePickCollectionCacheSnapshotImpl) then) =
      __$$OnlinePickCollectionCacheSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<OnlinePickCollectionStock> stocks,
      @HiveField(1) Map<String, String> dicSeq,
      @HiveField(2) Map<String, List<double>> dicMtlQty,
      @HiveField(3) Map<String, double> dicInvMtlQty,
      @HiveField(4) OnlinePickBarcodeContent? lastBarcode,
      @HiveField(5) String location,
      @HiveField(6) String trayNo,
      @HiveField(7) int userId,
      @HiveField(8) num? pendingQuantity,
      @HiveField(9) String mode,
      @HiveField(10) String expectedErpStore,
      @HiveField(11) List<Map<String, dynamic>> inventoryChecks,
      @HiveField(12) String destination,
      @HiveField(13) bool inventoryPending,
      @HiveField(14) String? pendingStoreSite,
      @HiveField(15) String? pendingMaterialCode,
      @HiveField(16) String? pendingBatchNo,
      @HiveField(17) String? pendingTrayNo});

  @override
  $OnlinePickBarcodeContentCopyWith<$Res>? get lastBarcode;
}

/// @nodoc
class __$$OnlinePickCollectionCacheSnapshotImplCopyWithImpl<$Res>
    extends _$OnlinePickCollectionCacheSnapshotCopyWithImpl<$Res,
        _$OnlinePickCollectionCacheSnapshotImpl>
    implements _$$OnlinePickCollectionCacheSnapshotImplCopyWith<$Res> {
  __$$OnlinePickCollectionCacheSnapshotImplCopyWithImpl(
      _$OnlinePickCollectionCacheSnapshotImpl _value,
      $Res Function(_$OnlinePickCollectionCacheSnapshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = null,
    Object? dicSeq = null,
    Object? dicMtlQty = null,
    Object? dicInvMtlQty = null,
    Object? lastBarcode = freezed,
    Object? location = null,
    Object? trayNo = null,
    Object? userId = null,
    Object? pendingQuantity = freezed,
    Object? mode = null,
    Object? expectedErpStore = null,
    Object? inventoryChecks = null,
    Object? destination = null,
    Object? inventoryPending = null,
    Object? pendingStoreSite = freezed,
    Object? pendingMaterialCode = freezed,
    Object? pendingBatchNo = freezed,
    Object? pendingTrayNo = freezed,
  }) {
    return _then(_$OnlinePickCollectionCacheSnapshotImpl(
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<OnlinePickCollectionStock>,
      dicSeq: null == dicSeq
          ? _value._dicSeq
          : dicSeq // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      dicMtlQty: null == dicMtlQty
          ? _value._dicMtlQty
          : dicMtlQty // ignore: cast_nullable_to_non_nullable
              as Map<String, List<double>>,
      dicInvMtlQty: null == dicInvMtlQty
          ? _value._dicInvMtlQty
          : dicInvMtlQty // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      lastBarcode: freezed == lastBarcode
          ? _value.lastBarcode
          : lastBarcode // ignore: cast_nullable_to_non_nullable
              as OnlinePickBarcodeContent?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      pendingQuantity: freezed == pendingQuantity
          ? _value.pendingQuantity
          : pendingQuantity // ignore: cast_nullable_to_non_nullable
              as num?,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      expectedErpStore: null == expectedErpStore
          ? _value.expectedErpStore
          : expectedErpStore // ignore: cast_nullable_to_non_nullable
              as String,
      inventoryChecks: null == inventoryChecks
          ? _value._inventoryChecks
          : inventoryChecks // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
      inventoryPending: null == inventoryPending
          ? _value.inventoryPending
          : inventoryPending // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingStoreSite: freezed == pendingStoreSite
          ? _value.pendingStoreSite
          : pendingStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingMaterialCode: freezed == pendingMaterialCode
          ? _value.pendingMaterialCode
          : pendingMaterialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingBatchNo: freezed == pendingBatchNo
          ? _value.pendingBatchNo
          : pendingBatchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingTrayNo: freezed == pendingTrayNo
          ? _value.pendingTrayNo
          : pendingTrayNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickCollectionCacheSnapshotImpl
    implements _OnlinePickCollectionCacheSnapshot {
  const _$OnlinePickCollectionCacheSnapshotImpl(
      {@HiveField(0) final List<OnlinePickCollectionStock> stocks =
          const <OnlinePickCollectionStock>[],
      @HiveField(1) final Map<String, String> dicSeq = const <String, String>{},
      @HiveField(2) final Map<String, List<double>> dicMtlQty =
          const <String, List<double>>{},
      @HiveField(3)
      final Map<String, double> dicInvMtlQty = const <String, double>{},
      @HiveField(4) this.lastBarcode,
      @HiveField(5) this.location = '',
      @HiveField(6) this.trayNo = '',
      @HiveField(7) this.userId = 0,
      @HiveField(8) this.pendingQuantity,
      @HiveField(9) this.mode = 'outbound',
      @HiveField(10) this.expectedErpStore = '',
      @HiveField(11)
      final List<Map<String, dynamic>> inventoryChecks =
          const <Map<String, dynamic>>[],
      @HiveField(12) this.destination = '',
      @HiveField(13) this.inventoryPending = false,
      @HiveField(14) this.pendingStoreSite,
      @HiveField(15) this.pendingMaterialCode,
      @HiveField(16) this.pendingBatchNo,
      @HiveField(17) this.pendingTrayNo})
      : _stocks = stocks,
        _dicSeq = dicSeq,
        _dicMtlQty = dicMtlQty,
        _dicInvMtlQty = dicInvMtlQty,
        _inventoryChecks = inventoryChecks;

  factory _$OnlinePickCollectionCacheSnapshotImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OnlinePickCollectionCacheSnapshotImplFromJson(json);

  final List<OnlinePickCollectionStock> _stocks;
  @override
  @JsonKey()
  @HiveField(0)
  List<OnlinePickCollectionStock> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  final Map<String, String> _dicSeq;
  @override
  @JsonKey()
  @HiveField(1)
  Map<String, String> get dicSeq {
    if (_dicSeq is EqualUnmodifiableMapView) return _dicSeq;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dicSeq);
  }

  final Map<String, List<double>> _dicMtlQty;
  @override
  @JsonKey()
  @HiveField(2)
  Map<String, List<double>> get dicMtlQty {
    if (_dicMtlQty is EqualUnmodifiableMapView) return _dicMtlQty;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dicMtlQty);
  }

  final Map<String, double> _dicInvMtlQty;
  @override
  @JsonKey()
  @HiveField(3)
  Map<String, double> get dicInvMtlQty {
    if (_dicInvMtlQty is EqualUnmodifiableMapView) return _dicInvMtlQty;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dicInvMtlQty);
  }

  @override
  @HiveField(4)
  final OnlinePickBarcodeContent? lastBarcode;
  @override
  @JsonKey()
  @HiveField(5)
  final String location;
  @override
  @JsonKey()
  @HiveField(6)
  final String trayNo;
  @override
  @JsonKey()
  @HiveField(7)
  final int userId;
  @override
  @HiveField(8)
  final num? pendingQuantity;
  @override
  @JsonKey()
  @HiveField(9)
  final String mode;
  @override
  @JsonKey()
  @HiveField(10)
  final String expectedErpStore;
  final List<Map<String, dynamic>> _inventoryChecks;
  @override
  @JsonKey()
  @HiveField(11)
  List<Map<String, dynamic>> get inventoryChecks {
    if (_inventoryChecks is EqualUnmodifiableListView) {
      return _inventoryChecks;
    }
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inventoryChecks);
  }

  @override
  @JsonKey()
  @HiveField(12)
  final String destination;
  @override
  @JsonKey()
  @HiveField(13)
  final bool inventoryPending;
  @override
  @HiveField(14)
  final String? pendingStoreSite;
  @override
  @HiveField(15)
  final String? pendingMaterialCode;
  @override
  @HiveField(16)
  final String? pendingBatchNo;
  @override
  @HiveField(17)
  final String? pendingTrayNo;

  @override
  String toString() {
    return 'OnlinePickCollectionCacheSnapshot(stocks: $stocks, dicSeq: $dicSeq, dicMtlQty: $dicMtlQty, dicInvMtlQty: $dicInvMtlQty, lastBarcode: $lastBarcode, location: $location, trayNo: $trayNo, userId: $userId, pendingQuantity: $pendingQuantity, mode: $mode, expectedErpStore: $expectedErpStore, inventoryChecks: $inventoryChecks, destination: $destination, inventoryPending: $inventoryPending, pendingStoreSite: $pendingStoreSite, pendingMaterialCode: $pendingMaterialCode, pendingBatchNo: $pendingBatchNo, pendingTrayNo: $pendingTrayNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickCollectionCacheSnapshotImpl &&
            const DeepCollectionEquality().equals(other._stocks, _stocks) &&
            const DeepCollectionEquality().equals(other._dicSeq, _dicSeq) &&
            const DeepCollectionEquality()
                .equals(other._dicMtlQty, _dicMtlQty) &&
            const DeepCollectionEquality()
                .equals(other._dicInvMtlQty, _dicInvMtlQty) &&
            (identical(other.lastBarcode, lastBarcode) ||
                other.lastBarcode == lastBarcode) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pendingQuantity, pendingQuantity) ||
                other.pendingQuantity == pendingQuantity) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.expectedErpStore, expectedErpStore) ||
                other.expectedErpStore == expectedErpStore) &&
            const DeepCollectionEquality()
                .equals(other._inventoryChecks, _inventoryChecks) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.inventoryPending, inventoryPending) ||
                other.inventoryPending == inventoryPending) &&
            (identical(other.pendingStoreSite, pendingStoreSite) ||
                other.pendingStoreSite == pendingStoreSite) &&
            (identical(other.pendingMaterialCode, pendingMaterialCode) ||
                other.pendingMaterialCode == pendingMaterialCode) &&
            (identical(other.pendingBatchNo, pendingBatchNo) ||
                other.pendingBatchNo == pendingBatchNo) &&
            (identical(other.pendingTrayNo, pendingTrayNo) ||
                other.pendingTrayNo == pendingTrayNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_stocks),
      const DeepCollectionEquality().hash(_dicSeq),
      const DeepCollectionEquality().hash(_dicMtlQty),
          const DeepCollectionEquality().hash(_dicInvMtlQty),
          lastBarcode,
          location,
          trayNo,
          userId,
          pendingQuantity,
          mode,
          expectedErpStore,
          const DeepCollectionEquality().hash(_inventoryChecks),
          destination,
          inventoryPending,
          pendingStoreSite,
          pendingMaterialCode,
          pendingBatchNo,
          pendingTrayNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickCollectionCacheSnapshotImplCopyWith<
          _$OnlinePickCollectionCacheSnapshotImpl>
      get copyWith => __$$OnlinePickCollectionCacheSnapshotImplCopyWithImpl<
          _$OnlinePickCollectionCacheSnapshotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickCollectionCacheSnapshotImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickCollectionCacheSnapshot
    implements OnlinePickCollectionCacheSnapshot {
  const factory _OnlinePickCollectionCacheSnapshot(
          {@HiveField(0) final List<OnlinePickCollectionStock> stocks,
          @HiveField(1) final Map<String, String> dicSeq,
          @HiveField(2) final Map<String, List<double>> dicMtlQty,
          @HiveField(3) final Map<String, double> dicInvMtlQty,
          @HiveField(4) final OnlinePickBarcodeContent? lastBarcode,
          @HiveField(5) final String location,
          @HiveField(6) final String trayNo,
          @HiveField(7) final int userId,
          @HiveField(8) final num? pendingQuantity,
          @HiveField(9) final String mode,
          @HiveField(10) final String expectedErpStore,
          @HiveField(11) final List<Map<String, dynamic>> inventoryChecks,
          @HiveField(12) final String destination,
          @HiveField(13) final bool inventoryPending,
          @HiveField(14) final String? pendingStoreSite,
          @HiveField(15) final String? pendingMaterialCode,
          @HiveField(16) final String? pendingBatchNo,
          @HiveField(17) final String? pendingTrayNo}) =
      _$OnlinePickCollectionCacheSnapshotImpl;

  factory _OnlinePickCollectionCacheSnapshot.fromJson(
          Map<String, dynamic> json) =
      _$OnlinePickCollectionCacheSnapshotImpl.fromJson;

  @override
  @HiveField(0)
  List<OnlinePickCollectionStock> get stocks;
  @override
  @HiveField(1)
  Map<String, String> get dicSeq;
  @override
  @HiveField(2)
  Map<String, List<double>> get dicMtlQty;
  @override
  @HiveField(3)
  Map<String, double> get dicInvMtlQty;
  @override
  @HiveField(4)
  OnlinePickBarcodeContent? get lastBarcode;
  @override
  @HiveField(5)
  String get location;
  @override
  @HiveField(6)
  String get trayNo;
  @override
  @HiveField(7)
  int get userId;
  @override
  @HiveField(8)
  num? get pendingQuantity;
  @override
  @HiveField(9)
  String get mode;
  @override
  @HiveField(10)
  String get expectedErpStore;
  @override
  @HiveField(11)
  List<Map<String, dynamic>> get inventoryChecks;
  @override
  @HiveField(12)
  String get destination;
  @override
  @HiveField(13)
  bool get inventoryPending;
  @override
  @HiveField(14)
  String? get pendingStoreSite;
  @override
  @HiveField(15)
  String? get pendingMaterialCode;
  @override
  @HiveField(16)
  String? get pendingBatchNo;
  @override
  @HiveField(17)
  String? get pendingTrayNo;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickCollectionCacheSnapshotImplCopyWith<
          _$OnlinePickCollectionCacheSnapshotImpl>
      get copyWith => throw _privateConstructorUsedError;
}
