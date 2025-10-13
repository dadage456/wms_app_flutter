// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_up_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GoodsUpTaskItemQueryRequest _$GoodsUpTaskItemQueryRequestFromJson(
  Map<String, dynamic> json,
) {
  return _GoodsUpTaskItemQueryRequest.fromJson(json);
}

/// @nodoc
mixin _$GoodsUpTaskItemQueryRequest {
  /// 入库任务号
  @JsonKey(name: 'intaskno')
  String get inTaskNo => throw _privateConstructorUsedError;

  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 强制库位标志
  @JsonKey(name: 'forcesite')
  String get forceSite => throw _privateConstructorUsedError;

  /// 强制批次标志
  @JsonKey(name: 'forcebatch')
  String get forceBatch => throw _privateConstructorUsedError;

  /// 任务备注
  @JsonKey(name: 'taskcomment')
  String get taskComment => throw _privateConstructorUsedError;

  /// 完成标志
  @JsonKey(name: 'taskFinishFlag')
  String get taskFinishFlag => throw _privateConstructorUsedError;

  /// 库房标签
  @JsonKey(name: 'roomtag')
  String get roomTag => throw _privateConstructorUsedError;

  /// 工作站
  @JsonKey(name: 'workstation')
  String get workStation => throw _privateConstructorUsedError;

  /// 完成标志（兼容字段）
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

  /// 采集人
  @JsonKey(name: 'collecter')
  int get collecter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoodsUpTaskItemQueryRequestCopyWith<GoodsUpTaskItemQueryRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodsUpTaskItemQueryRequestCopyWith<$Res> {
  factory $GoodsUpTaskItemQueryRequestCopyWith(
    GoodsUpTaskItemQueryRequest value,
    $Res Function(GoodsUpTaskItemQueryRequest) then,
  ) =
      _$GoodsUpTaskItemQueryRequestCopyWithImpl<
        $Res,
        GoodsUpTaskItemQueryRequest
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'intaskno') String inTaskNo,
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
    @JsonKey(name: 'collecter') int collecter,
  });
}

/// @nodoc
class _$GoodsUpTaskItemQueryRequestCopyWithImpl<
  $Res,
  $Val extends GoodsUpTaskItemQueryRequest
>
    implements $GoodsUpTaskItemQueryRequestCopyWith<$Res> {
  _$GoodsUpTaskItemQueryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inTaskNo = null,
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
    return _then(
      _value.copyWith(
            inTaskNo: null == inTaskNo
                ? _value.inTaskNo
                : inTaskNo // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoodsUpTaskItemQueryRequestImplCopyWith<$Res>
    implements $GoodsUpTaskItemQueryRequestCopyWith<$Res> {
  factory _$$GoodsUpTaskItemQueryRequestImplCopyWith(
    _$GoodsUpTaskItemQueryRequestImpl value,
    $Res Function(_$GoodsUpTaskItemQueryRequestImpl) then,
  ) = __$$GoodsUpTaskItemQueryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'intaskno') String inTaskNo,
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
    @JsonKey(name: 'collecter') int collecter,
  });
}

/// @nodoc
class __$$GoodsUpTaskItemQueryRequestImplCopyWithImpl<$Res>
    extends
        _$GoodsUpTaskItemQueryRequestCopyWithImpl<
          $Res,
          _$GoodsUpTaskItemQueryRequestImpl
        >
    implements _$$GoodsUpTaskItemQueryRequestImplCopyWith<$Res> {
  __$$GoodsUpTaskItemQueryRequestImplCopyWithImpl(
    _$GoodsUpTaskItemQueryRequestImpl _value,
    $Res Function(_$GoodsUpTaskItemQueryRequestImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inTaskNo = null,
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
    return _then(
      _$GoodsUpTaskItemQueryRequestImpl(
        inTaskNo: null == inTaskNo
            ? _value.inTaskNo
            : inTaskNo // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodsUpTaskItemQueryRequestImpl
    implements _GoodsUpTaskItemQueryRequest {
  const _$GoodsUpTaskItemQueryRequestImpl({
    @JsonKey(name: 'intaskno') this.inTaskNo = '',
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
    @JsonKey(name: 'collecter') this.collecter = 0,
  });

  factory _$GoodsUpTaskItemQueryRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$GoodsUpTaskItemQueryRequestImplFromJson(json);

  /// 入库任务号
  @override
  @JsonKey(name: 'intaskno')
  final String inTaskNo;

  /// 库房编号
  @override
  @JsonKey(name: 'storeroomno')
  final String storeRoomNo;

  /// 强制库位标志
  @override
  @JsonKey(name: 'forcesite')
  final String forceSite;

  /// 强制批次标志
  @override
  @JsonKey(name: 'forcebatch')
  final String forceBatch;

  /// 任务备注
  @override
  @JsonKey(name: 'taskcomment')
  final String taskComment;

  /// 完成标志
  @override
  @JsonKey(name: 'taskFinishFlag')
  final String taskFinishFlag;

  /// 库房标签
  @override
  @JsonKey(name: 'roomtag')
  final String roomTag;

  /// 工作站
  @override
  @JsonKey(name: 'workstation')
  final String workStation;

  /// 完成标志（兼容字段）
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

  /// 采集人
  @override
  @JsonKey(name: 'collecter')
  final int collecter;

  @override
  String toString() {
    return 'GoodsUpTaskItemQueryRequest(inTaskNo: $inTaskNo, storeRoomNo: $storeRoomNo, forceSite: $forceSite, forceBatch: $forceBatch, taskComment: $taskComment, taskFinishFlag: $taskFinishFlag, roomTag: $roomTag, workStation: $workStation, finishFlag: $finishFlag, sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, beatFlag: $beatFlag, collecter: $collecter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodsUpTaskItemQueryRequestImpl &&
            (identical(other.inTaskNo, inTaskNo) ||
                other.inTaskNo == inTaskNo) &&
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
    inTaskNo,
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
    collecter,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodsUpTaskItemQueryRequestImplCopyWith<_$GoodsUpTaskItemQueryRequestImpl>
  get copyWith =>
      __$$GoodsUpTaskItemQueryRequestImplCopyWithImpl<
        _$GoodsUpTaskItemQueryRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodsUpTaskItemQueryRequestImplToJson(this);
  }
}

abstract class _GoodsUpTaskItemQueryRequest
    implements GoodsUpTaskItemQueryRequest {
  const factory _GoodsUpTaskItemQueryRequest({
    @JsonKey(name: 'intaskno') final String inTaskNo,
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
    @JsonKey(name: 'collecter') final int collecter,
  }) = _$GoodsUpTaskItemQueryRequestImpl;

  factory _GoodsUpTaskItemQueryRequest.fromJson(Map<String, dynamic> json) =
      _$GoodsUpTaskItemQueryRequestImpl.fromJson;

  @override
  /// 入库任务号
  @JsonKey(name: 'intaskno')
  String get inTaskNo;
  @override
  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo;
  @override
  /// 强制库位标志
  @JsonKey(name: 'forcesite')
  String get forceSite;
  @override
  /// 强制批次标志
  @JsonKey(name: 'forcebatch')
  String get forceBatch;
  @override
  /// 任务备注
  @JsonKey(name: 'taskcomment')
  String get taskComment;
  @override
  /// 完成标志
  @JsonKey(name: 'taskFinishFlag')
  String get taskFinishFlag;
  @override
  /// 库房标签
  @JsonKey(name: 'roomtag')
  String get roomTag;
  @override
  /// 工作站
  @JsonKey(name: 'workstation')
  String get workStation;
  @override
  /// 完成标志（兼容字段）
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
  /// 采集人
  @JsonKey(name: 'collecter')
  int get collecter;
  @override
  @JsonKey(ignore: true)
  _$$GoodsUpTaskItemQueryRequestImplCopyWith<_$GoodsUpTaskItemQueryRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
