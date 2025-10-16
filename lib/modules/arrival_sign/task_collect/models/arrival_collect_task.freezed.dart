// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_collect_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ArrivalCollectTask _$ArrivalCollectTaskFromJson(Map<String, dynamic> json) {
  return _ArrivalCollectTask.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectTask {
  /// 物料编码
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;

  /// 到货单号
  @JsonKey(name: 'arrivalsBillno')
  String? get arrivalsBillNo => throw _privateConstructorUsedError;

  /// 到货单行ID
  @JsonKey(name: 'arrivalsBillid')
  String? get arrivalsBillId => throw _privateConstructorUsedError;

  /// 采购单号
  @JsonKey(name: 'orderno')
  String? get orderNo => throw _privateConstructorUsedError;

  /// 计划数量
  @JsonKey(name: 'qty')
  double get plannedQuantity => throw _privateConstructorUsedError;

  /// 已良品数量
  @JsonKey(name: 'goodqty')
  double get collectedQuantity => throw _privateConstructorUsedError;

  /// 初始良品数量（用于删除/恢复时回写）
  @JsonKey(ignore: true)
  double get baseCollectedQuantity => throw _privateConstructorUsedError;

  /// 单位
  @JsonKey(name: 'meins')
  String? get unit => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  String? get serialNumber => throw _privateConstructorUsedError;

  /// 库位编码
  @JsonKey(name: 'subinventoryCode')
  String? get subInventoryCode => throw _privateConstructorUsedError;

  /// 物料控制类型（0 无、1 批次、2 序列）
  @JsonKey(name: 'matcodecontrol')
  int? get materialControlType => throw _privateConstructorUsedError;

  /// 生产日期
  @JsonKey(name: 'pdate')
  String? get productionDate => throw _privateConstructorUsedError;

  /// 有效天数
  @JsonKey(name: 'vdays')
  String? get validDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectTaskCopyWith<ArrivalCollectTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectTaskCopyWith<$Res> {
  factory $ArrivalCollectTaskCopyWith(
          ArrivalCollectTask value, $Res Function(ArrivalCollectTask) then) =
      _$ArrivalCollectTaskCopyWithImpl<$Res, ArrivalCollectTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'arrivalsBillno') String? arrivalsBillNo,
      @JsonKey(name: 'arrivalsBillid') String? arrivalsBillId,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'qty') double plannedQuantity,
      @JsonKey(name: 'goodqty') double collectedQuantity,
      @JsonKey(ignore: true) double baseCollectedQuantity,
      @JsonKey(name: 'meins') String? unit,
      @JsonKey(name: 'batchno') String? batchNo,
      String? serialNumber,
      @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
      @JsonKey(name: 'matcodecontrol') int? materialControlType,
      @JsonKey(name: 'pdate') String? productionDate,
      @JsonKey(name: 'vdays') String? validDays});
}

/// @nodoc
class _$ArrivalCollectTaskCopyWithImpl<$Res, $Val extends ArrivalCollectTask>
    implements $ArrivalCollectTaskCopyWith<$Res> {
  _$ArrivalCollectTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? arrivalsBillNo = freezed,
    Object? arrivalsBillId = freezed,
    Object? orderNo = freezed,
    Object? plannedQuantity = null,
    Object? collectedQuantity = null,
    Object? baseCollectedQuantity = null,
    Object? unit = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? subInventoryCode = freezed,
    Object? materialControlType = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
  }) {
    return _then(_value.copyWith(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalsBillNo: freezed == arrivalsBillNo
          ? _value.arrivalsBillNo
          : arrivalsBillNo // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalsBillId: freezed == arrivalsBillId
          ? _value.arrivalsBillId
          : arrivalsBillId // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedQuantity: null == plannedQuantity
          ? _value.plannedQuantity
          : plannedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      collectedQuantity: null == collectedQuantity
          ? _value.collectedQuantity
          : collectedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      baseCollectedQuantity: null == baseCollectedQuantity
          ? _value.baseCollectedQuantity
          : baseCollectedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
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
      materialControlType: freezed == materialControlType
          ? _value.materialControlType
          : materialControlType // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$ArrivalCollectTaskImplCopyWith<$Res>
    implements $ArrivalCollectTaskCopyWith<$Res> {
  factory _$$ArrivalCollectTaskImplCopyWith(_$ArrivalCollectTaskImpl value,
          $Res Function(_$ArrivalCollectTaskImpl) then) =
      __$$ArrivalCollectTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'arrivalsBillno') String? arrivalsBillNo,
      @JsonKey(name: 'arrivalsBillid') String? arrivalsBillId,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'qty') double plannedQuantity,
      @JsonKey(name: 'goodqty') double collectedQuantity,
      @JsonKey(ignore: true) double baseCollectedQuantity,
      @JsonKey(name: 'meins') String? unit,
      @JsonKey(name: 'batchno') String? batchNo,
      String? serialNumber,
      @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
      @JsonKey(name: 'matcodecontrol') int? materialControlType,
      @JsonKey(name: 'pdate') String? productionDate,
      @JsonKey(name: 'vdays') String? validDays});
}

/// @nodoc
class __$$ArrivalCollectTaskImplCopyWithImpl<$Res>
    extends _$ArrivalCollectTaskCopyWithImpl<$Res, _$ArrivalCollectTaskImpl>
    implements _$$ArrivalCollectTaskImplCopyWith<$Res> {
  __$$ArrivalCollectTaskImplCopyWithImpl(_$ArrivalCollectTaskImpl _value,
      $Res Function(_$ArrivalCollectTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? arrivalsBillNo = freezed,
    Object? arrivalsBillId = freezed,
    Object? orderNo = freezed,
    Object? plannedQuantity = null,
    Object? collectedQuantity = null,
    Object? baseCollectedQuantity = null,
    Object? unit = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? subInventoryCode = freezed,
    Object? materialControlType = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
  }) {
    return _then(_$ArrivalCollectTaskImpl(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalsBillNo: freezed == arrivalsBillNo
          ? _value.arrivalsBillNo
          : arrivalsBillNo // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalsBillId: freezed == arrivalsBillId
          ? _value.arrivalsBillId
          : arrivalsBillId // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      plannedQuantity: null == plannedQuantity
          ? _value.plannedQuantity
          : plannedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      collectedQuantity: null == collectedQuantity
          ? _value.collectedQuantity
          : collectedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      baseCollectedQuantity: null == baseCollectedQuantity
          ? _value.baseCollectedQuantity
          : baseCollectedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
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
      materialControlType: freezed == materialControlType
          ? _value.materialControlType
          : materialControlType // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$ArrivalCollectTaskImpl extends _ArrivalCollectTask {
  const _$ArrivalCollectTaskImpl(
      {@JsonKey(name: 'matcode') required this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'arrivalsBillno') this.arrivalsBillNo,
      @JsonKey(name: 'arrivalsBillid') this.arrivalsBillId,
      @JsonKey(name: 'orderno') this.orderNo,
      @JsonKey(name: 'qty') required this.plannedQuantity,
      @JsonKey(name: 'goodqty') required this.collectedQuantity,
      @JsonKey(ignore: true) this.baseCollectedQuantity = 0,
      @JsonKey(name: 'meins') this.unit,
      @JsonKey(name: 'batchno') this.batchNo,
      this.serialNumber,
      @JsonKey(name: 'subinventoryCode') this.subInventoryCode,
      @JsonKey(name: 'matcodecontrol') this.materialControlType,
      @JsonKey(name: 'pdate') this.productionDate,
      @JsonKey(name: 'vdays') this.validDays})
      : super._();

  factory _$ArrivalCollectTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalCollectTaskImplFromJson(json);

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String materialCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  final String? materialName;

  /// 到货单号
  @override
  @JsonKey(name: 'arrivalsBillno')
  final String? arrivalsBillNo;

  /// 到货单行ID
  @override
  @JsonKey(name: 'arrivalsBillid')
  final String? arrivalsBillId;

  /// 采购单号
  @override
  @JsonKey(name: 'orderno')
  final String? orderNo;

  /// 计划数量
  @override
  @JsonKey(name: 'qty')
  final double plannedQuantity;

  /// 已良品数量
  @override
  @JsonKey(name: 'goodqty')
  final double collectedQuantity;

  /// 初始良品数量（用于删除/恢复时回写）
  @override
  @JsonKey(ignore: true)
  final double baseCollectedQuantity;

  /// 单位
  @override
  @JsonKey(name: 'meins')
  final String? unit;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;

  /// 序列号
  @override
  final String? serialNumber;

  /// 库位编码
  @override
  @JsonKey(name: 'subinventoryCode')
  final String? subInventoryCode;

  /// 物料控制类型（0 无、1 批次、2 序列）
  @override
  @JsonKey(name: 'matcodecontrol')
  final int? materialControlType;

  /// 生产日期
  @override
  @JsonKey(name: 'pdate')
  final String? productionDate;

  /// 有效天数
  @override
  @JsonKey(name: 'vdays')
  final String? validDays;

  @override
  String toString() {
    return 'ArrivalCollectTask(materialCode: $materialCode, materialName: $materialName, arrivalsBillNo: $arrivalsBillNo, arrivalsBillId: $arrivalsBillId, orderNo: $orderNo, plannedQuantity: $plannedQuantity, collectedQuantity: $collectedQuantity, baseCollectedQuantity: $baseCollectedQuantity, unit: $unit, batchNo: $batchNo, serialNumber: $serialNumber, subInventoryCode: $subInventoryCode, materialControlType: $materialControlType, productionDate: $productionDate, validDays: $validDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectTaskImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.arrivalsBillNo, arrivalsBillNo) ||
                other.arrivalsBillNo == arrivalsBillNo) &&
            (identical(other.arrivalsBillId, arrivalsBillId) ||
                other.arrivalsBillId == arrivalsBillId) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.plannedQuantity, plannedQuantity) ||
                other.plannedQuantity == plannedQuantity) &&
            (identical(other.collectedQuantity, collectedQuantity) ||
                other.collectedQuantity == collectedQuantity) &&
            (identical(other.baseCollectedQuantity, baseCollectedQuantity) ||
                other.baseCollectedQuantity == baseCollectedQuantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.subInventoryCode, subInventoryCode) ||
                other.subInventoryCode == subInventoryCode) &&
            (identical(other.materialControlType, materialControlType) ||
                other.materialControlType == materialControlType) &&
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
      arrivalsBillNo,
      arrivalsBillId,
      orderNo,
      plannedQuantity,
      collectedQuantity,
      baseCollectedQuantity,
      unit,
      batchNo,
      serialNumber,
      subInventoryCode,
      materialControlType,
      productionDate,
      validDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectTaskImplCopyWith<_$ArrivalCollectTaskImpl> get copyWith =>
      __$$ArrivalCollectTaskImplCopyWithImpl<_$ArrivalCollectTaskImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectTaskImplToJson(
      this,
    );
  }
}

abstract class _ArrivalCollectTask extends ArrivalCollectTask {
  const factory _ArrivalCollectTask(
          {@JsonKey(name: 'matcode') required final String materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'arrivalsBillno') final String? arrivalsBillNo,
          @JsonKey(name: 'arrivalsBillid') final String? arrivalsBillId,
          @JsonKey(name: 'orderno') final String? orderNo,
          @JsonKey(name: 'qty') required final double plannedQuantity,
          @JsonKey(name: 'goodqty') required final double collectedQuantity,
          @JsonKey(ignore: true) final double baseCollectedQuantity,
          @JsonKey(name: 'meins') final String? unit,
          @JsonKey(name: 'batchno') final String? batchNo,
          final String? serialNumber,
          @JsonKey(name: 'subinventoryCode') final String? subInventoryCode,
          @JsonKey(name: 'matcodecontrol') final int? materialControlType,
          @JsonKey(name: 'pdate') final String? productionDate,
          @JsonKey(name: 'vdays') final String? validDays}) =
      _$ArrivalCollectTaskImpl;
  const _ArrivalCollectTask._() : super._();

  factory _ArrivalCollectTask.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectTaskImpl.fromJson;

  @override

  /// 物料编码
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override

  /// 物料名称
  @JsonKey(name: 'matname')
  String? get materialName;
  @override

  /// 到货单号
  @JsonKey(name: 'arrivalsBillno')
  String? get arrivalsBillNo;
  @override

  /// 到货单行ID
  @JsonKey(name: 'arrivalsBillid')
  String? get arrivalsBillId;
  @override

  /// 采购单号
  @JsonKey(name: 'orderno')
  String? get orderNo;
  @override

  /// 计划数量
  @JsonKey(name: 'qty')
  double get plannedQuantity;
  @override

  /// 已良品数量
  @JsonKey(name: 'goodqty')
  double get collectedQuantity;
  @override

  /// 初始良品数量（用于删除/恢复时回写）
  @JsonKey(ignore: true)
  double get baseCollectedQuantity;
  @override

  /// 单位
  @JsonKey(name: 'meins')
  String? get unit;
  @override

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override

  /// 序列号
  String? get serialNumber;
  @override

  /// 库位编码
  @JsonKey(name: 'subinventoryCode')
  String? get subInventoryCode;
  @override

  /// 物料控制类型（0 无、1 批次、2 序列）
  @JsonKey(name: 'matcodecontrol')
  int? get materialControlType;
  @override

  /// 生产日期
  @JsonKey(name: 'pdate')
  String? get productionDate;
  @override

  /// 有效天数
  @JsonKey(name: 'vdays')
  String? get validDays;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectTaskImplCopyWith<_$ArrivalCollectTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
