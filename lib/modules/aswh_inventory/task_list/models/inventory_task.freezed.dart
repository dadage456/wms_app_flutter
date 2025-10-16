// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryTaskFilter _$InventoryTaskFilterFromJson(Map<String, dynamic> json) {
  return _InventoryTaskFilter.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskFilter {
  /// 排序方向
  @JsonKey(name: 'sortType')
  String get sortType => throw _privateConstructorUsedError;

  /// 排序字段
  @JsonKey(name: 'sortColumn')
  String get sortColumn => throw _privateConstructorUsedError;

  /// 搜索关键字（支持扫码输入任务号/盘库单号）
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;

  /// 用户ID（字符串，兼容接口入参）
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;

  /// 角色或用户ID（接口字段名为 roleoRuserId）
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId => throw _privateConstructorUsedError;

  /// 库房标签（1 表示立库）
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;

  /// 完成标识（0-未完成，1-全部）
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;

  /// 当前页码（接口使用 PageIndex 字段，1 开始）
  @JsonKey(name: 'PageIndex')
  int get pageIndex => throw _privateConstructorUsedError;

  /// 每页条目数量
  @JsonKey(name: 'PageSize')
  int get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskFilterCopyWith<InventoryTaskFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskFilterCopyWith<$Res> {
  factory $InventoryTaskFilterCopyWith(
          InventoryTaskFilter value, $Res Function(InventoryTaskFilter) then) =
      _$InventoryTaskFilterCopyWithImpl<$Res, InventoryTaskFilter>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize});
}

/// @nodoc
class _$InventoryTaskFilterCopyWithImpl<$Res, $Val extends InventoryTaskFilter>
    implements $InventoryTaskFilterCopyWith<$Res> {
  _$InventoryTaskFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? userId = null,
    Object? roleOrUserId = null,
    Object? roomTag = null,
    Object? finishFlag = null,
    Object? pageIndex = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
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
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      roleOrUserId: null == roleOrUserId
          ? _value.roleOrUserId
          : roleOrUserId // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
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
abstract class _$$InventoryTaskFilterImplCopyWith<$Res>
    implements $InventoryTaskFilterCopyWith<$Res> {
  factory _$$InventoryTaskFilterImplCopyWith(_$InventoryTaskFilterImpl value,
          $Res Function(_$InventoryTaskFilterImpl) then) =
      __$$InventoryTaskFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize});
}

/// @nodoc
class __$$InventoryTaskFilterImplCopyWithImpl<$Res>
    extends _$InventoryTaskFilterCopyWithImpl<$Res, _$InventoryTaskFilterImpl>
    implements _$$InventoryTaskFilterImplCopyWith<$Res> {
  __$$InventoryTaskFilterImplCopyWithImpl(_$InventoryTaskFilterImpl _value,
      $Res Function(_$InventoryTaskFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? userId = null,
    Object? roleOrUserId = null,
    Object? roomTag = null,
    Object? finishFlag = null,
    Object? pageIndex = null,
    Object? pageSize = null,
  }) {
    return _then(_$InventoryTaskFilterImpl(
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
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      roleOrUserId: null == roleOrUserId
          ? _value.roleOrUserId
          : roleOrUserId // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
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
class _$InventoryTaskFilterImpl implements _InventoryTaskFilter {
  const _$InventoryTaskFilterImpl(
      {@JsonKey(name: 'sortType') this.sortType = 'desc',
      @JsonKey(name: 'sortColumn') this.sortColumn = 'createdate',
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'roleoRuserId') required this.roleOrUserId,
      @JsonKey(name: 'roomTag') this.roomTag = '1',
      @JsonKey(name: 'finshFlg') this.finishFlag = '0',
      @JsonKey(name: 'PageIndex') this.pageIndex = 1,
      @JsonKey(name: 'PageSize') this.pageSize = 100});

  factory _$InventoryTaskFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskFilterImplFromJson(json);

  /// 排序方向
  @override
  @JsonKey(name: 'sortType')
  final String sortType;

  /// 排序字段
  @override
  @JsonKey(name: 'sortColumn')
  final String sortColumn;

  /// 搜索关键字（支持扫码输入任务号/盘库单号）
  @override
  @JsonKey(name: 'searchKey')
  final String searchKey;

  /// 用户ID（字符串，兼容接口入参）
  @override
  @JsonKey(name: 'userId')
  final String userId;

  /// 角色或用户ID（接口字段名为 roleoRuserId）
  @override
  @JsonKey(name: 'roleoRuserId')
  final String roleOrUserId;

  /// 库房标签（1 表示立库）
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;

  /// 完成标识（0-未完成，1-全部）
  @override
  @JsonKey(name: 'finshFlg')
  final String finishFlag;

  /// 当前页码（接口使用 PageIndex 字段，1 开始）
  @override
  @JsonKey(name: 'PageIndex')
  final int pageIndex;

  /// 每页条目数量
  @override
  @JsonKey(name: 'PageSize')
  final int pageSize;

  @override
  String toString() {
    return 'InventoryTaskFilter(sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, userId: $userId, roleOrUserId: $roleOrUserId, roomTag: $roomTag, finishFlag: $finishFlag, pageIndex: $pageIndex, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskFilterImpl &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.sortColumn, sortColumn) ||
                other.sortColumn == sortColumn) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roleOrUserId, roleOrUserId) ||
                other.roleOrUserId == roleOrUserId) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag) &&
            (identical(other.finishFlag, finishFlag) ||
                other.finishFlag == finishFlag) &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sortType, sortColumn, searchKey,
      userId, roleOrUserId, roomTag, finishFlag, pageIndex, pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskFilterImplCopyWith<_$InventoryTaskFilterImpl> get copyWith =>
      __$$InventoryTaskFilterImplCopyWithImpl<_$InventoryTaskFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskFilterImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskFilter implements InventoryTaskFilter {
  const factory _InventoryTaskFilter(
          {@JsonKey(name: 'sortType') final String sortType,
          @JsonKey(name: 'sortColumn') final String sortColumn,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'userId') required final String userId,
          @JsonKey(name: 'roleoRuserId') required final String roleOrUserId,
          @JsonKey(name: 'roomTag') final String roomTag,
          @JsonKey(name: 'finshFlg') final String finishFlag,
          @JsonKey(name: 'PageIndex') final int pageIndex,
          @JsonKey(name: 'PageSize') final int pageSize}) =
      _$InventoryTaskFilterImpl;

  factory _InventoryTaskFilter.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskFilterImpl.fromJson;

  @override

  /// 排序方向
  @JsonKey(name: 'sortType')
  String get sortType;
  @override

  /// 排序字段
  @JsonKey(name: 'sortColumn')
  String get sortColumn;
  @override

  /// 搜索关键字（支持扫码输入任务号/盘库单号）
  @JsonKey(name: 'searchKey')
  String get searchKey;
  @override

  /// 用户ID（字符串，兼容接口入参）
  @JsonKey(name: 'userId')
  String get userId;
  @override

  /// 角色或用户ID（接口字段名为 roleoRuserId）
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId;
  @override

  /// 库房标签（1 表示立库）
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override

  /// 完成标识（0-未完成，1-全部）
  @JsonKey(name: 'finshFlg')
  String get finishFlag;
  @override

  /// 当前页码（接口使用 PageIndex 字段，1 开始）
  @JsonKey(name: 'PageIndex')
  int get pageIndex;
  @override

  /// 每页条目数量
  @JsonKey(name: 'PageSize')
  int get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskFilterImplCopyWith<_$InventoryTaskFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryTaskSummary _$InventoryTaskSummaryFromJson(Map<String, dynamic> json) {
  return _InventoryTaskSummary.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskSummary {
  /// 盘库单号
  @JsonKey(name: 'taskcomment')
  String get taskComment => throw _privateConstructorUsedError;

  /// 库房号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 库房名称
  @JsonKey(name: 'storeroomname')
  String get storeRoomName => throw _privateConstructorUsedError;

  /// 任务号
  @JsonKey(name: 'checktaskno')
  String get checkTaskNo => throw _privateConstructorUsedError;

  /// 任务ID
  @JsonKey(name: 'checktaskid')
  int? get checkTaskId => throw _privateConstructorUsedError;

  /// 状态描述
  @JsonKey(name: 'status')
  String? get status => throw _privateConstructorUsedError;

  /// 工位/拣选位
  @JsonKey(name: 'workstation')
  String? get workStation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskSummaryCopyWith<InventoryTaskSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskSummaryCopyWith<$Res> {
  factory $InventoryTaskSummaryCopyWith(InventoryTaskSummary value,
          $Res Function(InventoryTaskSummary) then) =
      _$InventoryTaskSummaryCopyWithImpl<$Res, InventoryTaskSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'storeroomname') String storeRoomName,
      @JsonKey(name: 'checktaskno') String checkTaskNo,
      @JsonKey(name: 'checktaskid') int? checkTaskId,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'workstation') String? workStation});
}

/// @nodoc
class _$InventoryTaskSummaryCopyWithImpl<$Res,
        $Val extends InventoryTaskSummary>
    implements $InventoryTaskSummaryCopyWith<$Res> {
  _$InventoryTaskSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskComment = null,
    Object? storeRoomNo = null,
    Object? storeRoomName = null,
    Object? checkTaskNo = null,
    Object? checkTaskId = freezed,
    Object? status = freezed,
    Object? workStation = freezed,
  }) {
    return _then(_value.copyWith(
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomName: null == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskNo: null == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskId: freezed == checkTaskId
          ? _value.checkTaskId
          : checkTaskId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskSummaryImplCopyWith<$Res>
    implements $InventoryTaskSummaryCopyWith<$Res> {
  factory _$$InventoryTaskSummaryImplCopyWith(_$InventoryTaskSummaryImpl value,
          $Res Function(_$InventoryTaskSummaryImpl) then) =
      __$$InventoryTaskSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'storeroomname') String storeRoomName,
      @JsonKey(name: 'checktaskno') String checkTaskNo,
      @JsonKey(name: 'checktaskid') int? checkTaskId,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'workstation') String? workStation});
}

/// @nodoc
class __$$InventoryTaskSummaryImplCopyWithImpl<$Res>
    extends _$InventoryTaskSummaryCopyWithImpl<$Res, _$InventoryTaskSummaryImpl>
    implements _$$InventoryTaskSummaryImplCopyWith<$Res> {
  __$$InventoryTaskSummaryImplCopyWithImpl(_$InventoryTaskSummaryImpl _value,
      $Res Function(_$InventoryTaskSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskComment = null,
    Object? storeRoomNo = null,
    Object? storeRoomName = null,
    Object? checkTaskNo = null,
    Object? checkTaskId = freezed,
    Object? status = freezed,
    Object? workStation = freezed,
  }) {
    return _then(_$InventoryTaskSummaryImpl(
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomName: null == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskNo: null == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskId: freezed == checkTaskId
          ? _value.checkTaskId
          : checkTaskId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskSummaryImpl implements _InventoryTaskSummary {
  const _$InventoryTaskSummaryImpl(
      {@JsonKey(name: 'taskcomment') required this.taskComment,
      @JsonKey(name: 'storeroomno') required this.storeRoomNo,
      @JsonKey(name: 'storeroomname') required this.storeRoomName,
      @JsonKey(name: 'checktaskno') required this.checkTaskNo,
      @JsonKey(name: 'checktaskid') this.checkTaskId,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'workstation') this.workStation});

  factory _$InventoryTaskSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskSummaryImplFromJson(json);

  /// 盘库单号
  @override
  @JsonKey(name: 'taskcomment')
  final String taskComment;

  /// 库房号
  @override
  @JsonKey(name: 'storeroomno')
  final String storeRoomNo;

  /// 库房名称
  @override
  @JsonKey(name: 'storeroomname')
  final String storeRoomName;

  /// 任务号
  @override
  @JsonKey(name: 'checktaskno')
  final String checkTaskNo;

  /// 任务ID
  @override
  @JsonKey(name: 'checktaskid')
  final int? checkTaskId;

  /// 状态描述
  @override
  @JsonKey(name: 'status')
  final String? status;

  /// 工位/拣选位
  @override
  @JsonKey(name: 'workstation')
  final String? workStation;

  @override
  String toString() {
    return 'InventoryTaskSummary(taskComment: $taskComment, storeRoomNo: $storeRoomNo, storeRoomName: $storeRoomName, checkTaskNo: $checkTaskNo, checkTaskId: $checkTaskId, status: $status, workStation: $workStation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskSummaryImpl &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeRoomName, storeRoomName) ||
                other.storeRoomName == storeRoomName) &&
            (identical(other.checkTaskNo, checkTaskNo) ||
                other.checkTaskNo == checkTaskNo) &&
            (identical(other.checkTaskId, checkTaskId) ||
                other.checkTaskId == checkTaskId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskComment, storeRoomNo,
      storeRoomName, checkTaskNo, checkTaskId, status, workStation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskSummaryImplCopyWith<_$InventoryTaskSummaryImpl>
      get copyWith =>
          __$$InventoryTaskSummaryImplCopyWithImpl<_$InventoryTaskSummaryImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskSummaryImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskSummary implements InventoryTaskSummary {
  const factory _InventoryTaskSummary(
          {@JsonKey(name: 'taskcomment') required final String taskComment,
          @JsonKey(name: 'storeroomno') required final String storeRoomNo,
          @JsonKey(name: 'storeroomname') required final String storeRoomName,
          @JsonKey(name: 'checktaskno') required final String checkTaskNo,
          @JsonKey(name: 'checktaskid') final int? checkTaskId,
          @JsonKey(name: 'status') final String? status,
          @JsonKey(name: 'workstation') final String? workStation}) =
      _$InventoryTaskSummaryImpl;

  factory _InventoryTaskSummary.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskSummaryImpl.fromJson;

  @override

  /// 盘库单号
  @JsonKey(name: 'taskcomment')
  String get taskComment;
  @override

  /// 库房号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo;
  @override

  /// 库房名称
  @JsonKey(name: 'storeroomname')
  String get storeRoomName;
  @override

  /// 任务号
  @JsonKey(name: 'checktaskno')
  String get checkTaskNo;
  @override

  /// 任务ID
  @JsonKey(name: 'checktaskid')
  int? get checkTaskId;
  @override

  /// 状态描述
  @JsonKey(name: 'status')
  String? get status;
  @override

  /// 工位/拣选位
  @JsonKey(name: 'workstation')
  String? get workStation;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskSummaryImplCopyWith<_$InventoryTaskSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryTaskListData _$InventoryTaskListDataFromJson(
    Map<String, dynamic> json) {
  return _InventoryTaskListData.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskListData {
  @JsonKey(name: 'rows')
  List<InventoryTaskSummary> get rows => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskListDataCopyWith<InventoryTaskListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskListDataCopyWith<$Res> {
  factory $InventoryTaskListDataCopyWith(InventoryTaskListData value,
          $Res Function(InventoryTaskListData) then) =
      _$InventoryTaskListDataCopyWithImpl<$Res, InventoryTaskListData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<InventoryTaskSummary> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class _$InventoryTaskListDataCopyWithImpl<$Res,
        $Val extends InventoryTaskListData>
    implements $InventoryTaskListDataCopyWith<$Res> {
  _$InventoryTaskListDataCopyWithImpl(this._value, this._then);

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
              as List<InventoryTaskSummary>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskListDataImplCopyWith<$Res>
    implements $InventoryTaskListDataCopyWith<$Res> {
  factory _$$InventoryTaskListDataImplCopyWith(
          _$InventoryTaskListDataImpl value,
          $Res Function(_$InventoryTaskListDataImpl) then) =
      __$$InventoryTaskListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<InventoryTaskSummary> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class __$$InventoryTaskListDataImplCopyWithImpl<$Res>
    extends _$InventoryTaskListDataCopyWithImpl<$Res,
        _$InventoryTaskListDataImpl>
    implements _$$InventoryTaskListDataImplCopyWith<$Res> {
  __$$InventoryTaskListDataImplCopyWithImpl(_$InventoryTaskListDataImpl _value,
      $Res Function(_$InventoryTaskListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_$InventoryTaskListDataImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<InventoryTaskSummary>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskListDataImpl implements _InventoryTaskListData {
  const _$InventoryTaskListDataImpl(
      {@JsonKey(name: 'rows')
      final List<InventoryTaskSummary> rows = const <InventoryTaskSummary>[],
      @JsonKey(name: 'total') this.total = 0})
      : _rows = rows;

  factory _$InventoryTaskListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskListDataImplFromJson(json);

  final List<InventoryTaskSummary> _rows;
  @override
  @JsonKey(name: 'rows')
  List<InventoryTaskSummary> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'InventoryTaskListData(rows: $rows, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskListDataImpl &&
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
  _$$InventoryTaskListDataImplCopyWith<_$InventoryTaskListDataImpl>
      get copyWith => __$$InventoryTaskListDataImplCopyWithImpl<
          _$InventoryTaskListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskListDataImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskListData implements InventoryTaskListData {
  const factory _InventoryTaskListData(
      {@JsonKey(name: 'rows') final List<InventoryTaskSummary> rows,
      @JsonKey(name: 'total') final int total}) = _$InventoryTaskListDataImpl;

  factory _InventoryTaskListData.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskListDataImpl.fromJson;

  @override
  @JsonKey(name: 'rows')
  List<InventoryTaskSummary> get rows;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskListDataImplCopyWith<_$InventoryTaskListDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
