// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_collect_detail_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryCollectedItem _$InventoryCollectedItemFromJson(
    Map<String, dynamic> json) {
  return _InventoryCollectedItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryCollectedItem {
  /// 本地缓存记录ID
  @JsonKey(name: 'stockid')
  String get stockId => throw _privateConstructorUsedError;

  /// 对应的盘点任务明细ID
  @JsonKey(name: 'InvTaskItemid')
  String get invTaskItemId => throw _privateConstructorUsedError;

  /// 采集数量（源数量）
  @JsonKey(name: 'InventoryQty')
  double get sourceQty => throw _privateConstructorUsedError;

  /// 物料编码
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;

  /// 库房编码
  @JsonKey(name: 'storeRoom')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 库位编码
  @JsonKey(name: 'storeSite')
  String get storeSiteNo => throw _privateConstructorUsedError;

  /// 托盘号
  @JsonKey(name: 'TrayNo')
  String? get trayNo => throw _privateConstructorUsedError;

  /// 物料主数据ID
  @JsonKey(name: 'MatId')
  String? get materialId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCollectedItemCopyWith<InventoryCollectedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectedItemCopyWith<$Res> {
  factory $InventoryCollectedItemCopyWith(InventoryCollectedItem value,
          $Res Function(InventoryCollectedItem) then) =
      _$InventoryCollectedItemCopyWithImpl<$Res, InventoryCollectedItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'stockid') String stockId,
      @JsonKey(name: 'InvTaskItemid') String invTaskItemId,
      @JsonKey(name: 'InventoryQty') double sourceQty,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'storeRoom') String storeRoomNo,
      @JsonKey(name: 'storeSite') String storeSiteNo,
      @JsonKey(name: 'TrayNo') String? trayNo,
      @JsonKey(name: 'MatId') String? materialId});
}

/// @nodoc
class _$InventoryCollectedItemCopyWithImpl<$Res,
        $Val extends InventoryCollectedItem>
    implements $InventoryCollectedItemCopyWith<$Res> {
  _$InventoryCollectedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? invTaskItemId = null,
    Object? sourceQty = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? storeRoomNo = null,
    Object? storeSiteNo = null,
    Object? trayNo = freezed,
    Object? materialId = freezed,
  }) {
    return _then(_value.copyWith(
      stockId: null == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String,
      invTaskItemId: null == invTaskItemId
          ? _value.invTaskItemId
          : invTaskItemId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceQty: null == sourceQty
          ? _value.sourceQty
          : sourceQty // ignore: cast_nullable_to_non_nullable
              as double,
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
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: freezed == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialId: freezed == materialId
          ? _value.materialId
          : materialId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryCollectedItemImplCopyWith<$Res>
    implements $InventoryCollectedItemCopyWith<$Res> {
  factory _$$InventoryCollectedItemImplCopyWith(
          _$InventoryCollectedItemImpl value,
          $Res Function(_$InventoryCollectedItemImpl) then) =
      __$$InventoryCollectedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'stockid') String stockId,
      @JsonKey(name: 'InvTaskItemid') String invTaskItemId,
      @JsonKey(name: 'InventoryQty') double sourceQty,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'storeRoom') String storeRoomNo,
      @JsonKey(name: 'storeSite') String storeSiteNo,
      @JsonKey(name: 'TrayNo') String? trayNo,
      @JsonKey(name: 'MatId') String? materialId});
}

/// @nodoc
class __$$InventoryCollectedItemImplCopyWithImpl<$Res>
    extends _$InventoryCollectedItemCopyWithImpl<$Res,
        _$InventoryCollectedItemImpl>
    implements _$$InventoryCollectedItemImplCopyWith<$Res> {
  __$$InventoryCollectedItemImplCopyWithImpl(
      _$InventoryCollectedItemImpl _value,
      $Res Function(_$InventoryCollectedItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? invTaskItemId = null,
    Object? sourceQty = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? storeRoomNo = null,
    Object? storeSiteNo = null,
    Object? trayNo = freezed,
    Object? materialId = freezed,
  }) {
    return _then(_$InventoryCollectedItemImpl(
      stockId: null == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String,
      invTaskItemId: null == invTaskItemId
          ? _value.invTaskItemId
          : invTaskItemId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceQty: null == sourceQty
          ? _value.sourceQty
          : sourceQty // ignore: cast_nullable_to_non_nullable
              as double,
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
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: freezed == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialId: freezed == materialId
          ? _value.materialId
          : materialId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryCollectedItemImpl implements _InventoryCollectedItem {
  const _$InventoryCollectedItemImpl(
      {@JsonKey(name: 'stockid') required this.stockId,
      @JsonKey(name: 'InvTaskItemid') required this.invTaskItemId,
      @JsonKey(name: 'InventoryQty') this.sourceQty = 0,
      @JsonKey(name: 'matcode') required this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'storeRoom') required this.storeRoomNo,
      @JsonKey(name: 'storeSite') required this.storeSiteNo,
      @JsonKey(name: 'TrayNo') this.trayNo,
      @JsonKey(name: 'MatId') this.materialId});

  factory _$InventoryCollectedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryCollectedItemImplFromJson(json);

  /// 本地缓存记录ID
  @override
  @JsonKey(name: 'stockid')
  final String stockId;

  /// 对应的盘点任务明细ID
  @override
  @JsonKey(name: 'InvTaskItemid')
  final String invTaskItemId;

  /// 采集数量（源数量）
  @override
  @JsonKey(name: 'InventoryQty')
  final double sourceQty;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String materialCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  final String? materialName;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;

  /// 库房编码
  @override
  @JsonKey(name: 'storeRoom')
  final String storeRoomNo;

  /// 库位编码
  @override
  @JsonKey(name: 'storeSite')
  final String storeSiteNo;

  /// 托盘号
  @override
  @JsonKey(name: 'TrayNo')
  final String? trayNo;

  /// 物料主数据ID
  @override
  @JsonKey(name: 'MatId')
  final String? materialId;

  @override
  String toString() {
    return 'InventoryCollectedItem(stockId: $stockId, invTaskItemId: $invTaskItemId, sourceQty: $sourceQty, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, storeRoomNo: $storeRoomNo, storeSiteNo: $storeSiteNo, trayNo: $trayNo, materialId: $materialId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCollectedItemImpl &&
            (identical(other.stockId, stockId) || other.stockId == stockId) &&
            (identical(other.invTaskItemId, invTaskItemId) ||
                other.invTaskItemId == invTaskItemId) &&
            (identical(other.sourceQty, sourceQty) ||
                other.sourceQty == sourceQty) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stockId,
      invTaskItemId,
      sourceQty,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      storeRoomNo,
      storeSiteNo,
      trayNo,
      materialId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCollectedItemImplCopyWith<_$InventoryCollectedItemImpl>
      get copyWith => __$$InventoryCollectedItemImplCopyWithImpl<
          _$InventoryCollectedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryCollectedItemImplToJson(
      this,
    );
  }
}

abstract class _InventoryCollectedItem implements InventoryCollectedItem {
  const factory _InventoryCollectedItem(
          {@JsonKey(name: 'stockid') required final String stockId,
          @JsonKey(name: 'InvTaskItemid') required final String invTaskItemId,
          @JsonKey(name: 'InventoryQty') final double sourceQty,
          @JsonKey(name: 'matcode') required final String materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNo,
          @JsonKey(name: 'storeRoom') required final String storeRoomNo,
          @JsonKey(name: 'storeSite') required final String storeSiteNo,
          @JsonKey(name: 'TrayNo') final String? trayNo,
          @JsonKey(name: 'MatId') final String? materialId}) =
      _$InventoryCollectedItemImpl;

  factory _InventoryCollectedItem.fromJson(Map<String, dynamic> json) =
      _$InventoryCollectedItemImpl.fromJson;

  @override

  /// 本地缓存记录ID
  @JsonKey(name: 'stockid')
  String get stockId;
  @override

  /// 对应的盘点任务明细ID
  @JsonKey(name: 'InvTaskItemid')
  String get invTaskItemId;
  @override

  /// 采集数量（源数量）
  @JsonKey(name: 'InventoryQty')
  double get sourceQty;
  @override

  /// 物料编码
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override

  /// 物料名称
  @JsonKey(name: 'matname')
  String? get materialName;
  @override

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override

  /// 库房编码
  @JsonKey(name: 'storeRoom')
  String get storeRoomNo;
  @override

  /// 库位编码
  @JsonKey(name: 'storeSite')
  String get storeSiteNo;
  @override

  /// 托盘号
  @JsonKey(name: 'TrayNo')
  String? get trayNo;
  @override

  /// 物料主数据ID
  @JsonKey(name: 'MatId')
  String? get materialId;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCollectedItemImplCopyWith<_$InventoryCollectedItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}
