// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionTaskItemQuery _$CollectionTaskItemQueryFromJson(
    Map<String, dynamic> json) {
  return _CollectionTaskItemQuery.fromJson(json);
}

/// @nodoc
mixin _$CollectionTaskItemQuery {
  /// 任务号（示例字段）
  @JsonKey(name: 'outtaskno')
  String get outTaskNo => throw _privateConstructorUsedError;

  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 强制库位标志/参数（示例字段）
  @JsonKey(name: 'forcesite')
  String get forceSite => throw _privateConstructorUsedError;

  /// 强制批次标志/参数（示例字段）
  @JsonKey(name: 'forcebatch')
  String get forceBatch => throw _privateConstructorUsedError;

  /// 凭证/备注
  @JsonKey(name: 'taskcomment')
  String get taskComment => throw _privateConstructorUsedError;

  /// 任务完成标志（示例字段）
  @JsonKey(name: 'taskFinishFlag')
  String get taskFinishFlag => throw _privateConstructorUsedError;

  /// 库房标签（示例为 roomtag）
  @JsonKey(name: 'roomtag')
  String get roomTag => throw _privateConstructorUsedError;

  /// 工作站
  @JsonKey(name: 'workstation')
  String get workStation => throw _privateConstructorUsedError;

  /// 完成标志（示例字段）
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;

  /// 排序类型
  @JsonKey(name: 'sortType')
  String get sortType => throw _privateConstructorUsedError;

  /// 排序字段
  @JsonKey(name: 'sortColumn')
  String get sortColumn => throw _privateConstructorUsedError;

  /// 搜索关键字
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;

  /// 节拍标志
  @JsonKey(name: 'beatflag')
  String get beatFlag => throw _privateConstructorUsedError;

  /// 采集人（示例为 this.$store.state.userid）
  @JsonKey(name: 'collecter')
  int get collecter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionTaskItemQueryCopyWith<CollectionTaskItemQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionTaskItemQueryCopyWith<$Res> {
  factory $CollectionTaskItemQueryCopyWith(CollectionTaskItemQuery value,
          $Res Function(CollectionTaskItemQuery) then) =
      _$CollectionTaskItemQueryCopyWithImpl<$Res, CollectionTaskItemQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'forcesite') String forceSite,
      @JsonKey(name: 'forcebatch') String forceBatch,
      @JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'taskFinishFlag') String taskFinishFlag,
      @JsonKey(name: 'roomtag') String roomTag,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'collecter') int collecter});
}

/// @nodoc
class _$CollectionTaskItemQueryCopyWithImpl<$Res,
        $Val extends CollectionTaskItemQuery>
    implements $CollectionTaskItemQueryCopyWith<$Res> {
  _$CollectionTaskItemQueryCopyWithImpl(this._value, this._then);

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
    Object? taskFinishFlag = null,
    Object? roomTag = null,
    Object? workStation = null,
    Object? finishFlag = null,
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? beatFlag = null,
    Object? collecter = null,
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
      taskFinishFlag: null == taskFinishFlag
          ? _value.taskFinishFlag
          : taskFinishFlag // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
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
      collecter: null == collecter
          ? _value.collecter
          : collecter // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionTaskItemQueryImplCopyWith<$Res>
    implements $CollectionTaskItemQueryCopyWith<$Res> {
  factory _$$CollectionTaskItemQueryImplCopyWith(
          _$CollectionTaskItemQueryImpl value,
          $Res Function(_$CollectionTaskItemQueryImpl) then) =
      __$$CollectionTaskItemQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'forcesite') String forceSite,
      @JsonKey(name: 'forcebatch') String forceBatch,
      @JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'taskFinishFlag') String taskFinishFlag,
      @JsonKey(name: 'roomtag') String roomTag,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'finshFlg') String finishFlag,
      @JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'collecter') int collecter});
}

/// @nodoc
class __$$CollectionTaskItemQueryImplCopyWithImpl<$Res>
    extends _$CollectionTaskItemQueryCopyWithImpl<$Res,
        _$CollectionTaskItemQueryImpl>
    implements _$$CollectionTaskItemQueryImplCopyWith<$Res> {
  __$$CollectionTaskItemQueryImplCopyWithImpl(
      _$CollectionTaskItemQueryImpl _value,
      $Res Function(_$CollectionTaskItemQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskNo = null,
    Object? storeRoomNo = null,
    Object? forceSite = null,
    Object? forceBatch = null,
    Object? taskComment = null,
    Object? taskFinishFlag = null,
    Object? roomTag = null,
    Object? workStation = null,
    Object? finishFlag = null,
    Object? sortType = null,
    Object? sortColumn = null,
    Object? searchKey = null,
    Object? beatFlag = null,
    Object? collecter = null,
  }) {
    return _then(_$CollectionTaskItemQueryImpl(
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
      taskFinishFlag: null == taskFinishFlag
          ? _value.taskFinishFlag
          : taskFinishFlag // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
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
      collecter: null == collecter
          ? _value.collecter
          : collecter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionTaskItemQueryImpl implements _CollectionTaskItemQuery {
  const _$CollectionTaskItemQueryImpl(
      {@JsonKey(name: 'outtaskno') this.outTaskNo = '',
      @JsonKey(name: 'storeroomno') this.storeRoomNo = '',
      @JsonKey(name: 'forcesite') this.forceSite = '',
      @JsonKey(name: 'forcebatch') this.forceBatch = '',
      @JsonKey(name: 'taskcomment') this.taskComment = '',
      @JsonKey(name: 'taskFinishFlag') this.taskFinishFlag = '0',
      @JsonKey(name: 'roomtag') this.roomTag = '0',
      @JsonKey(name: 'workstation') this.workStation = '',
      @JsonKey(name: 'finshFlg') this.finishFlag = '0',
      @JsonKey(name: 'sortType') this.sortType = '',
      @JsonKey(name: 'sortColumn') this.sortColumn = '',
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'beatflag') this.beatFlag = 'N',
      @JsonKey(name: 'collecter') this.collecter = 0});

  factory _$CollectionTaskItemQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionTaskItemQueryImplFromJson(json);

  /// 任务号（示例字段）
  @override
  @JsonKey(name: 'outtaskno')
  final String outTaskNo;

  /// 库房编号
  @override
  @JsonKey(name: 'storeroomno')
  final String storeRoomNo;

  /// 强制库位标志/参数（示例字段）
  @override
  @JsonKey(name: 'forcesite')
  final String forceSite;

  /// 强制批次标志/参数（示例字段）
  @override
  @JsonKey(name: 'forcebatch')
  final String forceBatch;

  /// 凭证/备注
  @override
  @JsonKey(name: 'taskcomment')
  final String taskComment;

  /// 任务完成标志（示例字段）
  @override
  @JsonKey(name: 'taskFinishFlag')
  final String taskFinishFlag;

  /// 库房标签（示例为 roomtag）
  @override
  @JsonKey(name: 'roomtag')
  final String roomTag;

  /// 工作站
  @override
  @JsonKey(name: 'workstation')
  final String workStation;

  /// 完成标志（示例字段）
  @override
  @JsonKey(name: 'finshFlg')
  final String finishFlag;

  /// 排序类型
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

  /// 节拍标志
  @override
  @JsonKey(name: 'beatflag')
  final String beatFlag;

  /// 采集人（示例为 this.$store.state.userid）
  @override
  @JsonKey(name: 'collecter')
  final int collecter;

  @override
  String toString() {
    return 'CollectionTaskItemQuery(outTaskNo: $outTaskNo, storeRoomNo: $storeRoomNo, forceSite: $forceSite, forceBatch: $forceBatch, taskComment: $taskComment, taskFinishFlag: $taskFinishFlag, roomTag: $roomTag, workStation: $workStation, finishFlag: $finishFlag, sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, beatFlag: $beatFlag, collecter: $collecter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionTaskItemQueryImpl &&
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
            (identical(other.taskFinishFlag, taskFinishFlag) ||
                other.taskFinishFlag == taskFinishFlag) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.finishFlag, finishFlag) ||
                other.finishFlag == finishFlag) &&
            (identical(other.sortType, sortType) ||
                other.sortType == sortType) &&
            (identical(other.sortColumn, sortColumn) ||
                other.sortColumn == sortColumn) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.beatFlag, beatFlag) ||
                other.beatFlag == beatFlag) &&
            (identical(other.collecter, collecter) ||
                other.collecter == collecter));
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
      taskFinishFlag,
      roomTag,
      workStation,
      finishFlag,
      sortType,
      sortColumn,
      searchKey,
      beatFlag,
      collecter);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionTaskItemQueryImplCopyWith<_$CollectionTaskItemQueryImpl>
      get copyWith => __$$CollectionTaskItemQueryImplCopyWithImpl<
          _$CollectionTaskItemQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionTaskItemQueryImplToJson(
      this,
    );
  }
}

abstract class _CollectionTaskItemQuery implements CollectionTaskItemQuery {
  const factory _CollectionTaskItemQuery(
          {@JsonKey(name: 'outtaskno') final String outTaskNo,
          @JsonKey(name: 'storeroomno') final String storeRoomNo,
          @JsonKey(name: 'forcesite') final String forceSite,
          @JsonKey(name: 'forcebatch') final String forceBatch,
          @JsonKey(name: 'taskcomment') final String taskComment,
          @JsonKey(name: 'taskFinishFlag') final String taskFinishFlag,
          @JsonKey(name: 'roomtag') final String roomTag,
          @JsonKey(name: 'workstation') final String workStation,
          @JsonKey(name: 'finshFlg') final String finishFlag,
          @JsonKey(name: 'sortType') final String sortType,
          @JsonKey(name: 'sortColumn') final String sortColumn,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'beatflag') final String beatFlag,
          @JsonKey(name: 'collecter') final int collecter}) =
      _$CollectionTaskItemQueryImpl;

  factory _CollectionTaskItemQuery.fromJson(Map<String, dynamic> json) =
      _$CollectionTaskItemQueryImpl.fromJson;

  @override

  /// 任务号（示例字段）
  @JsonKey(name: 'outtaskno')
  String get outTaskNo;
  @override

  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo;
  @override

  /// 强制库位标志/参数（示例字段）
  @JsonKey(name: 'forcesite')
  String get forceSite;
  @override

  /// 强制批次标志/参数（示例字段）
  @JsonKey(name: 'forcebatch')
  String get forceBatch;
  @override

  /// 凭证/备注
  @JsonKey(name: 'taskcomment')
  String get taskComment;
  @override

  /// 任务完成标志（示例字段）
  @JsonKey(name: 'taskFinishFlag')
  String get taskFinishFlag;
  @override

  /// 库房标签（示例为 roomtag）
  @JsonKey(name: 'roomtag')
  String get roomTag;
  @override

  /// 工作站
  @JsonKey(name: 'workstation')
  String get workStation;
  @override

  /// 完成标志（示例字段）
  @JsonKey(name: 'finshFlg')
  String get finishFlag;
  @override

  /// 排序类型
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

  /// 节拍标志
  @JsonKey(name: 'beatflag')
  String get beatFlag;
  @override

  /// 采集人（示例为 this.$store.state.userid）
  @JsonKey(name: 'collecter')
  int get collecter;
  @override
  @JsonKey(ignore: true)
  _$$CollectionTaskItemQueryImplCopyWith<_$CollectionTaskItemQueryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
