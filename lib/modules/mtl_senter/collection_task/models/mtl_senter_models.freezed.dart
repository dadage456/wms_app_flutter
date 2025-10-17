// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mtl_senter_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MtlSenterTask _$MtlSenterTaskFromJson(Map<String, dynamic> json) {
  return _MtlSenterTask.fromJson(json);
}

/// @nodoc
mixin _$MtlSenterTask {
  /// 任务 ID
  String get taskId => throw _privateConstructorUsedError;

  /// 工单号
  String? get workOrderNo => throw _privateConstructorUsedError;

  /// 产线/班组
  String? get productionLine => throw _privateConstructorUsedError;

  /// 需求车间
  String? get workshop => throw _privateConstructorUsedError;

  /// 计划数量
  double? get planQty => throw _privateConstructorUsedError;

  /// 需求日期
  DateTime? get requiredDate => throw _privateConstructorUsedError;

  /// 备注
  String? get remark => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MtlSenterTaskCopyWith<MtlSenterTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MtlSenterTaskCopyWith<$Res> {
  factory $MtlSenterTaskCopyWith(
          MtlSenterTask value, $Res Function(MtlSenterTask) then) =
      _$MtlSenterTaskCopyWithImpl<$Res, MtlSenterTask>;
  @useResult
  $Res call(
      {String taskId,
      String? workOrderNo,
      String? productionLine,
      String? workshop,
      double? planQty,
      DateTime? requiredDate,
      String? remark});
}

/// @nodoc
class _$MtlSenterTaskCopyWithImpl<$Res, $Val extends MtlSenterTask>
    implements $MtlSenterTaskCopyWith<$Res> {
  _$MtlSenterTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? workOrderNo = freezed,
    Object? productionLine = freezed,
    Object? workshop = freezed,
    Object? planQty = freezed,
    Object? requiredDate = freezed,
    Object? remark = freezed,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderNo: freezed == workOrderNo
          ? _value.workOrderNo
          : workOrderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      productionLine: freezed == productionLine
          ? _value.productionLine
          : productionLine // ignore: cast_nullable_to_non_nullable
              as String?,
      workshop: freezed == workshop
          ? _value.workshop
          : workshop // ignore: cast_nullable_to_non_nullable
              as String?,
      planQty: freezed == planQty
          ? _value.planQty
          : planQty // ignore: cast_nullable_to_non_nullable
              as double?,
      requiredDate: freezed == requiredDate
          ? _value.requiredDate
          : requiredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MtlSenterTaskImplCopyWith<$Res>
    implements $MtlSenterTaskCopyWith<$Res> {
  factory _$$MtlSenterTaskImplCopyWith(
          _$MtlSenterTaskImpl value, $Res Function(_$MtlSenterTaskImpl) then) =
      __$$MtlSenterTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String taskId,
      String? workOrderNo,
      String? productionLine,
      String? workshop,
      double? planQty,
      DateTime? requiredDate,
      String? remark});
}

/// @nodoc
class __$$MtlSenterTaskImplCopyWithImpl<$Res>
    extends _$MtlSenterTaskCopyWithImpl<$Res, _$MtlSenterTaskImpl>
    implements _$$MtlSenterTaskImplCopyWith<$Res> {
  __$$MtlSenterTaskImplCopyWithImpl(
      _$MtlSenterTaskImpl _value, $Res Function(_$MtlSenterTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? workOrderNo = freezed,
    Object? productionLine = freezed,
    Object? workshop = freezed,
    Object? planQty = freezed,
    Object? requiredDate = freezed,
    Object? remark = freezed,
  }) {
    return _then(_$MtlSenterTaskImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      workOrderNo: freezed == workOrderNo
          ? _value.workOrderNo
          : workOrderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      productionLine: freezed == productionLine
          ? _value.productionLine
          : productionLine // ignore: cast_nullable_to_non_nullable
              as String?,
      workshop: freezed == workshop
          ? _value.workshop
          : workshop // ignore: cast_nullable_to_non_nullable
              as String?,
      planQty: freezed == planQty
          ? _value.planQty
          : planQty // ignore: cast_nullable_to_non_nullable
              as double?,
      requiredDate: freezed == requiredDate
          ? _value.requiredDate
          : requiredDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      remark: freezed == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MtlSenterTaskImpl implements _MtlSenterTask {
  const _$MtlSenterTaskImpl(
      {required this.taskId,
      this.workOrderNo,
      this.productionLine,
      this.workshop,
      this.planQty,
      this.requiredDate,
      this.remark});

  factory _$MtlSenterTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$MtlSenterTaskImplFromJson(json);

  /// 任务 ID
  @override
  final String taskId;

  /// 工单号
  @override
  final String? workOrderNo;

  /// 产线/班组
  @override
  final String? productionLine;

  /// 需求车间
  @override
  final String? workshop;

  /// 计划数量
  @override
  final double? planQty;

  /// 需求日期
  @override
  final DateTime? requiredDate;

  /// 备注
  @override
  final String? remark;

  @override
  String toString() {
    return 'MtlSenterTask(taskId: $taskId, workOrderNo: $workOrderNo, productionLine: $productionLine, workshop: $workshop, planQty: $planQty, requiredDate: $requiredDate, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MtlSenterTaskImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.workOrderNo, workOrderNo) ||
                other.workOrderNo == workOrderNo) &&
            (identical(other.productionLine, productionLine) ||
                other.productionLine == productionLine) &&
            (identical(other.workshop, workshop) ||
                other.workshop == workshop) &&
            (identical(other.planQty, planQty) || other.planQty == planQty) &&
            (identical(other.requiredDate, requiredDate) ||
                other.requiredDate == requiredDate) &&
            (identical(other.remark, remark) || other.remark == remark));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskId, workOrderNo,
      productionLine, workshop, planQty, requiredDate, remark);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MtlSenterTaskImplCopyWith<_$MtlSenterTaskImpl> get copyWith =>
      __$$MtlSenterTaskImplCopyWithImpl<_$MtlSenterTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MtlSenterTaskImplToJson(
      this,
    );
  }
}

abstract class _MtlSenterTask implements MtlSenterTask {
  const factory _MtlSenterTask(
      {required final String taskId,
      final String? workOrderNo,
      final String? productionLine,
      final String? workshop,
      final double? planQty,
      final DateTime? requiredDate,
      final String? remark}) = _$MtlSenterTaskImpl;

  factory _MtlSenterTask.fromJson(Map<String, dynamic> json) =
      _$MtlSenterTaskImpl.fromJson;

  @override

  /// 任务 ID
  String get taskId;
  @override

  /// 工单号
  String? get workOrderNo;
  @override

  /// 产线/班组
  String? get productionLine;
  @override

  /// 需求车间
  String? get workshop;
  @override

  /// 计划数量
  double? get planQty;
  @override

  /// 需求日期
  DateTime? get requiredDate;
  @override

  /// 备注
  String? get remark;
  @override
  @JsonKey(ignore: true)
  _$$MtlSenterTaskImplCopyWith<_$MtlSenterTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MtlSenterMaterial _$MtlSenterMaterialFromJson(Map<String, dynamic> json) {
  return _MtlSenterMaterial.fromJson(json);
}

/// @nodoc
mixin _$MtlSenterMaterial {
  /// 物料编码
  String get materialCode => throw _privateConstructorUsedError;

  /// 物料名称
  String? get materialName => throw _privateConstructorUsedError;

  /// 规格型号
  String? get specification => throw _privateConstructorUsedError;

  /// 控制方式（批次/序列）
  String? get controlType => throw _privateConstructorUsedError;

  /// 默认库房
  String? get storeRoomNo => throw _privateConstructorUsedError;

  /// 默认库位
  String? get storeSiteNo => throw _privateConstructorUsedError;

  /// 可用库存
  double? get availableQty => throw _privateConstructorUsedError;

  /// 最小包装数
  double? get minPackageQty => throw _privateConstructorUsedError;

  /// 默认配送量
  double? get defaultDeliveryQty => throw _privateConstructorUsedError;

  /// 生产批次
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  String? get serialNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MtlSenterMaterialCopyWith<MtlSenterMaterial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MtlSenterMaterialCopyWith<$Res> {
  factory $MtlSenterMaterialCopyWith(
          MtlSenterMaterial value, $Res Function(MtlSenterMaterial) then) =
      _$MtlSenterMaterialCopyWithImpl<$Res, MtlSenterMaterial>;
  @useResult
  $Res call(
      {String materialCode,
      String? materialName,
      String? specification,
      String? controlType,
      String? storeRoomNo,
      String? storeSiteNo,
      double? availableQty,
      double? minPackageQty,
      double? defaultDeliveryQty,
      String? batchNo,
      String? serialNo});
}

/// @nodoc
class _$MtlSenterMaterialCopyWithImpl<$Res, $Val extends MtlSenterMaterial>
    implements $MtlSenterMaterialCopyWith<$Res> {
  _$MtlSenterMaterialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? specification = freezed,
    Object? controlType = freezed,
    Object? storeRoomNo = freezed,
    Object? storeSiteNo = freezed,
    Object? availableQty = freezed,
    Object? minPackageQty = freezed,
    Object? defaultDeliveryQty = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
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
      specification: freezed == specification
          ? _value.specification
          : specification // ignore: cast_nullable_to_non_nullable
              as String?,
      controlType: freezed == controlType
          ? _value.controlType
          : controlType // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      availableQty: freezed == availableQty
          ? _value.availableQty
          : availableQty // ignore: cast_nullable_to_non_nullable
              as double?,
      minPackageQty: freezed == minPackageQty
          ? _value.minPackageQty
          : minPackageQty // ignore: cast_nullable_to_non_nullable
              as double?,
      defaultDeliveryQty: freezed == defaultDeliveryQty
          ? _value.defaultDeliveryQty
          : defaultDeliveryQty // ignore: cast_nullable_to_non_nullable
              as double?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MtlSenterMaterialImplCopyWith<$Res>
    implements $MtlSenterMaterialCopyWith<$Res> {
  factory _$$MtlSenterMaterialImplCopyWith(_$MtlSenterMaterialImpl value,
          $Res Function(_$MtlSenterMaterialImpl) then) =
      __$$MtlSenterMaterialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String materialCode,
      String? materialName,
      String? specification,
      String? controlType,
      String? storeRoomNo,
      String? storeSiteNo,
      double? availableQty,
      double? minPackageQty,
      double? defaultDeliveryQty,
      String? batchNo,
      String? serialNo});
}

/// @nodoc
class __$$MtlSenterMaterialImplCopyWithImpl<$Res>
    extends _$MtlSenterMaterialCopyWithImpl<$Res, _$MtlSenterMaterialImpl>
    implements _$$MtlSenterMaterialImplCopyWith<$Res> {
  __$$MtlSenterMaterialImplCopyWithImpl(_$MtlSenterMaterialImpl _value,
      $Res Function(_$MtlSenterMaterialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? specification = freezed,
    Object? controlType = freezed,
    Object? storeRoomNo = freezed,
    Object? storeSiteNo = freezed,
    Object? availableQty = freezed,
    Object? minPackageQty = freezed,
    Object? defaultDeliveryQty = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
  }) {
    return _then(_$MtlSenterMaterialImpl(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      specification: freezed == specification
          ? _value.specification
          : specification // ignore: cast_nullable_to_non_nullable
              as String?,
      controlType: freezed == controlType
          ? _value.controlType
          : controlType // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      availableQty: freezed == availableQty
          ? _value.availableQty
          : availableQty // ignore: cast_nullable_to_non_nullable
              as double?,
      minPackageQty: freezed == minPackageQty
          ? _value.minPackageQty
          : minPackageQty // ignore: cast_nullable_to_non_nullable
              as double?,
      defaultDeliveryQty: freezed == defaultDeliveryQty
          ? _value.defaultDeliveryQty
          : defaultDeliveryQty // ignore: cast_nullable_to_non_nullable
              as double?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MtlSenterMaterialImpl implements _MtlSenterMaterial {
  const _$MtlSenterMaterialImpl(
      {required this.materialCode,
      this.materialName,
      this.specification,
      this.controlType,
      this.storeRoomNo,
      this.storeSiteNo,
      this.availableQty,
      this.minPackageQty,
      this.defaultDeliveryQty,
      this.batchNo,
      this.serialNo});

  factory _$MtlSenterMaterialImpl.fromJson(Map<String, dynamic> json) =>
      _$$MtlSenterMaterialImplFromJson(json);

  /// 物料编码
  @override
  final String materialCode;

  /// 物料名称
  @override
  final String? materialName;

  /// 规格型号
  @override
  final String? specification;

  /// 控制方式（批次/序列）
  @override
  final String? controlType;

  /// 默认库房
  @override
  final String? storeRoomNo;

  /// 默认库位
  @override
  final String? storeSiteNo;

  /// 可用库存
  @override
  final double? availableQty;

  /// 最小包装数
  @override
  final double? minPackageQty;

  /// 默认配送量
  @override
  final double? defaultDeliveryQty;

  /// 生产批次
  @override
  final String? batchNo;

  /// 序列号
  @override
  final String? serialNo;

  @override
  String toString() {
    return 'MtlSenterMaterial(materialCode: $materialCode, materialName: $materialName, specification: $specification, controlType: $controlType, storeRoomNo: $storeRoomNo, storeSiteNo: $storeSiteNo, availableQty: $availableQty, minPackageQty: $minPackageQty, defaultDeliveryQty: $defaultDeliveryQty, batchNo: $batchNo, serialNo: $serialNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MtlSenterMaterialImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.specification, specification) ||
                other.specification == specification) &&
            (identical(other.controlType, controlType) ||
                other.controlType == controlType) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.availableQty, availableQty) ||
                other.availableQty == availableQty) &&
            (identical(other.minPackageQty, minPackageQty) ||
                other.minPackageQty == minPackageQty) &&
            (identical(other.defaultDeliveryQty, defaultDeliveryQty) ||
                other.defaultDeliveryQty == defaultDeliveryQty) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      materialCode,
      materialName,
      specification,
      controlType,
      storeRoomNo,
      storeSiteNo,
      availableQty,
      minPackageQty,
      defaultDeliveryQty,
      batchNo,
      serialNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MtlSenterMaterialImplCopyWith<_$MtlSenterMaterialImpl> get copyWith =>
      __$$MtlSenterMaterialImplCopyWithImpl<_$MtlSenterMaterialImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MtlSenterMaterialImplToJson(
      this,
    );
  }
}

abstract class _MtlSenterMaterial implements MtlSenterMaterial {
  const factory _MtlSenterMaterial(
      {required final String materialCode,
      final String? materialName,
      final String? specification,
      final String? controlType,
      final String? storeRoomNo,
      final String? storeSiteNo,
      final double? availableQty,
      final double? minPackageQty,
      final double? defaultDeliveryQty,
      final String? batchNo,
      final String? serialNo}) = _$MtlSenterMaterialImpl;

  factory _MtlSenterMaterial.fromJson(Map<String, dynamic> json) =
      _$MtlSenterMaterialImpl.fromJson;

  @override

  /// 物料编码
  String get materialCode;
  @override

  /// 物料名称
  String? get materialName;
  @override

  /// 规格型号
  String? get specification;
  @override

  /// 控制方式（批次/序列）
  String? get controlType;
  @override

  /// 默认库房
  String? get storeRoomNo;
  @override

  /// 默认库位
  String? get storeSiteNo;
  @override

  /// 可用库存
  double? get availableQty;
  @override

  /// 最小包装数
  double? get minPackageQty;
  @override

  /// 默认配送量
  double? get defaultDeliveryQty;
  @override

  /// 生产批次
  String? get batchNo;
  @override

  /// 序列号
  String? get serialNo;
  @override
  @JsonKey(ignore: true)
  _$$MtlSenterMaterialImplCopyWith<_$MtlSenterMaterialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MtlSenterCollectItem _$MtlSenterCollectItemFromJson(Map<String, dynamic> json) {
  return _MtlSenterCollectItem.fromJson(json);
}

/// @nodoc
mixin _$MtlSenterCollectItem {
  /// 行内唯一标识
  String get id => throw _privateConstructorUsedError;

  /// 库位编码
  String get storeSiteNo => throw _privateConstructorUsedError;

  /// 库房编码
  String? get storeRoomNo => throw _privateConstructorUsedError;

  /// 物料编码
  String get materialCode => throw _privateConstructorUsedError;

  /// 物料名称
  String? get materialName => throw _privateConstructorUsedError;

  /// 批次号
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  String? get serialNo => throw _privateConstructorUsedError;

  /// 生产日期
  DateTime? get productionDate => throw _privateConstructorUsedError;

  /// 失效天数
  int? get validDays => throw _privateConstructorUsedError;

  /// 采集数量
  double get quantity => throw _privateConstructorUsedError;

  /// 当前库位可用库存
  double? get availableQty => throw _privateConstructorUsedError;

  /// 最小包装
  double? get minPackageQty => throw _privateConstructorUsedError;

  /// 默认配送量
  double? get defaultDeliveryQty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MtlSenterCollectItemCopyWith<MtlSenterCollectItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MtlSenterCollectItemCopyWith<$Res> {
  factory $MtlSenterCollectItemCopyWith(MtlSenterCollectItem value,
          $Res Function(MtlSenterCollectItem) then) =
      _$MtlSenterCollectItemCopyWithImpl<$Res, MtlSenterCollectItem>;
  @useResult
  $Res call(
      {String id,
      String storeSiteNo,
      String? storeRoomNo,
      String materialCode,
      String? materialName,
      String? batchNo,
      String? serialNo,
      DateTime? productionDate,
      int? validDays,
      double quantity,
      double? availableQty,
      double? minPackageQty,
      double? defaultDeliveryQty});
}

/// @nodoc
class _$MtlSenterCollectItemCopyWithImpl<$Res,
        $Val extends MtlSenterCollectItem>
    implements $MtlSenterCollectItemCopyWith<$Res> {
  _$MtlSenterCollectItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeSiteNo = null,
    Object? storeRoomNo = freezed,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? quantity = null,
    Object? availableQty = freezed,
    Object? minPackageQty = freezed,
    Object? defaultDeliveryQty = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
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
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      availableQty: freezed == availableQty
          ? _value.availableQty
          : availableQty // ignore: cast_nullable_to_non_nullable
              as double?,
      minPackageQty: freezed == minPackageQty
          ? _value.minPackageQty
          : minPackageQty // ignore: cast_nullable_to_non_nullable
              as double?,
      defaultDeliveryQty: freezed == defaultDeliveryQty
          ? _value.defaultDeliveryQty
          : defaultDeliveryQty // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MtlSenterCollectItemImplCopyWith<$Res>
    implements $MtlSenterCollectItemCopyWith<$Res> {
  factory _$$MtlSenterCollectItemImplCopyWith(_$MtlSenterCollectItemImpl value,
          $Res Function(_$MtlSenterCollectItemImpl) then) =
      __$$MtlSenterCollectItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String storeSiteNo,
      String? storeRoomNo,
      String materialCode,
      String? materialName,
      String? batchNo,
      String? serialNo,
      DateTime? productionDate,
      int? validDays,
      double quantity,
      double? availableQty,
      double? minPackageQty,
      double? defaultDeliveryQty});
}

/// @nodoc
class __$$MtlSenterCollectItemImplCopyWithImpl<$Res>
    extends _$MtlSenterCollectItemCopyWithImpl<$Res, _$MtlSenterCollectItemImpl>
    implements _$$MtlSenterCollectItemImplCopyWith<$Res> {
  __$$MtlSenterCollectItemImplCopyWithImpl(_$MtlSenterCollectItemImpl _value,
      $Res Function(_$MtlSenterCollectItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeSiteNo = null,
    Object? storeRoomNo = freezed,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? quantity = null,
    Object? availableQty = freezed,
    Object? minPackageQty = freezed,
    Object? defaultDeliveryQty = freezed,
  }) {
    return _then(_$MtlSenterCollectItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
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
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as int?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      availableQty: freezed == availableQty
          ? _value.availableQty
          : availableQty // ignore: cast_nullable_to_non_nullable
              as double?,
      minPackageQty: freezed == minPackageQty
          ? _value.minPackageQty
          : minPackageQty // ignore: cast_nullable_to_non_nullable
              as double?,
      defaultDeliveryQty: freezed == defaultDeliveryQty
          ? _value.defaultDeliveryQty
          : defaultDeliveryQty // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MtlSenterCollectItemImpl implements _MtlSenterCollectItem {
  const _$MtlSenterCollectItemImpl(
      {required this.id,
      required this.storeSiteNo,
      this.storeRoomNo,
      required this.materialCode,
      this.materialName,
      this.batchNo,
      this.serialNo,
      this.productionDate,
      this.validDays,
      required this.quantity,
      this.availableQty,
      this.minPackageQty,
      this.defaultDeliveryQty});

  factory _$MtlSenterCollectItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MtlSenterCollectItemImplFromJson(json);

  /// 行内唯一标识
  @override
  final String id;

  /// 库位编码
  @override
  final String storeSiteNo;

  /// 库房编码
  @override
  final String? storeRoomNo;

  /// 物料编码
  @override
  final String materialCode;

  /// 物料名称
  @override
  final String? materialName;

  /// 批次号
  @override
  final String? batchNo;

  /// 序列号
  @override
  final String? serialNo;

  /// 生产日期
  @override
  final DateTime? productionDate;

  /// 失效天数
  @override
  final int? validDays;

  /// 采集数量
  @override
  final double quantity;

  /// 当前库位可用库存
  @override
  final double? availableQty;

  /// 最小包装
  @override
  final double? minPackageQty;

  /// 默认配送量
  @override
  final double? defaultDeliveryQty;

  @override
  String toString() {
    return 'MtlSenterCollectItem(id: $id, storeSiteNo: $storeSiteNo, storeRoomNo: $storeRoomNo, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, productionDate: $productionDate, validDays: $validDays, quantity: $quantity, availableQty: $availableQty, minPackageQty: $minPackageQty, defaultDeliveryQty: $defaultDeliveryQty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MtlSenterCollectItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.availableQty, availableQty) ||
                other.availableQty == availableQty) &&
            (identical(other.minPackageQty, minPackageQty) ||
                other.minPackageQty == minPackageQty) &&
            (identical(other.defaultDeliveryQty, defaultDeliveryQty) ||
                other.defaultDeliveryQty == defaultDeliveryQty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      storeSiteNo,
      storeRoomNo,
      materialCode,
      materialName,
      batchNo,
      serialNo,
      productionDate,
      validDays,
      quantity,
      availableQty,
      minPackageQty,
      defaultDeliveryQty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MtlSenterCollectItemImplCopyWith<_$MtlSenterCollectItemImpl>
      get copyWith =>
          __$$MtlSenterCollectItemImplCopyWithImpl<_$MtlSenterCollectItemImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MtlSenterCollectItemImplToJson(
      this,
    );
  }
}

abstract class _MtlSenterCollectItem implements MtlSenterCollectItem {
  const factory _MtlSenterCollectItem(
      {required final String id,
      required final String storeSiteNo,
      final String? storeRoomNo,
      required final String materialCode,
      final String? materialName,
      final String? batchNo,
      final String? serialNo,
      final DateTime? productionDate,
      final int? validDays,
      required final double quantity,
      final double? availableQty,
      final double? minPackageQty,
      final double? defaultDeliveryQty}) = _$MtlSenterCollectItemImpl;

  factory _MtlSenterCollectItem.fromJson(Map<String, dynamic> json) =
      _$MtlSenterCollectItemImpl.fromJson;

  @override

  /// 行内唯一标识
  String get id;
  @override

  /// 库位编码
  String get storeSiteNo;
  @override

  /// 库房编码
  String? get storeRoomNo;
  @override

  /// 物料编码
  String get materialCode;
  @override

  /// 物料名称
  String? get materialName;
  @override

  /// 批次号
  String? get batchNo;
  @override

  /// 序列号
  String? get serialNo;
  @override

  /// 生产日期
  DateTime? get productionDate;
  @override

  /// 失效天数
  int? get validDays;
  @override

  /// 采集数量
  double get quantity;
  @override

  /// 当前库位可用库存
  double? get availableQty;
  @override

  /// 最小包装
  double? get minPackageQty;
  @override

  /// 默认配送量
  double? get defaultDeliveryQty;
  @override
  @JsonKey(ignore: true)
  _$$MtlSenterCollectItemImplCopyWith<_$MtlSenterCollectItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MtlSenterSubmitRequest _$MtlSenterSubmitRequestFromJson(
    Map<String, dynamic> json) {
  return _MtlSenterSubmitRequest.fromJson(json);
}

/// @nodoc
mixin _$MtlSenterSubmitRequest {
  /// 采集提交列表
  List<MtlSenterCollectItem> get mtlSenderInfos =>
      throw _privateConstructorUsedError;

  /// 提交任务号
  String? get taskNo => throw _privateConstructorUsedError;

  /// 操作人工号
  String? get operatorId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MtlSenterSubmitRequestCopyWith<MtlSenterSubmitRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MtlSenterSubmitRequestCopyWith<$Res> {
  factory $MtlSenterSubmitRequestCopyWith(MtlSenterSubmitRequest value,
          $Res Function(MtlSenterSubmitRequest) then) =
      _$MtlSenterSubmitRequestCopyWithImpl<$Res, MtlSenterSubmitRequest>;
  @useResult
  $Res call(
      {List<MtlSenterCollectItem> mtlSenderInfos,
      String? taskNo,
      String? operatorId});
}

/// @nodoc
class _$MtlSenterSubmitRequestCopyWithImpl<$Res,
        $Val extends MtlSenterSubmitRequest>
    implements $MtlSenterSubmitRequestCopyWith<$Res> {
  _$MtlSenterSubmitRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mtlSenderInfos = null,
    Object? taskNo = freezed,
    Object? operatorId = freezed,
  }) {
    return _then(_value.copyWith(
      mtlSenderInfos: null == mtlSenderInfos
          ? _value.mtlSenderInfos
          : mtlSenderInfos // ignore: cast_nullable_to_non_nullable
              as List<MtlSenterCollectItem>,
      taskNo: freezed == taskNo
          ? _value.taskNo
          : taskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MtlSenterSubmitRequestImplCopyWith<$Res>
    implements $MtlSenterSubmitRequestCopyWith<$Res> {
  factory _$$MtlSenterSubmitRequestImplCopyWith(
          _$MtlSenterSubmitRequestImpl value,
          $Res Function(_$MtlSenterSubmitRequestImpl) then) =
      __$$MtlSenterSubmitRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MtlSenterCollectItem> mtlSenderInfos,
      String? taskNo,
      String? operatorId});
}

/// @nodoc
class __$$MtlSenterSubmitRequestImplCopyWithImpl<$Res>
    extends _$MtlSenterSubmitRequestCopyWithImpl<$Res,
        _$MtlSenterSubmitRequestImpl>
    implements _$$MtlSenterSubmitRequestImplCopyWith<$Res> {
  __$$MtlSenterSubmitRequestImplCopyWithImpl(
      _$MtlSenterSubmitRequestImpl _value,
      $Res Function(_$MtlSenterSubmitRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mtlSenderInfos = null,
    Object? taskNo = freezed,
    Object? operatorId = freezed,
  }) {
    return _then(_$MtlSenterSubmitRequestImpl(
      mtlSenderInfos: null == mtlSenderInfos
          ? _value._mtlSenderInfos
          : mtlSenderInfos // ignore: cast_nullable_to_non_nullable
              as List<MtlSenterCollectItem>,
      taskNo: freezed == taskNo
          ? _value.taskNo
          : taskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      operatorId: freezed == operatorId
          ? _value.operatorId
          : operatorId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MtlSenterSubmitRequestImpl implements _MtlSenterSubmitRequest {
  const _$MtlSenterSubmitRequestImpl(
      {final List<MtlSenterCollectItem> mtlSenderInfos =
          const <MtlSenterCollectItem>[],
      this.taskNo,
      this.operatorId})
      : _mtlSenderInfos = mtlSenderInfos;

  factory _$MtlSenterSubmitRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MtlSenterSubmitRequestImplFromJson(json);

  /// 采集提交列表
  final List<MtlSenterCollectItem> _mtlSenderInfos;

  /// 采集提交列表
  @override
  @JsonKey()
  List<MtlSenterCollectItem> get mtlSenderInfos {
    if (_mtlSenderInfos is EqualUnmodifiableListView) return _mtlSenderInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mtlSenderInfos);
  }

  /// 提交任务号
  @override
  final String? taskNo;

  /// 操作人工号
  @override
  final String? operatorId;

  @override
  String toString() {
    return 'MtlSenterSubmitRequest(mtlSenderInfos: $mtlSenderInfos, taskNo: $taskNo, operatorId: $operatorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MtlSenterSubmitRequestImpl &&
            const DeepCollectionEquality()
                .equals(other._mtlSenderInfos, _mtlSenderInfos) &&
            (identical(other.taskNo, taskNo) || other.taskNo == taskNo) &&
            (identical(other.operatorId, operatorId) ||
                other.operatorId == operatorId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_mtlSenderInfos), taskNo, operatorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MtlSenterSubmitRequestImplCopyWith<_$MtlSenterSubmitRequestImpl>
      get copyWith => __$$MtlSenterSubmitRequestImplCopyWithImpl<
          _$MtlSenterSubmitRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MtlSenterSubmitRequestImplToJson(
      this,
    );
  }
}

abstract class _MtlSenterSubmitRequest implements MtlSenterSubmitRequest {
  const factory _MtlSenterSubmitRequest(
      {final List<MtlSenterCollectItem> mtlSenderInfos,
      final String? taskNo,
      final String? operatorId}) = _$MtlSenterSubmitRequestImpl;

  factory _MtlSenterSubmitRequest.fromJson(Map<String, dynamic> json) =
      _$MtlSenterSubmitRequestImpl.fromJson;

  @override

  /// 采集提交列表
  List<MtlSenterCollectItem> get mtlSenderInfos;
  @override

  /// 提交任务号
  String? get taskNo;
  @override

  /// 操作人工号
  String? get operatorId;
  @override
  @JsonKey(ignore: true)
  _$$MtlSenterSubmitRequestImplCopyWith<_$MtlSenterSubmitRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MtlSenterSubmitResponse _$MtlSenterSubmitResponseFromJson(
    Map<String, dynamic> json) {
  return _MtlSenterSubmitResponse.fromJson(json);
}

/// @nodoc
mixin _$MtlSenterSubmitResponse {
  /// 接口状态码
  String? get code => throw _privateConstructorUsedError;

  /// 提示信息
  String? get message => throw _privateConstructorUsedError;

  /// 是否成功
  bool? get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MtlSenterSubmitResponseCopyWith<MtlSenterSubmitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MtlSenterSubmitResponseCopyWith<$Res> {
  factory $MtlSenterSubmitResponseCopyWith(MtlSenterSubmitResponse value,
          $Res Function(MtlSenterSubmitResponse) then) =
      _$MtlSenterSubmitResponseCopyWithImpl<$Res, MtlSenterSubmitResponse>;
  @useResult
  $Res call({String? code, String? message, bool? success});
}

/// @nodoc
class _$MtlSenterSubmitResponseCopyWithImpl<$Res,
        $Val extends MtlSenterSubmitResponse>
    implements $MtlSenterSubmitResponseCopyWith<$Res> {
  _$MtlSenterSubmitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? success = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MtlSenterSubmitResponseImplCopyWith<$Res>
    implements $MtlSenterSubmitResponseCopyWith<$Res> {
  factory _$$MtlSenterSubmitResponseImplCopyWith(
          _$MtlSenterSubmitResponseImpl value,
          $Res Function(_$MtlSenterSubmitResponseImpl) then) =
      __$$MtlSenterSubmitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, bool? success});
}

/// @nodoc
class __$$MtlSenterSubmitResponseImplCopyWithImpl<$Res>
    extends _$MtlSenterSubmitResponseCopyWithImpl<$Res,
        _$MtlSenterSubmitResponseImpl>
    implements _$$MtlSenterSubmitResponseImplCopyWith<$Res> {
  __$$MtlSenterSubmitResponseImplCopyWithImpl(
      _$MtlSenterSubmitResponseImpl _value,
      $Res Function(_$MtlSenterSubmitResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? success = freezed,
  }) {
    return _then(_$MtlSenterSubmitResponseImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MtlSenterSubmitResponseImpl implements _MtlSenterSubmitResponse {
  const _$MtlSenterSubmitResponseImpl({this.code, this.message, this.success});

  factory _$MtlSenterSubmitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MtlSenterSubmitResponseImplFromJson(json);

  /// 接口状态码
  @override
  final String? code;

  /// 提示信息
  @override
  final String? message;

  /// 是否成功
  @override
  final bool? success;

  @override
  String toString() {
    return 'MtlSenterSubmitResponse(code: $code, message: $message, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MtlSenterSubmitResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MtlSenterSubmitResponseImplCopyWith<_$MtlSenterSubmitResponseImpl>
      get copyWith => __$$MtlSenterSubmitResponseImplCopyWithImpl<
          _$MtlSenterSubmitResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MtlSenterSubmitResponseImplToJson(
      this,
    );
  }
}

abstract class _MtlSenterSubmitResponse implements MtlSenterSubmitResponse {
  const factory _MtlSenterSubmitResponse(
      {final String? code,
      final String? message,
      final bool? success}) = _$MtlSenterSubmitResponseImpl;

  factory _MtlSenterSubmitResponse.fromJson(Map<String, dynamic> json) =
      _$MtlSenterSubmitResponseImpl.fromJson;

  @override

  /// 接口状态码
  String? get code;
  @override

  /// 提示信息
  String? get message;
  @override

  /// 是否成功
  bool? get success;
  @override
  @JsonKey(ignore: true)
  _$$MtlSenterSubmitResponseImplCopyWith<_$MtlSenterSubmitResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
