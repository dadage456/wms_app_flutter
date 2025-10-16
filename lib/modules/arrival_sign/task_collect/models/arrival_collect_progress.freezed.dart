// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_collect_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ArrivalCollectProgress _$ArrivalCollectProgressFromJson(
    Map<String, dynamic> json) {
  return _ArrivalCollectProgress.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectProgress {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
  ArrivalCollectTask get task => throw _privateConstructorUsedError;
  double get collectQty => throw _privateConstructorUsedError;
  String? get batchNo => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  String? get productionDate => throw _privateConstructorUsedError;
  String? get validDays => throw _privateConstructorUsedError;
  bool get submitted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectProgressCopyWith<ArrivalCollectProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectProgressCopyWith<$Res> {
  factory $ArrivalCollectProgressCopyWith(ArrivalCollectProgress value,
          $Res Function(ArrivalCollectProgress) then) =
      _$ArrivalCollectProgressCopyWithImpl<$Res, ArrivalCollectProgress>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
      ArrivalCollectTask task,
      double collectQty,
      String? batchNo,
      String? serialNumber,
      String? productionDate,
      String? validDays,
      bool submitted});

  $ArrivalCollectTaskCopyWith<$Res> get task;
}

/// @nodoc
class _$ArrivalCollectProgressCopyWithImpl<$Res,
        $Val extends ArrivalCollectProgress>
    implements $ArrivalCollectProgressCopyWith<$Res> {
  _$ArrivalCollectProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? task = null,
    Object? collectQty = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? submitted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as ArrivalCollectTask,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as String?,
      submitted: null == submitted
          ? _value.submitted
          : submitted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ArrivalCollectTaskCopyWith<$Res> get task {
    return $ArrivalCollectTaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArrivalCollectProgressImplCopyWith<$Res>
    implements $ArrivalCollectProgressCopyWith<$Res> {
  factory _$$ArrivalCollectProgressImplCopyWith(
          _$ArrivalCollectProgressImpl value,
          $Res Function(_$ArrivalCollectProgressImpl) then) =
      __$$ArrivalCollectProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
      ArrivalCollectTask task,
      double collectQty,
      String? batchNo,
      String? serialNumber,
      String? productionDate,
      String? validDays,
      bool submitted});

  @override
  $ArrivalCollectTaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$ArrivalCollectProgressImplCopyWithImpl<$Res>
    extends _$ArrivalCollectProgressCopyWithImpl<$Res,
        _$ArrivalCollectProgressImpl>
    implements _$$ArrivalCollectProgressImplCopyWith<$Res> {
  __$$ArrivalCollectProgressImplCopyWithImpl(
      _$ArrivalCollectProgressImpl _value,
      $Res Function(_$ArrivalCollectProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? task = null,
    Object? collectQty = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? submitted = null,
  }) {
    return _then(_$ArrivalCollectProgressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as ArrivalCollectTask,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as String?,
      submitted: null == submitted
          ? _value.submitted
          : submitted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ArrivalCollectProgressImpl implements _ArrivalCollectProgress {
  const _$ArrivalCollectProgressImpl(
      {required this.id,
      @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
      required this.task,
      required this.collectQty,
      this.batchNo,
      this.serialNumber,
      this.productionDate,
      this.validDays,
      this.submitted = false});

  factory _$ArrivalCollectProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalCollectProgressImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
  final ArrivalCollectTask task;
  @override
  final double collectQty;
  @override
  final String? batchNo;
  @override
  final String? serialNumber;
  @override
  final String? productionDate;
  @override
  final String? validDays;
  @override
  @JsonKey()
  final bool submitted;

  @override
  String toString() {
    return 'ArrivalCollectProgress(id: $id, task: $task, collectQty: $collectQty, batchNo: $batchNo, serialNumber: $serialNumber, productionDate: $productionDate, validDays: $validDays, submitted: $submitted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.collectQty, collectQty) ||
                other.collectQty == collectQty) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays) &&
            (identical(other.submitted, submitted) ||
                other.submitted == submitted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, task, collectQty, batchNo,
      serialNumber, productionDate, validDays, submitted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectProgressImplCopyWith<_$ArrivalCollectProgressImpl>
      get copyWith => __$$ArrivalCollectProgressImplCopyWithImpl<
          _$ArrivalCollectProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectProgressImplToJson(
      this,
    );
  }
}

abstract class _ArrivalCollectProgress implements ArrivalCollectProgress {
  const factory _ArrivalCollectProgress(
      {required final String id,
      @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
      required final ArrivalCollectTask task,
      required final double collectQty,
      final String? batchNo,
      final String? serialNumber,
      final String? productionDate,
      final String? validDays,
      final bool submitted}) = _$ArrivalCollectProgressImpl;

  factory _ArrivalCollectProgress.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectProgressImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(fromJson: ArrivalCollectTask.fromJson, toJson: _taskToJson)
  ArrivalCollectTask get task;
  @override
  double get collectQty;
  @override
  String? get batchNo;
  @override
  String? get serialNumber;
  @override
  String? get productionDate;
  @override
  String? get validDays;
  @override
  bool get submitted;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectProgressImplCopyWith<_$ArrivalCollectProgressImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ArrivalCollectSummary _$ArrivalCollectSummaryFromJson(
    Map<String, dynamic> json) {
  return _ArrivalCollectSummary.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectSummary {
  String get id => throw _privateConstructorUsedError;
  String get materialCode => throw _privateConstructorUsedError;
  String? get materialName => throw _privateConstructorUsedError;
  String? get batchNo => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  double? get collectQty => throw _privateConstructorUsedError;
  double? get taskQty => throw _privateConstructorUsedError;
  String? get productionDate => throw _privateConstructorUsedError;
  String? get validDays => throw _privateConstructorUsedError;
  bool get committed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectSummaryCopyWith<ArrivalCollectSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectSummaryCopyWith<$Res> {
  factory $ArrivalCollectSummaryCopyWith(ArrivalCollectSummary value,
          $Res Function(ArrivalCollectSummary) then) =
      _$ArrivalCollectSummaryCopyWithImpl<$Res, ArrivalCollectSummary>;
  @useResult
  $Res call(
      {String id,
      String materialCode,
      String? materialName,
      String? batchNo,
      String? serialNumber,
      double? collectQty,
      double? taskQty,
      String? productionDate,
      String? validDays,
      bool committed});
}

/// @nodoc
class _$ArrivalCollectSummaryCopyWithImpl<$Res,
        $Val extends ArrivalCollectSummary>
    implements $ArrivalCollectSummaryCopyWith<$Res> {
  _$ArrivalCollectSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? collectQty = freezed,
    Object? taskQty = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? committed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      collectQty: freezed == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double?,
      taskQty: freezed == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as double?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as String?,
      committed: null == committed
          ? _value.committed
          : committed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArrivalCollectSummaryImplCopyWith<$Res>
    implements $ArrivalCollectSummaryCopyWith<$Res> {
  factory _$$ArrivalCollectSummaryImplCopyWith(
          _$ArrivalCollectSummaryImpl value,
          $Res Function(_$ArrivalCollectSummaryImpl) then) =
      __$$ArrivalCollectSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String materialCode,
      String? materialName,
      String? batchNo,
      String? serialNumber,
      double? collectQty,
      double? taskQty,
      String? productionDate,
      String? validDays,
      bool committed});
}

/// @nodoc
class __$$ArrivalCollectSummaryImplCopyWithImpl<$Res>
    extends _$ArrivalCollectSummaryCopyWithImpl<$Res,
        _$ArrivalCollectSummaryImpl>
    implements _$$ArrivalCollectSummaryImplCopyWith<$Res> {
  __$$ArrivalCollectSummaryImplCopyWithImpl(_$ArrivalCollectSummaryImpl _value,
      $Res Function(_$ArrivalCollectSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? collectQty = freezed,
    Object? taskQty = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? committed = null,
  }) {
    return _then(_$ArrivalCollectSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      collectQty: freezed == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double?,
      taskQty: freezed == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as double?,
      productionDate: freezed == productionDate
          ? _value.productionDate
          : productionDate // ignore: cast_nullable_to_non_nullable
              as String?,
      validDays: freezed == validDays
          ? _value.validDays
          : validDays // ignore: cast_nullable_to_non_nullable
              as String?,
      committed: null == committed
          ? _value.committed
          : committed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArrivalCollectSummaryImpl implements _ArrivalCollectSummary {
  const _$ArrivalCollectSummaryImpl(
      {required this.id,
      required this.materialCode,
      this.materialName,
      this.batchNo,
      this.serialNumber,
      this.collectQty,
      this.taskQty,
      this.productionDate,
      this.validDays,
      this.committed = false});

  factory _$ArrivalCollectSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalCollectSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String materialCode;
  @override
  final String? materialName;
  @override
  final String? batchNo;
  @override
  final String? serialNumber;
  @override
  final double? collectQty;
  @override
  final double? taskQty;
  @override
  final String? productionDate;
  @override
  final String? validDays;
  @override
  @JsonKey()
  final bool committed;

  @override
  String toString() {
    return 'ArrivalCollectSummary(id: $id, materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNumber: $serialNumber, collectQty: $collectQty, taskQty: $taskQty, productionDate: $productionDate, validDays: $validDays, committed: $committed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.collectQty, collectQty) ||
                other.collectQty == collectQty) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays) &&
            (identical(other.committed, committed) ||
                other.committed == committed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      materialCode,
      materialName,
      batchNo,
      serialNumber,
      collectQty,
      taskQty,
      productionDate,
      validDays,
      committed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectSummaryImplCopyWith<_$ArrivalCollectSummaryImpl>
      get copyWith => __$$ArrivalCollectSummaryImplCopyWithImpl<
          _$ArrivalCollectSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectSummaryImplToJson(
      this,
    );
  }
}

abstract class _ArrivalCollectSummary implements ArrivalCollectSummary {
  const factory _ArrivalCollectSummary(
      {required final String id,
      required final String materialCode,
      final String? materialName,
      final String? batchNo,
      final String? serialNumber,
      final double? collectQty,
      final double? taskQty,
      final String? productionDate,
      final String? validDays,
      final bool committed}) = _$ArrivalCollectSummaryImpl;

  factory _ArrivalCollectSummary.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get materialCode;
  @override
  String? get materialName;
  @override
  String? get batchNo;
  @override
  String? get serialNumber;
  @override
  double? get collectQty;
  @override
  double? get taskQty;
  @override
  String? get productionDate;
  @override
  String? get validDays;
  @override
  bool get committed;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectSummaryImplCopyWith<_$ArrivalCollectSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
