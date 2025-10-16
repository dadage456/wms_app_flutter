// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_pick_task_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnlinePickTask _$OnlinePickTaskFromJson(Map<String, dynamic> json) {
  return _OnlinePickTask.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTask {
  /// 任务唯一标识
  @JsonKey(name: 'outtaskid')
  int get outTaskId => throw _privateConstructorUsedError;

  /// 任务号
  @JsonKey(name: 'outtaskno')
  String get outTaskNo => throw _privateConstructorUsedError;

  /// 出库单号
  @JsonKey(name: 'orderno')
  String? get orderNo => throw _privateConstructorUsedError;

  /// 来源单号
  @JsonKey(name: 'po_number')
  String? get poNumber => throw _privateConstructorUsedError;

  /// 库房号
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;

  /// 工位
  @JsonKey(name: 'workstation')
  String? get workStation => throw _privateConstructorUsedError;

  /// 凭证号
  @JsonKey(name: 'taskcomment')
  String? get taskComment => throw _privateConstructorUsedError;

  /// 紧急补单标识
  @JsonKey(name: 'wip_supplement_flag')
  String? get urgentFlag => throw _privateConstructorUsedError;

  /// 班组名称
  @JsonKey(name: 'schedule_group_name')
  String? get scheduleGroupName => throw _privateConstructorUsedError;

  /// 强制校验库位标志
  @JsonKey(name: 'forcesite')
  String? get forceSite => throw _privateConstructorUsedError;

  /// 强制校验批次标志
  @JsonKey(name: 'forcebatch')
  String? get forceBatch => throw _privateConstructorUsedError;

  /// 完成标记（0：采集中，1：全部）
  @JsonKey(name: 'finshFlg')
  String? get finishFlag => throw _privateConstructorUsedError;

  /// 创建时间
  @JsonKey(name: 'createtime')
  String? get createTime => throw _privateConstructorUsedError;

  /// 任务数量
  @JsonKey(name: 'taskqty')
  num get taskQty => throw _privateConstructorUsedError;

  /// 完成数量
  @JsonKey(name: 'finishqty')
  num get finishQty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskCopyWith<OnlinePickTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskCopyWith<$Res> {
  factory $OnlinePickTaskCopyWith(
          OnlinePickTask value, $Res Function(OnlinePickTask) then) =
      _$OnlinePickTaskCopyWithImpl<$Res, OnlinePickTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') int outTaskId,
      @JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'po_number') String? poNumber,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'workstation') String? workStation,
      @JsonKey(name: 'taskcomment') String? taskComment,
      @JsonKey(name: 'wip_supplement_flag') String? urgentFlag,
      @JsonKey(name: 'schedule_group_name') String? scheduleGroupName,
      @JsonKey(name: 'forcesite') String? forceSite,
      @JsonKey(name: 'forcebatch') String? forceBatch,
      @JsonKey(name: 'finshFlg') String? finishFlag,
      @JsonKey(name: 'createtime') String? createTime,
      @JsonKey(name: 'taskqty') num taskQty,
      @JsonKey(name: 'finishqty') num finishQty});
}

/// @nodoc
class _$OnlinePickTaskCopyWithImpl<$Res, $Val extends OnlinePickTask>
    implements $OnlinePickTaskCopyWith<$Res> {
  _$OnlinePickTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? outTaskNo = null,
    Object? orderNo = freezed,
    Object? poNumber = freezed,
    Object? storeRoomNo = freezed,
    Object? workStation = freezed,
    Object? taskComment = freezed,
    Object? urgentFlag = freezed,
    Object? scheduleGroupName = freezed,
    Object? forceSite = freezed,
    Object? forceBatch = freezed,
    Object? finishFlag = freezed,
    Object? createTime = freezed,
    Object? taskQty = null,
    Object? finishQty = null,
  }) {
    return _then(_value.copyWith(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskNo: null == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      poNumber: freezed == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
      urgentFlag: freezed == urgentFlag
          ? _value.urgentFlag
          : urgentFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleGroupName: freezed == scheduleGroupName
          ? _value.scheduleGroupName
          : scheduleGroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      forceSite: freezed == forceSite
          ? _value.forceSite
          : forceSite // ignore: cast_nullable_to_non_nullable
              as String?,
      forceBatch: freezed == forceBatch
          ? _value.forceBatch
          : forceBatch // ignore: cast_nullable_to_non_nullable
              as String?,
      finishFlag: freezed == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as num,
      finishQty: null == finishQty
          ? _value.finishQty
          : finishQty // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskImplCopyWith<$Res>
    implements $OnlinePickTaskCopyWith<$Res> {
  factory _$$OnlinePickTaskImplCopyWith(_$OnlinePickTaskImpl value,
          $Res Function(_$OnlinePickTaskImpl) then) =
      __$$OnlinePickTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') int outTaskId,
      @JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'orderno') String? orderNo,
      @JsonKey(name: 'po_number') String? poNumber,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'workstation') String? workStation,
      @JsonKey(name: 'taskcomment') String? taskComment,
      @JsonKey(name: 'wip_supplement_flag') String? urgentFlag,
      @JsonKey(name: 'schedule_group_name') String? scheduleGroupName,
      @JsonKey(name: 'forcesite') String? forceSite,
      @JsonKey(name: 'forcebatch') String? forceBatch,
      @JsonKey(name: 'finshFlg') String? finishFlag,
      @JsonKey(name: 'createtime') String? createTime,
      @JsonKey(name: 'taskqty') num taskQty,
      @JsonKey(name: 'finishqty') num finishQty});
}

/// @nodoc
class __$$OnlinePickTaskImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskCopyWithImpl<$Res, _$OnlinePickTaskImpl>
    implements _$$OnlinePickTaskImplCopyWith<$Res> {
  __$$OnlinePickTaskImplCopyWithImpl(
      _$OnlinePickTaskImpl _value, $Res Function(_$OnlinePickTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? outTaskNo = null,
    Object? orderNo = freezed,
    Object? poNumber = freezed,
    Object? storeRoomNo = freezed,
    Object? workStation = freezed,
    Object? taskComment = freezed,
    Object? urgentFlag = freezed,
    Object? scheduleGroupName = freezed,
    Object? forceSite = freezed,
    Object? forceBatch = freezed,
    Object? finishFlag = freezed,
    Object? createTime = freezed,
    Object? taskQty = null,
    Object? finishQty = null,
  }) {
    return _then(_$OnlinePickTaskImpl(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskNo: null == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      orderNo: freezed == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      poNumber: freezed == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
      urgentFlag: freezed == urgentFlag
          ? _value.urgentFlag
          : urgentFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleGroupName: freezed == scheduleGroupName
          ? _value.scheduleGroupName
          : scheduleGroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      forceSite: freezed == forceSite
          ? _value.forceSite
          : forceSite // ignore: cast_nullable_to_non_nullable
              as String?,
      forceBatch: freezed == forceBatch
          ? _value.forceBatch
          : forceBatch // ignore: cast_nullable_to_non_nullable
              as String?,
      finishFlag: freezed == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as num,
      finishQty: null == finishQty
          ? _value.finishQty
          : finishQty // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskImpl implements _OnlinePickTask {
  const _$OnlinePickTaskImpl(
      {@JsonKey(name: 'outtaskid') required this.outTaskId,
      @JsonKey(name: 'outtaskno') required this.outTaskNo,
      @JsonKey(name: 'orderno') this.orderNo,
      @JsonKey(name: 'po_number') this.poNumber,
      @JsonKey(name: 'storeroomno') this.storeRoomNo,
      @JsonKey(name: 'workstation') this.workStation,
      @JsonKey(name: 'taskcomment') this.taskComment,
      @JsonKey(name: 'wip_supplement_flag') this.urgentFlag,
      @JsonKey(name: 'schedule_group_name') this.scheduleGroupName,
      @JsonKey(name: 'forcesite') this.forceSite,
      @JsonKey(name: 'forcebatch') this.forceBatch,
      @JsonKey(name: 'finshFlg') this.finishFlag,
      @JsonKey(name: 'createtime') this.createTime,
      @JsonKey(name: 'taskqty') this.taskQty = 0,
      @JsonKey(name: 'finishqty') this.finishQty = 0});

  factory _$OnlinePickTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickTaskImplFromJson(json);

  /// 任务唯一标识
  @override
  @JsonKey(name: 'outtaskid')
  final int outTaskId;

  /// 任务号
  @override
  @JsonKey(name: 'outtaskno')
  final String outTaskNo;

  /// 出库单号
  @override
  @JsonKey(name: 'orderno')
  final String? orderNo;

  /// 来源单号
  @override
  @JsonKey(name: 'po_number')
  final String? poNumber;

  /// 库房号
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;

  /// 工位
  @override
  @JsonKey(name: 'workstation')
  final String? workStation;

  /// 凭证号
  @override
  @JsonKey(name: 'taskcomment')
  final String? taskComment;

  /// 紧急补单标识
  @override
  @JsonKey(name: 'wip_supplement_flag')
  final String? urgentFlag;

  /// 班组名称
  @override
  @JsonKey(name: 'schedule_group_name')
  final String? scheduleGroupName;

  /// 强制校验库位标志
  @override
  @JsonKey(name: 'forcesite')
  final String? forceSite;

  /// 强制校验批次标志
  @override
  @JsonKey(name: 'forcebatch')
  final String? forceBatch;

  /// 完成标记（0：采集中，1：全部）
  @override
  @JsonKey(name: 'finshFlg')
  final String? finishFlag;

  /// 创建时间
  @override
  @JsonKey(name: 'createtime')
  final String? createTime;

  /// 任务数量
  @override
  @JsonKey(name: 'taskqty')
  final num taskQty;

  /// 完成数量
  @override
  @JsonKey(name: 'finishqty')
  final num finishQty;

  @override
  String toString() {
    return 'OnlinePickTask(outTaskId: $outTaskId, outTaskNo: $outTaskNo, orderNo: $orderNo, poNumber: $poNumber, storeRoomNo: $storeRoomNo, workStation: $workStation, taskComment: $taskComment, urgentFlag: $urgentFlag, scheduleGroupName: $scheduleGroupName, forceSite: $forceSite, forceBatch: $forceBatch, finishFlag: $finishFlag, createTime: $createTime, taskQty: $taskQty, finishQty: $finishQty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskImpl &&
            (identical(other.outTaskId, outTaskId) ||
                other.outTaskId == outTaskId) &&
            (identical(other.outTaskNo, outTaskNo) ||
                other.outTaskNo == outTaskNo) &&
            (identical(other.orderNo, orderNo) || other.orderNo == orderNo) &&
            (identical(other.poNumber, poNumber) ||
                other.poNumber == poNumber) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.urgentFlag, urgentFlag) ||
                other.urgentFlag == urgentFlag) &&
            (identical(other.scheduleGroupName, scheduleGroupName) ||
                other.scheduleGroupName == scheduleGroupName) &&
            (identical(other.forceSite, forceSite) ||
                other.forceSite == forceSite) &&
            (identical(other.forceBatch, forceBatch) ||
                other.forceBatch == forceBatch) &&
            (identical(other.finishFlag, finishFlag) ||
                other.finishFlag == finishFlag) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.finishQty, finishQty) ||
                other.finishQty == finishQty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      outTaskId,
      outTaskNo,
      orderNo,
      poNumber,
      storeRoomNo,
      workStation,
      taskComment,
      urgentFlag,
      scheduleGroupName,
      forceSite,
      forceBatch,
      finishFlag,
      createTime,
      taskQty,
      finishQty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickTaskImplCopyWith<_$OnlinePickTaskImpl> get copyWith =>
      __$$OnlinePickTaskImplCopyWithImpl<_$OnlinePickTaskImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTask implements OnlinePickTask {
  const factory _OnlinePickTask(
      {@JsonKey(name: 'outtaskid') required final int outTaskId,
      @JsonKey(name: 'outtaskno') required final String outTaskNo,
      @JsonKey(name: 'orderno') final String? orderNo,
      @JsonKey(name: 'po_number') final String? poNumber,
      @JsonKey(name: 'storeroomno') final String? storeRoomNo,
      @JsonKey(name: 'workstation') final String? workStation,
      @JsonKey(name: 'taskcomment') final String? taskComment,
      @JsonKey(name: 'wip_supplement_flag') final String? urgentFlag,
      @JsonKey(name: 'schedule_group_name') final String? scheduleGroupName,
      @JsonKey(name: 'forcesite') final String? forceSite,
      @JsonKey(name: 'forcebatch') final String? forceBatch,
      @JsonKey(name: 'finshFlg') final String? finishFlag,
      @JsonKey(name: 'createtime') final String? createTime,
      @JsonKey(name: 'taskqty') final num taskQty,
      @JsonKey(name: 'finishqty') final num finishQty}) = _$OnlinePickTaskImpl;

  factory _OnlinePickTask.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskImpl.fromJson;

  @override

  /// 任务唯一标识
  @JsonKey(name: 'outtaskid')
  int get outTaskId;
  @override

  /// 任务号
  @JsonKey(name: 'outtaskno')
  String get outTaskNo;
  @override

  /// 出库单号
  @JsonKey(name: 'orderno')
  String? get orderNo;
  @override

  /// 来源单号
  @JsonKey(name: 'po_number')
  String? get poNumber;
  @override

  /// 库房号
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;
  @override

  /// 工位
  @JsonKey(name: 'workstation')
  String? get workStation;
  @override

  /// 凭证号
  @JsonKey(name: 'taskcomment')
  String? get taskComment;
  @override

  /// 紧急补单标识
  @JsonKey(name: 'wip_supplement_flag')
  String? get urgentFlag;
  @override

  /// 班组名称
  @JsonKey(name: 'schedule_group_name')
  String? get scheduleGroupName;
  @override

  /// 强制校验库位标志
  @JsonKey(name: 'forcesite')
  String? get forceSite;
  @override

  /// 强制校验批次标志
  @JsonKey(name: 'forcebatch')
  String? get forceBatch;
  @override

  /// 完成标记（0：采集中，1：全部）
  @JsonKey(name: 'finshFlg')
  String? get finishFlag;
  @override

  /// 创建时间
  @JsonKey(name: 'createtime')
  String? get createTime;
  @override

  /// 任务数量
  @JsonKey(name: 'taskqty')
  num get taskQty;
  @override

  /// 完成数量
  @JsonKey(name: 'finishqty')
  num get finishQty;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTaskImplCopyWith<_$OnlinePickTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OnlinePickTaskListData _$OnlinePickTaskListDataFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickTaskListData.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTaskListData {
  @JsonKey(name: 'rows')
  List<OnlinePickTask> get rows => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskListDataCopyWith<OnlinePickTaskListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskListDataCopyWith<$Res> {
  factory $OnlinePickTaskListDataCopyWith(OnlinePickTaskListData value,
          $Res Function(OnlinePickTaskListData) then) =
      _$OnlinePickTaskListDataCopyWithImpl<$Res, OnlinePickTaskListData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OnlinePickTask> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class _$OnlinePickTaskListDataCopyWithImpl<$Res,
        $Val extends OnlinePickTaskListData>
    implements $OnlinePickTaskListDataCopyWith<$Res> {
  _$OnlinePickTaskListDataCopyWithImpl(this._value, this._then);

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
              as List<OnlinePickTask>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskListDataImplCopyWith<$Res>
    implements $OnlinePickTaskListDataCopyWith<$Res> {
  factory _$$OnlinePickTaskListDataImplCopyWith(
          _$OnlinePickTaskListDataImpl value,
          $Res Function(_$OnlinePickTaskListDataImpl) then) =
      __$$OnlinePickTaskListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OnlinePickTask> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class __$$OnlinePickTaskListDataImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskListDataCopyWithImpl<$Res,
        _$OnlinePickTaskListDataImpl>
    implements _$$OnlinePickTaskListDataImplCopyWith<$Res> {
  __$$OnlinePickTaskListDataImplCopyWithImpl(
      _$OnlinePickTaskListDataImpl _value,
      $Res Function(_$OnlinePickTaskListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_$OnlinePickTaskListDataImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<OnlinePickTask>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskListDataImpl implements _OnlinePickTaskListData {
  const _$OnlinePickTaskListDataImpl(
      {@JsonKey(name: 'rows') final List<OnlinePickTask> rows = const [],
      @JsonKey(name: 'total') this.total = 0})
      : _rows = rows;

  factory _$OnlinePickTaskListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickTaskListDataImplFromJson(json);

  final List<OnlinePickTask> _rows;
  @override
  @JsonKey(name: 'rows')
  List<OnlinePickTask> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'OnlinePickTaskListData(rows: $rows, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskListDataImpl &&
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
  _$$OnlinePickTaskListDataImplCopyWith<_$OnlinePickTaskListDataImpl>
      get copyWith => __$$OnlinePickTaskListDataImplCopyWithImpl<
          _$OnlinePickTaskListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskListDataImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTaskListData implements OnlinePickTaskListData {
  const factory _OnlinePickTaskListData(
      {@JsonKey(name: 'rows') final List<OnlinePickTask> rows,
      @JsonKey(name: 'total') final int total}) = _$OnlinePickTaskListDataImpl;

  factory _OnlinePickTaskListData.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskListDataImpl.fromJson;

  @override
  @JsonKey(name: 'rows')
  List<OnlinePickTask> get rows;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTaskListDataImplCopyWith<_$OnlinePickTaskListDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickTaskListResponse _$OnlinePickTaskListResponseFromJson(
    Map<String, dynamic> json) {
  return _OnlinePickTaskListResponse.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTaskListResponse {
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  OnlinePickTaskListData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskListResponseCopyWith<OnlinePickTaskListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskListResponseCopyWith<$Res> {
  factory $OnlinePickTaskListResponseCopyWith(OnlinePickTaskListResponse value,
          $Res Function(OnlinePickTaskListResponse) then) =
      _$OnlinePickTaskListResponseCopyWithImpl<$Res,
          OnlinePickTaskListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') OnlinePickTaskListData data});

  $OnlinePickTaskListDataCopyWith<$Res> get data;
}

/// @nodoc
class _$OnlinePickTaskListResponseCopyWithImpl<$Res,
        $Val extends OnlinePickTaskListResponse>
    implements $OnlinePickTaskListResponseCopyWith<$Res> {
  _$OnlinePickTaskListResponseCopyWithImpl(this._value, this._then);

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
              as OnlinePickTaskListData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OnlinePickTaskListDataCopyWith<$Res> get data {
    return $OnlinePickTaskListDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskListResponseImplCopyWith<$Res>
    implements $OnlinePickTaskListResponseCopyWith<$Res> {
  factory _$$OnlinePickTaskListResponseImplCopyWith(
          _$OnlinePickTaskListResponseImpl value,
          $Res Function(_$OnlinePickTaskListResponseImpl) then) =
      __$$OnlinePickTaskListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') OnlinePickTaskListData data});

  @override
  $OnlinePickTaskListDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$OnlinePickTaskListResponseImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskListResponseCopyWithImpl<$Res,
        _$OnlinePickTaskListResponseImpl>
    implements _$$OnlinePickTaskListResponseImplCopyWith<$Res> {
  __$$OnlinePickTaskListResponseImplCopyWithImpl(
      _$OnlinePickTaskListResponseImpl _value,
      $Res Function(_$OnlinePickTaskListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$OnlinePickTaskListResponseImpl(
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
              as OnlinePickTaskListData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskListResponseImpl implements _OnlinePickTaskListResponse {
  const _$OnlinePickTaskListResponseImpl(
      {@JsonKey(name: 'code') required this.code,
      @JsonKey(name: 'msg') required this.message,
      @JsonKey(name: 'data') required this.data});

  factory _$OnlinePickTaskListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OnlinePickTaskListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'code')
  final String code;
  @override
  @JsonKey(name: 'msg')
  final String message;
  @override
  @JsonKey(name: 'data')
  final OnlinePickTaskListData data;

  @override
  String toString() {
    return 'OnlinePickTaskListResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskListResponseImpl &&
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
  _$$OnlinePickTaskListResponseImplCopyWith<_$OnlinePickTaskListResponseImpl>
      get copyWith => __$$OnlinePickTaskListResponseImplCopyWithImpl<
          _$OnlinePickTaskListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskListResponseImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTaskListResponse
    implements OnlinePickTaskListResponse {
  const factory _OnlinePickTaskListResponse(
          {@JsonKey(name: 'code') required final String code,
          @JsonKey(name: 'msg') required final String message,
          @JsonKey(name: 'data') required final OnlinePickTaskListData data}) =
      _$OnlinePickTaskListResponseImpl;

  factory _OnlinePickTaskListResponse.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'code')
  String get code;
  @override
  @JsonKey(name: 'msg')
  String get message;
  @override
  @JsonKey(name: 'data')
  OnlinePickTaskListData get data;
  @override
  @JsonKey(ignore: true)
  _$$OnlinePickTaskListResponseImplCopyWith<_$OnlinePickTaskListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OnlinePickTaskQuery _$OnlinePickTaskQueryFromJson(Map<String, dynamic> json) {
  return _OnlinePickTaskQuery.fromJson(json);
}

/// @nodoc
mixin _$OnlinePickTaskQuery {
  @JsonKey(name: 'sortType')
  String get sortType => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortColumn')
  String get sortColumn => throw _privateConstructorUsedError;
  @JsonKey(name: 'searchKey')
  String get searchKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchflag')
  String get batchFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'transferType')
  String get transferType => throw _privateConstructorUsedError;
  @JsonKey(name: 'beatflag')
  String get beatFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'PageIndex')
  int get pageIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'PageSize')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlinePickTaskQueryCopyWith<OnlinePickTaskQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlinePickTaskQueryCopyWith<$Res> {
  factory $OnlinePickTaskQueryCopyWith(
          OnlinePickTaskQuery value, $Res Function(OnlinePickTaskQuery) then) =
      _$OnlinePickTaskQueryCopyWithImpl<$Res, OnlinePickTaskQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'batchflag') String batchFlag,
      @JsonKey(name: 'transferType') String transferType,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize,
      @JsonKey(name: 'finshFlg') String finishFlag});
}

/// @nodoc
class _$OnlinePickTaskQueryCopyWithImpl<$Res, $Val extends OnlinePickTaskQuery>
    implements $OnlinePickTaskQueryCopyWith<$Res> {
  _$OnlinePickTaskQueryCopyWithImpl(this._value, this._then);

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
    Object? batchFlag = null,
    Object? transferType = null,
    Object? beatFlag = null,
    Object? pageIndex = null,
    Object? pageSize = null,
    Object? finishFlag = null,
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
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlinePickTaskQueryImplCopyWith<$Res>
    implements $OnlinePickTaskQueryCopyWith<$Res> {
  factory _$$OnlinePickTaskQueryImplCopyWith(_$OnlinePickTaskQueryImpl value,
          $Res Function(_$OnlinePickTaskQueryImpl) then) =
      __$$OnlinePickTaskQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sortType') String sortType,
      @JsonKey(name: 'sortColumn') String sortColumn,
      @JsonKey(name: 'searchKey') String searchKey,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'batchflag') String batchFlag,
      @JsonKey(name: 'transferType') String transferType,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'PageIndex') int pageIndex,
      @JsonKey(name: 'PageSize') int pageSize,
      @JsonKey(name: 'finshFlg') String finishFlag});
}

/// @nodoc
class __$$OnlinePickTaskQueryImplCopyWithImpl<$Res>
    extends _$OnlinePickTaskQueryCopyWithImpl<$Res, _$OnlinePickTaskQueryImpl>
    implements _$$OnlinePickTaskQueryImplCopyWith<$Res> {
  __$$OnlinePickTaskQueryImplCopyWithImpl(_$OnlinePickTaskQueryImpl _value,
      $Res Function(_$OnlinePickTaskQueryImpl) _then)
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
    Object? batchFlag = null,
    Object? transferType = null,
    Object? beatFlag = null,
    Object? pageIndex = null,
    Object? pageSize = null,
    Object? finishFlag = null,
  }) {
    return _then(_$OnlinePickTaskQueryImpl(
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
      finishFlag: null == finishFlag
          ? _value.finishFlag
          : finishFlag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlinePickTaskQueryImpl implements _OnlinePickTaskQuery {
  const _$OnlinePickTaskQueryImpl(
      {@JsonKey(name: 'sortType') this.sortType = '',
      @JsonKey(name: 'sortColumn') this.sortColumn = '',
      @JsonKey(name: 'searchKey') this.searchKey = '',
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'roleoRuserId') required this.roleOrUserId,
      @JsonKey(name: 'roomTag') this.roomTag = '1',
      @JsonKey(name: 'batchflag') this.batchFlag = '0',
      @JsonKey(name: 'transferType') this.transferType = '0',
      @JsonKey(name: 'beatflag') this.beatFlag = 'N',
      @JsonKey(name: 'PageIndex') this.pageIndex = 1,
      @JsonKey(name: 'PageSize') this.pageSize = 100,
      @JsonKey(name: 'finshFlg') this.finishFlag = '0'});

  factory _$OnlinePickTaskQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlinePickTaskQueryImplFromJson(json);

  @override
  @JsonKey(name: 'sortType')
  final String sortType;
  @override
  @JsonKey(name: 'sortColumn')
  final String sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  final String searchKey;
  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: 'roleoRuserId')
  final String roleOrUserId;
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;
  @override
  @JsonKey(name: 'batchflag')
  final String batchFlag;
  @override
  @JsonKey(name: 'transferType')
  final String transferType;
  @override
  @JsonKey(name: 'beatflag')
  final String beatFlag;
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
  String toString() {
    return 'OnlinePickTaskQuery(sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, userId: $userId, roleOrUserId: $roleOrUserId, roomTag: $roomTag, batchFlag: $batchFlag, transferType: $transferType, beatFlag: $beatFlag, pageIndex: $pageIndex, pageSize: $pageSize, finishFlag: $finishFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlinePickTaskQueryImpl &&
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
            (identical(other.batchFlag, batchFlag) ||
                other.batchFlag == batchFlag) &&
            (identical(other.transferType, transferType) ||
                other.transferType == transferType) &&
            (identical(other.beatFlag, beatFlag) ||
                other.beatFlag == beatFlag) &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.finishFlag, finishFlag) ||
                other.finishFlag == finishFlag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sortType,
      sortColumn,
      searchKey,
      userId,
      roleOrUserId,
      roomTag,
      batchFlag,
      transferType,
      beatFlag,
      pageIndex,
      pageSize,
      finishFlag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlinePickTaskQueryImplCopyWith<_$OnlinePickTaskQueryImpl> get copyWith =>
      __$$OnlinePickTaskQueryImplCopyWithImpl<_$OnlinePickTaskQueryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlinePickTaskQueryImplToJson(
      this,
    );
  }
}

abstract class _OnlinePickTaskQuery implements OnlinePickTaskQuery {
  const factory _OnlinePickTaskQuery(
          {@JsonKey(name: 'sortType') final String sortType,
          @JsonKey(name: 'sortColumn') final String sortColumn,
          @JsonKey(name: 'searchKey') final String searchKey,
          @JsonKey(name: 'userId') required final String userId,
          @JsonKey(name: 'roleoRuserId') required final String roleOrUserId,
          @JsonKey(name: 'roomTag') final String roomTag,
          @JsonKey(name: 'batchflag') final String batchFlag,
          @JsonKey(name: 'transferType') final String transferType,
          @JsonKey(name: 'beatflag') final String beatFlag,
          @JsonKey(name: 'PageIndex') final int pageIndex,
          @JsonKey(name: 'PageSize') final int pageSize,
          @JsonKey(name: 'finshFlg') final String finishFlag}) =
      _$OnlinePickTaskQueryImpl;

  factory _OnlinePickTaskQuery.fromJson(Map<String, dynamic> json) =
      _$OnlinePickTaskQueryImpl.fromJson;

  @override
  @JsonKey(name: 'sortType')
  String get sortType;
  @override
  @JsonKey(name: 'sortColumn')
  String get sortColumn;
  @override
  @JsonKey(name: 'searchKey')
  String get searchKey;
  @override
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId;
  @override
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override
  @JsonKey(name: 'batchflag')
  String get batchFlag;
  @override
  @JsonKey(name: 'transferType')
  String get transferType;
  @override
  @JsonKey(name: 'beatflag')
  String get beatFlag;
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
  @JsonKey(ignore: true)
  _$$OnlinePickTaskQueryImplCopyWith<_$OnlinePickTaskQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
