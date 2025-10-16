// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aswh_up_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AswhUpTask _$AswhUpTaskFromJson(Map<String, dynamic> json) {
  return _AswhUpTask.fromJson(json);
}

/// @nodoc
mixin _$AswhUpTask {
  @JsonKey(name: 'intaskid')
  @HiveField(0)
  int get inTaskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'intaskno')
  @HiveField(1)
  String get inTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'data2')
  @HiveField(2)
  String? get inboundOrderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'data3')
  @HiveField(3)
  String? get sourceOrderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  @HiveField(4)
  String? get storeRoomNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'workstation')
  @HiveField(5)
  String? get workStation => throw _privateConstructorUsedError;
  @JsonKey(name: 'parname')
  @HiveField(6)
  String? get partnerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskcomment')
  @HiveField(7)
  String? get taskComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskqty')
  @HiveField(8)
  num get taskQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'finishqty')
  @HiveField(9)
  num get finishQty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AswhUpTaskCopyWith<AswhUpTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhUpTaskCopyWith<$Res> {
  factory $AswhUpTaskCopyWith(
          AswhUpTask value, $Res Function(AswhUpTask) then) =
      _$AswhUpTaskCopyWithImpl<$Res, AswhUpTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'intaskid') @HiveField(0) int inTaskId,
      @JsonKey(name: 'intaskno') @HiveField(1) String inTaskNo,
      @JsonKey(name: 'data2') @HiveField(2) String? inboundOrderNo,
      @JsonKey(name: 'data3') @HiveField(3) String? sourceOrderNo,
      @JsonKey(name: 'storeroomno') @HiveField(4) String? storeRoomNo,
      @JsonKey(name: 'workstation') @HiveField(5) String? workStation,
      @JsonKey(name: 'parname') @HiveField(6) String? partnerName,
      @JsonKey(name: 'taskcomment') @HiveField(7) String? taskComment,
      @JsonKey(name: 'taskqty') @HiveField(8) num taskQty,
      @JsonKey(name: 'finishqty') @HiveField(9) num finishQty});
}

/// @nodoc
class _$AswhUpTaskCopyWithImpl<$Res, $Val extends AswhUpTask>
    implements $AswhUpTaskCopyWith<$Res> {
  _$AswhUpTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inTaskId = null,
    Object? inTaskNo = null,
    Object? inboundOrderNo = freezed,
    Object? sourceOrderNo = freezed,
    Object? storeRoomNo = freezed,
    Object? workStation = freezed,
    Object? partnerName = freezed,
    Object? taskComment = freezed,
    Object? taskQty = null,
    Object? finishQty = null,
  }) {
    return _then(_value.copyWith(
      inTaskId: null == inTaskId
          ? _value.inTaskId
          : inTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      inTaskNo: null == inTaskNo
          ? _value.inTaskNo
          : inTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      inboundOrderNo: freezed == inboundOrderNo
          ? _value.inboundOrderNo
          : inboundOrderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceOrderNo: freezed == sourceOrderNo
          ? _value.sourceOrderNo
          : sourceOrderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerName: freezed == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AswhUpTaskImplCopyWith<$Res>
    implements $AswhUpTaskCopyWith<$Res> {
  factory _$$AswhUpTaskImplCopyWith(
          _$AswhUpTaskImpl value, $Res Function(_$AswhUpTaskImpl) then) =
      __$$AswhUpTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'intaskid') @HiveField(0) int inTaskId,
      @JsonKey(name: 'intaskno') @HiveField(1) String inTaskNo,
      @JsonKey(name: 'data2') @HiveField(2) String? inboundOrderNo,
      @JsonKey(name: 'data3') @HiveField(3) String? sourceOrderNo,
      @JsonKey(name: 'storeroomno') @HiveField(4) String? storeRoomNo,
      @JsonKey(name: 'workstation') @HiveField(5) String? workStation,
      @JsonKey(name: 'parname') @HiveField(6) String? partnerName,
      @JsonKey(name: 'taskcomment') @HiveField(7) String? taskComment,
      @JsonKey(name: 'taskqty') @HiveField(8) num taskQty,
      @JsonKey(name: 'finishqty') @HiveField(9) num finishQty});
}

/// @nodoc
class __$$AswhUpTaskImplCopyWithImpl<$Res>
    extends _$AswhUpTaskCopyWithImpl<$Res, _$AswhUpTaskImpl>
    implements _$$AswhUpTaskImplCopyWith<$Res> {
  __$$AswhUpTaskImplCopyWithImpl(
      _$AswhUpTaskImpl _value, $Res Function(_$AswhUpTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inTaskId = null,
    Object? inTaskNo = null,
    Object? inboundOrderNo = freezed,
    Object? sourceOrderNo = freezed,
    Object? storeRoomNo = freezed,
    Object? workStation = freezed,
    Object? partnerName = freezed,
    Object? taskComment = freezed,
    Object? taskQty = null,
    Object? finishQty = null,
  }) {
    return _then(_$AswhUpTaskImpl(
      inTaskId: null == inTaskId
          ? _value.inTaskId
          : inTaskId // ignore: cast_nullable_to_non_nullable
              as int,
      inTaskNo: null == inTaskNo
          ? _value.inTaskNo
          : inTaskNo // ignore: cast_nullable_to_non_nullable
              as String,
      inboundOrderNo: freezed == inboundOrderNo
          ? _value.inboundOrderNo
          : inboundOrderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceOrderNo: freezed == sourceOrderNo
          ? _value.sourceOrderNo
          : sourceOrderNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      workStation: freezed == workStation
          ? _value.workStation
          : workStation // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerName: freezed == partnerName
          ? _value.partnerName
          : partnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
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
class _$AswhUpTaskImpl extends _AswhUpTask {
  _$AswhUpTaskImpl(
      {@JsonKey(name: 'intaskid') @HiveField(0) this.inTaskId = 0,
      @JsonKey(name: 'intaskno') @HiveField(1) this.inTaskNo = '',
      @JsonKey(name: 'data2') @HiveField(2) this.inboundOrderNo,
      @JsonKey(name: 'data3') @HiveField(3) this.sourceOrderNo,
      @JsonKey(name: 'storeroomno') @HiveField(4) this.storeRoomNo,
      @JsonKey(name: 'workstation') @HiveField(5) this.workStation,
      @JsonKey(name: 'parname') @HiveField(6) this.partnerName,
      @JsonKey(name: 'taskcomment') @HiveField(7) this.taskComment,
      @JsonKey(name: 'taskqty') @HiveField(8) this.taskQty = 0,
      @JsonKey(name: 'finishqty') @HiveField(9) this.finishQty = 0})
      : super._();

  factory _$AswhUpTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$AswhUpTaskImplFromJson(json);

  @override
  @JsonKey(name: 'intaskid')
  @HiveField(0)
  final int inTaskId;
  @override
  @JsonKey(name: 'intaskno')
  @HiveField(1)
  final String inTaskNo;
  @override
  @JsonKey(name: 'data2')
  @HiveField(2)
  final String? inboundOrderNo;
  @override
  @JsonKey(name: 'data3')
  @HiveField(3)
  final String? sourceOrderNo;
  @override
  @JsonKey(name: 'storeroomno')
  @HiveField(4)
  final String? storeRoomNo;
  @override
  @JsonKey(name: 'workstation')
  @HiveField(5)
  final String? workStation;
  @override
  @JsonKey(name: 'parname')
  @HiveField(6)
  final String? partnerName;
  @override
  @JsonKey(name: 'taskcomment')
  @HiveField(7)
  final String? taskComment;
  @override
  @JsonKey(name: 'taskqty')
  @HiveField(8)
  final num taskQty;
  @override
  @JsonKey(name: 'finishqty')
  @HiveField(9)
  final num finishQty;

  @override
  String toString() {
    return 'AswhUpTask(inTaskId: $inTaskId, inTaskNo: $inTaskNo, inboundOrderNo: $inboundOrderNo, sourceOrderNo: $sourceOrderNo, storeRoomNo: $storeRoomNo, workStation: $workStation, partnerName: $partnerName, taskComment: $taskComment, taskQty: $taskQty, finishQty: $finishQty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhUpTaskImpl &&
            (identical(other.inTaskId, inTaskId) ||
                other.inTaskId == inTaskId) &&
            (identical(other.inTaskNo, inTaskNo) ||
                other.inTaskNo == inTaskNo) &&
            (identical(other.inboundOrderNo, inboundOrderNo) ||
                other.inboundOrderNo == inboundOrderNo) &&
            (identical(other.sourceOrderNo, sourceOrderNo) ||
                other.sourceOrderNo == sourceOrderNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.workStation, workStation) ||
                other.workStation == workStation) &&
            (identical(other.partnerName, partnerName) ||
                other.partnerName == partnerName) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.finishQty, finishQty) ||
                other.finishQty == finishQty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      inTaskId,
      inTaskNo,
      inboundOrderNo,
      sourceOrderNo,
      storeRoomNo,
      workStation,
      partnerName,
      taskComment,
      taskQty,
      finishQty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AswhUpTaskImplCopyWith<_$AswhUpTaskImpl> get copyWith =>
      __$$AswhUpTaskImplCopyWithImpl<_$AswhUpTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AswhUpTaskImplToJson(
      this,
    );
  }
}

abstract class _AswhUpTask extends AswhUpTask {
  factory _AswhUpTask(
          {@JsonKey(name: 'intaskid') @HiveField(0) final int inTaskId,
          @JsonKey(name: 'intaskno') @HiveField(1) final String inTaskNo,
          @JsonKey(name: 'data2') @HiveField(2) final String? inboundOrderNo,
          @JsonKey(name: 'data3') @HiveField(3) final String? sourceOrderNo,
          @JsonKey(name: 'storeroomno') @HiveField(4) final String? storeRoomNo,
          @JsonKey(name: 'workstation') @HiveField(5) final String? workStation,
          @JsonKey(name: 'parname') @HiveField(6) final String? partnerName,
          @JsonKey(name: 'taskcomment') @HiveField(7) final String? taskComment,
          @JsonKey(name: 'taskqty') @HiveField(8) final num taskQty,
          @JsonKey(name: 'finishqty') @HiveField(9) final num finishQty}) =
      _$AswhUpTaskImpl;
  _AswhUpTask._() : super._();

  factory _AswhUpTask.fromJson(Map<String, dynamic> json) =
      _$AswhUpTaskImpl.fromJson;

  @override
  @JsonKey(name: 'intaskid')
  @HiveField(0)
  int get inTaskId;
  @override
  @JsonKey(name: 'intaskno')
  @HiveField(1)
  String get inTaskNo;
  @override
  @JsonKey(name: 'data2')
  @HiveField(2)
  String? get inboundOrderNo;
  @override
  @JsonKey(name: 'data3')
  @HiveField(3)
  String? get sourceOrderNo;
  @override
  @JsonKey(name: 'storeroomno')
  @HiveField(4)
  String? get storeRoomNo;
  @override
  @JsonKey(name: 'workstation')
  @HiveField(5)
  String? get workStation;
  @override
  @JsonKey(name: 'parname')
  @HiveField(6)
  String? get partnerName;
  @override
  @JsonKey(name: 'taskcomment')
  @HiveField(7)
  String? get taskComment;
  @override
  @JsonKey(name: 'taskqty')
  @HiveField(8)
  num get taskQty;
  @override
  @JsonKey(name: 'finishqty')
  @HiveField(9)
  num get finishQty;
  @override
  @JsonKey(ignore: true)
  _$$AswhUpTaskImplCopyWith<_$AswhUpTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AswhUpTaskListData _$AswhUpTaskListDataFromJson(Map<String, dynamic> json) {
  return _AswhUpTaskListData.fromJson(json);
}

/// @nodoc
mixin _$AswhUpTaskListData {
  int get total => throw _privateConstructorUsedError;
  List<AswhUpTask> get rows => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AswhUpTaskListDataCopyWith<AswhUpTaskListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhUpTaskListDataCopyWith<$Res> {
  factory $AswhUpTaskListDataCopyWith(
          AswhUpTaskListData value, $Res Function(AswhUpTaskListData) then) =
      _$AswhUpTaskListDataCopyWithImpl<$Res, AswhUpTaskListData>;
  @useResult
  $Res call({int total, List<AswhUpTask> rows});
}

/// @nodoc
class _$AswhUpTaskListDataCopyWithImpl<$Res, $Val extends AswhUpTaskListData>
    implements $AswhUpTaskListDataCopyWith<$Res> {
  _$AswhUpTaskListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? rows = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<AswhUpTask>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AswhUpTaskListDataImplCopyWith<$Res>
    implements $AswhUpTaskListDataCopyWith<$Res> {
  factory _$$AswhUpTaskListDataImplCopyWith(_$AswhUpTaskListDataImpl value,
          $Res Function(_$AswhUpTaskListDataImpl) then) =
      __$$AswhUpTaskListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, List<AswhUpTask> rows});
}

/// @nodoc
class __$$AswhUpTaskListDataImplCopyWithImpl<$Res>
    extends _$AswhUpTaskListDataCopyWithImpl<$Res, _$AswhUpTaskListDataImpl>
    implements _$$AswhUpTaskListDataImplCopyWith<$Res> {
  __$$AswhUpTaskListDataImplCopyWithImpl(_$AswhUpTaskListDataImpl _value,
      $Res Function(_$AswhUpTaskListDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? rows = null,
  }) {
    return _then(_$AswhUpTaskListDataImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<AswhUpTask>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AswhUpTaskListDataImpl implements _AswhUpTaskListData {
  const _$AswhUpTaskListDataImpl(
      {this.total = 0, final List<AswhUpTask> rows = const <AswhUpTask>[]})
      : _rows = rows;

  factory _$AswhUpTaskListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AswhUpTaskListDataImplFromJson(json);

  @override
  @JsonKey()
  final int total;
  final List<AswhUpTask> _rows;
  @override
  @JsonKey()
  List<AswhUpTask> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'AswhUpTaskListData(total: $total, rows: $rows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhUpTaskListDataImpl &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_rows));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AswhUpTaskListDataImplCopyWith<_$AswhUpTaskListDataImpl> get copyWith =>
      __$$AswhUpTaskListDataImplCopyWithImpl<_$AswhUpTaskListDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AswhUpTaskListDataImplToJson(
      this,
    );
  }
}

abstract class _AswhUpTaskListData implements AswhUpTaskListData {
  const factory _AswhUpTaskListData(
      {final int total,
      final List<AswhUpTask> rows}) = _$AswhUpTaskListDataImpl;

  factory _AswhUpTaskListData.fromJson(Map<String, dynamic> json) =
      _$AswhUpTaskListDataImpl.fromJson;

  @override
  int get total;
  @override
  List<AswhUpTask> get rows;
  @override
  @JsonKey(ignore: true)
  _$$AswhUpTaskListDataImplCopyWith<_$AswhUpTaskListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AswhUpTaskQuery _$AswhUpTaskQueryFromJson(Map<String, dynamic> json) {
  return _AswhUpTaskQuery.fromJson(json);
}

/// @nodoc
mixin _$AswhUpTaskQuery {
  @JsonKey(includeToJson: false)
  String get sortType => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get sortColumn => throw _privateConstructorUsedError;
  String get searchKey => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'roleoRuserId')
  String get roleOrUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchflag')
  String get batchFlag => throw _privateConstructorUsedError;
  String get transferType => throw _privateConstructorUsedError;
  @JsonKey(name: 'beatflag')
  String get beatFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
  int get pageIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'finshFlg')
  String get finishFlag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AswhUpTaskQueryCopyWith<AswhUpTaskQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AswhUpTaskQueryCopyWith<$Res> {
  factory $AswhUpTaskQueryCopyWith(
          AswhUpTaskQuery value, $Res Function(AswhUpTaskQuery) then) =
      _$AswhUpTaskQueryCopyWithImpl<$Res, AswhUpTaskQuery>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String sortType,
      @JsonKey(includeToJson: false) String sortColumn,
      String searchKey,
      String userId,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'batchflag') String batchFlag,
      String transferType,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
      int pageIndex,
      @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
      int pageSize,
      @JsonKey(name: 'finshFlg') String finishFlag});
}

/// @nodoc
class _$AswhUpTaskQueryCopyWithImpl<$Res, $Val extends AswhUpTaskQuery>
    implements $AswhUpTaskQueryCopyWith<$Res> {
  _$AswhUpTaskQueryCopyWithImpl(this._value, this._then);

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
abstract class _$$AswhUpTaskQueryImplCopyWith<$Res>
    implements $AswhUpTaskQueryCopyWith<$Res> {
  factory _$$AswhUpTaskQueryImplCopyWith(_$AswhUpTaskQueryImpl value,
          $Res Function(_$AswhUpTaskQueryImpl) then) =
      __$$AswhUpTaskQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String sortType,
      @JsonKey(includeToJson: false) String sortColumn,
      String searchKey,
      String userId,
      @JsonKey(name: 'roleoRuserId') String roleOrUserId,
      @JsonKey(name: 'roomTag') String roomTag,
      @JsonKey(name: 'batchflag') String batchFlag,
      String transferType,
      @JsonKey(name: 'beatflag') String beatFlag,
      @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
      int pageIndex,
      @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
      int pageSize,
      @JsonKey(name: 'finshFlg') String finishFlag});
}

/// @nodoc
class __$$AswhUpTaskQueryImplCopyWithImpl<$Res>
    extends _$AswhUpTaskQueryCopyWithImpl<$Res, _$AswhUpTaskQueryImpl>
    implements _$$AswhUpTaskQueryImplCopyWith<$Res> {
  __$$AswhUpTaskQueryImplCopyWithImpl(
      _$AswhUpTaskQueryImpl _value, $Res Function(_$AswhUpTaskQueryImpl) _then)
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
    return _then(_$AswhUpTaskQueryImpl(
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
class _$AswhUpTaskQueryImpl implements _AswhUpTaskQuery {
  const _$AswhUpTaskQueryImpl(
      {@JsonKey(includeToJson: false) this.sortType = '',
      @JsonKey(includeToJson: false) this.sortColumn = '',
      this.searchKey = '',
      this.userId = '',
      @JsonKey(name: 'roleoRuserId') this.roleOrUserId = '',
      @JsonKey(name: 'roomTag') this.roomTag = '0',
      @JsonKey(name: 'batchflag') this.batchFlag = '0',
      this.transferType = '0',
      @JsonKey(name: 'beatflag') this.beatFlag = 'N',
      @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
      this.pageIndex = 1,
      @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
      this.pageSize = 100,
      @JsonKey(name: 'finshFlg') this.finishFlag = '0'});

  factory _$AswhUpTaskQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AswhUpTaskQueryImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String sortType;
  @override
  @JsonKey(includeToJson: false)
  final String sortColumn;
  @override
  @JsonKey()
  final String searchKey;
  @override
  @JsonKey()
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
  @JsonKey()
  final String transferType;
  @override
  @JsonKey(name: 'beatflag')
  final String beatFlag;
  @override
  @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
  final int pageIndex;
  @override
  @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
  final int pageSize;
  @override
  @JsonKey(name: 'finshFlg')
  final String finishFlag;

  @override
  String toString() {
    return 'AswhUpTaskQuery(sortType: $sortType, sortColumn: $sortColumn, searchKey: $searchKey, userId: $userId, roleOrUserId: $roleOrUserId, roomTag: $roomTag, batchFlag: $batchFlag, transferType: $transferType, beatFlag: $beatFlag, pageIndex: $pageIndex, pageSize: $pageSize, finishFlag: $finishFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AswhUpTaskQueryImpl &&
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
  _$$AswhUpTaskQueryImplCopyWith<_$AswhUpTaskQueryImpl> get copyWith =>
      __$$AswhUpTaskQueryImplCopyWithImpl<_$AswhUpTaskQueryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AswhUpTaskQueryImplToJson(
      this,
    );
  }
}

abstract class _AswhUpTaskQuery implements AswhUpTaskQuery {
  const factory _AswhUpTaskQuery(
      {@JsonKey(includeToJson: false) final String sortType,
      @JsonKey(includeToJson: false) final String sortColumn,
      final String searchKey,
      final String userId,
      @JsonKey(name: 'roleoRuserId') final String roleOrUserId,
      @JsonKey(name: 'roomTag') final String roomTag,
      @JsonKey(name: 'batchflag') final String batchFlag,
      final String transferType,
      @JsonKey(name: 'beatflag') final String beatFlag,
      @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
      final int pageIndex,
      @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
      final int pageSize,
      @JsonKey(name: 'finshFlg')
      final String finishFlag}) = _$AswhUpTaskQueryImpl;

  factory _AswhUpTaskQuery.fromJson(Map<String, dynamic> json) =
      _$AswhUpTaskQueryImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get sortType;
  @override
  @JsonKey(includeToJson: false)
  String get sortColumn;
  @override
  String get searchKey;
  @override
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
  String get transferType;
  @override
  @JsonKey(name: 'beatflag')
  String get beatFlag;
  @override
  @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
  int get pageIndex;
  @override
  @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
  int get pageSize;
  @override
  @JsonKey(name: 'finshFlg')
  String get finishFlag;
  @override
  @JsonKey(ignore: true)
  _$$AswhUpTaskQueryImplCopyWith<_$AswhUpTaskQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
