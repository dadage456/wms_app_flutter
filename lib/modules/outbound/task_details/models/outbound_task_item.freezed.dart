// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbound_task_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutboundTaskItem _$OutboundTaskItemFromJson(Map<String, dynamic> json) {
  return _OutboundTaskItem.fromJson(json);
}

/// @nodoc
mixin _$OutboundTaskItem {
  /// 任务明细ID
  @JsonKey(name: 'outtaskitemid')
  int get outTaskItemId => throw _privateConstructorUsedError;

  /// 物料编码
  @JsonKey(name: 'matcode')
  String get matCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matname')
  String get matName => throw _privateConstructorUsedError;

  /// 物料旧编码
  @JsonKey(name: 'matinnercode')
  String? get matInnerCode => throw _privateConstructorUsedError;

  /// 库位编号
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo => throw _privateConstructorUsedError;

  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 子库编码
  @JsonKey(name: 'subinventoryCode')
  String get subInventoryCode => throw _privateConstructorUsedError;

  /// 任务数量
  @JsonKey(name: 'hintqty')
  int get hintQty => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'hintbatchno')
  String? get hintBatchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get sn => throw _privateConstructorUsedError;

  /// 出库单号
  @JsonKey(name: 'orderno')
  String get orderNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskItemCopyWith<OutboundTaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskItemCopyWith<$Res> {
  factory $OutboundTaskItemCopyWith(
          OutboundTaskItem value, $Res Function(OutboundTaskItem) then) =
      _$OutboundTaskItemCopyWithImpl<$Res, OutboundTaskItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskitemid') int outTaskItemId,
      @JsonKey(name: 'matcode') String matCode,
      @JsonKey(name: 'matname') String matName,
      @JsonKey(name: 'matinnercode') String? matInnerCode,
      @JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'subinventoryCode') String subInventoryCode,
      @JsonKey(name: 'hintqty') int hintQty,
      @JsonKey(name: 'hintbatchno') String? hintBatchNo,
      @JsonKey(name: 'sn') String? sn,
      @JsonKey(name: 'orderno') String orderNo});
}

/// @nodoc
class _$OutboundTaskItemCopyWithImpl<$Res, $Val extends OutboundTaskItem>
    implements $OutboundTaskItemCopyWith<$Res> {
  _$OutboundTaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskItemId = null,
    Object? matCode = null,
    Object? matName = null,
    Object? matInnerCode = freezed,
    Object? storeSiteNo = null,
    Object? storeRoomNo = null,
    Object? subInventoryCode = null,
    Object? hintQty = null,
    Object? hintBatchNo = freezed,
    Object? sn = freezed,
    Object? orderNo = null,
  }) {
    return _then(_value.copyWith(
      outTaskItemId: null == outTaskItemId
          ? _value.outTaskItemId
          : outTaskItemId // ignore: cast_nullable_to_non_nullable
              as int,
      matCode: null == matCode
          ? _value.matCode
          : matCode // ignore: cast_nullable_to_non_nullable
              as String,
      matName: null == matName
          ? _value.matName
          : matName // ignore: cast_nullable_to_non_nullable
              as String,
      matInnerCode: freezed == matInnerCode
          ? _value.matInnerCode
          : matInnerCode // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      subInventoryCode: null == subInventoryCode
          ? _value.subInventoryCode
          : subInventoryCode // ignore: cast_nullable_to_non_nullable
              as String,
      hintQty: null == hintQty
          ? _value.hintQty
          : hintQty // ignore: cast_nullable_to_non_nullable
              as int,
      hintBatchNo: freezed == hintBatchNo
          ? _value.hintBatchNo
          : hintBatchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      sn: freezed == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutboundTaskItemImplCopyWith<$Res>
    implements $OutboundTaskItemCopyWith<$Res> {
  factory _$$OutboundTaskItemImplCopyWith(_$OutboundTaskItemImpl value,
          $Res Function(_$OutboundTaskItemImpl) then) =
      __$$OutboundTaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskitemid') int outTaskItemId,
      @JsonKey(name: 'matcode') String matCode,
      @JsonKey(name: 'matname') String matName,
      @JsonKey(name: 'matinnercode') String? matInnerCode,
      @JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'subinventoryCode') String subInventoryCode,
      @JsonKey(name: 'hintqty') int hintQty,
      @JsonKey(name: 'hintbatchno') String? hintBatchNo,
      @JsonKey(name: 'sn') String? sn,
      @JsonKey(name: 'orderno') String orderNo});
}

/// @nodoc
class __$$OutboundTaskItemImplCopyWithImpl<$Res>
    extends _$OutboundTaskItemCopyWithImpl<$Res, _$OutboundTaskItemImpl>
    implements _$$OutboundTaskItemImplCopyWith<$Res> {
  __$$OutboundTaskItemImplCopyWithImpl(_$OutboundTaskItemImpl _value,
      $Res Function(_$OutboundTaskItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskItemId = null,
    Object? matCode = null,
    Object? matName = null,
    Object? matInnerCode = freezed,
    Object? storeSiteNo = null,
    Object? storeRoomNo = null,
    Object? subInventoryCode = null,
    Object? hintQty = null,
    Object? hintBatchNo = freezed,
    Object? sn = freezed,
    Object? orderNo = null,
  }) {
    return _then(_$OutboundTaskItemImpl(
      outTaskItemId: null == outTaskItemId
          ? _value.outTaskItemId
          : outTaskItemId // ignore: cast_nullable_to_non_nullable
              as int,
      matCode: null == matCode
          ? _value.matCode
          : matCode // ignore: cast_nullable_to_non_nullable
              as String,
      matName: null == matName
          ? _value.matName
          : matName // ignore: cast_nullable_to_non_nullable
              as String,
      matInnerCode: freezed == matInnerCode
          ? _value.matInnerCode
          : matInnerCode // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      subInventoryCode: null == subInventoryCode
          ? _value.subInventoryCode
          : subInventoryCode // ignore: cast_nullable_to_non_nullable
              as String,
      hintQty: null == hintQty
          ? _value.hintQty
          : hintQty // ignore: cast_nullable_to_non_nullable
              as int,
      hintBatchNo: freezed == hintBatchNo
          ? _value.hintBatchNo
          : hintBatchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      sn: freezed == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskItemImpl implements _OutboundTaskItem {
  const _$OutboundTaskItemImpl(
      {@JsonKey(name: 'outtaskitemid') required this.outTaskItemId,
      @JsonKey(name: 'matcode') required this.matCode,
      @JsonKey(name: 'matname') required this.matName,
      @JsonKey(name: 'matinnercode') this.matInnerCode,
      @JsonKey(name: 'storesiteno') required this.storeSiteNo,
      @JsonKey(name: 'storeroomno') required this.storeRoomNo,
      @JsonKey(name: 'subinventoryCode') required this.subInventoryCode,
      @JsonKey(name: 'hintqty') required this.hintQty,
      @JsonKey(name: 'hintbatchno') this.hintBatchNo,
      @JsonKey(name: 'sn') this.sn,
      @JsonKey(name: 'orderno') required this.orderNo});

  factory _$OutboundTaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboundTaskItemImplFromJson(json);

  /// 任务明细ID
  @override
  @JsonKey(name: 'outtaskitemid')
  final int outTaskItemId;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String matCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  final String matName;

  /// 物料旧编码
  @override
  @JsonKey(name: 'matinnercode')
  final String? matInnerCode;

  /// 库位编号
  @override
  @JsonKey(name: 'storesiteno')
  final String storeSiteNo;

  /// 库房编号
  @override
  @JsonKey(name: 'storeroomno')
  final String storeRoomNo;

  /// 子库编码
  @override
  @JsonKey(name: 'subinventoryCode')
  final String subInventoryCode;

  /// 任务数量
  @override
  @JsonKey(name: 'hintqty')
  final int hintQty;

  /// 批次号
  @override
  @JsonKey(name: 'hintbatchno')
  final String? hintBatchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? sn;

  /// 出库单号
  @override
  @JsonKey(name: 'orderno')
  final String orderNo;

  @override
  String toString() {
    return 'OutboundTaskItem(outTaskItemId: $outTaskItemId, matCode: $matCode, matName: $matName, matInnerCode: $matInnerCode, storeSiteNo: $storeSiteNo, storeRoomNo: $storeRoomNo, subInventoryCode: $subInventoryCode, hintQty: $hintQty, hintBatchNo: $hintBatchNo, sn: $sn, orderNo: $orderNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskItemImpl &&
            (identical(other.outTaskItemId, outTaskItemId) ||
                other.outTaskItemId == outTaskItemId) &&
            (identical(other.matCode, matCode) || other.matCode == matCode) &&
            (identical(other.matName, matName) || other.matName == matName) &&
            (identical(other.matInnerCode, matInnerCode) ||
                other.matInnerCode == matInnerCode) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.subInventoryCode, subInventoryCode) ||
                other.subInventoryCode == subInventoryCode) &&
            (identical(other.hintQty, hintQty) || other.hintQty == hintQty) &&
            (identical(other.hintBatchNo, hintBatchNo) ||
                other.hintBatchNo == hintBatchNo) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      outTaskItemId,
      matCode,
      matName,
      matInnerCode,
      storeSiteNo,
      storeRoomNo,
      subInventoryCode,
      hintQty,
      hintBatchNo,
      sn,
      orderNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundTaskItemImplCopyWith<_$OutboundTaskItemImpl> get copyWith =>
      __$$OutboundTaskItemImplCopyWithImpl<_$OutboundTaskItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskItemImplToJson(
      this,
    );
  }
}

abstract class _OutboundTaskItem implements OutboundTaskItem {
  const factory _OutboundTaskItem(
      {@JsonKey(name: 'outtaskitemid') required final int outTaskItemId,
      @JsonKey(name: 'matcode') required final String matCode,
      @JsonKey(name: 'matname') required final String matName,
      @JsonKey(name: 'matinnercode') final String? matInnerCode,
      @JsonKey(name: 'storesiteno') required final String storeSiteNo,
      @JsonKey(name: 'storeroomno') required final String storeRoomNo,
      @JsonKey(name: 'subinventoryCode') required final String subInventoryCode,
      @JsonKey(name: 'hintqty') required final int hintQty,
      @JsonKey(name: 'hintbatchno') final String? hintBatchNo,
      @JsonKey(name: 'sn') final String? sn,
      @JsonKey(name: 'orderno')
      required final String orderNo}) = _$OutboundTaskItemImpl;

  factory _OutboundTaskItem.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskItemImpl.fromJson;

  @override

  /// 任务明细ID
  @JsonKey(name: 'outtaskitemid')
  int get outTaskItemId;
  @override

  /// 物料编码
  @JsonKey(name: 'matcode')
  String get matCode;
  @override

  /// 物料名称
  @JsonKey(name: 'matname')
  String get matName;
  @override

  /// 物料旧编码
  @JsonKey(name: 'matinnercode')
  String? get matInnerCode;
  @override

  /// 库位编号
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo;
  @override

  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo;
  @override

  /// 子库编码
  @JsonKey(name: 'subinventoryCode')
  String get subInventoryCode;
  @override

  /// 任务数量
  @JsonKey(name: 'hintqty')
  int get hintQty;
  @override

  /// 批次号
  @JsonKey(name: 'hintbatchno')
  String? get hintBatchNo;
  @override

  /// 序列号
  @JsonKey(name: 'sn')
  String? get sn;
  @override

  /// 出库单号
  @JsonKey(name: 'orderno')
  String get orderNo;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskItemImplCopyWith<_$OutboundTaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutboundTaskItemQuery _$OutboundTaskItemQueryFromJson(
    Map<String, dynamic> json) {
  return _OutboundTaskItemQuery.fromJson(json);
}

/// @nodoc
mixin _$OutboundTaskItemQuery {
  /// 出库任务ID（必填）
  @JsonKey(name: 'outtaskid')
  String get outTaskId => throw _privateConstructorUsedError;

  /// 工作站（必填）
  @JsonKey(name: 'workstation')
  String get workStation => throw _privateConstructorUsedError;

  /// 搜索关键字（物料编码）
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;

  /// 用户ID
  @JsonKey(name: 'userId')
  int get userId => throw _privateConstructorUsedError;

  /// 角色或用户ID
  @JsonKey(name: 'roleoRuserId')
  int get roleOrUserId => throw _privateConstructorUsedError;

  /// 库房标签
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;

  /// 批次标志
  @JsonKey(name: 'batchflag')
  String get batchFlag => throw _privateConstructorUsedError;

  /// 转移类型
  @JsonKey(name: 'transferType')
  String get transferType => throw _privateConstructorUsedError;

  /// 节拍标志
  @JsonKey(name: 'beatflag')
  String get beatFlag => throw _privateConstructorUsedError;

  /// 页码
  @JsonKey(name: 'PageIndex')
  int get pageIndex => throw _privateConstructorUsedError;

  /// 页面大小
  @JsonKey(name: 'PageSize')
  int get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskItemQueryCopyWith<OutboundTaskItemQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskItemQueryCopyWith<$Res> {
  factory $OutboundTaskItemQueryCopyWith(OutboundTaskItemQuery value,
          $Res Function(OutboundTaskItemQuery) then) =
      _$OutboundTaskItemQueryCopyWithImpl<$Res, OutboundTaskItemQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') String outTaskId,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'userId') int userId,
      @JsonKey(name: 'roleoRuserId') int roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'batchflag') String batchFlag,
      @JsonKey(name: 'transferType') String transferType,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize});
}

/// @nodoc
class _$OutboundTaskItemQueryCopyWithImpl<$Res,
        $Val extends OutboundTaskItemQuery>
    implements $OutboundTaskItemQueryCopyWith<$Res> {
  _$OutboundTaskItemQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? workStation = null,
    Object? searchKey = null,
    Object? userId = null,
    Object? roleOrUserId = null,
    Object? roomTag = null,
    Object? batchFlag = null,
    Object? transferType = null,
    Object? beatFlag = null,
    Object? pageIndex = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      searchKey: null == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      roleOrUserId: null == roleOrUserId
          ? _value.roleOrUserId
          : roleOrUserId // ignore: cast_nullable_to_non_nullable
              as int,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      batchFlag: null == batchFlag
          ? _value.batchFlag
          : batchFlag // ignore: cast_nullable_to_non_nullable
              as String,
      transferType: null == transferType
          ? _value.transferType
          : transferType // ignore: cast_nullable_to_non_nullable
              as String,
      beatFlag: null == beatFlag
          ? _value.beatFlag
          : beatFlag // ignore: cast_nullable_to_non_nullable
              as String,
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutboundTaskItemQueryImplCopyWith<$Res>
    implements $OutboundTaskItemQueryCopyWith<$Res> {
  factory _$$OutboundTaskItemQueryImplCopyWith(
          _$OutboundTaskItemQueryImpl value,
          $Res Function(_$OutboundTaskItemQueryImpl) then) =
      __$$OutboundTaskItemQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') String outTaskId,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'userId') int userId,
      @JsonKey(name: 'roleoRuserId') int roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'batchflag') String batchFlag,
      @JsonKey(name: 'transferType') String transferType,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize});
}

/// @nodoc
class __$$OutboundTaskItemQueryImplCopyWithImpl<$Res>
    extends _$OutboundTaskItemQueryCopyWithImpl<$Res,
        _$OutboundTaskItemQueryImpl>
    implements _$$OutboundTaskItemQueryImplCopyWith<$Res> {
  __$$OutboundTaskItemQueryImplCopyWithImpl(_$OutboundTaskItemQueryImpl _value,
      $Res Function(_$OutboundTaskItemQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? workStation = null,
    Object? searchKey = null,
    Object? userId = null,
    Object? roleOrUserId = null,
    Object? roomTag = null,
    Object? batchFlag = null,
    Object? transferType = null,
    Object? beatFlag = null,
    Object? pageIndex = null,
    Object? pageSize = null,
  }) {
    return _then(_$OutboundTaskItemQueryImpl(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      searchKey: null == searchKey
          ? _value.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      roleOrUserId: null == roleOrUserId
          ? _value.roleOrUserId
          : roleOrUserId // ignore: cast_nullable_to_non_nullable
              as int,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      batchFlag: null == batchFlag
          ? _value.batchFlag
          : batchFlag // ignore: cast_nullable_to_non_nullable
              as String,
      transferType: null == transferType
          ? _value.transferType
          : transferType // ignore: cast_nullable_to_non_nullable
              as String,
      beatFlag: null == beatFlag
          ? _value.beatFlag
          : beatFlag // ignore: cast_nullable_to_non_nullable
              as String,
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskItemQueryImpl implements _OutboundTaskItemQuery {
  const _$OutboundTaskItemQueryImpl(
      {@JsonKey(name: 'outtaskid') required this.outTaskId,
      @JsonKey(name: 'workstation') required this.workStation,
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'roleoRuserId') required this.roleOrUserId,
      @JsonKey(name: 'roomTag') this.roomTag = '0',
      @JsonKey(name: 'batchflag') this.batchFlag = '0',
      @JsonKey(name: 'transferType') this.transferType = '0',
      @JsonKey(name: 'beatflag') this.beatFlag = 'N',
      @JsonKey(name: 'PageIndex') this.pageIndex = 1,
      @JsonKey(name: 'PageSize') this.pageSize = 100});

  factory _$OutboundTaskItemQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboundTaskItemQueryImplFromJson(json);

  /// 出库任务ID（必填）
  @override
  @JsonKey(name: 'outtaskid')
  final String outTaskId;

  /// 工作站（必填）
  @override
  @JsonKey(name: 'workstation')
  final String workStation;

  /// 搜索关键字（物料编码）
  @override
  @JsonKey(name: 'searchKey')
  final String searchKey;

  /// 用户ID
  @override
  @JsonKey(name: 'userId')
  final int userId;

  /// 角色或用户ID
  @override
  @JsonKey(name: 'roleoRuserId')
  final int roleOrUserId;

  /// 库房标签
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;

  /// 批次标志
  @override
  @JsonKey(name: 'batchflag')
  final String batchFlag;

  /// 转移类型
  @override
  @JsonKey(name: 'transferType')
  final String transferType;

  /// 节拍标志
  @override
  @JsonKey(name: 'beatflag')
  final String beatFlag;

  /// 页码
  @override
  @JsonKey(name: 'PageIndex')
  final int pageIndex;

  /// 页面大小
  @override
  @JsonKey(name: 'PageSize')
  final int pageSize;

  @override
  String toString() {
    return 'OutboundTaskItemQuery(outTaskId: $outTaskId, workStation: $workStation, searchKey: $searchKey, userId: $userId, roleOrUserId: $roleOrUserId, roomTag: $roomTag, batchFlag: $batchFlag, transferType: $transferType, beatFlag: $beatFlag, pageIndex: $pageIndex, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskItemQueryImpl &&
            (identical(other.outTaskId, outTaskId) ||
                other.outTaskId == outTaskId) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roleOrUserId, roleOrUserId) ||
                other.roleOrUserId == roleOrUserId) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag) &&
            (identical(other.batchFlag, batchFlag) ||
                other.batchFlag == batchFlag) &&
            (identical(other.transferType, transferType) ||
                other.transferType == transferType) &&
            (identical(other.beatFlag, beatFlag) ||
                other.beatFlag == beatFlag) &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      outTaskId,
      workStation,
      searchKey,
      userId,
      roleOrUserId,
      roomTag,
      batchFlag,
      transferType,
      beatFlag,
      pageIndex,
      pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundTaskItemQueryImplCopyWith<_$OutboundTaskItemQueryImpl>
      get copyWith => __$$OutboundTaskItemQueryImplCopyWithImpl<
          _$OutboundTaskItemQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskItemQueryImplToJson(
      this,
    );
  }
}

abstract class _OutboundTaskItemQuery implements OutboundTaskItemQuery {
  const factory _OutboundTaskItemQuery(
          {@JsonKey(name: 'outtaskid') required final String outTaskId,
          @JsonKey(name: 'workstation') required final String workStation,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'userId') required final int userId,
          @JsonKey(name: 'roleoRuserId') required final int roleOrUserId,
          @JsonKey(name: 'roomTag') final String roomTag,
          @JsonKey(name: 'batchflag') final String batchFlag,
          @JsonKey(name: 'transferType') final String transferType,
          @JsonKey(name: 'beatflag') final String beatFlag,
          @JsonKey(name: 'PageIndex') final int pageIndex,
          @JsonKey(name: 'PageSize') final int pageSize}) =
      _$OutboundTaskItemQueryImpl;

  factory _OutboundTaskItemQuery.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskItemQueryImpl.fromJson;

  @override

  /// 出库任务ID（必填）
  @JsonKey(name: 'outtaskid')
  String get outTaskId;
  @override

  /// 工作站（必填）
  @JsonKey(name: 'workstation')
  String get workStation;
  @override

  /// 搜索关键字（物料编码）
  @JsonKey(name: 'searchKey')
  String get searchKey;
  @override

  /// 用户ID
  @JsonKey(name: 'userId')
  int get userId;
  @override

  /// 角色或用户ID
  @JsonKey(name: 'roleoRuserId')
  int get roleOrUserId;
  @override

  /// 库房标签
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override

  /// 批次标志
  @JsonKey(name: 'batchflag')
  String get batchFlag;
  @override

  /// 转移类型
  @JsonKey(name: 'transferType')
  String get transferType;
  @override

  /// 节拍标志
  @JsonKey(name: 'beatflag')
  String get beatFlag;
  @override

  /// 页码
  @JsonKey(name: 'PageIndex')
  int get pageIndex;
  @override

  /// 页面大小
  @JsonKey(name: 'PageSize')
  int get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskItemQueryImplCopyWith<_$OutboundTaskItemQueryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OutboundTaskItemListData _$OutboundTaskItemListDataFromJson(
    Map<String, dynamic> json) {
  return _OutboundTaskItemListData.fromJson(json);
}

/// @nodoc
mixin _$OutboundTaskItemListData {
  /// 明细列表
  @JsonKey(name: 'rows')
  List<OutboundTaskItem> get rows => throw _privateConstructorUsedError;

  /// 总记录数
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskItemListDataCopyWith<OutboundTaskItemListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskItemListDataCopyWith<$Res> {
  factory $OutboundTaskItemListDataCopyWith(OutboundTaskItemListData value,
          $Res Function(OutboundTaskItemListData) then) =
      _$OutboundTaskItemListDataCopyWithImpl<$Res, OutboundTaskItemListData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OutboundTaskItem> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class _$OutboundTaskItemListDataCopyWithImpl<$Res,
        $Val extends OutboundTaskItemListData>
    implements $OutboundTaskItemListDataCopyWith<$Res> {
  _$OutboundTaskItemListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<OutboundTaskItem>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutboundTaskItemListDataImplCopyWith<$Res>
    implements $OutboundTaskItemListDataCopyWith<$Res> {
  factory _$$OutboundTaskItemListDataImplCopyWith(
          _$OutboundTaskItemListDataImpl value,
          $Res Function(_$OutboundTaskItemListDataImpl) then) =
      __$$OutboundTaskItemListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OutboundTaskItem> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class __$$OutboundTaskItemListDataImplCopyWithImpl<$Res>
    extends _$OutboundTaskItemListDataCopyWithImpl<$Res,
        _$OutboundTaskItemListDataImpl>
    implements _$$OutboundTaskItemListDataImplCopyWith<$Res> {
  __$$OutboundTaskItemListDataImplCopyWithImpl(
      _$OutboundTaskItemListDataImpl _value,
      $Res Function(_$OutboundTaskItemListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_$OutboundTaskItemListDataImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<OutboundTaskItem>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskItemListDataImpl implements _OutboundTaskItemListData {
  const _$OutboundTaskItemListDataImpl(
      {@JsonKey(name: 'rows') required final List<OutboundTaskItem> rows,
      @JsonKey(name: 'total') required this.total})
      : _rows = rows;

  factory _$OutboundTaskItemListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboundTaskItemListDataImplFromJson(json);

  /// 明细列表
  final List<OutboundTaskItem> _rows;

  /// 明细列表
  @override
  @JsonKey(name: 'rows')
  List<OutboundTaskItem> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  /// 总记录数
  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'OutboundTaskItemListData(rows: $rows, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskItemListDataImpl &&
            const DeepCollectionEquality().equals(other._rows, _rows) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_rows), total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundTaskItemListDataImplCopyWith<_$OutboundTaskItemListDataImpl>
      get copyWith => __$$OutboundTaskItemListDataImplCopyWithImpl<
          _$OutboundTaskItemListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskItemListDataImplToJson(
      this,
    );
  }
}

abstract class _OutboundTaskItemListData implements OutboundTaskItemListData {
  const factory _OutboundTaskItemListData(
          {@JsonKey(name: 'rows') required final List<OutboundTaskItem> rows,
          @JsonKey(name: 'total') required final int total}) =
      _$OutboundTaskItemListDataImpl;

  factory _OutboundTaskItemListData.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskItemListDataImpl.fromJson;

  @override

  /// 明细列表
  @JsonKey(name: 'rows')
  List<OutboundTaskItem> get rows;
  @override

  /// 总记录数
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskItemListDataImplCopyWith<_$OutboundTaskItemListDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OutboundTaskItemListResponse _$OutboundTaskItemListResponseFromJson(
    Map<String, dynamic> json) {
  return _OutboundTaskItemListResponse.fromJson(json);
}

/// @nodoc
mixin _$OutboundTaskItemListResponse {
  /// 响应码
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;

  /// 响应数据
  @JsonKey(name: 'data')
  OutboundTaskItemListData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskItemListResponseCopyWith<OutboundTaskItemListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskItemListResponseCopyWith<$Res> {
  factory $OutboundTaskItemListResponseCopyWith(
          OutboundTaskItemListResponse value,
          $Res Function(OutboundTaskItemListResponse) then) =
      _$OutboundTaskItemListResponseCopyWithImpl<$Res,
          OutboundTaskItemListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') OutboundTaskItemListData data});

  $OutboundTaskItemListDataCopyWith<$Res> get data;
}

/// @nodoc
class _$OutboundTaskItemListResponseCopyWithImpl<$Res,
        $Val extends OutboundTaskItemListResponse>
    implements $OutboundTaskItemListResponseCopyWith<$Res> {
  _$OutboundTaskItemListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OutboundTaskItemListData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskItemListDataCopyWith<$Res> get data {
    return $OutboundTaskItemListDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OutboundTaskItemListResponseImplCopyWith<$Res>
    implements $OutboundTaskItemListResponseCopyWith<$Res> {
  factory _$$OutboundTaskItemListResponseImplCopyWith(
          _$OutboundTaskItemListResponseImpl value,
          $Res Function(_$OutboundTaskItemListResponseImpl) then) =
      __$$OutboundTaskItemListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') OutboundTaskItemListData data});

  @override
  $OutboundTaskItemListDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$OutboundTaskItemListResponseImplCopyWithImpl<$Res>
    extends _$OutboundTaskItemListResponseCopyWithImpl<$Res,
        _$OutboundTaskItemListResponseImpl>
    implements _$$OutboundTaskItemListResponseImplCopyWith<$Res> {
  __$$OutboundTaskItemListResponseImplCopyWithImpl(
      _$OutboundTaskItemListResponseImpl _value,
      $Res Function(_$OutboundTaskItemListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$OutboundTaskItemListResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OutboundTaskItemListData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskItemListResponseImpl
    implements _OutboundTaskItemListResponse {
  const _$OutboundTaskItemListResponseImpl(
      {@JsonKey(name: 'code') required this.code,
      @JsonKey(name: 'msg') required this.message,
      @JsonKey(name: 'data') required this.data});

  factory _$OutboundTaskItemListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OutboundTaskItemListResponseImplFromJson(json);

  /// 响应码
  @override
  @JsonKey(name: 'code')
  final String code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  final String message;

  /// 响应数据
  @override
  @JsonKey(name: 'data')
  final OutboundTaskItemListData data;

  @override
  String toString() {
    return 'OutboundTaskItemListResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskItemListResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundTaskItemListResponseImplCopyWith<
          _$OutboundTaskItemListResponseImpl>
      get copyWith => __$$OutboundTaskItemListResponseImplCopyWithImpl<
          _$OutboundTaskItemListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskItemListResponseImplToJson(
      this,
    );
  }
}

abstract class _OutboundTaskItemListResponse
    implements OutboundTaskItemListResponse {
  const factory _OutboundTaskItemListResponse(
          {@JsonKey(name: 'code') required final String code,
          @JsonKey(name: 'msg') required final String message,
          @JsonKey(name: 'data')
          required final OutboundTaskItemListData data}) =
      _$OutboundTaskItemListResponseImpl;

  factory _OutboundTaskItemListResponse.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskItemListResponseImpl.fromJson;

  @override

  /// 响应码
  @JsonKey(name: 'code')
  String get code;
  @override

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message;
  @override

  /// 响应数据
  @JsonKey(name: 'data')
  OutboundTaskItemListData get data;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskItemListResponseImplCopyWith<
          _$OutboundTaskItemListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MaterialInfoResponse _$MaterialInfoResponseFromJson(Map<String, dynamic> json) {
  return _MaterialInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$MaterialInfoResponse {
  /// 响应码
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;

  /// 物料信息
  @JsonKey(name: 'data')
  MaterialInfo get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialInfoResponseCopyWith<MaterialInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialInfoResponseCopyWith<$Res> {
  factory $MaterialInfoResponseCopyWith(MaterialInfoResponse value,
          $Res Function(MaterialInfoResponse) then) =
      _$MaterialInfoResponseCopyWithImpl<$Res, MaterialInfoResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') MaterialInfo data});

  $MaterialInfoCopyWith<$Res> get data;
}

/// @nodoc
class _$MaterialInfoResponseCopyWithImpl<$Res,
        $Val extends MaterialInfoResponse>
    implements $MaterialInfoResponseCopyWith<$Res> {
  _$MaterialInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MaterialInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MaterialInfoCopyWith<$Res> get data {
    return $MaterialInfoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MaterialInfoResponseImplCopyWith<$Res>
    implements $MaterialInfoResponseCopyWith<$Res> {
  factory _$$MaterialInfoResponseImplCopyWith(_$MaterialInfoResponseImpl value,
          $Res Function(_$MaterialInfoResponseImpl) then) =
      __$$MaterialInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') MaterialInfo data});

  @override
  $MaterialInfoCopyWith<$Res> get data;
}

/// @nodoc
class __$$MaterialInfoResponseImplCopyWithImpl<$Res>
    extends _$MaterialInfoResponseCopyWithImpl<$Res, _$MaterialInfoResponseImpl>
    implements _$$MaterialInfoResponseImplCopyWith<$Res> {
  __$$MaterialInfoResponseImplCopyWithImpl(_$MaterialInfoResponseImpl _value,
      $Res Function(_$MaterialInfoResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$MaterialInfoResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MaterialInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialInfoResponseImpl implements _MaterialInfoResponse {
  const _$MaterialInfoResponseImpl(
      {@JsonKey(name: 'code') required this.code,
      @JsonKey(name: 'msg') required this.message,
      @JsonKey(name: 'data') required this.data});

  factory _$MaterialInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialInfoResponseImplFromJson(json);

  /// 响应码
  @override
  @JsonKey(name: 'code')
  final String code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  final String message;

  /// 物料信息
  @override
  @JsonKey(name: 'data')
  final MaterialInfo data;

  @override
  String toString() {
    return 'MaterialInfoResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialInfoResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialInfoResponseImplCopyWith<_$MaterialInfoResponseImpl>
      get copyWith =>
          __$$MaterialInfoResponseImplCopyWithImpl<_$MaterialInfoResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _MaterialInfoResponse implements MaterialInfoResponse {
  const factory _MaterialInfoResponse(
          {@JsonKey(name: 'code') required final String code,
          @JsonKey(name: 'msg') required final String message,
          @JsonKey(name: 'data') required final MaterialInfo data}) =
      _$MaterialInfoResponseImpl;

  factory _MaterialInfoResponse.fromJson(Map<String, dynamic> json) =
      _$MaterialInfoResponseImpl.fromJson;

  @override

  /// 响应码
  @JsonKey(name: 'code')
  String get code;
  @override

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message;
  @override

  /// 物料信息
  @JsonKey(name: 'data')
  MaterialInfo get data;
  @override
  @JsonKey(ignore: true)
  _$$MaterialInfoResponseImplCopyWith<_$MaterialInfoResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MaterialInfo _$MaterialInfoFromJson(Map<String, dynamic> json) {
  return _MaterialInfo.fromJson(json);
}

/// @nodoc
mixin _$MaterialInfo {
  /// 物料编码
  @JsonKey(name: 'matcode')
  String get matCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialInfoCopyWith<MaterialInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialInfoCopyWith<$Res> {
  factory $MaterialInfoCopyWith(
          MaterialInfo value, $Res Function(MaterialInfo) then) =
      _$MaterialInfoCopyWithImpl<$Res, MaterialInfo>;
  @useResult
  $Res call({@JsonKey(name: 'matcode') String matCode});
}

/// @nodoc
class _$MaterialInfoCopyWithImpl<$Res, $Val extends MaterialInfo>
    implements $MaterialInfoCopyWith<$Res> {
  _$MaterialInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
  }) {
    return _then(_value.copyWith(
      matCode: null == matCode
          ? _value.matCode
          : matCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MaterialInfoImplCopyWith<$Res>
    implements $MaterialInfoCopyWith<$Res> {
  factory _$$MaterialInfoImplCopyWith(
          _$MaterialInfoImpl value, $Res Function(_$MaterialInfoImpl) then) =
      __$$MaterialInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'matcode') String matCode});
}

/// @nodoc
class __$$MaterialInfoImplCopyWithImpl<$Res>
    extends _$MaterialInfoCopyWithImpl<$Res, _$MaterialInfoImpl>
    implements _$$MaterialInfoImplCopyWith<$Res> {
  __$$MaterialInfoImplCopyWithImpl(
      _$MaterialInfoImpl _value, $Res Function(_$MaterialInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
  }) {
    return _then(_$MaterialInfoImpl(
      matCode: null == matCode
          ? _value.matCode
          : matCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialInfoImpl implements _MaterialInfo {
  const _$MaterialInfoImpl({@JsonKey(name: 'matcode') required this.matCode});

  factory _$MaterialInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialInfoImplFromJson(json);

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String matCode;

  @override
  String toString() {
    return 'MaterialInfo(matCode: $matCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialInfoImpl &&
            (identical(other.matCode, matCode) || other.matCode == matCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, matCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialInfoImplCopyWith<_$MaterialInfoImpl> get copyWith =>
      __$$MaterialInfoImplCopyWithImpl<_$MaterialInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialInfoImplToJson(
      this,
    );
  }
}

abstract class _MaterialInfo implements MaterialInfo {
  const factory _MaterialInfo(
          {@JsonKey(name: 'matcode') required final String matCode}) =
      _$MaterialInfoImpl;

  factory _MaterialInfo.fromJson(Map<String, dynamic> json) =
      _$MaterialInfoImpl.fromJson;

  @override

  /// 物料编码
  @JsonKey(name: 'matcode')
  String get matCode;
  @override
  @JsonKey(ignore: true)
  _$$MaterialInfoImplCopyWith<_$MaterialInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CancelTaskResponse _$CancelTaskResponseFromJson(Map<String, dynamic> json) {
  return _CancelTaskResponse.fromJson(json);
}

/// @nodoc
mixin _$CancelTaskResponse {
  /// 响应码
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CancelTaskResponseCopyWith<CancelTaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelTaskResponseCopyWith<$Res> {
  factory $CancelTaskResponseCopyWith(
          CancelTaskResponse value, $Res Function(CancelTaskResponse) then) =
      _$CancelTaskResponseCopyWithImpl<$Res, CancelTaskResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message});
}

/// @nodoc
class _$CancelTaskResponseCopyWithImpl<$Res, $Val extends CancelTaskResponse>
    implements $CancelTaskResponseCopyWith<$Res> {
  _$CancelTaskResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CancelTaskResponseImplCopyWith<$Res>
    implements $CancelTaskResponseCopyWith<$Res> {
  factory _$$CancelTaskResponseImplCopyWith(_$CancelTaskResponseImpl value,
          $Res Function(_$CancelTaskResponseImpl) then) =
      __$$CancelTaskResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message});
}

/// @nodoc
class __$$CancelTaskResponseImplCopyWithImpl<$Res>
    extends _$CancelTaskResponseCopyWithImpl<$Res, _$CancelTaskResponseImpl>
    implements _$$CancelTaskResponseImplCopyWith<$Res> {
  __$$CancelTaskResponseImplCopyWithImpl(_$CancelTaskResponseImpl _value,
      $Res Function(_$CancelTaskResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$CancelTaskResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CancelTaskResponseImpl implements _CancelTaskResponse {
  const _$CancelTaskResponseImpl(
      {@JsonKey(name: 'code') required this.code,
      @JsonKey(name: 'msg') required this.message});

  factory _$CancelTaskResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelTaskResponseImplFromJson(json);

  /// 响应码
  @override
  @JsonKey(name: 'code')
  final String code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  final String message;

  @override
  String toString() {
    return 'CancelTaskResponse(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelTaskResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelTaskResponseImplCopyWith<_$CancelTaskResponseImpl> get copyWith =>
      __$$CancelTaskResponseImplCopyWithImpl<_$CancelTaskResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelTaskResponseImplToJson(
      this,
    );
  }
}

abstract class _CancelTaskResponse implements CancelTaskResponse {
  const factory _CancelTaskResponse(
          {@JsonKey(name: 'code') required final String code,
          @JsonKey(name: 'msg') required final String message}) =
      _$CancelTaskResponseImpl;

  factory _CancelTaskResponse.fromJson(Map<String, dynamic> json) =
      _$CancelTaskResponseImpl.fromJson;

  @override

  /// 响应码
  @JsonKey(name: 'code')
  String get code;
  @override

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$CancelTaskResponseImplCopyWith<_$CancelTaskResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
