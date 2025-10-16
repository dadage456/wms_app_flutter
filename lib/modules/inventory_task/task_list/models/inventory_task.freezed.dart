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

InventoryTaskQuery _$InventoryTaskQueryFromJson(Map<String, dynamic> json) {
  return _InventoryTaskQuery.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskQuery {
  /// 排序方向
  @JsonKey(name: 'sortType')
  String get sortType => throw _privateConstructorUsedError;

  /// 排序字段
  @JsonKey(name: 'sortColumn')
  String get sortColumn => throw _privateConstructorUsedError;

  /// 搜索关键字
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;

  /// 用户ID
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;

  /// 角色或用户ID
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId => throw _privateConstructorUsedError;

  /// 库房标签（0-平库、1-立库）
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;

  /// 完成标识：0-未完成，1-全部
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;

  /// 当前页码（1 开始）
  @JsonKey(name: 'PageIndex')
  int get pageIndex => throw _privateConstructorUsedError;

  /// 每页条目数
  @JsonKey(name: 'PageSize')
  int get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskQueryCopyWith<InventoryTaskQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskQueryCopyWith<$Res> {
  factory $InventoryTaskQueryCopyWith(
          InventoryTaskQuery value, $Res Function(InventoryTaskQuery) then) =
      _$InventoryTaskQueryCopyWithImpl<$Res, InventoryTaskQuery>;
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
class _$InventoryTaskQueryCopyWithImpl<$Res, $Val extends InventoryTaskQuery>
    implements $InventoryTaskQueryCopyWith<$Res> {
  _$InventoryTaskQueryCopyWithImpl(this._value, this._then);

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
abstract class _$$InventoryTaskQueryImplCopyWith<$Res>
    implements $InventoryTaskQueryCopyWith<$Res> {
  factory _$$InventoryTaskQueryImplCopyWith(_$InventoryTaskQueryImpl value,
          $Res Function(_$InventoryTaskQueryImpl) then) =
      __$$InventoryTaskQueryImplCopyWithImpl<$Res>;
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
class __$$InventoryTaskQueryImplCopyWithImpl<$Res>
    extends _$InventoryTaskQueryCopyWithImpl<$Res, _$InventoryTaskQueryImpl>
    implements _$$InventoryTaskQueryImplCopyWith<$Res> {
  __$$InventoryTaskQueryImplCopyWithImpl(_$InventoryTaskQueryImpl _value,
      $Res Function(_$InventoryTaskQueryImpl) _then)
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
    return _then(_$InventoryTaskQueryImpl(
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
class _$InventoryTaskQueryImpl implements _InventoryTaskQuery {
  const _$InventoryTaskQueryImpl(
      {@JsonKey(name: 'sortType') this.sortType = 'desc',
      @JsonKey(name: 'sortColumn') this.sortColumn = 'createdate',
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'roleoRuserId') required this.roleOrUserId,
      @JsonKey(name: 'roomTag') this.roomTag = '0',
      @JsonKey(name: 'finshFlg') this.finishFlag = '0',
      @JsonKey(name: 'PageIndex') this.pageIndex = 1,
      @JsonKey(name: 'PageSize') this.pageSize = 100});

  factory _$InventoryTaskQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskQueryImplFromJson(json);

  /// 排序方向
  @override
  @JsonKey(name: 'sortType')
  final String sortType;

  /// 排序字段
  @override
  @JsonKey(name: 'sortColumn')
  final String sortColumn;

  /// 搜索关键字
  @override
  @JsonKey(name: 'searchKey')
  final String searchKey;

  /// 用户ID
  @override
  @JsonKey(name: 'userId')
  final String userId;

  /// 角色或用户ID
  @override
  @JsonKey(name: 'roleoRuserId')
  final String roleOrUserId;

  /// 库房标签（0-平库、1-立库）
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;

  /// 完成标识：0-未完成，1-全部
  @override
  @JsonKey(name: 'finshFlg')
  final String finishFlag;

  /// 当前页码（1 开始）
  @override
  @JsonKey(name: 'PageIndex')
  final int pageIndex;

  /// 每页条目数
  @override
  @JsonKey(name: 'PageSize')
  final int pageSize;

  @override
  String toString() {
    return 'InventoryTaskQuery(sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, userId: $userId, roleOrUserId: $roleOrUserId, roomTag: $roomTag, finishFlag: $finishFlag, pageIndex: $pageIndex, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskQueryImpl &&
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
  _$$InventoryTaskQueryImplCopyWith<_$InventoryTaskQueryImpl> get copyWith =>
      __$$InventoryTaskQueryImplCopyWithImpl<_$InventoryTaskQueryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskQueryImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskQuery implements InventoryTaskQuery {
  const factory _InventoryTaskQuery(
          {@JsonKey(name: 'sortType') final String sortType,
          @JsonKey(name: 'sortColumn') final String sortColumn,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'userId') required final String userId,
          @JsonKey(name: 'roleoRuserId') required final String roleOrUserId,
          @JsonKey(name: 'roomTag') final String roomTag,
          @JsonKey(name: 'finshFlg') final String finishFlag,
          @JsonKey(name: 'PageIndex') final int pageIndex,
          @JsonKey(name: 'PageSize') final int pageSize}) =
      _$InventoryTaskQueryImpl;

  factory _InventoryTaskQuery.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskQueryImpl.fromJson;

  @override

  /// 排序方向
  @JsonKey(name: 'sortType')
  String get sortType;
  @override

  /// 排序字段
  @JsonKey(name: 'sortColumn')
  String get sortColumn;
  @override

  /// 搜索关键字
  @JsonKey(name: 'searchKey')
  String get searchKey;
  @override

  /// 用户ID
  @JsonKey(name: 'userId')
  String get userId;
  @override

  /// 角色或用户ID
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId;
  @override

  /// 库房标签（0-平库、1-立库）
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override

  /// 完成标识：0-未完成，1-全部
  @JsonKey(name: 'finshFlg')
  String get finishFlag;
  @override

  /// 当前页码（1 开始）
  @JsonKey(name: 'PageIndex')
  int get pageIndex;
  @override

  /// 每页条目数
  @JsonKey(name: 'PageSize')
  int get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskQueryImplCopyWith<_$InventoryTaskQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryTask _$InventoryTaskFromJson(Map<String, dynamic> json) {
  return _InventoryTask.fromJson(json);
}

/// @nodoc
mixin _$InventoryTask {
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

  /// 任务主键
  @JsonKey(name: 'checktaskid')
  int? get checkTaskId => throw _privateConstructorUsedError;

  /// 当前状态
  @JsonKey(name: 'status')
  String? get status => throw _privateConstructorUsedError;

  /// 工位/拣选位
  @JsonKey(name: 'workstation')
  String? get workStation => throw _privateConstructorUsedError;

  /// 任务备注
  @JsonKey(name: 'memo')
  String? get memo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskCopyWith<InventoryTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskCopyWith<$Res> {
  factory $InventoryTaskCopyWith(
          InventoryTask value, $Res Function(InventoryTask) then) =
      _$InventoryTaskCopyWithImpl<$Res, InventoryTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'storeroomname') String storeRoomName,
      @JsonKey(name: 'checktaskno') String checkTaskNo,
      @JsonKey(name: 'checktaskid') int? checkTaskId,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'workstation') String? workStation,
      @JsonKey(name: 'memo') String? memo});
}

/// @nodoc
class _$InventoryTaskCopyWithImpl<$Res, $Val extends InventoryTask>
    implements $InventoryTaskCopyWith<$Res> {
  _$InventoryTaskCopyWithImpl(this._value, this._then);

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
    Object? memo = freezed,
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
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskImplCopyWith<$Res>
    implements $InventoryTaskCopyWith<$Res> {
  factory _$$InventoryTaskImplCopyWith(
          _$InventoryTaskImpl value, $Res Function(_$InventoryTaskImpl) then) =
      __$$InventoryTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'storeroomname') String storeRoomName,
      @JsonKey(name: 'checktaskno') String checkTaskNo,
      @JsonKey(name: 'checktaskid') int? checkTaskId,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'workstation') String? workStation,
      @JsonKey(name: 'memo') String? memo});
}

/// @nodoc
class __$$InventoryTaskImplCopyWithImpl<$Res>
    extends _$InventoryTaskCopyWithImpl<$Res, _$InventoryTaskImpl>
    implements _$$InventoryTaskImplCopyWith<$Res> {
  __$$InventoryTaskImplCopyWithImpl(
      _$InventoryTaskImpl _value, $Res Function(_$InventoryTaskImpl) _then)
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
    Object? memo = freezed,
  }) {
    return _then(_$InventoryTaskImpl(
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
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskImpl implements _InventoryTask {
  const _$InventoryTaskImpl(
      {@JsonKey(name: 'taskcomment') required this.taskComment,
      @JsonKey(name: 'storeroomno') required this.storeRoomNo,
      @JsonKey(name: 'storeroomname') required this.storeRoomName,
      @JsonKey(name: 'checktaskno') required this.checkTaskNo,
      @JsonKey(name: 'checktaskid') this.checkTaskId,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'workstation') this.workStation,
      @JsonKey(name: 'memo') this.memo});

  factory _$InventoryTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskImplFromJson(json);

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

  /// 任务主键
  @override
  @JsonKey(name: 'checktaskid')
  final int? checkTaskId;

  /// 当前状态
  @override
  @JsonKey(name: 'status')
  final String? status;

  /// 工位/拣选位
  @override
  @JsonKey(name: 'workstation')
  final String? workStation;

  /// 任务备注
  @override
  @JsonKey(name: 'memo')
  final String? memo;

  @override
  String toString() {
    return 'InventoryTask(taskComment: $taskComment, storeRoomNo: $storeRoomNo, storeRoomName: $storeRoomName, checkTaskNo: $checkTaskNo, checkTaskId: $checkTaskId, status: $status, workStation: $workStation, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskImpl &&
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
                other.workStation == workStation) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskComment, storeRoomNo,
      storeRoomName, checkTaskNo, checkTaskId, status, workStation, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskImplCopyWith<_$InventoryTaskImpl> get copyWith =>
      __$$InventoryTaskImplCopyWithImpl<_$InventoryTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskImplToJson(
      this,
    );
  }
}

abstract class _InventoryTask implements InventoryTask {
  const factory _InventoryTask(
      {@JsonKey(name: 'taskcomment') required final String taskComment,
      @JsonKey(name: 'storeroomno') required final String storeRoomNo,
      @JsonKey(name: 'storeroomname') required final String storeRoomName,
      @JsonKey(name: 'checktaskno') required final String checkTaskNo,
      @JsonKey(name: 'checktaskid') final int? checkTaskId,
      @JsonKey(name: 'status') final String? status,
      @JsonKey(name: 'workstation') final String? workStation,
      @JsonKey(name: 'memo') final String? memo}) = _$InventoryTaskImpl;

  factory _InventoryTask.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskImpl.fromJson;

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

  /// 任务主键
  @JsonKey(name: 'checktaskid')
  int? get checkTaskId;
  @override

  /// 当前状态
  @JsonKey(name: 'status')
  String? get status;
  @override

  /// 工位/拣选位
  @JsonKey(name: 'workstation')
  String? get workStation;
  @override

  /// 任务备注
  @JsonKey(name: 'memo')
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskImplCopyWith<_$InventoryTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryTaskListResponse _$InventoryTaskListResponseFromJson(
    Map<String, dynamic> json) {
  return _InventoryTaskListResponse.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskListResponse {
  @JsonKey(name: 'rows')
  List<InventoryTask> get rows => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskListResponseCopyWith<InventoryTaskListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskListResponseCopyWith<$Res> {
  factory $InventoryTaskListResponseCopyWith(InventoryTaskListResponse value,
          $Res Function(InventoryTaskListResponse) then) =
      _$InventoryTaskListResponseCopyWithImpl<$Res, InventoryTaskListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<InventoryTask> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class _$InventoryTaskListResponseCopyWithImpl<$Res,
        $Val extends InventoryTaskListResponse>
    implements $InventoryTaskListResponseCopyWith<$Res> {
  _$InventoryTaskListResponseCopyWithImpl(this._value, this._then);

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
              as List<InventoryTask>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskListResponseImplCopyWith<$Res>
    implements $InventoryTaskListResponseCopyWith<$Res> {
  factory _$$InventoryTaskListResponseImplCopyWith(
          _$InventoryTaskListResponseImpl value,
          $Res Function(_$InventoryTaskListResponseImpl) then) =
      __$$InventoryTaskListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<InventoryTask> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class __$$InventoryTaskListResponseImplCopyWithImpl<$Res>
    extends _$InventoryTaskListResponseCopyWithImpl<$Res,
        _$InventoryTaskListResponseImpl>
    implements _$$InventoryTaskListResponseImplCopyWith<$Res> {
  __$$InventoryTaskListResponseImplCopyWithImpl(
      _$InventoryTaskListResponseImpl _value,
      $Res Function(_$InventoryTaskListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_$InventoryTaskListResponseImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<InventoryTask>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskListResponseImpl implements _InventoryTaskListResponse {
  const _$InventoryTaskListResponseImpl(
      {@JsonKey(name: 'rows')
      final List<InventoryTask> rows = const <InventoryTask>[],
      @JsonKey(name: 'total') this.total = 0})
      : _rows = rows;

  factory _$InventoryTaskListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskListResponseImplFromJson(json);

  final List<InventoryTask> _rows;
  @override
  @JsonKey(name: 'rows')
  List<InventoryTask> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'InventoryTaskListResponse(rows: $rows, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskListResponseImpl &&
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
  _$$InventoryTaskListResponseImplCopyWith<_$InventoryTaskListResponseImpl>
      get copyWith => __$$InventoryTaskListResponseImplCopyWithImpl<
          _$InventoryTaskListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskListResponseImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskListResponse implements InventoryTaskListResponse {
  const factory _InventoryTaskListResponse(
          {@JsonKey(name: 'rows') final List<InventoryTask> rows,
          @JsonKey(name: 'total') final int total}) =
      _$InventoryTaskListResponseImpl;

  factory _InventoryTaskListResponse.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'rows')
  List<InventoryTask> get rows;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskListResponseImplCopyWith<_$InventoryTaskListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
