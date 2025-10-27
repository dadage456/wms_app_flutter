// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_pick_task_item_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnlinePickTaskItem _$OnlinePickTaskItemFromJson(Map<String, dynamic> json) {
  return _OnlinePickTaskItem.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTaskItem {
  @JsonKey(name: 'outtaskitemid')
  int get outTaskItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'outtaskid')
  int? get outTaskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'outtaskno')
  String? get outTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  String? get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'matinnercode')
  String? get oldMaterialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'storesiteno')
  String? get storeSiteNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'subinventoryCode')
  String? get subInventoryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderno')
  String? get orderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskcomment')
  String? get taskComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'palletno')
  String? get palletNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'hintqty')
  num get taskQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'collectedqty')
  num get collectedQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'repqty')
  num get repositoryQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'hintbatchno')
  String? get hintBatchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'wcsstate')
  String? get wcsState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskItemCopyWith<OnlinePickTaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskItemCopyWith<$Res> {
  factory $OnlinePickTaskItemCopyWith(
          OnlinePickTaskItem value, $Res Function(OnlinePickTaskItem) then) =
      _$OnlinePickTaskItemCopyWithImpl<$Res, OnlinePickTaskItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskitemid') int outTaskItemId,
      @JsonKey(name: 'outtaskid') int? outTaskId,
      @JsonKey(name: 'outtaskno') String? outTaskNo,
      @JsonKey(name: 'matcode') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'matinnercode') String? oldMaterialCode,
      @JsonKey(name: 'storesiteno') String? storeSiteNo,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'taskcomment') String? taskComment,
      @JsonKey(name: 'palletno') String? palletNo,
      @JsonKey(name: 'hintqty') num taskQty,
      @JsonKey(name: 'collectedqty') num collectedQty,
      @JsonKey(name: 'repqty') num repositoryQty,
      @JsonKey(name: 'hintbatchno') String? hintBatchNo,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNumber,
      @JsonKey(name: 'wcsstate') String? wcsState});
}

/// @nodoc
class _$OnlinePickTaskItemCopyWithImpl<$Res, $Val extends OnlinePickTaskItem>
    implements $OnlinePickTaskItemCopyWith<$Res> {
  _$OnlinePickTaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskItemId = null,
    Object? outTaskId = freezed,
    Object? outTaskNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? oldMaterialCode = freezed,
    Object? storeSiteNo = freezed,
    Object? storeRoomNo = freezed,
    Object? subInventoryCode = freezed,
    Object? orderNo = freezed,
    Object? taskComment = freezed,
    Object? palletNo = freezed,
    Object? taskQty = null,
    Object? collectedQty = null,
    Object? repositoryQty = null,
    Object? hintBatchNo = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? wcsState = freezed,
  }) {
    return _then(_value.copyWith(
      outTaskItemId: null == outTaskItemId
          ? _value.outTaskItemId
          : outTaskItemId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskId: freezed == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int?,
      outTaskNo: freezed == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      oldMaterialCode: freezed == oldMaterialCode
          ? _value.oldMaterialCode
          : oldMaterialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      subInventoryCode: freezed == subInventoryCode
          ? _value.subInventoryCode
          : subInventoryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as num,
      collectedQty: null == collectedQty
          ? _value.collectedQty
          : collectedQty // ignore: cast_nullable_to_non_nullable
              as num,
      repositoryQty: null == repositoryQty
          ? _value.repositoryQty
          : repositoryQty // ignore: cast_nullable_to_non_nullable
              as num,
      hintBatchNo: freezed == hintBatchNo
          ? _value.hintBatchNo
          : hintBatchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      wcsState: freezed == wcsState
          ? _value.wcsState
          : wcsState // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskItemImplCopyWith<$Res>
    implements $OnlinePickTaskItemCopyWith<$Res> {
  factory _$$OnlinePickTaskItemImplCopyWith(_$OnlinePickTaskItemImpl value,
          $Res Function(_$OnlinePickTaskItemImpl) then) =
      __$$OnlinePickTaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskitemid') int outTaskItemId,
      @JsonKey(name: 'outtaskid') int? outTaskId,
      @JsonKey(name: 'outtaskno') String? outTaskNo,
      @JsonKey(name: 'matcode') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'matinnercode') String? oldMaterialCode,
      @JsonKey(name: 'storesiteno') String? storeSiteNo,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'taskcomment') String? taskComment,
      @JsonKey(name: 'palletno') String? palletNo,
      @JsonKey(name: 'hintqty') num taskQty,
      @JsonKey(name: 'collectedqty') num collectedQty,
      @JsonKey(name: 'repqty') num repositoryQty,
      @JsonKey(name: 'hintbatchno') String? hintBatchNo,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNumber,
      @JsonKey(name: 'wcsstate') String? wcsState});
}

/// @nodoc
class __$$OnlinePickTaskItemImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskItemCopyWithImpl<$Res, _$OnlinePickTaskItemImpl>
    implements _$$OnlinePickTaskItemImplCopyWith<$Res> {
  __$$OnlinePickTaskItemImplCopyWithImpl(_$OnlinePickTaskItemImpl _value,
      $Res Function(_$OnlinePickTaskItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskItemId = null,
    Object? outTaskId = freezed,
    Object? outTaskNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? oldMaterialCode = freezed,
    Object? storeSiteNo = freezed,
    Object? storeRoomNo = freezed,
    Object? subInventoryCode = freezed,
    Object? orderNo = freezed,
    Object? taskComment = freezed,
    Object? palletNo = freezed,
    Object? taskQty = null,
    Object? collectedQty = null,
    Object? repositoryQty = null,
    Object? hintBatchNo = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? wcsState = freezed,
  }) {
    return _then(_$OnlinePickTaskItemImpl(
      outTaskItemId: null == outTaskItemId
          ? _value.outTaskItemId
          : outTaskItemId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskId: freezed == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int?,
      outTaskNo: freezed == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      oldMaterialCode: freezed == oldMaterialCode
          ? _value.oldMaterialCode
          : oldMaterialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: freezed == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      subInventoryCode: freezed == subInventoryCode
          ? _value.subInventoryCode
          : subInventoryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
      palletNo: freezed == palletNo
          ? _value.palletNo
          : palletNo // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as num,
      collectedQty: null == collectedQty
          ? _value.collectedQty
          : collectedQty // ignore: cast_nullable_to_non_nullable
              as num,
      repositoryQty: null == repositoryQty
          ? _value.repositoryQty
          : repositoryQty // ignore: cast_nullable_to_non_nullable
              as num,
      hintBatchNo: freezed == hintBatchNo
          ? _value.hintBatchNo
          : hintBatchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      wcsState: freezed == wcsState
          ? _value.wcsState
          : wcsState // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskItemImpl implements _OnlinePickTaskItem {
  const _$OnlinePickTaskItemImpl(
      {@JsonKey(name: 'outtaskitemid') required this.outTaskItemId,
      @JsonKey(name: 'outtaskid') this.outTaskId,
      @JsonKey(name: 'outtaskno') this.outTaskNo,
      @JsonKey(name: 'matcode') this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'matinnercode') this.oldMaterialCode,
      @JsonKey(name: 'storesiteno') this.storeSiteNo,
      @JsonKey(name: 'storeroomno') this.storeRoomNo,
      @JsonKey(name: 'subinventoryCode') this.subInventoryCode,
      @JsonKey(name: 'orderno') this.orderNo,
      @JsonKey(name: 'taskcomment') this.taskComment,
      @JsonKey(name: 'palletno') this.palletNo,
      @JsonKey(name: 'hintqty') this.taskQty = 0,
      @JsonKey(name: 'collectedqty') this.collectedQty = 0,
      @JsonKey(name: 'repqty') this.repositoryQty = 0,
      @JsonKey(name: 'hintbatchno') this.hintBatchNo,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNumber,
      @JsonKey(name: 'wcsstate') this.wcsState});

  factory _$OnlinePickTaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickTaskItemImplFromJson(json);

  @override
  @JsonKey(name: 'outtaskitemid')
  final int outTaskItemId;
  @override
  @JsonKey(name: 'outtaskid')
  final int? outTaskId;
  @override
  @JsonKey(name: 'outtaskno')
  final String? outTaskNo;
  @override
  @JsonKey(name: 'matcode')
  final String? materialCode;
  @override
  @JsonKey(name: 'matname')
  final String? materialName;
  @override
  @JsonKey(name: 'matinnercode')
  final String? oldMaterialCode;
  @override
  @JsonKey(name: 'storesiteno')
  final String? storeSiteNo;
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;
  @override
  @JsonKey(name: 'subinventoryCode')
  final String? subInventoryCode;
  @override
  @JsonKey(name: 'orderno')
  final String? orderNo;
  @override
  @JsonKey(name: 'taskcomment')
  final String? taskComment;
  @override
  @JsonKey(name: 'palletno')
  final String? palletNo;
  @override
  @JsonKey(name: 'hintqty')
  final num taskQty;
  @override
  @JsonKey(name: 'collectedqty')
  final num collectedQty;
  @override
  @JsonKey(name: 'repqty')
  final num repositoryQty;
  @override
  @JsonKey(name: 'hintbatchno')
  final String? hintBatchNo;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNumber;
  @override
  @JsonKey(name: 'wcsstate')
  final String? wcsState;

  @override
  String toString() {
    return 'OnlinePickTaskItem(outTaskItemId: $outTaskItemId, outTaskId: $outTaskId, outTaskNo: $outTaskNo, materialCode: $materialCode, materialName: $materialName, oldMaterialCode: $oldMaterialCode, storeSiteNo: $storeSiteNo, storeRoomNo: $storeRoomNo, subInventoryCode: $subInventoryCode, orderNo: $orderNo, taskComment: $taskComment, palletNo: $palletNo, taskQty: $taskQty, collectedQty: $collectedQty, repositoryQty: $repositoryQty, hintBatchNo: $hintBatchNo, batchNo: $batchNo, serialNumber: $serialNumber, wcsState: $wcsState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskItemImpl &&
            (identical(other.outTaskItemId, outTaskItemId) ||
                other.outTaskItemId == outTaskItemId) &&
            (identical(other.outTaskId, outTaskId) ||
                other.outTaskId == outTaskId) &&
            (identical(other.outTaskNo, outTaskNo) ||
                other.outTaskNo == outTaskNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.oldMaterialCode, oldMaterialCode) ||
                other.oldMaterialCode == oldMaterialCode) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.subInventoryCode, subInventoryCode) ||
                other.subInventoryCode == subInventoryCode) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.palletNo, palletNo) ||
                other.palletNo == palletNo) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.collectedQty, collectedQty) ||
                other.collectedQty == collectedQty) &&
            (identical(other.repositoryQty, repositoryQty) ||
                other.repositoryQty == repositoryQty) &&
            (identical(other.hintBatchNo, hintBatchNo) ||
                other.hintBatchNo == hintBatchNo) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.wcsState, wcsState) ||
                other.wcsState == wcsState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        outTaskItemId,
        outTaskId,
        outTaskNo,
        materialCode,
        materialName,
        oldMaterialCode,
        storeSiteNo,
        storeRoomNo,
        subInventoryCode,
        orderNo,
        taskComment,
        palletNo,
        taskQty,
        collectedQty,
        repositoryQty,
        hintBatchNo,
        batchNo,
        serialNumber,
        wcsState
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickTaskItemImplCopyWith<_$OnlinePickTaskItemImpl> get copyWith =>
      __$$OnlinePickTaskItemImplCopyWithImpl<_$OnlinePickTaskItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskItemImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTaskItem implements OnlinePickTaskItem {
  const factory _OnlinePickTaskItem(
          {@JsonKey(name: 'outtaskitemid') required final int outTaskItemId,
          @JsonKey(name: 'outtaskid') final int? outTaskId,
          @JsonKey(name: 'outtaskno') final String? outTaskNo,
          @JsonKey(name: 'matcode') final String? materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'matinnercode') final String? oldMaterialCode,
          @JsonKey(name: 'storesiteno') final String? storeSiteNo,
          @JsonKey(name: 'storeroomno') final String? storeRoomNo,
          @JsonKey(name: 'subinventoryCode') final String? subInventoryCode,
          @JsonKey(name: 'orderno') final String? orderNo,
          @JsonKey(name: 'taskcomment') final String? taskComment,
          @JsonKey(name: 'palletno') final String? palletNo,
          @JsonKey(name: 'hintqty') final num taskQty,
          @JsonKey(name: 'collectedqty') final num collectedQty,
          @JsonKey(name: 'repqty') final num repositoryQty,
          @JsonKey(name: 'hintbatchno') final String? hintBatchNo,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNumber,
          @JsonKey(name: 'wcsstate') final String? wcsState}) =
      _$OnlinePickTaskItemImpl;

  factory _OnlinePickTaskItem.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskItemImpl.fromJson;

  @override
  @JsonKey(name: 'outtaskitemid')
  int get outTaskItemId;
  @override
  @JsonKey(name: 'outtaskid')
  int? get outTaskId;
  @override
  @JsonKey(name: 'outtaskno')
  String? get outTaskNo;
  @override
  @JsonKey(name: 'matcode')
  String? get materialCode;
  @override
  @JsonKey(name: 'matname')
  String? get materialName;
  @override
  @JsonKey(name: 'matinnercode')
  String? get oldMaterialCode;
  @override
  @JsonKey(name: 'storesiteno')
  String? get storeSiteNo;
  @override
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;
  @override
  @JsonKey(name: 'subinventoryCode')
  String? get subInventoryCode;
  @override
  @JsonKey(name: 'orderno')
  String? get orderNo;
  @override
  @JsonKey(name: 'taskcomment')
  String? get taskComment;
  @override
  @JsonKey(name: 'palletno')
  String? get palletNo;
  @override
  @JsonKey(name: 'hintqty')
  num get taskQty;
  @override
  @JsonKey(name: 'collectedqty')
  num get collectedQty;
  @override
  @JsonKey(name: 'repqty')
  num get repositoryQty;
  @override
  @JsonKey(name: 'hintbatchno')
  String? get hintBatchNo;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNumber;
  @override
  @JsonKey(name: 'wcsstate')
  String? get wcsState;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTaskItemImplCopyWith<_$OnlinePickTaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OnlinePickTaskItemListData _$OnlinePickTaskItemListDataFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickTaskItemListData.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTaskItemListData {
  @JsonKey(name: 'rows')
  List<OnlinePickTaskItem> get rows => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskItemListDataCopyWith<OnlinePickTaskItemListData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskItemListDataCopyWith<$Res> {
  factory $OnlinePickTaskItemListDataCopyWith(OnlinePickTaskItemListData value,
          $Res Function(OnlinePickTaskItemListData) then) =
      _$OnlinePickTaskItemListDataCopyWithImpl<$Res,
          OnlinePickTaskItemListData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OnlinePickTaskItem> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class _$OnlinePickTaskItemListDataCopyWithImpl<$Res,
        $Val extends OnlinePickTaskItemListData>
    implements $OnlinePickTaskItemListDataCopyWith<$Res> {
  _$OnlinePickTaskItemListDataCopyWithImpl(this._value, this._then);

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
              as List<OnlinePickTaskItem>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskItemListDataImplCopyWith<$Res>
    implements $OnlinePickTaskItemListDataCopyWith<$Res> {
  factory _$$OnlinePickTaskItemListDataImplCopyWith(
          _$OnlinePickTaskItemListDataImpl value,
          $Res Function(_$OnlinePickTaskItemListDataImpl) then) =
      __$$OnlinePickTaskItemListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OnlinePickTaskItem> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class __$$OnlinePickTaskItemListDataImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskItemListDataCopyWithImpl<$Res,
        _$OnlinePickTaskItemListDataImpl>
    implements _$$OnlinePickTaskItemListDataImplCopyWith<$Res> {
  __$$OnlinePickTaskItemListDataImplCopyWithImpl(
      _$OnlinePickTaskItemListDataImpl _value,
      $Res Function(_$OnlinePickTaskItemListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_$OnlinePickTaskItemListDataImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<OnlinePickTaskItem>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskItemListDataImpl implements _OnlinePickTaskItemListData {
  const _$OnlinePickTaskItemListDataImpl(
      {@JsonKey(name: 'rows') final List<OnlinePickTaskItem> rows = const [],
      @JsonKey(name: 'total') this.total = 0})
      : _rows = rows;

  factory _$OnlinePickTaskItemListDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OnlinePickTaskItemListDataImplFromJson(json);

  final List<OnlinePickTaskItem> _rows;
  @override
  @JsonKey(name: 'rows')
  List<OnlinePickTaskItem> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'OnlinePickTaskItemListData(rows: $rows, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskItemListDataImpl &&
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
  _$$OnlinePickTaskItemListDataImplCopyWith<_$OnlinePickTaskItemListDataImpl>
      get copyWith => __$$OnlinePickTaskItemListDataImplCopyWithImpl<
          _$OnlinePickTaskItemListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskItemListDataImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTaskItemListData
    implements OnlinePickTaskItemListData {
  const factory _OnlinePickTaskItemListData(
          {@JsonKey(name: 'rows') final List<OnlinePickTaskItem> rows,
          @JsonKey(name: 'total') final int total}) =
      _$OnlinePickTaskItemListDataImpl;

  factory _OnlinePickTaskItemListData.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskItemListDataImpl.fromJson;

  @override
  @JsonKey(name: 'rows')
  List<OnlinePickTaskItem> get rows;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTaskItemListDataImplCopyWith<_$OnlinePickTaskItemListDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickTaskItemQuery _$OnlinePickTaskItemQueryFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickTaskItemQuery.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTaskItemQuery {
  @JsonKey(name: 'outtaskid')
  int get outTaskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'outtaskno')
  String? get outTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'workstation')
  String? get workStation => throw _privateConstructorUsedError;
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get sortType => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get sortColumn => throw _privateConstructorUsedError;
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'PageIndex')
  int get pageIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'PageSize')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'beatflag')
  String get beatFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'forcesite')
  String? get forceSite => throw _privateConstructorUsedError;
  @JsonKey(name: 'forcebatch')
  String? get forceBatch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskItemQueryCopyWith<OnlinePickTaskItemQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskItemQueryCopyWith<$Res> {
  factory $OnlinePickTaskItemQueryCopyWith(OnlinePickTaskItemQuery value,
          $Res Function(OnlinePickTaskItemQuery) then) =
      _$OnlinePickTaskItemQueryCopyWithImpl<$Res, OnlinePickTaskItemQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') int outTaskId,
      @JsonKey(name: 'outtaskno') String? outTaskNo,
      @JsonKey(name: 'workstation') String? workStation,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(includeToJson: false) String sortType,
      @JsonKey(includeToJson: false) String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'forcesite') String? forceSite,
      @JsonKey(name: 'forcebatch') String? forceBatch});
}

/// @nodoc
class _$OnlinePickTaskItemQueryCopyWithImpl<$Res,
        $Val extends OnlinePickTaskItemQuery>
    implements $OnlinePickTaskItemQueryCopyWith<$Res> {
  _$OnlinePickTaskItemQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? outTaskNo = freezed,
    Object? workStation = freezed,
    Object? roomTag = null,
    Object? roleOrUserId = null,
    Object? userId = null,
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? pageIndex = null,
    Object? pageSize = null,
    Object? finishFlag = null,
    Object? beatFlag = null,
    Object? forceSite = freezed,
    Object? forceBatch = freezed,
  }) {
    return _then(_value.copyWith(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskNo: freezed == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      roleOrUserId: null == roleOrUserId
          ? _value.roleOrUserId
          : roleOrUserId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
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
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String,
      beatFlag: null == beatFlag
          ? _value.beatFlag
          : beatFlag // ignore: cast_nullable_to_non_nullable
              as String,
      forceSite: freezed == forceSite
          ? _value.forceSite
          : forceSite // ignore: cast_nullable_to_non_nullable
              as String?,
      forceBatch: freezed == forceBatch
          ? _value.forceBatch
          : forceBatch // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskItemQueryImplCopyWith<$Res>
    implements $OnlinePickTaskItemQueryCopyWith<$Res> {
  factory _$$OnlinePickTaskItemQueryImplCopyWith(
          _$OnlinePickTaskItemQueryImpl value,
          $Res Function(_$OnlinePickTaskItemQueryImpl) then) =
      __$$OnlinePickTaskItemQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') int outTaskId,
      @JsonKey(name: 'outtaskno') String? outTaskNo,
      @JsonKey(name: 'workstation') String? workStation,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(includeToJson: false) String sortType,
      @JsonKey(includeToJson: false) String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'forcesite') String? forceSite,
      @JsonKey(name: 'forcebatch') String? forceBatch});
}

/// @nodoc
class __$$OnlinePickTaskItemQueryImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskItemQueryCopyWithImpl<$Res,
        _$OnlinePickTaskItemQueryImpl>
    implements _$$OnlinePickTaskItemQueryImplCopyWith<$Res> {
  __$$OnlinePickTaskItemQueryImplCopyWithImpl(
      _$OnlinePickTaskItemQueryImpl _value,
      $Res Function(_$OnlinePickTaskItemQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? outTaskNo = freezed,
    Object? workStation = freezed,
    Object? roomTag = null,
    Object? roleOrUserId = null,
    Object? userId = null,
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? pageIndex = null,
    Object? pageSize = null,
    Object? finishFlag = null,
    Object? beatFlag = null,
    Object? forceSite = freezed,
    Object? forceBatch = freezed,
  }) {
    return _then(_$OnlinePickTaskItemQueryImpl(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskNo: freezed == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      roleOrUserId: null == roleOrUserId
          ? _value.roleOrUserId
          : roleOrUserId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
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
      pageIndex: null == pageIndex
          ? _value.pageIndex
          : pageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String,
      beatFlag: null == beatFlag
          ? _value.beatFlag
          : beatFlag // ignore: cast_nullable_to_non_nullable
              as String,
      forceSite: freezed == forceSite
          ? _value.forceSite
          : forceSite // ignore: cast_nullable_to_non_nullable
              as String?,
      forceBatch: freezed == forceBatch
          ? _value.forceBatch
          : forceBatch // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskItemQueryImpl implements _OnlinePickTaskItemQuery {
  const _$OnlinePickTaskItemQueryImpl(
      {@JsonKey(name: 'outtaskid') required this.outTaskId,
      @JsonKey(name: 'outtaskno') this.outTaskNo,
      @JsonKey(name: 'workstation') this.workStation,
      @JsonKey(name: 'roomTag') this.roomTag = '1',
      @JsonKey(name: 'roleoRuserId') required this.roleOrUserId,
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(includeToJson: false) this.sortType = '',
      @JsonKey(includeToJson: false) this.sortColumn = '',
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'PageIndex') this.pageIndex = 1,
      @JsonKey(name: 'PageSize') this.pageSize = 100,
      @JsonKey(name: 'finshFlg') this.finishFlag = '0',
      @JsonKey(name: 'beatflag') this.beatFlag = 'N',
      @JsonKey(name: 'forcesite') this.forceSite,
      @JsonKey(name: 'forcebatch') this.forceBatch});

  factory _$OnlinePickTaskItemQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickTaskItemQueryImplFromJson(json);

  @override
  @JsonKey(name: 'outtaskid')
  final int outTaskId;
  @override
  @JsonKey(name: 'outtaskno')
  final String? outTaskNo;
  @override
  @JsonKey(name: 'workstation')
  final String? workStation;
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;
  @override
  @JsonKey(name: 'roleoRuserId')
  final String roleOrUserId;
  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(includeToJson: false)
  final String sortType;
  @override
  @JsonKey(includeToJson: false)
  final String sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  final String searchKey;
  @override
  @JsonKey(name: 'PageIndex')
  final int pageIndex;
  @override
  @JsonKey(name: 'PageSize')
  final int pageSize;
  @override
  @JsonKey(name: 'finshFlg')
  final String finishFlag;
  @override
  @JsonKey(name: 'beatflag')
  final String beatFlag;
  @override
  @JsonKey(name: 'forcesite')
  final String? forceSite;
  @override
  @JsonKey(name: 'forcebatch')
  final String? forceBatch;

  @override
  String toString() {
    return 'OnlinePickTaskItemQuery(outTaskId: $outTaskId, outTaskNo: $outTaskNo, workStation: $workStation, roomTag: $roomTag, roleOrUserId: $roleOrUserId, userId: $userId, sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, pageIndex: $pageIndex, pageSize: $pageSize, finishFlag: $finishFlag, beatFlag: $beatFlag, forceSite: $forceSite, forceBatch: $forceBatch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskItemQueryImpl &&
            (identical(other.outTaskId, outTaskId) ||
                other.outTaskId == outTaskId) &&
            (identical(other.outTaskNo, outTaskNo) ||
                other.outTaskNo == outTaskNo) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag) &&
            (identical(other.roleOrUserId, roleOrUserId) ||
                other.roleOrUserId == roleOrUserId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.sortColumn, sortColumn) ||
                other.sortColumn == sortColumn) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.finishFlag, finishFlag) ||
                other.finishFlag == finishFlag) &&
            (identical(other.beatFlag, beatFlag) ||
                other.beatFlag == beatFlag) &&
            (identical(other.forceSite, forceSite) ||
                other.forceSite == forceSite) &&
            (identical(other.forceBatch, forceBatch) ||
                other.forceBatch == forceBatch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      outTaskId,
      outTaskNo,
      workStation,
      roomTag,
      roleOrUserId,
      userId,
      sortType,
      sortColumn,
      searchKey,
      pageIndex,
      pageSize,
      finishFlag,
      beatFlag,
      forceSite,
      forceBatch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickTaskItemQueryImplCopyWith<_$OnlinePickTaskItemQueryImpl>
      get copyWith => __$$OnlinePickTaskItemQueryImplCopyWithImpl<
          _$OnlinePickTaskItemQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskItemQueryImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTaskItemQuery implements OnlinePickTaskItemQuery {
  const factory _OnlinePickTaskItemQuery(
          {@JsonKey(name: 'outtaskid') required final int outTaskId,
          @JsonKey(name: 'outtaskno') final String? outTaskNo,
          @JsonKey(name: 'workstation') final String? workStation,
          @JsonKey(name: 'roomTag') final String roomTag,
          @JsonKey(name: 'roleoRuserId') required final String roleOrUserId,
          @JsonKey(name: 'userId') required final String userId,
          @JsonKey(includeToJson: false) final String sortType,
          @JsonKey(includeToJson: false) final String sortColumn,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'PageIndex') final int pageIndex,
          @JsonKey(name: 'PageSize') final int pageSize,
          @JsonKey(name: 'finshFlg') final String finishFlag,
          @JsonKey(name: 'beatflag') final String beatFlag,
          @JsonKey(name: 'forcesite') final String? forceSite,
          @JsonKey(name: 'forcebatch') final String? forceBatch}) =
      _$OnlinePickTaskItemQueryImpl;

  factory _OnlinePickTaskItemQuery.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskItemQueryImpl.fromJson;

  @override
  @JsonKey(name: 'outtaskid')
  int get outTaskId;
  @override
  @JsonKey(name: 'outtaskno')
  String? get outTaskNo;
  @override
  @JsonKey(name: 'workstation')
  String? get workStation;
  @override
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId;
  @override
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(includeToJson: false)
  String get sortType;
  @override
  @JsonKey(includeToJson: false)
  String get sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  String get searchKey;
  @override
  @JsonKey(name: 'PageIndex')
  int get pageIndex;
  @override
  @JsonKey(name: 'PageSize')
  int get pageSize;
  @override
  @JsonKey(name: 'finshFlg')
  String get finishFlag;
  @override
  @JsonKey(name: 'beatflag')
  String get beatFlag;
  @override
  @JsonKey(name: 'forcesite')
  String? get forceSite;
  @override
  @JsonKey(name: 'forcebatch')
  String? get forceBatch;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTaskItemQueryImplCopyWith<_$OnlinePickTaskItemQueryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
