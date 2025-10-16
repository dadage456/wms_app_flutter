// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_collect_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryTaskItem _$InventoryTaskItemFromJson(Map<String, dynamic> json) {
  return _InventoryTaskItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskItem {
  /// 明细主键
  @JsonKey(name: 'co_checkitemid')
  int? get checkItemId => throw _privateConstructorUsedError;

  /// 任务ID
  @JsonKey(name: 'checktaskid')
  int? get checkTaskId => throw _privateConstructorUsedError;

  /// 任务号
  @JsonKey(name: 'checktaskno')
  String? get checkTaskNo => throw _privateConstructorUsedError;

  /// 盘库单号
  @JsonKey(name: 'taskcomment')
  String? get taskComment => throw _privateConstructorUsedError;

  /// 库房编码
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;

  /// 库房名称
  @JsonKey(name: 'storeroomname')
  String? get storeRoomName => throw _privateConstructorUsedError;

  /// 库位编码
  @JsonKey(name: 'storesiteno')
  String? get storeSiteNo => throw _privateConstructorUsedError;

  /// 库位描述
  @JsonKey(name: 'storesite')
  String? get storeSiteName => throw _privateConstructorUsedError;

  /// 托盘号
  @JsonKey(name: 'palletno')
  String? get palletNo => throw _privateConstructorUsedError;

  /// 物料编码
  @JsonKey(name: 'matcode2')
  String? get materialCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;

  /// 计划数量
  @JsonKey(name: 'qty')
  double get planQty => throw _privateConstructorUsedError;

  /// 已采集数量
  @JsonKey(name: 'collectdataqty')
  double get collectedQty => throw _privateConstructorUsedError;

  /// 盘点类型
  @JsonKey(name: 'checkmethod_nm')
  String? get checkMethodName => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;

  /// 供应商编码
  @JsonKey(name: 'suppliercode')
  String? get supplierCode => throw _privateConstructorUsedError;

  /// 拣选位置/终点地址
  @JsonKey(name: 'endaddr')
  String? get endAddr => throw _privateConstructorUsedError;

  /// ERP 子库
  @JsonKey(name: 'erpstoreroom')
  String? get erpStoreRoom => throw _privateConstructorUsedError;

  /// ERP 库位
  @JsonKey(name: 'erpstoresite')
  String? get erpStoreSite => throw _privateConstructorUsedError;

  /// 物料控制标识
  @JsonKey(name: 'matcontrolflag')
  String? get materialControlFlag => throw _privateConstructorUsedError;

  /// 是否完成
  @JsonKey(name: 'isfinish')
  bool get isFinished => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskItemCopyWith<InventoryTaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskItemCopyWith<$Res> {
  factory $InventoryTaskItemCopyWith(
          InventoryTaskItem value, $Res Function(InventoryTaskItem) then) =
      _$InventoryTaskItemCopyWithImpl<$Res, InventoryTaskItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'co_checkitemid') int? checkItemId,
      @JsonKey(name: 'checktaskid') int? checkTaskId,
      @JsonKey(name: 'checktaskno') String? checkTaskNo,
      @JsonKey(name: 'taskcomment') String? taskComment,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'storeroomname') String? storeRoomName,
      @JsonKey(name: 'storesiteno') String? storeSiteNo,
      @JsonKey(name: 'storesite') String? storeSiteName,
      @JsonKey(name: 'palletno') String? palletNo,
      @JsonKey(name: 'matcode2') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'qty') double planQty,
      @JsonKey(name: 'collectdataqty') double collectedQty,
      @JsonKey(name: 'checkmethod_nm') String? checkMethodName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'suppliercode') String? supplierCode,
      @JsonKey(name: 'endaddr') String? endAddr,
      @JsonKey(name: 'erpstoreroom') String? erpStoreRoom,
      @JsonKey(name: 'erpstoresite') String? erpStoreSite,
      @JsonKey(name: 'matcontrolflag') String? materialControlFlag,
      @JsonKey(name: 'isfinish') bool isFinished});
}

/// @nodoc
class _$InventoryTaskItemCopyWithImpl<$Res, $Val extends InventoryTaskItem>
    implements $InventoryTaskItemCopyWith<$Res> {
  _$InventoryTaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkItemId = freezed,
    Object? checkTaskId = freezed,
    Object? checkTaskNo = freezed,
    Object? taskComment = freezed,
    Object? storeRoomNo = freezed,
    Object? storeRoomName = freezed,
    Object? storeSiteNo = freezed,
    Object? storeSiteName = freezed,
    Object? palletNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? planQty = null,
    Object? collectedQty = null,
    Object? checkMethodName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? supplierCode = freezed,
    Object? endAddr = freezed,
    Object? erpStoreRoom = freezed,
    Object? erpStoreSite = freezed,
    Object? materialControlFlag = freezed,
    Object? isFinished = null,
  }) {
    return _then(_value.copyWith(
      checkItemId: freezed == checkItemId
          ? _value.checkItemId
          : checkItemId // ignore: cast_nullable_to_non_nullable
              as int?,
      checkTaskId: freezed == checkTaskId
          ? _value.checkTaskId
          : checkTaskId // ignore: cast_nullable_to_non_nullable
              as int?,
      checkTaskNo: freezed == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomName: freezed == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteName: freezed == storeSiteName
          ? _value.storeSiteName
          : storeSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      planQty: null == planQty
          ? _value.planQty
          : planQty // ignore: cast_nullable_to_non_nullable
              as double,
      collectedQty: null == collectedQty
          ? _value.collectedQty
          : collectedQty // ignore: cast_nullable_to_non_nullable
              as double,
      checkMethodName: freezed == checkMethodName
          ? _value.checkMethodName
          : checkMethodName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierCode: freezed == supplierCode
          ? _value.supplierCode
          : supplierCode // ignore: cast_nullable_to_non_nullable
              as String?,
      endAddr: freezed == endAddr
          ? _value.endAddr
          : endAddr // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreRoom: freezed == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreSite: freezed == erpStoreSite
          ? _value.erpStoreSite
          : erpStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
      materialControlFlag: freezed == materialControlFlag
          ? _value.materialControlFlag
          : materialControlFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskItemImplCopyWith<$Res>
    implements $InventoryTaskItemCopyWith<$Res> {
  factory _$$InventoryTaskItemImplCopyWith(_$InventoryTaskItemImpl value,
          $Res Function(_$InventoryTaskItemImpl) then) =
      __$$InventoryTaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'co_checkitemid') int? checkItemId,
      @JsonKey(name: 'checktaskid') int? checkTaskId,
      @JsonKey(name: 'checktaskno') String? checkTaskNo,
      @JsonKey(name: 'taskcomment') String? taskComment,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'storeroomname') String? storeRoomName,
      @JsonKey(name: 'storesiteno') String? storeSiteNo,
      @JsonKey(name: 'storesite') String? storeSiteName,
      @JsonKey(name: 'palletno') String? palletNo,
      @JsonKey(name: 'matcode2') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'qty') double planQty,
      @JsonKey(name: 'collectdataqty') double collectedQty,
      @JsonKey(name: 'checkmethod_nm') String? checkMethodName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'suppliercode') String? supplierCode,
      @JsonKey(name: 'endaddr') String? endAddr,
      @JsonKey(name: 'erpstoreroom') String? erpStoreRoom,
      @JsonKey(name: 'erpstoresite') String? erpStoreSite,
      @JsonKey(name: 'matcontrolflag') String? materialControlFlag,
      @JsonKey(name: 'isfinish') bool isFinished});
}

/// @nodoc
class __$$InventoryTaskItemImplCopyWithImpl<$Res>
    extends _$InventoryTaskItemCopyWithImpl<$Res, _$InventoryTaskItemImpl>
    implements _$$InventoryTaskItemImplCopyWith<$Res> {
  __$$InventoryTaskItemImplCopyWithImpl(_$InventoryTaskItemImpl _value,
      $Res Function(_$InventoryTaskItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkItemId = freezed,
    Object? checkTaskId = freezed,
    Object? checkTaskNo = freezed,
    Object? taskComment = freezed,
    Object? storeRoomNo = freezed,
    Object? storeRoomName = freezed,
    Object? storeSiteNo = freezed,
    Object? storeSiteName = freezed,
    Object? palletNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? planQty = null,
    Object? collectedQty = null,
    Object? checkMethodName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? supplierCode = freezed,
    Object? endAddr = freezed,
    Object? erpStoreRoom = freezed,
    Object? erpStoreSite = freezed,
    Object? materialControlFlag = freezed,
    Object? isFinished = null,
  }) {
    return _then(_$InventoryTaskItemImpl(
      checkItemId: freezed == checkItemId
          ? _value.checkItemId
          : checkItemId // ignore: cast_nullable_to_non_nullable
              as int?,
      checkTaskId: freezed == checkTaskId
          ? _value.checkTaskId
          : checkTaskId // ignore: cast_nullable_to_non_nullable
              as int?,
      checkTaskNo: freezed == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomName: freezed == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteName: freezed == storeSiteName
          ? _value.storeSiteName
          : storeSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      planQty: null == planQty
          ? _value.planQty
          : planQty // ignore: cast_nullable_to_non_nullable
              as double,
      collectedQty: null == collectedQty
          ? _value.collectedQty
          : collectedQty // ignore: cast_nullable_to_non_nullable
              as double,
      checkMethodName: freezed == checkMethodName
          ? _value.checkMethodName
          : checkMethodName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierCode: freezed == supplierCode
          ? _value.supplierCode
          : supplierCode // ignore: cast_nullable_to_non_nullable
              as String?,
      endAddr: freezed == endAddr
          ? _value.endAddr
          : endAddr // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreRoom: freezed == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreSite: freezed == erpStoreSite
          ? _value.erpStoreSite
          : erpStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
      materialControlFlag: freezed == materialControlFlag
          ? _value.materialControlFlag
          : materialControlFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskItemImpl extends _InventoryTaskItem {
  const _$InventoryTaskItemImpl(
      {@JsonKey(name: 'co_checkitemid') this.checkItemId,
      @JsonKey(name: 'checktaskid') this.checkTaskId,
      @JsonKey(name: 'checktaskno') this.checkTaskNo,
      @JsonKey(name: 'taskcomment') this.taskComment,
      @JsonKey(name: 'storeroomno') this.storeRoomNo,
      @JsonKey(name: 'storeroomname') this.storeRoomName,
      @JsonKey(name: 'storesiteno') this.storeSiteNo,
      @JsonKey(name: 'storesite') this.storeSiteName,
      @JsonKey(name: 'palletno') this.palletNo,
      @JsonKey(name: 'matcode2') this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'qty') this.planQty = 0,
      @JsonKey(name: 'collectdataqty') this.collectedQty = 0,
      @JsonKey(name: 'checkmethod_nm') this.checkMethodName,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'suppliercode') this.supplierCode,
      @JsonKey(name: 'endaddr') this.endAddr,
      @JsonKey(name: 'erpstoreroom') this.erpStoreRoom,
      @JsonKey(name: 'erpstoresite') this.erpStoreSite,
      @JsonKey(name: 'matcontrolflag') this.materialControlFlag,
      @JsonKey(name: 'isfinish') this.isFinished = false})
      : super._();

  factory _$InventoryTaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskItemImplFromJson(json);

  /// 明细主键
  @override
  @JsonKey(name: 'co_checkitemid')
  final int? checkItemId;

  /// 任务ID
  @override
  @JsonKey(name: 'checktaskid')
  final int? checkTaskId;

  /// 任务号
  @override
  @JsonKey(name: 'checktaskno')
  final String? checkTaskNo;

  /// 盘库单号
  @override
  @JsonKey(name: 'taskcomment')
  final String? taskComment;

  /// 库房编码
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;

  /// 库房名称
  @override
  @JsonKey(name: 'storeroomname')
  final String? storeRoomName;

  /// 库位编码
  @override
  @JsonKey(name: 'storesiteno')
  final String? storeSiteNo;

  /// 库位描述
  @override
  @JsonKey(name: 'storesite')
  final String? storeSiteName;

  /// 托盘号
  @override
  @JsonKey(name: 'palletno')
  final String? palletNo;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode2')
  final String? materialCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  final String? materialName;

  /// 计划数量
  @override
  @JsonKey(name: 'qty')
  final double planQty;

  /// 已采集数量
  @override
  @JsonKey(name: 'collectdataqty')
  final double collectedQty;

  /// 盘点类型
  @override
  @JsonKey(name: 'checkmethod_nm')
  final String? checkMethodName;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;

  /// 供应商编码
  @override
  @JsonKey(name: 'suppliercode')
  final String? supplierCode;

  /// 拣选位置/终点地址
  @override
  @JsonKey(name: 'endaddr')
  final String? endAddr;

  /// ERP 子库
  @override
  @JsonKey(name: 'erpstoreroom')
  final String? erpStoreRoom;

  /// ERP 库位
  @override
  @JsonKey(name: 'erpstoresite')
  final String? erpStoreSite;

  /// 物料控制标识
  @override
  @JsonKey(name: 'matcontrolflag')
  final String? materialControlFlag;

  /// 是否完成
  @override
  @JsonKey(name: 'isfinish')
  final bool isFinished;

  @override
  String toString() {
    return 'InventoryTaskItem(checkItemId: $checkItemId, checkTaskId: $checkTaskId, checkTaskNo: $checkTaskNo, taskComment: $taskComment, storeRoomNo: $storeRoomNo, storeRoomName: $storeRoomName, storeSiteNo: $storeSiteNo, storeSiteName: $storeSiteName, palletNo: $palletNo, materialCode: $materialCode, materialName: $materialName, planQty: $planQty, collectedQty: $collectedQty, checkMethodName: $checkMethodName, batchNo: $batchNo, serialNo: $serialNo, supplierCode: $supplierCode, endAddr: $endAddr, erpStoreRoom: $erpStoreRoom, erpStoreSite: $erpStoreSite, materialControlFlag: $materialControlFlag, isFinished: $isFinished)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskItemImpl &&
            (identical(other.checkItemId, checkItemId) ||
                other.checkItemId == checkItemId) &&
            (identical(other.checkTaskId, checkTaskId) ||
                other.checkTaskId == checkTaskId) &&
            (identical(other.checkTaskNo, checkTaskNo) ||
                other.checkTaskNo == checkTaskNo) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeRoomName, storeRoomName) ||
                other.storeRoomName == storeRoomName) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeSiteName, storeSiteName) ||
                other.storeSiteName == storeSiteName) &&
            (identical(other.palletNo, palletNo) ||
                other.palletNo == palletNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.planQty, planQty) || other.planQty == planQty) &&
            (identical(other.collectedQty, collectedQty) ||
                other.collectedQty == collectedQty) &&
            (identical(other.checkMethodName, checkMethodName) ||
                other.checkMethodName == checkMethodName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.supplierCode, supplierCode) ||
                other.supplierCode == supplierCode) &&
            (identical(other.endAddr, endAddr) || other.endAddr == endAddr) &&
            (identical(other.erpStoreRoom, erpStoreRoom) ||
                other.erpStoreRoom == erpStoreRoom) &&
            (identical(other.erpStoreSite, erpStoreSite) ||
                other.erpStoreSite == erpStoreSite) &&
            (identical(other.materialControlFlag, materialControlFlag) ||
                other.materialControlFlag == materialControlFlag) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        checkItemId,
        checkTaskId,
        checkTaskNo,
        taskComment,
        storeRoomNo,
        storeRoomName,
        storeSiteNo,
        storeSiteName,
        palletNo,
        materialCode,
        materialName,
        planQty,
        collectedQty,
        checkMethodName,
        batchNo,
        serialNo,
        supplierCode,
        endAddr,
        erpStoreRoom,
        erpStoreSite,
        materialControlFlag,
        isFinished
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskItemImplCopyWith<_$InventoryTaskItemImpl> get copyWith =>
      __$$InventoryTaskItemImplCopyWithImpl<_$InventoryTaskItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskItemImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskItem extends InventoryTaskItem {
  const factory _InventoryTaskItem(
          {@JsonKey(name: 'co_checkitemid') final int? checkItemId,
          @JsonKey(name: 'checktaskid') final int? checkTaskId,
          @JsonKey(name: 'checktaskno') final String? checkTaskNo,
          @JsonKey(name: 'taskcomment') final String? taskComment,
          @JsonKey(name: 'storeroomno') final String? storeRoomNo,
          @JsonKey(name: 'storeroomname') final String? storeRoomName,
          @JsonKey(name: 'storesiteno') final String? storeSiteNo,
          @JsonKey(name: 'storesite') final String? storeSiteName,
          @JsonKey(name: 'palletno') final String? palletNo,
          @JsonKey(name: 'matcode2') final String? materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'qty') final double planQty,
          @JsonKey(name: 'collectdataqty') final double collectedQty,
          @JsonKey(name: 'checkmethod_nm') final String? checkMethodName,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNo,
          @JsonKey(name: 'suppliercode') final String? supplierCode,
          @JsonKey(name: 'endaddr') final String? endAddr,
          @JsonKey(name: 'erpstoreroom') final String? erpStoreRoom,
          @JsonKey(name: 'erpstoresite') final String? erpStoreSite,
          @JsonKey(name: 'matcontrolflag') final String? materialControlFlag,
          @JsonKey(name: 'isfinish') final bool isFinished}) =
      _$InventoryTaskItemImpl;
  const _InventoryTaskItem._() : super._();

  factory _InventoryTaskItem.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskItemImpl.fromJson;

  @override

  /// 明细主键
  @JsonKey(name: 'co_checkitemid')
  int? get checkItemId;
  @override

  /// 任务ID
  @JsonKey(name: 'checktaskid')
  int? get checkTaskId;
  @override

  /// 任务号
  @JsonKey(name: 'checktaskno')
  String? get checkTaskNo;
  @override

  /// 盘库单号
  @JsonKey(name: 'taskcomment')
  String? get taskComment;
  @override

  /// 库房编码
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;
  @override

  /// 库房名称
  @JsonKey(name: 'storeroomname')
  String? get storeRoomName;
  @override

  /// 库位编码
  @JsonKey(name: 'storesiteno')
  String? get storeSiteNo;
  @override

  /// 库位描述
  @JsonKey(name: 'storesite')
  String? get storeSiteName;
  @override

  /// 托盘号
  @JsonKey(name: 'palletno')
  String? get palletNo;
  @override

  /// 物料编码
  @JsonKey(name: 'matcode2')
  String? get materialCode;
  @override

  /// 物料名称
  @JsonKey(name: 'matname')
  String? get materialName;
  @override

  /// 计划数量
  @JsonKey(name: 'qty')
  double get planQty;
  @override

  /// 已采集数量
  @JsonKey(name: 'collectdataqty')
  double get collectedQty;
  @override

  /// 盘点类型
  @JsonKey(name: 'checkmethod_nm')
  String? get checkMethodName;
  @override

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override

  /// 供应商编码
  @JsonKey(name: 'suppliercode')
  String? get supplierCode;
  @override

  /// 拣选位置/终点地址
  @JsonKey(name: 'endaddr')
  String? get endAddr;
  @override

  /// ERP 子库
  @JsonKey(name: 'erpstoreroom')
  String? get erpStoreRoom;
  @override

  /// ERP 库位
  @JsonKey(name: 'erpstoresite')
  String? get erpStoreSite;
  @override

  /// 物料控制标识
  @JsonKey(name: 'matcontrolflag')
  String? get materialControlFlag;
  @override

  /// 是否完成
  @JsonKey(name: 'isfinish')
  bool get isFinished;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskItemImplCopyWith<_$InventoryTaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryCollectingRecord _$InventoryCollectingRecordFromJson(
    Map<String, dynamic> json) {
  return _InventoryCollectingRecord.fromJson(json);
}

/// @nodoc
mixin _$InventoryCollectingRecord {
  /// 盘库单号
  @JsonKey(name: 'TaskComment')
  String get taskComment => throw _privateConstructorUsedError;

  /// 任务明细 ID
  @JsonKey(name: 'invTaskItemid')
  String get taskItemId => throw _privateConstructorUsedError;

  /// 物料编码
  @JsonKey(name: 'matCode')
  String get materialCode => throw _privateConstructorUsedError;

  /// 物料主数据 ID
  @JsonKey(name: 'materialId')
  String? get materialId => throw _privateConstructorUsedError;

  /// 库房编码
  @JsonKey(name: 'storeRoomNo')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 库位编码
  @JsonKey(name: 'storeSiteNo')
  String get storeSiteNo => throw _privateConstructorUsedError;

  /// 采集数量
  @JsonKey(name: 'collectQty')
  double get collectQty => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchNo')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;

  /// 托盘号
  @JsonKey(name: 'trayNo')
  String? get trayNo => throw _privateConstructorUsedError;

  /// 采集时间
  @JsonKey(
      name: 'collectedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get collectedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCollectingRecordCopyWith<InventoryCollectingRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectingRecordCopyWith<$Res> {
  factory $InventoryCollectingRecordCopyWith(InventoryCollectingRecord value,
          $Res Function(InventoryCollectingRecord) then) =
      _$InventoryCollectingRecordCopyWithImpl<$Res, InventoryCollectingRecord>;
  @useResult
  $Res call(
      {@JsonKey(name: 'TaskComment') String taskComment,
      @JsonKey(name: 'invTaskItemid') String taskItemId,
      @JsonKey(name: 'matCode') String materialCode,
      @JsonKey(name: 'materialId') String? materialId,
      @JsonKey(name: 'storeRoomNo') String storeRoomNo,
      @JsonKey(name: 'storeSiteNo') String storeSiteNo,
      @JsonKey(name: 'collectQty') double collectQty,
      @JsonKey(name: 'batchNo') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'trayNo') String? trayNo,
      @JsonKey(
          name: 'collectedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      DateTime? collectedAt});
}

/// @nodoc
class _$InventoryCollectingRecordCopyWithImpl<$Res,
        $Val extends InventoryCollectingRecord>
    implements $InventoryCollectingRecordCopyWith<$Res> {
  _$InventoryCollectingRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskComment = null,
    Object? taskItemId = null,
    Object? materialCode = null,
    Object? materialId = freezed,
    Object? storeRoomNo = null,
    Object? storeSiteNo = null,
    Object? collectQty = null,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? trayNo = freezed,
    Object? collectedAt = freezed,
  }) {
    return _then(_value.copyWith(
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      taskItemId: null == taskItemId
          ? _value.taskItemId
          : taskItemId // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialId: freezed == materialId
          ? _value.materialId
          : materialId // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      trayNo: freezed == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String?,
      collectedAt: freezed == collectedAt
          ? _value.collectedAt
          : collectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryCollectingRecordImplCopyWith<$Res>
    implements $InventoryCollectingRecordCopyWith<$Res> {
  factory _$$InventoryCollectingRecordImplCopyWith(
          _$InventoryCollectingRecordImpl value,
          $Res Function(_$InventoryCollectingRecordImpl) then) =
      __$$InventoryCollectingRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'TaskComment') String taskComment,
      @JsonKey(name: 'invTaskItemid') String taskItemId,
      @JsonKey(name: 'matCode') String materialCode,
      @JsonKey(name: 'materialId') String? materialId,
      @JsonKey(name: 'storeRoomNo') String storeRoomNo,
      @JsonKey(name: 'storeSiteNo') String storeSiteNo,
      @JsonKey(name: 'collectQty') double collectQty,
      @JsonKey(name: 'batchNo') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'trayNo') String? trayNo,
      @JsonKey(
          name: 'collectedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      DateTime? collectedAt});
}

/// @nodoc
class __$$InventoryCollectingRecordImplCopyWithImpl<$Res>
    extends _$InventoryCollectingRecordCopyWithImpl<$Res,
        _$InventoryCollectingRecordImpl>
    implements _$$InventoryCollectingRecordImplCopyWith<$Res> {
  __$$InventoryCollectingRecordImplCopyWithImpl(
      _$InventoryCollectingRecordImpl _value,
      $Res Function(_$InventoryCollectingRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskComment = null,
    Object? taskItemId = null,
    Object? materialCode = null,
    Object? materialId = freezed,
    Object? storeRoomNo = null,
    Object? storeSiteNo = null,
    Object? collectQty = null,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? trayNo = freezed,
    Object? collectedAt = freezed,
  }) {
    return _then(_$InventoryCollectingRecordImpl(
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      taskItemId: null == taskItemId
          ? _value.taskItemId
          : taskItemId // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialId: freezed == materialId
          ? _value.materialId
          : materialId // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      trayNo: freezed == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String?,
      collectedAt: freezed == collectedAt
          ? _value.collectedAt
          : collectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryCollectingRecordImpl implements _InventoryCollectingRecord {
  const _$InventoryCollectingRecordImpl(
      {@JsonKey(name: 'TaskComment') required this.taskComment,
      @JsonKey(name: 'invTaskItemid') required this.taskItemId,
      @JsonKey(name: 'matCode') required this.materialCode,
      @JsonKey(name: 'materialId') this.materialId,
      @JsonKey(name: 'storeRoomNo') required this.storeRoomNo,
      @JsonKey(name: 'storeSiteNo') required this.storeSiteNo,
      @JsonKey(name: 'collectQty') this.collectQty = 0,
      @JsonKey(name: 'batchNo') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'trayNo') this.trayNo,
      @JsonKey(
          name: 'collectedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      this.collectedAt});

  factory _$InventoryCollectingRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryCollectingRecordImplFromJson(json);

  /// 盘库单号
  @override
  @JsonKey(name: 'TaskComment')
  final String taskComment;

  /// 任务明细 ID
  @override
  @JsonKey(name: 'invTaskItemid')
  final String taskItemId;

  /// 物料编码
  @override
  @JsonKey(name: 'matCode')
  final String materialCode;

  /// 物料主数据 ID
  @override
  @JsonKey(name: 'materialId')
  final String? materialId;

  /// 库房编码
  @override
  @JsonKey(name: 'storeRoomNo')
  final String storeRoomNo;

  /// 库位编码
  @override
  @JsonKey(name: 'storeSiteNo')
  final String storeSiteNo;

  /// 采集数量
  @override
  @JsonKey(name: 'collectQty')
  final double collectQty;

  /// 批次号
  @override
  @JsonKey(name: 'batchNo')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;

  /// 托盘号
  @override
  @JsonKey(name: 'trayNo')
  final String? trayNo;

  /// 采集时间
  @override
  @JsonKey(
      name: 'collectedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? collectedAt;

  @override
  String toString() {
    return 'InventoryCollectingRecord(taskComment: $taskComment, taskItemId: $taskItemId, materialCode: $materialCode, materialId: $materialId, storeRoomNo: $storeRoomNo, storeSiteNo: $storeSiteNo, collectQty: $collectQty, batchNo: $batchNo, serialNo: $serialNo, trayNo: $trayNo, collectedAt: $collectedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCollectingRecordImpl &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.taskItemId, taskItemId) ||
                other.taskItemId == taskItemId) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.collectQty, collectQty) ||
                other.collectQty == collectQty) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.collectedAt, collectedAt) ||
                other.collectedAt == collectedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      taskComment,
      taskItemId,
      materialCode,
      materialId,
      storeRoomNo,
      storeSiteNo,
      collectQty,
      batchNo,
      serialNo,
      trayNo,
      collectedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCollectingRecordImplCopyWith<_$InventoryCollectingRecordImpl>
      get copyWith => __$$InventoryCollectingRecordImplCopyWithImpl<
          _$InventoryCollectingRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryCollectingRecordImplToJson(
      this,
    );
  }
}

abstract class _InventoryCollectingRecord implements InventoryCollectingRecord {
  const factory _InventoryCollectingRecord(
      {@JsonKey(name: 'TaskComment') required final String taskComment,
      @JsonKey(name: 'invTaskItemid') required final String taskItemId,
      @JsonKey(name: 'matCode') required final String materialCode,
      @JsonKey(name: 'materialId') final String? materialId,
      @JsonKey(name: 'storeRoomNo') required final String storeRoomNo,
      @JsonKey(name: 'storeSiteNo') required final String storeSiteNo,
      @JsonKey(name: 'collectQty') final double collectQty,
      @JsonKey(name: 'batchNo') final String? batchNo,
      @JsonKey(name: 'sn') final String? serialNo,
      @JsonKey(name: 'trayNo') final String? trayNo,
      @JsonKey(
          name: 'collectedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      final DateTime? collectedAt}) = _$InventoryCollectingRecordImpl;

  factory _InventoryCollectingRecord.fromJson(Map<String, dynamic> json) =
      _$InventoryCollectingRecordImpl.fromJson;

  @override

  /// 盘库单号
  @JsonKey(name: 'TaskComment')
  String get taskComment;
  @override

  /// 任务明细 ID
  @JsonKey(name: 'invTaskItemid')
  String get taskItemId;
  @override

  /// 物料编码
  @JsonKey(name: 'matCode')
  String get materialCode;
  @override

  /// 物料主数据 ID
  @JsonKey(name: 'materialId')
  String? get materialId;
  @override

  /// 库房编码
  @JsonKey(name: 'storeRoomNo')
  String get storeRoomNo;
  @override

  /// 库位编码
  @JsonKey(name: 'storeSiteNo')
  String get storeSiteNo;
  @override

  /// 采集数量
  @JsonKey(name: 'collectQty')
  double get collectQty;
  @override

  /// 批次号
  @JsonKey(name: 'batchNo')
  String? get batchNo;
  @override

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override

  /// 托盘号
  @JsonKey(name: 'trayNo')
  String? get trayNo;
  @override

  /// 采集时间
  @JsonKey(
      name: 'collectedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get collectedAt;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCollectingRecordImplCopyWith<_$InventoryCollectingRecordImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryCollectCommand _$InventoryCollectCommandFromJson(
    Map<String, dynamic> json) {
  return _InventoryCollectCommand.fromJson(json);
}

/// @nodoc
mixin _$InventoryCollectCommand {
  /// 任务 ID
  @JsonKey(name: 'taskId')
  String get taskId => throw _privateConstructorUsedError;

  /// 任务号
  @JsonKey(name: 'taskNo')
  String get taskNo => throw _privateConstructorUsedError;

  /// 托盘号
  @JsonKey(name: 'trayNo')
  String get trayNo => throw _privateConstructorUsedError;

  /// 起始地址
  @JsonKey(name: 'startAddr')
  String get startAddr => throw _privateConstructorUsedError;

  /// 目标地址
  @JsonKey(name: 'endAddr')
  String get endAddr => throw _privateConstructorUsedError;

  /// 单托盘标识
  @JsonKey(name: 'singleFlag')
  String get singleFlag => throw _privateConstructorUsedError;

  /// 指令类型（用于区分调用的接口）
  @JsonKey(name: 'action')
  InventoryCollectCommandAction get action =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCollectCommandCopyWith<InventoryCollectCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectCommandCopyWith<$Res> {
  factory $InventoryCollectCommandCopyWith(InventoryCollectCommand value,
          $Res Function(InventoryCollectCommand) then) =
      _$InventoryCollectCommandCopyWithImpl<$Res, InventoryCollectCommand>;
  @useResult
  $Res call(
      {@JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'taskNo') String taskNo,
      @JsonKey(name: 'trayNo') String trayNo,
      @JsonKey(name: 'startAddr') String startAddr,
      @JsonKey(name: 'endAddr') String endAddr,
      @JsonKey(name: 'singleFlag') String singleFlag,
      @JsonKey(name: 'action') InventoryCollectCommandAction action});
}

/// @nodoc
class _$InventoryCollectCommandCopyWithImpl<$Res,
        $Val extends InventoryCollectCommand>
    implements $InventoryCollectCommandCopyWith<$Res> {
  _$InventoryCollectCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? taskNo = null,
    Object? trayNo = null,
    Object? startAddr = null,
    Object? endAddr = null,
    Object? singleFlag = null,
    Object? action = null,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      taskNo: null == taskNo
          ? _value.taskNo
          : taskNo // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      startAddr: null == startAddr
          ? _value.startAddr
          : startAddr // ignore: cast_nullable_to_non_nullable
              as String,
      endAddr: null == endAddr
          ? _value.endAddr
          : endAddr // ignore: cast_nullable_to_non_nullable
              as String,
      singleFlag: null == singleFlag
          ? _value.singleFlag
          : singleFlag // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as InventoryCollectCommandAction,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryCollectCommandImplCopyWith<$Res>
    implements $InventoryCollectCommandCopyWith<$Res> {
  factory _$$InventoryCollectCommandImplCopyWith(
          _$InventoryCollectCommandImpl value,
          $Res Function(_$InventoryCollectCommandImpl) then) =
      __$$InventoryCollectCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'taskNo') String taskNo,
      @JsonKey(name: 'trayNo') String trayNo,
      @JsonKey(name: 'startAddr') String startAddr,
      @JsonKey(name: 'endAddr') String endAddr,
      @JsonKey(name: 'singleFlag') String singleFlag,
      @JsonKey(name: 'action') InventoryCollectCommandAction action});
}

/// @nodoc
class __$$InventoryCollectCommandImplCopyWithImpl<$Res>
    extends _$InventoryCollectCommandCopyWithImpl<$Res,
        _$InventoryCollectCommandImpl>
    implements _$$InventoryCollectCommandImplCopyWith<$Res> {
  __$$InventoryCollectCommandImplCopyWithImpl(
      _$InventoryCollectCommandImpl _value,
      $Res Function(_$InventoryCollectCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? taskNo = null,
    Object? trayNo = null,
    Object? startAddr = null,
    Object? endAddr = null,
    Object? singleFlag = null,
    Object? action = null,
  }) {
    return _then(_$InventoryCollectCommandImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      taskNo: null == taskNo
          ? _value.taskNo
          : taskNo // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      startAddr: null == startAddr
          ? _value.startAddr
          : startAddr // ignore: cast_nullable_to_non_nullable
              as String,
      endAddr: null == endAddr
          ? _value.endAddr
          : endAddr // ignore: cast_nullable_to_non_nullable
              as String,
      singleFlag: null == singleFlag
          ? _value.singleFlag
          : singleFlag // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as InventoryCollectCommandAction,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryCollectCommandImpl implements _InventoryCollectCommand {
  const _$InventoryCollectCommandImpl(
      {@JsonKey(name: 'taskId') required this.taskId,
      @JsonKey(name: 'taskNo') required this.taskNo,
      @JsonKey(name: 'trayNo') required this.trayNo,
      @JsonKey(name: 'startAddr') required this.startAddr,
      @JsonKey(name: 'endAddr') required this.endAddr,
      @JsonKey(name: 'singleFlag') this.singleFlag = '0',
      @JsonKey(name: 'action')
      this.action = InventoryCollectCommandAction.inventoryDown});

  factory _$InventoryCollectCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryCollectCommandImplFromJson(json);

  /// 任务 ID
  @override
  @JsonKey(name: 'taskId')
  final String taskId;

  /// 任务号
  @override
  @JsonKey(name: 'taskNo')
  final String taskNo;

  /// 托盘号
  @override
  @JsonKey(name: 'trayNo')
  final String trayNo;

  /// 起始地址
  @override
  @JsonKey(name: 'startAddr')
  final String startAddr;

  /// 目标地址
  @override
  @JsonKey(name: 'endAddr')
  final String endAddr;

  /// 单托盘标识
  @override
  @JsonKey(name: 'singleFlag')
  final String singleFlag;

  /// 指令类型（用于区分调用的接口）
  @override
  @JsonKey(name: 'action')
  final InventoryCollectCommandAction action;

  @override
  String toString() {
    return 'InventoryCollectCommand(taskId: $taskId, taskNo: $taskNo, trayNo: $trayNo, startAddr: $startAddr, endAddr: $endAddr, singleFlag: $singleFlag, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCollectCommandImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.taskNo, taskNo) || other.taskNo == taskNo) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.startAddr, startAddr) ||
                other.startAddr == startAddr) &&
            (identical(other.endAddr, endAddr) || other.endAddr == endAddr) &&
            (identical(other.singleFlag, singleFlag) ||
                other.singleFlag == singleFlag) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskId, taskNo, trayNo,
      startAddr, endAddr, singleFlag, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCollectCommandImplCopyWith<_$InventoryCollectCommandImpl>
      get copyWith => __$$InventoryCollectCommandImplCopyWithImpl<
          _$InventoryCollectCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryCollectCommandImplToJson(
      this,
    );
  }
}

abstract class _InventoryCollectCommand implements InventoryCollectCommand {
  const factory _InventoryCollectCommand(
          {@JsonKey(name: 'taskId') required final String taskId,
          @JsonKey(name: 'taskNo') required final String taskNo,
          @JsonKey(name: 'trayNo') required final String trayNo,
          @JsonKey(name: 'startAddr') required final String startAddr,
          @JsonKey(name: 'endAddr') required final String endAddr,
          @JsonKey(name: 'singleFlag') final String singleFlag,
          @JsonKey(name: 'action')
          final InventoryCollectCommandAction action}) =
      _$InventoryCollectCommandImpl;

  factory _InventoryCollectCommand.fromJson(Map<String, dynamic> json) =
      _$InventoryCollectCommandImpl.fromJson;

  @override

  /// 任务 ID
  @JsonKey(name: 'taskId')
  String get taskId;
  @override

  /// 任务号
  @JsonKey(name: 'taskNo')
  String get taskNo;
  @override

  /// 托盘号
  @JsonKey(name: 'trayNo')
  String get trayNo;
  @override

  /// 起始地址
  @JsonKey(name: 'startAddr')
  String get startAddr;
  @override

  /// 目标地址
  @JsonKey(name: 'endAddr')
  String get endAddr;
  @override

  /// 单托盘标识
  @JsonKey(name: 'singleFlag')
  String get singleFlag;
  @override

  /// 指令类型（用于区分调用的接口）
  @JsonKey(name: 'action')
  InventoryCollectCommandAction get action;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCollectCommandImplCopyWith<_$InventoryCollectCommandImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryCollectStateSnapshot _$InventoryCollectStateSnapshotFromJson(
    Map<String, dynamic> json) {
  return _InventoryCollectStateSnapshot.fromJson(json);
}

/// @nodoc
mixin _$InventoryCollectStateSnapshot {
  /// 任务 ID
  @JsonKey(name: 'taskId')
  String get taskId => throw _privateConstructorUsedError;

  /// 盘库单号
  @JsonKey(name: 'taskComment')
  String get taskComment => throw _privateConstructorUsedError;

  /// 当前托盘号
  @JsonKey(name: 'activeTrayNo')
  String? get activeTrayNo => throw _privateConstructorUsedError;

  /// 当前库位
  @JsonKey(name: 'activeStoreSiteNo')
  String? get activeStoreSiteNo => throw _privateConstructorUsedError;

  /// 最近一次扫描内容
  @JsonKey(name: 'lastScannedCode')
  String? get lastScannedCode => throw _privateConstructorUsedError;

  /// 采集中任务明细
  @JsonKey(name: 'taskItems')
  List<InventoryTaskItem> get taskItems => throw _privateConstructorUsedError;

  /// 已采集记录
  @JsonKey(name: 'collectedRecords')
  List<InventoryCollectingRecord> get collectedRecords =>
      throw _privateConstructorUsedError;

  /// 快照更新时间
  @JsonKey(
      name: 'updatedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCollectStateSnapshotCopyWith<InventoryCollectStateSnapshot>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectStateSnapshotCopyWith<$Res> {
  factory $InventoryCollectStateSnapshotCopyWith(
          InventoryCollectStateSnapshot value,
          $Res Function(InventoryCollectStateSnapshot) then) =
      _$InventoryCollectStateSnapshotCopyWithImpl<$Res,
          InventoryCollectStateSnapshot>;
  @useResult
  $Res call(
      {@JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'taskComment') String taskComment,
      @JsonKey(name: 'activeTrayNo') String? activeTrayNo,
      @JsonKey(name: 'activeStoreSiteNo') String? activeStoreSiteNo,
      @JsonKey(name: 'lastScannedCode') String? lastScannedCode,
      @JsonKey(name: 'taskItems') List<InventoryTaskItem> taskItems,
      @JsonKey(name: 'collectedRecords')
      List<InventoryCollectingRecord> collectedRecords,
      @JsonKey(
          name: 'updatedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      DateTime? updatedAt});
}

/// @nodoc
class _$InventoryCollectStateSnapshotCopyWithImpl<$Res,
        $Val extends InventoryCollectStateSnapshot>
    implements $InventoryCollectStateSnapshotCopyWith<$Res> {
  _$InventoryCollectStateSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? taskComment = null,
    Object? activeTrayNo = freezed,
    Object? activeStoreSiteNo = freezed,
    Object? lastScannedCode = freezed,
    Object? taskItems = null,
    Object? collectedRecords = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      activeTrayNo: freezed == activeTrayNo
          ? _value.activeTrayNo
          : activeTrayNo // ignore: cast_nullable_to_non_nullable
              as String?,
      activeStoreSiteNo: freezed == activeStoreSiteNo
          ? _value.activeStoreSiteNo
          : activeStoreSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      lastScannedCode: freezed == lastScannedCode
          ? _value.lastScannedCode
          : lastScannedCode // ignore: cast_nullable_to_non_nullable
              as String?,
      taskItems: null == taskItems
          ? _value.taskItems
          : taskItems // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskItem>,
      collectedRecords: null == collectedRecords
          ? _value.collectedRecords
          : collectedRecords // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectingRecord>,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryCollectStateSnapshotImplCopyWith<$Res>
    implements $InventoryCollectStateSnapshotCopyWith<$Res> {
  factory _$$InventoryCollectStateSnapshotImplCopyWith(
          _$InventoryCollectStateSnapshotImpl value,
          $Res Function(_$InventoryCollectStateSnapshotImpl) then) =
      __$$InventoryCollectStateSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'taskComment') String taskComment,
      @JsonKey(name: 'activeTrayNo') String? activeTrayNo,
      @JsonKey(name: 'activeStoreSiteNo') String? activeStoreSiteNo,
      @JsonKey(name: 'lastScannedCode') String? lastScannedCode,
      @JsonKey(name: 'taskItems') List<InventoryTaskItem> taskItems,
      @JsonKey(name: 'collectedRecords')
      List<InventoryCollectingRecord> collectedRecords,
      @JsonKey(
          name: 'updatedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      DateTime? updatedAt});
}

/// @nodoc
class __$$InventoryCollectStateSnapshotImplCopyWithImpl<$Res>
    extends _$InventoryCollectStateSnapshotCopyWithImpl<$Res,
        _$InventoryCollectStateSnapshotImpl>
    implements _$$InventoryCollectStateSnapshotImplCopyWith<$Res> {
  __$$InventoryCollectStateSnapshotImplCopyWithImpl(
      _$InventoryCollectStateSnapshotImpl _value,
      $Res Function(_$InventoryCollectStateSnapshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? taskComment = null,
    Object? activeTrayNo = freezed,
    Object? activeStoreSiteNo = freezed,
    Object? lastScannedCode = freezed,
    Object? taskItems = null,
    Object? collectedRecords = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$InventoryCollectStateSnapshotImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      activeTrayNo: freezed == activeTrayNo
          ? _value.activeTrayNo
          : activeTrayNo // ignore: cast_nullable_to_non_nullable
              as String?,
      activeStoreSiteNo: freezed == activeStoreSiteNo
          ? _value.activeStoreSiteNo
          : activeStoreSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      lastScannedCode: freezed == lastScannedCode
          ? _value.lastScannedCode
          : lastScannedCode // ignore: cast_nullable_to_non_nullable
              as String?,
      taskItems: null == taskItems
          ? _value._taskItems
          : taskItems // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskItem>,
      collectedRecords: null == collectedRecords
          ? _value._collectedRecords
          : collectedRecords // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectingRecord>,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryCollectStateSnapshotImpl
    implements _InventoryCollectStateSnapshot {
  const _$InventoryCollectStateSnapshotImpl(
      {@JsonKey(name: 'taskId') required this.taskId,
      @JsonKey(name: 'taskComment') required this.taskComment,
      @JsonKey(name: 'activeTrayNo') this.activeTrayNo,
      @JsonKey(name: 'activeStoreSiteNo') this.activeStoreSiteNo,
      @JsonKey(name: 'lastScannedCode') this.lastScannedCode,
      @JsonKey(name: 'taskItems')
      final List<InventoryTaskItem> taskItems = const <InventoryTaskItem>[],
      @JsonKey(name: 'collectedRecords')
      final List<InventoryCollectingRecord> collectedRecords =
          const <InventoryCollectingRecord>[],
      @JsonKey(
          name: 'updatedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      this.updatedAt})
      : _taskItems = taskItems,
        _collectedRecords = collectedRecords;

  factory _$InventoryCollectStateSnapshotImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InventoryCollectStateSnapshotImplFromJson(json);

  /// 任务 ID
  @override
  @JsonKey(name: 'taskId')
  final String taskId;

  /// 盘库单号
  @override
  @JsonKey(name: 'taskComment')
  final String taskComment;

  /// 当前托盘号
  @override
  @JsonKey(name: 'activeTrayNo')
  final String? activeTrayNo;

  /// 当前库位
  @override
  @JsonKey(name: 'activeStoreSiteNo')
  final String? activeStoreSiteNo;

  /// 最近一次扫描内容
  @override
  @JsonKey(name: 'lastScannedCode')
  final String? lastScannedCode;

  /// 采集中任务明细
  final List<InventoryTaskItem> _taskItems;

  /// 采集中任务明细
  @override
  @JsonKey(name: 'taskItems')
  List<InventoryTaskItem> get taskItems {
    if (_taskItems is EqualUnmodifiableListView) return _taskItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItems);
  }

  /// 已采集记录
  final List<InventoryCollectingRecord> _collectedRecords;

  /// 已采集记录
  @override
  @JsonKey(name: 'collectedRecords')
  List<InventoryCollectingRecord> get collectedRecords {
    if (_collectedRecords is EqualUnmodifiableListView)
      return _collectedRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectedRecords);
  }

  /// 快照更新时间
  @override
  @JsonKey(
      name: 'updatedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'InventoryCollectStateSnapshot(taskId: $taskId, taskComment: $taskComment, activeTrayNo: $activeTrayNo, activeStoreSiteNo: $activeStoreSiteNo, lastScannedCode: $lastScannedCode, taskItems: $taskItems, collectedRecords: $collectedRecords, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCollectStateSnapshotImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.activeTrayNo, activeTrayNo) ||
                other.activeTrayNo == activeTrayNo) &&
            (identical(other.activeStoreSiteNo, activeStoreSiteNo) ||
                other.activeStoreSiteNo == activeStoreSiteNo) &&
            (identical(other.lastScannedCode, lastScannedCode) ||
                other.lastScannedCode == lastScannedCode) &&
            const DeepCollectionEquality()
                .equals(other._taskItems, _taskItems) &&
            const DeepCollectionEquality()
                .equals(other._collectedRecords, _collectedRecords) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      taskId,
      taskComment,
      activeTrayNo,
      activeStoreSiteNo,
      lastScannedCode,
      const DeepCollectionEquality().hash(_taskItems),
      const DeepCollectionEquality().hash(_collectedRecords),
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCollectStateSnapshotImplCopyWith<
          _$InventoryCollectStateSnapshotImpl>
      get copyWith => __$$InventoryCollectStateSnapshotImplCopyWithImpl<
          _$InventoryCollectStateSnapshotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryCollectStateSnapshotImplToJson(
      this,
    );
  }
}

abstract class _InventoryCollectStateSnapshot
    implements InventoryCollectStateSnapshot {
  const factory _InventoryCollectStateSnapshot(
      {@JsonKey(name: 'taskId') required final String taskId,
      @JsonKey(name: 'taskComment') required final String taskComment,
      @JsonKey(name: 'activeTrayNo') final String? activeTrayNo,
      @JsonKey(name: 'activeStoreSiteNo') final String? activeStoreSiteNo,
      @JsonKey(name: 'lastScannedCode') final String? lastScannedCode,
      @JsonKey(name: 'taskItems') final List<InventoryTaskItem> taskItems,
      @JsonKey(name: 'collectedRecords')
      final List<InventoryCollectingRecord> collectedRecords,
      @JsonKey(
          name: 'updatedAt',
          fromJson: _dateTimeFromJson,
          toJson: _dateTimeToJson)
      final DateTime? updatedAt}) = _$InventoryCollectStateSnapshotImpl;

  factory _InventoryCollectStateSnapshot.fromJson(Map<String, dynamic> json) =
      _$InventoryCollectStateSnapshotImpl.fromJson;

  @override

  /// 任务 ID
  @JsonKey(name: 'taskId')
  String get taskId;
  @override

  /// 盘库单号
  @JsonKey(name: 'taskComment')
  String get taskComment;
  @override

  /// 当前托盘号
  @JsonKey(name: 'activeTrayNo')
  String? get activeTrayNo;
  @override

  /// 当前库位
  @JsonKey(name: 'activeStoreSiteNo')
  String? get activeStoreSiteNo;
  @override

  /// 最近一次扫描内容
  @JsonKey(name: 'lastScannedCode')
  String? get lastScannedCode;
  @override

  /// 采集中任务明细
  @JsonKey(name: 'taskItems')
  List<InventoryTaskItem> get taskItems;
  @override

  /// 已采集记录
  @JsonKey(name: 'collectedRecords')
  List<InventoryCollectingRecord> get collectedRecords;
  @override

  /// 快照更新时间
  @JsonKey(
      name: 'updatedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCollectStateSnapshotImplCopyWith<
          _$InventoryCollectStateSnapshotImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryPalletInfo _$InventoryPalletInfoFromJson(Map<String, dynamic> json) {
  return _InventoryPalletInfo.fromJson(json);
}

/// @nodoc
mixin _$InventoryPalletInfo {
  /// 托盘号
  @JsonKey(name: 'palletNo')
  String? get palletNo => throw _privateConstructorUsedError;

  /// 库位编码
  @JsonKey(name: 'storeSite')
  String? get storeSite => throw _privateConstructorUsedError;

  /// 库房编码
  @JsonKey(name: 'storeRoom')
  String? get storeRoom => throw _privateConstructorUsedError;

  /// 物料编码
  @JsonKey(name: 'matCode')
  String? get materialCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matName')
  String? get materialName => throw _privateConstructorUsedError;

  /// 库存数量
  @JsonKey(name: 'InventoryQty')
  double get inventoryQty => throw _privateConstructorUsedError;

  /// ERP 子库
  @JsonKey(name: 'erpStoreRoom')
  String? get erpStoreRoom => throw _privateConstructorUsedError;

  /// ERP 库位
  @JsonKey(name: 'erpStoreSite')
  String? get erpStoreSite => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchNo')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryPalletInfoCopyWith<InventoryPalletInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryPalletInfoCopyWith<$Res> {
  factory $InventoryPalletInfoCopyWith(
          InventoryPalletInfo value, $Res Function(InventoryPalletInfo) then) =
      _$InventoryPalletInfoCopyWithImpl<$Res, InventoryPalletInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'palletNo') String? palletNo,
      @JsonKey(name: 'storeSite') String? storeSite,
      @JsonKey(name: 'storeRoom') String? storeRoom,
      @JsonKey(name: 'matCode') String? materialCode,
      @JsonKey(name: 'matName') String? materialName,
      @JsonKey(name: 'InventoryQty') double inventoryQty,
      @JsonKey(name: 'erpStoreRoom') String? erpStoreRoom,
      @JsonKey(name: 'erpStoreSite') String? erpStoreSite,
      @JsonKey(name: 'batchNo') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo});
}

/// @nodoc
class _$InventoryPalletInfoCopyWithImpl<$Res, $Val extends InventoryPalletInfo>
    implements $InventoryPalletInfoCopyWith<$Res> {
  _$InventoryPalletInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? palletNo = freezed,
    Object? storeSite = freezed,
    Object? storeRoom = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? inventoryQty = null,
    Object? erpStoreRoom = freezed,
    Object? erpStoreSite = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
  }) {
    return _then(_value.copyWith(
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: freezed == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoom: freezed == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      inventoryQty: null == inventoryQty
          ? _value.inventoryQty
          : inventoryQty // ignore: cast_nullable_to_non_nullable
              as double,
      erpStoreRoom: freezed == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreSite: freezed == erpStoreSite
          ? _value.erpStoreSite
          : erpStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$InventoryPalletInfoImplCopyWith<$Res>
    implements $InventoryPalletInfoCopyWith<$Res> {
  factory _$$InventoryPalletInfoImplCopyWith(_$InventoryPalletInfoImpl value,
          $Res Function(_$InventoryPalletInfoImpl) then) =
      __$$InventoryPalletInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'palletNo') String? palletNo,
      @JsonKey(name: 'storeSite') String? storeSite,
      @JsonKey(name: 'storeRoom') String? storeRoom,
      @JsonKey(name: 'matCode') String? materialCode,
      @JsonKey(name: 'matName') String? materialName,
      @JsonKey(name: 'InventoryQty') double inventoryQty,
      @JsonKey(name: 'erpStoreRoom') String? erpStoreRoom,
      @JsonKey(name: 'erpStoreSite') String? erpStoreSite,
      @JsonKey(name: 'batchNo') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo});
}

/// @nodoc
class __$$InventoryPalletInfoImplCopyWithImpl<$Res>
    extends _$InventoryPalletInfoCopyWithImpl<$Res, _$InventoryPalletInfoImpl>
    implements _$$InventoryPalletInfoImplCopyWith<$Res> {
  __$$InventoryPalletInfoImplCopyWithImpl(_$InventoryPalletInfoImpl _value,
      $Res Function(_$InventoryPalletInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? palletNo = freezed,
    Object? storeSite = freezed,
    Object? storeRoom = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? inventoryQty = null,
    Object? erpStoreRoom = freezed,
    Object? erpStoreSite = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
  }) {
    return _then(_$InventoryPalletInfoImpl(
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSite: freezed == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoom: freezed == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      inventoryQty: null == inventoryQty
          ? _value.inventoryQty
          : inventoryQty // ignore: cast_nullable_to_non_nullable
              as double,
      erpStoreRoom: freezed == erpStoreRoom
          ? _value.erpStoreRoom
          : erpStoreRoom // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreSite: freezed == erpStoreSite
          ? _value.erpStoreSite
          : erpStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$InventoryPalletInfoImpl implements _InventoryPalletInfo {
  const _$InventoryPalletInfoImpl(
      {@JsonKey(name: 'palletNo') this.palletNo,
      @JsonKey(name: 'storeSite') this.storeSite,
      @JsonKey(name: 'storeRoom') this.storeRoom,
      @JsonKey(name: 'matCode') this.materialCode,
      @JsonKey(name: 'matName') this.materialName,
      @JsonKey(name: 'InventoryQty') this.inventoryQty = 0,
      @JsonKey(name: 'erpStoreRoom') this.erpStoreRoom,
      @JsonKey(name: 'erpStoreSite') this.erpStoreSite,
      @JsonKey(name: 'batchNo') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo});

  factory _$InventoryPalletInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryPalletInfoImplFromJson(json);

  /// 托盘号
  @override
  @JsonKey(name: 'palletNo')
  final String? palletNo;

  /// 库位编码
  @override
  @JsonKey(name: 'storeSite')
  final String? storeSite;

  /// 库房编码
  @override
  @JsonKey(name: 'storeRoom')
  final String? storeRoom;

  /// 物料编码
  @override
  @JsonKey(name: 'matCode')
  final String? materialCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matName')
  final String? materialName;

  /// 库存数量
  @override
  @JsonKey(name: 'InventoryQty')
  final double inventoryQty;

  /// ERP 子库
  @override
  @JsonKey(name: 'erpStoreRoom')
  final String? erpStoreRoom;

  /// ERP 库位
  @override
  @JsonKey(name: 'erpStoreSite')
  final String? erpStoreSite;

  /// 批次号
  @override
  @JsonKey(name: 'batchNo')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;

  @override
  String toString() {
    return 'InventoryPalletInfo(palletNo: $palletNo, storeSite: $storeSite, storeRoom: $storeRoom, materialCode: $materialCode, materialName: $materialName, inventoryQty: $inventoryQty, erpStoreRoom: $erpStoreRoom, erpStoreSite: $erpStoreSite, batchNo: $batchNo, serialNo: $serialNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryPalletInfoImpl &&
            (identical(other.palletNo, palletNo) ||
                other.palletNo == palletNo) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.inventoryQty, inventoryQty) ||
                other.inventoryQty == inventoryQty) &&
            (identical(other.erpStoreRoom, erpStoreRoom) ||
                other.erpStoreRoom == erpStoreRoom) &&
            (identical(other.erpStoreSite, erpStoreSite) ||
                other.erpStoreSite == erpStoreSite) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      palletNo,
      storeSite,
      storeRoom,
      materialCode,
      materialName,
      inventoryQty,
      erpStoreRoom,
      erpStoreSite,
      batchNo,
      serialNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryPalletInfoImplCopyWith<_$InventoryPalletInfoImpl> get copyWith =>
      __$$InventoryPalletInfoImplCopyWithImpl<_$InventoryPalletInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryPalletInfoImplToJson(
      this,
    );
  }
}

abstract class _InventoryPalletInfo implements InventoryPalletInfo {
  const factory _InventoryPalletInfo(
      {@JsonKey(name: 'palletNo') final String? palletNo,
      @JsonKey(name: 'storeSite') final String? storeSite,
      @JsonKey(name: 'storeRoom') final String? storeRoom,
      @JsonKey(name: 'matCode') final String? materialCode,
      @JsonKey(name: 'matName') final String? materialName,
      @JsonKey(name: 'InventoryQty') final double inventoryQty,
      @JsonKey(name: 'erpStoreRoom') final String? erpStoreRoom,
      @JsonKey(name: 'erpStoreSite') final String? erpStoreSite,
      @JsonKey(name: 'batchNo') final String? batchNo,
      @JsonKey(name: 'sn') final String? serialNo}) = _$InventoryPalletInfoImpl;

  factory _InventoryPalletInfo.fromJson(Map<String, dynamic> json) =
      _$InventoryPalletInfoImpl.fromJson;

  @override

  /// 托盘号
  @JsonKey(name: 'palletNo')
  String? get palletNo;
  @override

  /// 库位编码
  @JsonKey(name: 'storeSite')
  String? get storeSite;
  @override

  /// 库房编码
  @JsonKey(name: 'storeRoom')
  String? get storeRoom;
  @override

  /// 物料编码
  @JsonKey(name: 'matCode')
  String? get materialCode;
  @override

  /// 物料名称
  @JsonKey(name: 'matName')
  String? get materialName;
  @override

  /// 库存数量
  @JsonKey(name: 'InventoryQty')
  double get inventoryQty;
  @override

  /// ERP 子库
  @JsonKey(name: 'erpStoreRoom')
  String? get erpStoreRoom;
  @override

  /// ERP 库位
  @JsonKey(name: 'erpStoreSite')
  String? get erpStoreSite;
  @override

  /// 批次号
  @JsonKey(name: 'batchNo')
  String? get batchNo;
  @override

  /// 序列号
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override
  @JsonKey(ignore: true)
  _$$InventoryPalletInfoImplCopyWith<_$InventoryPalletInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryMatControl _$InventoryMatControlFromJson(Map<String, dynamic> json) {
  return _InventoryMatControl.fromJson(json);
}

/// @nodoc
mixin _$InventoryMatControl {
  /// 物料编码
  @JsonKey(name: 'matCode')
  String? get materialCode => throw _privateConstructorUsedError;

  /// 批次管控
  @JsonKey(name: 'batchFlag')
  bool get batchRequired => throw _privateConstructorUsedError;

  /// 供应商校验
  @JsonKey(name: 'supplierFlag')
  bool get supplierRequired => throw _privateConstructorUsedError;

  /// 序列号管控
  @JsonKey(name: 'snFlag')
  bool get serialRequired => throw _privateConstructorUsedError;

  /// 有效期校验
  @JsonKey(name: 'validFlag')
  bool get validityRequired => throw _privateConstructorUsedError;

  /// 控制标记
  @JsonKey(name: 'matControlFlag')
  String? get controlFlag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryMatControlCopyWith<InventoryMatControl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryMatControlCopyWith<$Res> {
  factory $InventoryMatControlCopyWith(
          InventoryMatControl value, $Res Function(InventoryMatControl) then) =
      _$InventoryMatControlCopyWithImpl<$Res, InventoryMatControl>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matCode') String? materialCode,
      @JsonKey(name: 'batchFlag') bool batchRequired,
      @JsonKey(name: 'supplierFlag') bool supplierRequired,
      @JsonKey(name: 'snFlag') bool serialRequired,
      @JsonKey(name: 'validFlag') bool validityRequired,
      @JsonKey(name: 'matControlFlag') String? controlFlag});
}

/// @nodoc
class _$InventoryMatControlCopyWithImpl<$Res, $Val extends InventoryMatControl>
    implements $InventoryMatControlCopyWith<$Res> {
  _$InventoryMatControlCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? batchRequired = null,
    Object? supplierRequired = null,
    Object? serialRequired = null,
    Object? validityRequired = null,
    Object? controlFlag = freezed,
  }) {
    return _then(_value.copyWith(
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      batchRequired: null == batchRequired
          ? _value.batchRequired
          : batchRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      supplierRequired: null == supplierRequired
          ? _value.supplierRequired
          : supplierRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      serialRequired: null == serialRequired
          ? _value.serialRequired
          : serialRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      validityRequired: null == validityRequired
          ? _value.validityRequired
          : validityRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      controlFlag: freezed == controlFlag
          ? _value.controlFlag
          : controlFlag // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryMatControlImplCopyWith<$Res>
    implements $InventoryMatControlCopyWith<$Res> {
  factory _$$InventoryMatControlImplCopyWith(_$InventoryMatControlImpl value,
          $Res Function(_$InventoryMatControlImpl) then) =
      __$$InventoryMatControlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matCode') String? materialCode,
      @JsonKey(name: 'batchFlag') bool batchRequired,
      @JsonKey(name: 'supplierFlag') bool supplierRequired,
      @JsonKey(name: 'snFlag') bool serialRequired,
      @JsonKey(name: 'validFlag') bool validityRequired,
      @JsonKey(name: 'matControlFlag') String? controlFlag});
}

/// @nodoc
class __$$InventoryMatControlImplCopyWithImpl<$Res>
    extends _$InventoryMatControlCopyWithImpl<$Res, _$InventoryMatControlImpl>
    implements _$$InventoryMatControlImplCopyWith<$Res> {
  __$$InventoryMatControlImplCopyWithImpl(_$InventoryMatControlImpl _value,
      $Res Function(_$InventoryMatControlImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? batchRequired = null,
    Object? supplierRequired = null,
    Object? serialRequired = null,
    Object? validityRequired = null,
    Object? controlFlag = freezed,
  }) {
    return _then(_$InventoryMatControlImpl(
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      batchRequired: null == batchRequired
          ? _value.batchRequired
          : batchRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      supplierRequired: null == supplierRequired
          ? _value.supplierRequired
          : supplierRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      serialRequired: null == serialRequired
          ? _value.serialRequired
          : serialRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      validityRequired: null == validityRequired
          ? _value.validityRequired
          : validityRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      controlFlag: freezed == controlFlag
          ? _value.controlFlag
          : controlFlag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryMatControlImpl implements _InventoryMatControl {
  const _$InventoryMatControlImpl(
      {@JsonKey(name: 'matCode') this.materialCode,
      @JsonKey(name: 'batchFlag') this.batchRequired = true,
      @JsonKey(name: 'supplierFlag') this.supplierRequired = true,
      @JsonKey(name: 'snFlag') this.serialRequired = false,
      @JsonKey(name: 'validFlag') this.validityRequired = false,
      @JsonKey(name: 'matControlFlag') this.controlFlag});

  factory _$InventoryMatControlImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryMatControlImplFromJson(json);

  /// 物料编码
  @override
  @JsonKey(name: 'matCode')
  final String? materialCode;

  /// 批次管控
  @override
  @JsonKey(name: 'batchFlag')
  final bool batchRequired;

  /// 供应商校验
  @override
  @JsonKey(name: 'supplierFlag')
  final bool supplierRequired;

  /// 序列号管控
  @override
  @JsonKey(name: 'snFlag')
  final bool serialRequired;

  /// 有效期校验
  @override
  @JsonKey(name: 'validFlag')
  final bool validityRequired;

  /// 控制标记
  @override
  @JsonKey(name: 'matControlFlag')
  final String? controlFlag;

  @override
  String toString() {
    return 'InventoryMatControl(materialCode: $materialCode, batchRequired: $batchRequired, supplierRequired: $supplierRequired, serialRequired: $serialRequired, validityRequired: $validityRequired, controlFlag: $controlFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryMatControlImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.batchRequired, batchRequired) ||
                other.batchRequired == batchRequired) &&
            (identical(other.supplierRequired, supplierRequired) ||
                other.supplierRequired == supplierRequired) &&
            (identical(other.serialRequired, serialRequired) ||
                other.serialRequired == serialRequired) &&
            (identical(other.validityRequired, validityRequired) ||
                other.validityRequired == validityRequired) &&
            (identical(other.controlFlag, controlFlag) ||
                other.controlFlag == controlFlag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, materialCode, batchRequired,
      supplierRequired, serialRequired, validityRequired, controlFlag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryMatControlImplCopyWith<_$InventoryMatControlImpl> get copyWith =>
      __$$InventoryMatControlImplCopyWithImpl<_$InventoryMatControlImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryMatControlImplToJson(
      this,
    );
  }
}

abstract class _InventoryMatControl implements InventoryMatControl {
  const factory _InventoryMatControl(
          {@JsonKey(name: 'matCode') final String? materialCode,
          @JsonKey(name: 'batchFlag') final bool batchRequired,
          @JsonKey(name: 'supplierFlag') final bool supplierRequired,
          @JsonKey(name: 'snFlag') final bool serialRequired,
          @JsonKey(name: 'validFlag') final bool validityRequired,
          @JsonKey(name: 'matControlFlag') final String? controlFlag}) =
      _$InventoryMatControlImpl;

  factory _InventoryMatControl.fromJson(Map<String, dynamic> json) =
      _$InventoryMatControlImpl.fromJson;

  @override

  /// 物料编码
  @JsonKey(name: 'matCode')
  String? get materialCode;
  @override

  /// 批次管控
  @JsonKey(name: 'batchFlag')
  bool get batchRequired;
  @override

  /// 供应商校验
  @JsonKey(name: 'supplierFlag')
  bool get supplierRequired;
  @override

  /// 序列号管控
  @JsonKey(name: 'snFlag')
  bool get serialRequired;
  @override

  /// 有效期校验
  @JsonKey(name: 'validFlag')
  bool get validityRequired;
  @override

  /// 控制标记
  @JsonKey(name: 'matControlFlag')
  String? get controlFlag;
  @override
  @JsonKey(ignore: true)
  _$$InventoryMatControlImplCopyWith<_$InventoryMatControlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventorySiteInfo _$InventorySiteInfoFromJson(Map<String, dynamic> json) {
  return _InventorySiteInfo.fromJson(json);
}

/// @nodoc
mixin _$InventorySiteInfo {
  /// 库房编码
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;

  /// 库位编码
  @JsonKey(name: 'storesiteno')
  String? get storeSiteNo => throw _privateConstructorUsedError;

  /// 库位名称
  @JsonKey(name: 'storesite')
  String? get storeSiteName => throw _privateConstructorUsedError;

  /// 锁定状态（0-正常）
  @JsonKey(name: 'isfrozen')
  String? get frozenFlag => throw _privateConstructorUsedError;

  /// ERP 库位
  @JsonKey(name: 'erpstoresite')
  String? get erpStoreSite => throw _privateConstructorUsedError;

  /// 库位属性
  @JsonKey(name: 'siteflag')
  String? get siteFlag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventorySiteInfoCopyWith<InventorySiteInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventorySiteInfoCopyWith<$Res> {
  factory $InventorySiteInfoCopyWith(
          InventorySiteInfo value, $Res Function(InventorySiteInfo) then) =
      _$InventorySiteInfoCopyWithImpl<$Res, InventorySiteInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'storesiteno') String? storeSiteNo,
      @JsonKey(name: 'storesite') String? storeSiteName,
      @JsonKey(name: 'isfrozen') String? frozenFlag,
      @JsonKey(name: 'erpstoresite') String? erpStoreSite,
      @JsonKey(name: 'siteflag') String? siteFlag});
}

/// @nodoc
class _$InventorySiteInfoCopyWithImpl<$Res, $Val extends InventorySiteInfo>
    implements $InventorySiteInfoCopyWith<$Res> {
  _$InventorySiteInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeRoomNo = freezed,
    Object? storeSiteNo = freezed,
    Object? storeSiteName = freezed,
    Object? frozenFlag = freezed,
    Object? erpStoreSite = freezed,
    Object? siteFlag = freezed,
  }) {
    return _then(_value.copyWith(
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteName: freezed == storeSiteName
          ? _value.storeSiteName
          : storeSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      frozenFlag: freezed == frozenFlag
          ? _value.frozenFlag
          : frozenFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreSite: freezed == erpStoreSite
          ? _value.erpStoreSite
          : erpStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
      siteFlag: freezed == siteFlag
          ? _value.siteFlag
          : siteFlag // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventorySiteInfoImplCopyWith<$Res>
    implements $InventorySiteInfoCopyWith<$Res> {
  factory _$$InventorySiteInfoImplCopyWith(_$InventorySiteInfoImpl value,
          $Res Function(_$InventorySiteInfoImpl) then) =
      __$$InventorySiteInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'storesiteno') String? storeSiteNo,
      @JsonKey(name: 'storesite') String? storeSiteName,
      @JsonKey(name: 'isfrozen') String? frozenFlag,
      @JsonKey(name: 'erpstoresite') String? erpStoreSite,
      @JsonKey(name: 'siteflag') String? siteFlag});
}

/// @nodoc
class __$$InventorySiteInfoImplCopyWithImpl<$Res>
    extends _$InventorySiteInfoCopyWithImpl<$Res, _$InventorySiteInfoImpl>
    implements _$$InventorySiteInfoImplCopyWith<$Res> {
  __$$InventorySiteInfoImplCopyWithImpl(_$InventorySiteInfoImpl _value,
      $Res Function(_$InventorySiteInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeRoomNo = freezed,
    Object? storeSiteNo = freezed,
    Object? storeSiteName = freezed,
    Object? frozenFlag = freezed,
    Object? erpStoreSite = freezed,
    Object? siteFlag = freezed,
  }) {
    return _then(_$InventorySiteInfoImpl(
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteName: freezed == storeSiteName
          ? _value.storeSiteName
          : storeSiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      frozenFlag: freezed == frozenFlag
          ? _value.frozenFlag
          : frozenFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      erpStoreSite: freezed == erpStoreSite
          ? _value.erpStoreSite
          : erpStoreSite // ignore: cast_nullable_to_non_nullable
              as String?,
      siteFlag: freezed == siteFlag
          ? _value.siteFlag
          : siteFlag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventorySiteInfoImpl implements _InventorySiteInfo {
  const _$InventorySiteInfoImpl(
      {@JsonKey(name: 'storeroomno') this.storeRoomNo,
      @JsonKey(name: 'storesiteno') this.storeSiteNo,
      @JsonKey(name: 'storesite') this.storeSiteName,
      @JsonKey(name: 'isfrozen') this.frozenFlag,
      @JsonKey(name: 'erpstoresite') this.erpStoreSite,
      @JsonKey(name: 'siteflag') this.siteFlag});

  factory _$InventorySiteInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventorySiteInfoImplFromJson(json);

  /// 库房编码
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;

  /// 库位编码
  @override
  @JsonKey(name: 'storesiteno')
  final String? storeSiteNo;

  /// 库位名称
  @override
  @JsonKey(name: 'storesite')
  final String? storeSiteName;

  /// 锁定状态（0-正常）
  @override
  @JsonKey(name: 'isfrozen')
  final String? frozenFlag;

  /// ERP 库位
  @override
  @JsonKey(name: 'erpstoresite')
  final String? erpStoreSite;

  /// 库位属性
  @override
  @JsonKey(name: 'siteflag')
  final String? siteFlag;

  @override
  String toString() {
    return 'InventorySiteInfo(storeRoomNo: $storeRoomNo, storeSiteNo: $storeSiteNo, storeSiteName: $storeSiteName, frozenFlag: $frozenFlag, erpStoreSite: $erpStoreSite, siteFlag: $siteFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventorySiteInfoImpl &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeSiteName, storeSiteName) ||
                other.storeSiteName == storeSiteName) &&
            (identical(other.frozenFlag, frozenFlag) ||
                other.frozenFlag == frozenFlag) &&
            (identical(other.erpStoreSite, erpStoreSite) ||
                other.erpStoreSite == erpStoreSite) &&
            (identical(other.siteFlag, siteFlag) ||
                other.siteFlag == siteFlag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, storeRoomNo, storeSiteNo,
      storeSiteName, frozenFlag, erpStoreSite, siteFlag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventorySiteInfoImplCopyWith<_$InventorySiteInfoImpl> get copyWith =>
      __$$InventorySiteInfoImplCopyWithImpl<_$InventorySiteInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventorySiteInfoImplToJson(
      this,
    );
  }
}

abstract class _InventorySiteInfo implements InventorySiteInfo {
  const factory _InventorySiteInfo(
          {@JsonKey(name: 'storeroomno') final String? storeRoomNo,
          @JsonKey(name: 'storesiteno') final String? storeSiteNo,
          @JsonKey(name: 'storesite') final String? storeSiteName,
          @JsonKey(name: 'isfrozen') final String? frozenFlag,
          @JsonKey(name: 'erpstoresite') final String? erpStoreSite,
          @JsonKey(name: 'siteflag') final String? siteFlag}) =
      _$InventorySiteInfoImpl;

  factory _InventorySiteInfo.fromJson(Map<String, dynamic> json) =
      _$InventorySiteInfoImpl.fromJson;

  @override

  /// 库房编码
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;
  @override

  /// 库位编码
  @JsonKey(name: 'storesiteno')
  String? get storeSiteNo;
  @override

  /// 库位名称
  @JsonKey(name: 'storesite')
  String? get storeSiteName;
  @override

  /// 锁定状态（0-正常）
  @JsonKey(name: 'isfrozen')
  String? get frozenFlag;
  @override

  /// ERP 库位
  @JsonKey(name: 'erpstoresite')
  String? get erpStoreSite;
  @override

  /// 库位属性
  @JsonKey(name: 'siteflag')
  String? get siteFlag;
  @override
  @JsonKey(ignore: true)
  _$$InventorySiteInfoImplCopyWith<_$InventorySiteInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryTaskItemQuery _$InventoryTaskItemQueryFromJson(
    Map<String, dynamic> json) {
  return _InventoryTaskItemQuery.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskItemQuery {
  @JsonKey(name: 'taskcomment')
  String get taskComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'checktaskno')
  String get checkTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'checktaskid')
  String? get checkTaskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortType')
  String? get sortType => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortColumn')
  String? get sortColumn => throw _privateConstructorUsedError;
  @JsonKey(name: 'searchKey')
  String? get searchKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskItemQueryCopyWith<InventoryTaskItemQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskItemQueryCopyWith<$Res> {
  factory $InventoryTaskItemQueryCopyWith(InventoryTaskItemQuery value,
          $Res Function(InventoryTaskItemQuery) then) =
      _$InventoryTaskItemQueryCopyWithImpl<$Res, InventoryTaskItemQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'checktaskno') String checkTaskNo,
      @JsonKey(name: 'checktaskid') String? checkTaskId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'sortType') String? sortType,
      @JsonKey(name: 'sortColumn') String? sortColumn,
      @JsonKey(name: 'searchKey') String? searchKey});
}

/// @nodoc
class _$InventoryTaskItemQueryCopyWithImpl<$Res,
        $Val extends InventoryTaskItemQuery>
    implements $InventoryTaskItemQueryCopyWith<$Res> {
  _$InventoryTaskItemQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskComment = null,
    Object? checkTaskNo = null,
    Object? checkTaskId = freezed,
    Object? roomTag = null,
    Object? sortType = freezed,
    Object? sortColumn = freezed,
    Object? searchKey = freezed,
  }) {
    return _then(_value.copyWith(
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskNo: null == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskId: freezed == checkTaskId
          ? _value.checkTaskId
          : checkTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      sortType: freezed == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as String?,
      sortColumn: freezed == sortColumn
          ? _value.sortColumn
          : sortColumn // ignore: cast_nullable_to_non_nullable
              as String?,
      searchKey: freezed == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskItemQueryImplCopyWith<$Res>
    implements $InventoryTaskItemQueryCopyWith<$Res> {
  factory _$$InventoryTaskItemQueryImplCopyWith(
          _$InventoryTaskItemQueryImpl value,
          $Res Function(_$InventoryTaskItemQueryImpl) then) =
      __$$InventoryTaskItemQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'checktaskno') String checkTaskNo,
      @JsonKey(name: 'checktaskid') String? checkTaskId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'sortType') String? sortType,
      @JsonKey(name: 'sortColumn') String? sortColumn,
      @JsonKey(name: 'searchKey') String? searchKey});
}

/// @nodoc
class __$$InventoryTaskItemQueryImplCopyWithImpl<$Res>
    extends _$InventoryTaskItemQueryCopyWithImpl<$Res,
        _$InventoryTaskItemQueryImpl>
    implements _$$InventoryTaskItemQueryImplCopyWith<$Res> {
  __$$InventoryTaskItemQueryImplCopyWithImpl(
      _$InventoryTaskItemQueryImpl _value,
      $Res Function(_$InventoryTaskItemQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskComment = null,
    Object? checkTaskNo = null,
    Object? checkTaskId = freezed,
    Object? roomTag = null,
    Object? sortType = freezed,
    Object? sortColumn = freezed,
    Object? searchKey = freezed,
  }) {
    return _then(_$InventoryTaskItemQueryImpl(
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskNo: null == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskId: freezed == checkTaskId
          ? _value.checkTaskId
          : checkTaskId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      sortType: freezed == sortType
          ? _value.sortType
          : sortType // ignore: cast_nullable_to_non_nullable
              as String?,
      sortColumn: freezed == sortColumn
          ? _value.sortColumn
          : sortColumn // ignore: cast_nullable_to_non_nullable
              as String?,
      searchKey: freezed == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskItemQueryImpl implements _InventoryTaskItemQuery {
  const _$InventoryTaskItemQueryImpl(
      {@JsonKey(name: 'taskcomment') required this.taskComment,
      @JsonKey(name: 'checktaskno') required this.checkTaskNo,
      @JsonKey(name: 'checktaskid') this.checkTaskId,
      @JsonKey(name: 'roomTag') this.roomTag = '1',
      @JsonKey(name: 'sortType') this.sortType,
      @JsonKey(name: 'sortColumn') this.sortColumn,
      @JsonKey(name: 'searchKey') this.searchKey});

  factory _$InventoryTaskItemQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskItemQueryImplFromJson(json);

  @override
  @JsonKey(name: 'taskcomment')
  final String taskComment;
  @override
  @JsonKey(name: 'checktaskno')
  final String checkTaskNo;
  @override
  @JsonKey(name: 'checktaskid')
  final String? checkTaskId;
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;
  @override
  @JsonKey(name: 'sortType')
  final String? sortType;
  @override
  @JsonKey(name: 'sortColumn')
  final String? sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  final String? searchKey;

  @override
  String toString() {
    return 'InventoryTaskItemQuery(taskComment: $taskComment, checkTaskNo: $checkTaskNo, checkTaskId: $checkTaskId, roomTag: $roomTag, sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskItemQueryImpl &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.checkTaskNo, checkTaskNo) ||
                other.checkTaskNo == checkTaskNo) &&
            (identical(other.checkTaskId, checkTaskId) ||
                other.checkTaskId == checkTaskId) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.sortColumn, sortColumn) ||
                other.sortColumn == sortColumn) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskComment, checkTaskNo,
      checkTaskId, roomTag, sortType, sortColumn, searchKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskItemQueryImplCopyWith<_$InventoryTaskItemQueryImpl>
      get copyWith => __$$InventoryTaskItemQueryImplCopyWithImpl<
          _$InventoryTaskItemQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskItemQueryImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskItemQuery implements InventoryTaskItemQuery {
  const factory _InventoryTaskItemQuery(
          {@JsonKey(name: 'taskcomment') required final String taskComment,
          @JsonKey(name: 'checktaskno') required final String checkTaskNo,
          @JsonKey(name: 'checktaskid') final String? checkTaskId,
          @JsonKey(name: 'roomTag') final String roomTag,
          @JsonKey(name: 'sortType') final String? sortType,
          @JsonKey(name: 'sortColumn') final String? sortColumn,
          @JsonKey(name: 'searchKey') final String? searchKey}) =
      _$InventoryTaskItemQueryImpl;

  factory _InventoryTaskItemQuery.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskItemQueryImpl.fromJson;

  @override
  @JsonKey(name: 'taskcomment')
  String get taskComment;
  @override
  @JsonKey(name: 'checktaskno')
  String get checkTaskNo;
  @override
  @JsonKey(name: 'checktaskid')
  String? get checkTaskId;
  @override
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override
  @JsonKey(name: 'sortType')
  String? get sortType;
  @override
  @JsonKey(name: 'sortColumn')
  String? get sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  String? get searchKey;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskItemQueryImplCopyWith<_$InventoryTaskItemQueryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
