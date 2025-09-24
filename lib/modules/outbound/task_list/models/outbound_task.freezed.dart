// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbound_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutboundTask _$OutboundTaskFromJson(Map<String, dynamic> json) {
  return _OutboundTask.fromJson(json);
}

/// @nodoc
mixin _$OutboundTask {
  /// 出库任务ID - 任务的唯一标识
  @JsonKey(name: 'outtaskid')
  int get outTaskId => throw _privateConstructorUsedError;

  /// 任务号 - 业务任务编号
  @JsonKey(name: 'outtaskno')
  String get outTaskNo => throw _privateConstructorUsedError;

  /// 出库单号 - 业务单据编号
  @JsonKey(name: 'orderno')
  String get orderNo => throw _privateConstructorUsedError;

  /// 来源单号 - 原始订单编号
  @JsonKey(name: 'po_number')
  String get poNumber => throw _privateConstructorUsedError;

  /// 库房号 - 物料所在库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo => throw _privateConstructorUsedError;

  /// 工位 - 执行任务的工作站
  @JsonKey(name: 'workstation')
  String get workStation => throw _privateConstructorUsedError;

  /// 凭证号 - 财务凭证编号
  @JsonKey(name: 'taskcomment')
  String get taskComment => throw _privateConstructorUsedError;

  /// 班组 - 执行任务的班组名称
  @JsonKey(name: 'schedule_group_name')
  String? get scheduleGroupName => throw _privateConstructorUsedError;

  /// 紧急补单 - 是否为紧急补单标识
  @JsonKey(name: 'wip_supplement_flag')
  String get wipSupplementFlag => throw _privateConstructorUsedError;

  /// 创建时间 - 任务创建的时间戳
  @JsonKey(name: 'createtime')
  String? get createTime => throw _privateConstructorUsedError;

  /// 状态 - 任务当前执行状态
  @JsonKey(name: 'status')
  String? get status => throw _privateConstructorUsedError;

  /// 任务数量 - 计划出库的总数量
  @JsonKey(name: 'taskqty')
  int get taskQty => throw _privateConstructorUsedError;

  /// 完成数量 - 已完成出库的数量
  @JsonKey(name: 'finishqty')
  int get finishQty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskCopyWith<OutboundTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskCopyWith<$Res> {
  factory $OutboundTaskCopyWith(
          OutboundTask value, $Res Function(OutboundTask) then) =
      _$OutboundTaskCopyWithImpl<$Res, OutboundTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') int outTaskId,
      @JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'orderno') String orderNo,
      @JsonKey(name: 'po_number') String poNumber,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'schedule_group_name') String? scheduleGroupName,
      @JsonKey(name: 'wip_supplement_flag') String wipSupplementFlag,
      @JsonKey(name: 'createtime') String? createTime,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'taskqty') int taskQty,
      @JsonKey(name: 'finishqty') int finishQty});
}

/// @nodoc
class _$OutboundTaskCopyWithImpl<$Res, $Val extends OutboundTask>
    implements $OutboundTaskCopyWith<$Res> {
  _$OutboundTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? outTaskNo = null,
    Object? orderNo = null,
    Object? poNumber = null,
    Object? storeRoomNo = null,
    Object? workStation = null,
    Object? taskComment = null,
    Object? scheduleGroupName = freezed,
    Object? wipSupplementFlag = null,
    Object? createTime = freezed,
    Object? status = freezed,
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
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String,
      poNumber: null == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleGroupName: freezed == scheduleGroupName
          ? _value.scheduleGroupName
          : scheduleGroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      wipSupplementFlag: null == wipSupplementFlag
          ? _value.wipSupplementFlag
          : wipSupplementFlag // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as int,
      finishQty: null == finishQty
          ? _value.finishQty
          : finishQty // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutboundTaskImplCopyWith<$Res>
    implements $OutboundTaskCopyWith<$Res> {
  factory _$$OutboundTaskImplCopyWith(
          _$OutboundTaskImpl value, $Res Function(_$OutboundTaskImpl) then) =
      __$$OutboundTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'outtaskid') int outTaskId,
      @JsonKey(name: 'outtaskno') String outTaskNo,
      @JsonKey(name: 'orderno') String orderNo,
      @JsonKey(name: 'po_number') String poNumber,
      @JsonKey(name: 'storeroomno') String storeRoomNo,
      @JsonKey(name: 'workstation') String workStation,
      @JsonKey(name: 'taskcomment') String taskComment,
      @JsonKey(name: 'schedule_group_name') String? scheduleGroupName,
      @JsonKey(name: 'wip_supplement_flag') String wipSupplementFlag,
      @JsonKey(name: 'createtime') String? createTime,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'taskqty') int taskQty,
      @JsonKey(name: 'finishqty') int finishQty});
}

/// @nodoc
class __$$OutboundTaskImplCopyWithImpl<$Res>
    extends _$OutboundTaskCopyWithImpl<$Res, _$OutboundTaskImpl>
    implements _$$OutboundTaskImplCopyWith<$Res> {
  __$$OutboundTaskImplCopyWithImpl(
      _$OutboundTaskImpl _value, $Res Function(_$OutboundTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outTaskId = null,
    Object? outTaskNo = null,
    Object? orderNo = null,
    Object? poNumber = null,
    Object? storeRoomNo = null,
    Object? workStation = null,
    Object? taskComment = null,
    Object? scheduleGroupName = freezed,
    Object? wipSupplementFlag = null,
    Object? createTime = freezed,
    Object? status = freezed,
    Object? taskQty = null,
    Object? finishQty = null,
  }) {
    return _then(_$OutboundTaskImpl(
      outTaskId: null == outTaskId
          ? _value.outTaskId
          : outTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      outTaskNo: null == outTaskNo
          ? _value.outTaskNo
          : outTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      orderNo: null == orderNo
          ? _value.orderNo
          : orderNo // ignore: cast_nullable_to_non_nullable
              as String,
      poNumber: null == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: null == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String,
      workStation: null == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleGroupName: freezed == scheduleGroupName
          ? _value.scheduleGroupName
          : scheduleGroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      wipSupplementFlag: null == wipSupplementFlag
          ? _value.wipSupplementFlag
          : wipSupplementFlag // ignore: cast_nullable_to_non_nullable
              as String,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as int,
      finishQty: null == finishQty
          ? _value.finishQty
          : finishQty // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskImpl implements _OutboundTask {
  const _$OutboundTaskImpl(
      {@JsonKey(name: 'outtaskid') required this.outTaskId,
      @JsonKey(name: 'outtaskno') required this.outTaskNo,
      @JsonKey(name: 'orderno') required this.orderNo,
      @JsonKey(name: 'po_number') required this.poNumber,
      @JsonKey(name: 'storeroomno') required this.storeRoomNo,
      @JsonKey(name: 'workstation') required this.workStation,
      @JsonKey(name: 'taskcomment') required this.taskComment,
      @JsonKey(name: 'schedule_group_name') required this.scheduleGroupName,
      @JsonKey(name: 'wip_supplement_flag') required this.wipSupplementFlag,
      @JsonKey(name: 'createtime') required this.createTime,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'taskqty') this.taskQty = 0,
      @JsonKey(name: 'finishqty') this.finishQty = 0});

  factory _$OutboundTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboundTaskImplFromJson(json);

  /// 出库任务ID - 任务的唯一标识
  @override
  @JsonKey(name: 'outtaskid')
  final int outTaskId;

  /// 任务号 - 业务任务编号
  @override
  @JsonKey(name: 'outtaskno')
  final String outTaskNo;

  /// 出库单号 - 业务单据编号
  @override
  @JsonKey(name: 'orderno')
  final String orderNo;

  /// 来源单号 - 原始订单编号
  @override
  @JsonKey(name: 'po_number')
  final String poNumber;

  /// 库房号 - 物料所在库房编号
  @override
  @JsonKey(name: 'storeroomno')
  final String storeRoomNo;

  /// 工位 - 执行任务的工作站
  @override
  @JsonKey(name: 'workstation')
  final String workStation;

  /// 凭证号 - 财务凭证编号
  @override
  @JsonKey(name: 'taskcomment')
  final String taskComment;

  /// 班组 - 执行任务的班组名称
  @override
  @JsonKey(name: 'schedule_group_name')
  final String? scheduleGroupName;

  /// 紧急补单 - 是否为紧急补单标识
  @override
  @JsonKey(name: 'wip_supplement_flag')
  final String wipSupplementFlag;

  /// 创建时间 - 任务创建的时间戳
  @override
  @JsonKey(name: 'createtime')
  final String? createTime;

  /// 状态 - 任务当前执行状态
  @override
  @JsonKey(name: 'status')
  final String? status;

  /// 任务数量 - 计划出库的总数量
  @override
  @JsonKey(name: 'taskqty')
  final int taskQty;

  /// 完成数量 - 已完成出库的数量
  @override
  @JsonKey(name: 'finishqty')
  final int finishQty;

  @override
  String toString() {
    return 'OutboundTask(outTaskId: $outTaskId, outTaskNo: $outTaskNo, orderNo: $orderNo, poNumber: $poNumber, storeRoomNo: $storeRoomNo, workStation: $workStation, taskComment: $taskComment, scheduleGroupName: $scheduleGroupName, wipSupplementFlag: $wipSupplementFlag, createTime: $createTime, status: $status, taskQty: $taskQty, finishQty: $finishQty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskImpl &&
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
            (identical(other.scheduleGroupName, scheduleGroupName) ||
                other.scheduleGroupName == scheduleGroupName) &&
            (identical(other.wipSupplementFlag, wipSupplementFlag) ||
                other.wipSupplementFlag == wipSupplementFlag) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.status, status) || other.status == status) &&
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
      scheduleGroupName,
      wipSupplementFlag,
      createTime,
      status,
      taskQty,
      finishQty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutboundTaskImplCopyWith<_$OutboundTaskImpl> get copyWith =>
      __$$OutboundTaskImplCopyWithImpl<_$OutboundTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskImplToJson(
      this,
    );
  }
}

abstract class _OutboundTask implements OutboundTask {
  const factory _OutboundTask(
      {@JsonKey(name: 'outtaskid') required final int outTaskId,
      @JsonKey(name: 'outtaskno') required final String outTaskNo,
      @JsonKey(name: 'orderno') required final String orderNo,
      @JsonKey(name: 'po_number') required final String poNumber,
      @JsonKey(name: 'storeroomno') required final String storeRoomNo,
      @JsonKey(name: 'workstation') required final String workStation,
      @JsonKey(name: 'taskcomment') required final String taskComment,
      @JsonKey(name: 'schedule_group_name')
      required final String? scheduleGroupName,
      @JsonKey(name: 'wip_supplement_flag')
      required final String wipSupplementFlag,
      @JsonKey(name: 'createtime') required final String? createTime,
      @JsonKey(name: 'status') required final String? status,
      @JsonKey(name: 'taskqty') final int taskQty,
      @JsonKey(name: 'finishqty') final int finishQty}) = _$OutboundTaskImpl;

  factory _OutboundTask.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskImpl.fromJson;

  @override

  /// 出库任务ID - 任务的唯一标识
  @JsonKey(name: 'outtaskid')
  int get outTaskId;
  @override

  /// 任务号 - 业务任务编号
  @JsonKey(name: 'outtaskno')
  String get outTaskNo;
  @override

  /// 出库单号 - 业务单据编号
  @JsonKey(name: 'orderno')
  String get orderNo;
  @override

  /// 来源单号 - 原始订单编号
  @JsonKey(name: 'po_number')
  String get poNumber;
  @override

  /// 库房号 - 物料所在库房编号
  @JsonKey(name: 'storeroomno')
  String get storeRoomNo;
  @override

  /// 工位 - 执行任务的工作站
  @JsonKey(name: 'workstation')
  String get workStation;
  @override

  /// 凭证号 - 财务凭证编号
  @JsonKey(name: 'taskcomment')
  String get taskComment;
  @override

  /// 班组 - 执行任务的班组名称
  @JsonKey(name: 'schedule_group_name')
  String? get scheduleGroupName;
  @override

  /// 紧急补单 - 是否为紧急补单标识
  @JsonKey(name: 'wip_supplement_flag')
  String get wipSupplementFlag;
  @override

  /// 创建时间 - 任务创建的时间戳
  @JsonKey(name: 'createtime')
  String? get createTime;
  @override

  /// 状态 - 任务当前执行状态
  @JsonKey(name: 'status')
  String? get status;
  @override

  /// 任务数量 - 计划出库的总数量
  @JsonKey(name: 'taskqty')
  int get taskQty;
  @override

  /// 完成数量 - 已完成出库的数量
  @JsonKey(name: 'finishqty')
  int get finishQty;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskImplCopyWith<_$OutboundTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OutboundTaskListResponse _$OutboundTaskListResponseFromJson(
    Map<String, dynamic> json) {
  return _OutboundTaskListResponse.fromJson(json);
}

/// @nodoc
mixin _$OutboundTaskListResponse {
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  OutboundTaskListData get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskListResponseCopyWith<OutboundTaskListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskListResponseCopyWith<$Res> {
  factory $OutboundTaskListResponseCopyWith(OutboundTaskListResponse value,
          $Res Function(OutboundTaskListResponse) then) =
      _$OutboundTaskListResponseCopyWithImpl<$Res, OutboundTaskListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') OutboundTaskListData data});

  $OutboundTaskListDataCopyWith<$Res> get data;
}

/// @nodoc
class _$OutboundTaskListResponseCopyWithImpl<$Res,
        $Val extends OutboundTaskListResponse>
    implements $OutboundTaskListResponseCopyWith<$Res> {
  _$OutboundTaskListResponseCopyWithImpl(this._value, this._then);

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
              as OutboundTaskListData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OutboundTaskListDataCopyWith<$Res> get data {
    return $OutboundTaskListDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OutboundTaskListResponseImplCopyWith<$Res>
    implements $OutboundTaskListResponseCopyWith<$Res> {
  factory _$$OutboundTaskListResponseImplCopyWith(
          _$OutboundTaskListResponseImpl value,
          $Res Function(_$OutboundTaskListResponseImpl) then) =
      __$$OutboundTaskListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') String code,
      @JsonKey(name: 'msg') String message,
      @JsonKey(name: 'data') OutboundTaskListData data});

  @override
  $OutboundTaskListDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$OutboundTaskListResponseImplCopyWithImpl<$Res>
    extends _$OutboundTaskListResponseCopyWithImpl<$Res,
        _$OutboundTaskListResponseImpl>
    implements _$$OutboundTaskListResponseImplCopyWith<$Res> {
  __$$OutboundTaskListResponseImplCopyWithImpl(
      _$OutboundTaskListResponseImpl _value,
      $Res Function(_$OutboundTaskListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$OutboundTaskListResponseImpl(
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
              as OutboundTaskListData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskListResponseImpl implements _OutboundTaskListResponse {
  const _$OutboundTaskListResponseImpl(
      {@JsonKey(name: 'code') required this.code,
      @JsonKey(name: 'msg') required this.message,
      @JsonKey(name: 'data') required this.data});

  factory _$OutboundTaskListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboundTaskListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'code')
  final String code;
  @override
  @JsonKey(name: 'msg')
  final String message;
  @override
  @JsonKey(name: 'data')
  final OutboundTaskListData data;

  @override
  String toString() {
    return 'OutboundTaskListResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskListResponseImpl &&
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
  _$$OutboundTaskListResponseImplCopyWith<_$OutboundTaskListResponseImpl>
      get copyWith => __$$OutboundTaskListResponseImplCopyWithImpl<
          _$OutboundTaskListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskListResponseImplToJson(
      this,
    );
  }
}

abstract class _OutboundTaskListResponse implements OutboundTaskListResponse {
  const factory _OutboundTaskListResponse(
          {@JsonKey(name: 'code') required final String code,
          @JsonKey(name: 'msg') required final String message,
          @JsonKey(name: 'data') required final OutboundTaskListData data}) =
      _$OutboundTaskListResponseImpl;

  factory _OutboundTaskListResponse.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'code')
  String get code;
  @override
  @JsonKey(name: 'msg')
  String get message;
  @override
  @JsonKey(name: 'data')
  OutboundTaskListData get data;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskListResponseImplCopyWith<_$OutboundTaskListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OutboundTaskListData _$OutboundTaskListDataFromJson(Map<String, dynamic> json) {
  return _OutboundTaskListData.fromJson(json);
}

/// @nodoc
mixin _$OutboundTaskListData {
  @JsonKey(name: 'rows')
  List<OutboundTask> get rows => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutboundTaskListDataCopyWith<OutboundTaskListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutboundTaskListDataCopyWith<$Res> {
  factory $OutboundTaskListDataCopyWith(OutboundTaskListData value,
          $Res Function(OutboundTaskListData) then) =
      _$OutboundTaskListDataCopyWithImpl<$Res, OutboundTaskListData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OutboundTask> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class _$OutboundTaskListDataCopyWithImpl<$Res,
        $Val extends OutboundTaskListData>
    implements $OutboundTaskListDataCopyWith<$Res> {
  _$OutboundTaskListDataCopyWithImpl(this._value, this._then);

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
              as List<OutboundTask>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutboundTaskListDataImplCopyWith<$Res>
    implements $OutboundTaskListDataCopyWith<$Res> {
  factory _$$OutboundTaskListDataImplCopyWith(_$OutboundTaskListDataImpl value,
          $Res Function(_$OutboundTaskListDataImpl) then) =
      __$$OutboundTaskListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'rows') List<OutboundTask> rows,
      @JsonKey(name: 'total') int total});
}

/// @nodoc
class __$$OutboundTaskListDataImplCopyWithImpl<$Res>
    extends _$OutboundTaskListDataCopyWithImpl<$Res, _$OutboundTaskListDataImpl>
    implements _$$OutboundTaskListDataImplCopyWith<$Res> {
  __$$OutboundTaskListDataImplCopyWithImpl(_$OutboundTaskListDataImpl _value,
      $Res Function(_$OutboundTaskListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? total = null,
  }) {
    return _then(_$OutboundTaskListDataImpl(
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<OutboundTask>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutboundTaskListDataImpl implements _OutboundTaskListData {
  const _$OutboundTaskListDataImpl(
      {@JsonKey(name: 'rows') final List<OutboundTask> rows = const [],
      @JsonKey(name: 'total') this.total = 0})
      : _rows = rows;

  factory _$OutboundTaskListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutboundTaskListDataImplFromJson(json);

  final List<OutboundTask> _rows;
  @override
  @JsonKey(name: 'rows')
  List<OutboundTask> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'OutboundTaskListData(rows: $rows, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutboundTaskListDataImpl &&
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
  _$$OutboundTaskListDataImplCopyWith<_$OutboundTaskListDataImpl>
      get copyWith =>
          __$$OutboundTaskListDataImplCopyWithImpl<_$OutboundTaskListDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutboundTaskListDataImplToJson(
      this,
    );
  }
}

abstract class _OutboundTaskListData implements OutboundTaskListData {
  const factory _OutboundTaskListData(
      {@JsonKey(name: 'rows') final List<OutboundTask> rows,
      @JsonKey(name: 'total') final int total}) = _$OutboundTaskListDataImpl;

  factory _OutboundTaskListData.fromJson(Map<String, dynamic> json) =
      _$OutboundTaskListDataImpl.fromJson;

  @override
  @JsonKey(name: 'rows')
  List<OutboundTask> get rows;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$OutboundTaskListDataImplCopyWith<_$OutboundTaskListDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
