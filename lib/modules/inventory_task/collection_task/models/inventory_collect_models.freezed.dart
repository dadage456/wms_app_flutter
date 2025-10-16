// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_collect_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryTaskItemQuery _$InventoryTaskItemQueryFromJson(
    Map<String, dynamic> json) {
  return _InventoryTaskItemQuery.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskItemQuery {
  @JsonKey(name: 'taskId')
  String get taskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'roomTag')
  String get roomTag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskItemQueryCopyWith<InventoryTaskItemQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskItemQueryCopyWith<$Res> {
  factory $InventoryTaskItemQueryCopyWith(InventoryTaskItemQuery value,
          $Res Function(InventoryTaskItemQuery) then) =
      _$InventoryTaskItemQueryCopyWithImpl<$Res, InventoryTaskItemQuery>;
  @useResult
  $Res call(
      {@JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'roomTag') String roomTag});
}

/// @nodoc
class _$InventoryTaskItemQueryCopyWithImpl<$Res,
        $Val extends InventoryTaskItemQuery>
    implements $InventoryTaskItemQueryCopyWith<$Res> {
  _$InventoryTaskItemQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? roomTag = null,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskItemQueryImplCopyWith<$Res>
    implements $InventoryTaskItemQueryCopyWith<$Res> {
  factory _$$InventoryTaskItemQueryImplCopyWith(
          _$InventoryTaskItemQueryImpl value,
          $Res Function(_$InventoryTaskItemQueryImpl) then) =
      __$$InventoryTaskItemQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'taskId') String taskId,
      @JsonKey(name: 'roomTag') String roomTag});
}

/// @nodoc
class __$$InventoryTaskItemQueryImplCopyWithImpl<$Res>
    extends _$InventoryTaskItemQueryCopyWithImpl<$Res,
        _$InventoryTaskItemQueryImpl>
    implements _$$InventoryTaskItemQueryImplCopyWith<$Res> {
  __$$InventoryTaskItemQueryImplCopyWithImpl(
      _$InventoryTaskItemQueryImpl _value,
      $Res Function(_$InventoryTaskItemQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
    Object? roomTag = null,
  }) {
    return _then(_$InventoryTaskItemQueryImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
      roomTag: null == roomTag
          ? _value.roomTag
          : roomTag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskItemQueryImpl implements _InventoryTaskItemQuery {
  const _$InventoryTaskItemQueryImpl(
      {@JsonKey(name: 'taskId') required this.taskId,
      @JsonKey(name: 'roomTag') this.roomTag = '0'});

  factory _$InventoryTaskItemQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskItemQueryImplFromJson(json);

  @override
  @JsonKey(name: 'taskId')
  final String taskId;
  @override
  @JsonKey(name: 'roomTag')
  final String roomTag;

  @override
  String toString() {
    return 'InventoryTaskItemQuery(taskId: $taskId, roomTag: $roomTag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskItemQueryImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.roomTag, roomTag) || other.roomTag == roomTag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskId, roomTag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskItemQueryImplCopyWith<_$InventoryTaskItemQueryImpl>
      get copyWith => __$$InventoryTaskItemQueryImplCopyWithImpl<
          _$InventoryTaskItemQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskItemQueryImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskItemQuery implements InventoryTaskItemQuery {
  const factory _InventoryTaskItemQuery(
          {@JsonKey(name: 'taskId') required final String taskId,
          @JsonKey(name: 'roomTag') final String roomTag}) =
      _$InventoryTaskItemQueryImpl;

  factory _InventoryTaskItemQuery.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskItemQueryImpl.fromJson;

  @override
  @JsonKey(name: 'taskId')
  String get taskId;
  @override
  @JsonKey(name: 'roomTag')
  String get roomTag;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskItemQueryImplCopyWith<_$InventoryTaskItemQueryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryTaskItem _$InventoryTaskItemFromJson(Map<String, dynamic> json) {
  return _InventoryTaskItem.fromJson(json);
}

/// @nodoc
mixin _$InventoryTaskItem {
  @JsonKey(name: 'itemid')
  String get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'checktaskno')
  String? get checkTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomname')
  String? get storeRoomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'systemquantity')
  double get systemQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'actualquantity')
  double get actualQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'difference')
  double get difference => throw _privateConstructorUsedError;
  @JsonKey(name: 'collectdataqty')
  double get collectedQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'checkmethod_nm')
  String? get checkMethodName => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit')
  String? get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryTaskItemCopyWith<InventoryTaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryTaskItemCopyWith<$Res> {
  factory $InventoryTaskItemCopyWith(
          InventoryTaskItem value, $Res Function(InventoryTaskItem) then) =
      _$InventoryTaskItemCopyWithImpl<$Res, InventoryTaskItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'itemid') String itemId,
      @JsonKey(name: 'checktaskno') String? checkTaskNo,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'storeroomname') String? storeRoomName,
      @JsonKey(name: 'systemquantity') double systemQuantity,
      @JsonKey(name: 'actualquantity') double actualQuantity,
      @JsonKey(name: 'difference') double difference,
      @JsonKey(name: 'collectdataqty') double collectedQuantity,
      @JsonKey(name: 'checkmethod_nm') String? checkMethodName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'unit') String? unit});
}

/// @nodoc
class _$InventoryTaskItemCopyWithImpl<$Res, $Val extends InventoryTaskItem>
    implements $InventoryTaskItemCopyWith<$Res> {
  _$InventoryTaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? checkTaskNo = freezed,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? storeSiteNo = null,
    Object? storeRoomNo = freezed,
    Object? storeRoomName = freezed,
    Object? systemQuantity = null,
    Object? actualQuantity = null,
    Object? difference = null,
    Object? collectedQuantity = null,
    Object? checkMethodName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskNo: freezed == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomName: freezed == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      systemQuantity: null == systemQuantity
          ? _value.systemQuantity
          : systemQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      actualQuantity: null == actualQuantity
          ? _value.actualQuantity
          : actualQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
      collectedQuantity: null == collectedQuantity
          ? _value.collectedQuantity
          : collectedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      checkMethodName: freezed == checkMethodName
          ? _value.checkMethodName
          : checkMethodName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryTaskItemImplCopyWith<$Res>
    implements $InventoryTaskItemCopyWith<$Res> {
  factory _$$InventoryTaskItemImplCopyWith(_$InventoryTaskItemImpl value,
          $Res Function(_$InventoryTaskItemImpl) then) =
      __$$InventoryTaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'itemid') String itemId,
      @JsonKey(name: 'checktaskno') String? checkTaskNo,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'storeroomname') String? storeRoomName,
      @JsonKey(name: 'systemquantity') double systemQuantity,
      @JsonKey(name: 'actualquantity') double actualQuantity,
      @JsonKey(name: 'difference') double difference,
      @JsonKey(name: 'collectdataqty') double collectedQuantity,
      @JsonKey(name: 'checkmethod_nm') String? checkMethodName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'unit') String? unit});
}

/// @nodoc
class __$$InventoryTaskItemImplCopyWithImpl<$Res>
    extends _$InventoryTaskItemCopyWithImpl<$Res, _$InventoryTaskItemImpl>
    implements _$$InventoryTaskItemImplCopyWith<$Res> {
  __$$InventoryTaskItemImplCopyWithImpl(_$InventoryTaskItemImpl _value,
      $Res Function(_$InventoryTaskItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? checkTaskNo = freezed,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? storeSiteNo = null,
    Object? storeRoomNo = freezed,
    Object? storeRoomName = freezed,
    Object? systemQuantity = null,
    Object? actualQuantity = null,
    Object? difference = null,
    Object? collectedQuantity = null,
    Object? checkMethodName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? unit = freezed,
  }) {
    return _then(_$InventoryTaskItemImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      checkTaskNo: freezed == checkTaskNo
          ? _value.checkTaskNo
          : checkTaskNo // ignore: cast_nullable_to_non_nullable
              as String?,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      storeRoomName: freezed == storeRoomName
          ? _value.storeRoomName
          : storeRoomName // ignore: cast_nullable_to_non_nullable
              as String?,
      systemQuantity: null == systemQuantity
          ? _value.systemQuantity
          : systemQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      actualQuantity: null == actualQuantity
          ? _value.actualQuantity
          : actualQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
      collectedQuantity: null == collectedQuantity
          ? _value.collectedQuantity
          : collectedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      checkMethodName: freezed == checkMethodName
          ? _value.checkMethodName
          : checkMethodName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryTaskItemImpl implements _InventoryTaskItem {
  const _$InventoryTaskItemImpl(
      {@JsonKey(name: 'itemid') required this.itemId,
      @JsonKey(name: 'checktaskno') this.checkTaskNo,
      @JsonKey(name: 'matcode') required this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'storesiteno') required this.storeSiteNo,
      @JsonKey(name: 'storeroomno') this.storeRoomNo,
      @JsonKey(name: 'storeroomname') this.storeRoomName,
      @JsonKey(name: 'systemquantity') this.systemQuantity = 0,
      @JsonKey(name: 'actualquantity') this.actualQuantity = 0,
      @JsonKey(name: 'difference') this.difference = 0,
      @JsonKey(name: 'collectdataqty') this.collectedQuantity = 0,
      @JsonKey(name: 'checkmethod_nm') this.checkMethodName,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'unit') this.unit});

  factory _$InventoryTaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryTaskItemImplFromJson(json);

  @override
  @JsonKey(name: 'itemid')
  final String itemId;
  @override
  @JsonKey(name: 'checktaskno')
  final String? checkTaskNo;
  @override
  @JsonKey(name: 'matcode')
  final String materialCode;
  @override
  @JsonKey(name: 'matname')
  final String? materialName;
  @override
  @JsonKey(name: 'storesiteno')
  final String storeSiteNo;
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;
  @override
  @JsonKey(name: 'storeroomname')
  final String? storeRoomName;
  @override
  @JsonKey(name: 'systemquantity')
  final double systemQuantity;
  @override
  @JsonKey(name: 'actualquantity')
  final double actualQuantity;
  @override
  @JsonKey(name: 'difference')
  final double difference;
  @override
  @JsonKey(name: 'collectdataqty')
  final double collectedQuantity;
  @override
  @JsonKey(name: 'checkmethod_nm')
  final String? checkMethodName;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;
  @override
  @JsonKey(name: 'unit')
  final String? unit;

  @override
  String toString() {
    return 'InventoryTaskItem(itemId: $itemId, checkTaskNo: $checkTaskNo, materialCode: $materialCode, materialName: $materialName, storeSiteNo: $storeSiteNo, storeRoomNo: $storeRoomNo, storeRoomName: $storeRoomName, systemQuantity: $systemQuantity, actualQuantity: $actualQuantity, difference: $difference, collectedQuantity: $collectedQuantity, checkMethodName: $checkMethodName, batchNo: $batchNo, serialNo: $serialNo, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryTaskItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.checkTaskNo, checkTaskNo) ||
                other.checkTaskNo == checkTaskNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeRoomName, storeRoomName) ||
                other.storeRoomName == storeRoomName) &&
            (identical(other.systemQuantity, systemQuantity) ||
                other.systemQuantity == systemQuantity) &&
            (identical(other.actualQuantity, actualQuantity) ||
                other.actualQuantity == actualQuantity) &&
            (identical(other.difference, difference) ||
                other.difference == difference) &&
            (identical(other.collectedQuantity, collectedQuantity) ||
                other.collectedQuantity == collectedQuantity) &&
            (identical(other.checkMethodName, checkMethodName) ||
                other.checkMethodName == checkMethodName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      itemId,
      checkTaskNo,
      materialCode,
      materialName,
      storeSiteNo,
      storeRoomNo,
      storeRoomName,
      systemQuantity,
      actualQuantity,
      difference,
      collectedQuantity,
      checkMethodName,
      batchNo,
      serialNo,
      unit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryTaskItemImplCopyWith<_$InventoryTaskItemImpl> get copyWith =>
      __$$InventoryTaskItemImplCopyWithImpl<_$InventoryTaskItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryTaskItemImplToJson(
      this,
    );
  }
}

abstract class _InventoryTaskItem implements InventoryTaskItem {
  const factory _InventoryTaskItem(
      {@JsonKey(name: 'itemid') required final String itemId,
      @JsonKey(name: 'checktaskno') final String? checkTaskNo,
      @JsonKey(name: 'matcode') required final String materialCode,
      @JsonKey(name: 'matname') final String? materialName,
      @JsonKey(name: 'storesiteno') required final String storeSiteNo,
      @JsonKey(name: 'storeroomno') final String? storeRoomNo,
      @JsonKey(name: 'storeroomname') final String? storeRoomName,
      @JsonKey(name: 'systemquantity') final double systemQuantity,
      @JsonKey(name: 'actualquantity') final double actualQuantity,
      @JsonKey(name: 'difference') final double difference,
      @JsonKey(name: 'collectdataqty') final double collectedQuantity,
      @JsonKey(name: 'checkmethod_nm') final String? checkMethodName,
      @JsonKey(name: 'batchno') final String? batchNo,
      @JsonKey(name: 'sn') final String? serialNo,
      @JsonKey(name: 'unit') final String? unit}) = _$InventoryTaskItemImpl;

  factory _InventoryTaskItem.fromJson(Map<String, dynamic> json) =
      _$InventoryTaskItemImpl.fromJson;

  @override
  @JsonKey(name: 'itemid')
  String get itemId;
  @override
  @JsonKey(name: 'checktaskno')
  String? get checkTaskNo;
  @override
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override
  @JsonKey(name: 'matname')
  String? get materialName;
  @override
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo;
  @override
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;
  @override
  @JsonKey(name: 'storeroomname')
  String? get storeRoomName;
  @override
  @JsonKey(name: 'systemquantity')
  double get systemQuantity;
  @override
  @JsonKey(name: 'actualquantity')
  double get actualQuantity;
  @override
  @JsonKey(name: 'difference')
  double get difference;
  @override
  @JsonKey(name: 'collectdataqty')
  double get collectedQuantity;
  @override
  @JsonKey(name: 'checkmethod_nm')
  String? get checkMethodName;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override
  @JsonKey(name: 'unit')
  String? get unit;
  @override
  @JsonKey(ignore: true)
  _$$InventoryTaskItemImplCopyWith<_$InventoryTaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryBarcodeContent _$InventoryBarcodeContentFromJson(
    Map<String, dynamic> json) {
  return _InventoryBarcodeContent.fromJson(json);
}

/// @nodoc
mixin _$InventoryBarcodeContent {
  @JsonKey(name: 'matcode')
  String? get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit')
  String? get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryBarcodeContentCopyWith<InventoryBarcodeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryBarcodeContentCopyWith<$Res> {
  factory $InventoryBarcodeContentCopyWith(InventoryBarcodeContent value,
          $Res Function(InventoryBarcodeContent) then) =
      _$InventoryBarcodeContentCopyWithImpl<$Res, InventoryBarcodeContent>;
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'qty') double quantity,
      @JsonKey(name: 'unit') String? unit});
}

/// @nodoc
class _$InventoryBarcodeContentCopyWithImpl<$Res,
        $Val extends InventoryBarcodeContent>
    implements $InventoryBarcodeContentCopyWith<$Res> {
  _$InventoryBarcodeContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = null,
    Object? unit = freezed,
  }) {
    return _then(_value.copyWith(
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryBarcodeContentImplCopyWith<$Res>
    implements $InventoryBarcodeContentCopyWith<$Res> {
  factory _$$InventoryBarcodeContentImplCopyWith(
          _$InventoryBarcodeContentImpl value,
          $Res Function(_$InventoryBarcodeContentImpl) then) =
      __$$InventoryBarcodeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'matcode') String? materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'qty') double quantity,
      @JsonKey(name: 'unit') String? unit});
}

/// @nodoc
class __$$InventoryBarcodeContentImplCopyWithImpl<$Res>
    extends _$InventoryBarcodeContentCopyWithImpl<$Res,
        _$InventoryBarcodeContentImpl>
    implements _$$InventoryBarcodeContentImplCopyWith<$Res> {
  __$$InventoryBarcodeContentImplCopyWithImpl(
      _$InventoryBarcodeContentImpl _value,
      $Res Function(_$InventoryBarcodeContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? quantity = null,
    Object? unit = freezed,
  }) {
    return _then(_$InventoryBarcodeContentImpl(
      materialCode: freezed == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String?,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryBarcodeContentImpl implements _InventoryBarcodeContent {
  const _$InventoryBarcodeContentImpl(
      {@JsonKey(name: 'matcode') this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'qty') this.quantity = 0,
      @JsonKey(name: 'unit') this.unit});

  factory _$InventoryBarcodeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryBarcodeContentImplFromJson(json);

  @override
  @JsonKey(name: 'matcode')
  final String? materialCode;
  @override
  @JsonKey(name: 'matname')
  final String? materialName;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;
  @override
  @JsonKey(name: 'qty')
  final double quantity;
  @override
  @JsonKey(name: 'unit')
  final String? unit;

  @override
  String toString() {
    return 'InventoryBarcodeContent(materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNo: $serialNo, quantity: $quantity, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryBarcodeContentImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, materialCode, materialName,
      batchNo, serialNo, quantity, unit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryBarcodeContentImplCopyWith<_$InventoryBarcodeContentImpl>
      get copyWith => __$$InventoryBarcodeContentImplCopyWithImpl<
          _$InventoryBarcodeContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryBarcodeContentImplToJson(
      this,
    );
  }
}

abstract class _InventoryBarcodeContent implements InventoryBarcodeContent {
  const factory _InventoryBarcodeContent(
          {@JsonKey(name: 'matcode') final String? materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNo,
          @JsonKey(name: 'qty') final double quantity,
          @JsonKey(name: 'unit') final String? unit}) =
      _$InventoryBarcodeContentImpl;

  factory _InventoryBarcodeContent.fromJson(Map<String, dynamic> json) =
      _$InventoryBarcodeContentImpl.fromJson;

  @override
  @JsonKey(name: 'matcode')
  String? get materialCode;
  @override
  @JsonKey(name: 'matname')
  String? get materialName;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override
  @JsonKey(name: 'qty')
  double get quantity;
  @override
  @JsonKey(name: 'unit')
  String? get unit;
  @override
  @JsonKey(ignore: true)
  _$$InventoryBarcodeContentImplCopyWith<_$InventoryBarcodeContentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryCollectRecord _$InventoryCollectRecordFromJson(
    Map<String, dynamic> json) {
  return _InventoryCollectRecord.fromJson(json);
}

/// @nodoc
mixin _$InventoryCollectRecord {
  @JsonKey(name: 'itemid')
  String get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  String get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'systemquantity')
  double get systemQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'actualquantity')
  double get actualQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'difference')
  double get difference => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit')
  String? get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskComment')
  String? get taskComment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCollectRecordCopyWith<InventoryCollectRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCollectRecordCopyWith<$Res> {
  factory $InventoryCollectRecordCopyWith(InventoryCollectRecord value,
          $Res Function(InventoryCollectRecord) then) =
      _$InventoryCollectRecordCopyWithImpl<$Res, InventoryCollectRecord>;
  @useResult
  $Res call(
      {@JsonKey(name: 'itemid') String itemId,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'systemquantity') double systemQuantity,
      @JsonKey(name: 'actualquantity') double actualQuantity,
      @JsonKey(name: 'difference') double difference,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'unit') String? unit,
      @JsonKey(name: 'taskComment') String? taskComment});
}

/// @nodoc
class _$InventoryCollectRecordCopyWithImpl<$Res,
        $Val extends InventoryCollectRecord>
    implements $InventoryCollectRecordCopyWith<$Res> {
  _$InventoryCollectRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? storeSiteNo = null,
    Object? storeRoomNo = freezed,
    Object? systemQuantity = null,
    Object? actualQuantity = null,
    Object? difference = null,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? unit = freezed,
    Object? taskComment = freezed,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      systemQuantity: null == systemQuantity
          ? _value.systemQuantity
          : systemQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      actualQuantity: null == actualQuantity
          ? _value.actualQuantity
          : actualQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryCollectRecordImplCopyWith<$Res>
    implements $InventoryCollectRecordCopyWith<$Res> {
  factory _$$InventoryCollectRecordImplCopyWith(
          _$InventoryCollectRecordImpl value,
          $Res Function(_$InventoryCollectRecordImpl) then) =
      __$$InventoryCollectRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'itemid') String itemId,
      @JsonKey(name: 'matcode') String materialCode,
      @JsonKey(name: 'matname') String? materialName,
      @JsonKey(name: 'storesiteno') String storeSiteNo,
      @JsonKey(name: 'storeroomno') String? storeRoomNo,
      @JsonKey(name: 'systemquantity') double systemQuantity,
      @JsonKey(name: 'actualquantity') double actualQuantity,
      @JsonKey(name: 'difference') double difference,
      @JsonKey(name: 'batchno') String? batchNo,
      @JsonKey(name: 'sn') String? serialNo,
      @JsonKey(name: 'unit') String? unit,
      @JsonKey(name: 'taskComment') String? taskComment});
}

/// @nodoc
class __$$InventoryCollectRecordImplCopyWithImpl<$Res>
    extends _$InventoryCollectRecordCopyWithImpl<$Res,
        _$InventoryCollectRecordImpl>
    implements _$$InventoryCollectRecordImplCopyWith<$Res> {
  __$$InventoryCollectRecordImplCopyWithImpl(
      _$InventoryCollectRecordImpl _value,
      $Res Function(_$InventoryCollectRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? materialCode = null,
    Object? materialName = freezed,
    Object? storeSiteNo = null,
    Object? storeRoomNo = freezed,
    Object? systemQuantity = null,
    Object? actualQuantity = null,
    Object? difference = null,
    Object? batchNo = freezed,
    Object? serialNo = freezed,
    Object? unit = freezed,
    Object? taskComment = freezed,
  }) {
    return _then(_$InventoryCollectRecordImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: freezed == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String?,
      storeSiteNo: null == storeSiteNo
          ? _value.storeSiteNo
          : storeSiteNo // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoomNo: freezed == storeRoomNo
          ? _value.storeRoomNo
          : storeRoomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      systemQuantity: null == systemQuantity
          ? _value.systemQuantity
          : systemQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      actualQuantity: null == actualQuantity
          ? _value.actualQuantity
          : actualQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      difference: null == difference
          ? _value.difference
          : difference // ignore: cast_nullable_to_non_nullable
              as double,
      batchNo: freezed == batchNo
          ? _value.batchNo
          : batchNo // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      taskComment: freezed == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryCollectRecordImpl implements _InventoryCollectRecord {
  const _$InventoryCollectRecordImpl(
      {@JsonKey(name: 'itemid') required this.itemId,
      @JsonKey(name: 'matcode') required this.materialCode,
      @JsonKey(name: 'matname') this.materialName,
      @JsonKey(name: 'storesiteno') required this.storeSiteNo,
      @JsonKey(name: 'storeroomno') this.storeRoomNo,
      @JsonKey(name: 'systemquantity') this.systemQuantity = 0,
      @JsonKey(name: 'actualquantity') this.actualQuantity = 0,
      @JsonKey(name: 'difference') this.difference = 0,
      @JsonKey(name: 'batchno') this.batchNo,
      @JsonKey(name: 'sn') this.serialNo,
      @JsonKey(name: 'unit') this.unit,
      @JsonKey(name: 'taskComment') this.taskComment});

  factory _$InventoryCollectRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryCollectRecordImplFromJson(json);

  @override
  @JsonKey(name: 'itemid')
  final String itemId;
  @override
  @JsonKey(name: 'matcode')
  final String materialCode;
  @override
  @JsonKey(name: 'matname')
  final String? materialName;
  @override
  @JsonKey(name: 'storesiteno')
  final String storeSiteNo;
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;
  @override
  @JsonKey(name: 'systemquantity')
  final double systemQuantity;
  @override
  @JsonKey(name: 'actualquantity')
  final double actualQuantity;
  @override
  @JsonKey(name: 'difference')
  final double difference;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNo;
  @override
  @JsonKey(name: 'unit')
  final String? unit;
  @override
  @JsonKey(name: 'taskComment')
  final String? taskComment;

  @override
  String toString() {
    return 'InventoryCollectRecord(itemId: $itemId, materialCode: $materialCode, materialName: $materialName, storeSiteNo: $storeSiteNo, storeRoomNo: $storeRoomNo, systemQuantity: $systemQuantity, actualQuantity: $actualQuantity, difference: $difference, batchNo: $batchNo, serialNo: $serialNo, unit: $unit, taskComment: $taskComment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCollectRecordImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.systemQuantity, systemQuantity) ||
                other.systemQuantity == systemQuantity) &&
            (identical(other.actualQuantity, actualQuantity) ||
                other.actualQuantity == actualQuantity) &&
            (identical(other.difference, difference) ||
                other.difference == difference) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      itemId,
      materialCode,
      materialName,
      storeSiteNo,
      storeRoomNo,
      systemQuantity,
      actualQuantity,
      difference,
      batchNo,
      serialNo,
      unit,
      taskComment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCollectRecordImplCopyWith<_$InventoryCollectRecordImpl>
      get copyWith => __$$InventoryCollectRecordImplCopyWithImpl<
          _$InventoryCollectRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryCollectRecordImplToJson(
      this,
    );
  }
}

abstract class _InventoryCollectRecord implements InventoryCollectRecord {
  const factory _InventoryCollectRecord(
          {@JsonKey(name: 'itemid') required final String itemId,
          @JsonKey(name: 'matcode') required final String materialCode,
          @JsonKey(name: 'matname') final String? materialName,
          @JsonKey(name: 'storesiteno') required final String storeSiteNo,
          @JsonKey(name: 'storeroomno') final String? storeRoomNo,
          @JsonKey(name: 'systemquantity') final double systemQuantity,
          @JsonKey(name: 'actualquantity') final double actualQuantity,
          @JsonKey(name: 'difference') final double difference,
          @JsonKey(name: 'batchno') final String? batchNo,
          @JsonKey(name: 'sn') final String? serialNo,
          @JsonKey(name: 'unit') final String? unit,
          @JsonKey(name: 'taskComment') final String? taskComment}) =
      _$InventoryCollectRecordImpl;

  factory _InventoryCollectRecord.fromJson(Map<String, dynamic> json) =
      _$InventoryCollectRecordImpl.fromJson;

  @override
  @JsonKey(name: 'itemid')
  String get itemId;
  @override
  @JsonKey(name: 'matcode')
  String get materialCode;
  @override
  @JsonKey(name: 'matname')
  String? get materialName;
  @override
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo;
  @override
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;
  @override
  @JsonKey(name: 'systemquantity')
  double get systemQuantity;
  @override
  @JsonKey(name: 'actualquantity')
  double get actualQuantity;
  @override
  @JsonKey(name: 'difference')
  double get difference;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNo;
  @override
  @JsonKey(name: 'unit')
  String? get unit;
  @override
  @JsonKey(name: 'taskComment')
  String? get taskComment;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCollectRecordImplCopyWith<_$InventoryCollectRecordImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InventoryCommitRequest _$InventoryCommitRequestFromJson(
    Map<String, dynamic> json) {
  return _InventoryCommitRequest.fromJson(json);
}

/// @nodoc
mixin _$InventoryCommitRequest {
  @JsonKey(name: 'inventoryInfos')
  List<InventoryCollectRecord> get records =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'taskComment')
  String get taskComment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCommitRequestCopyWith<InventoryCommitRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCommitRequestCopyWith<$Res> {
  factory $InventoryCommitRequestCopyWith(InventoryCommitRequest value,
          $Res Function(InventoryCommitRequest) then) =
      _$InventoryCommitRequestCopyWithImpl<$Res, InventoryCommitRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'inventoryInfos') List<InventoryCollectRecord> records,
      @JsonKey(name: 'taskComment') String taskComment});
}

/// @nodoc
class _$InventoryCommitRequestCopyWithImpl<$Res,
        $Val extends InventoryCommitRequest>
    implements $InventoryCommitRequestCopyWith<$Res> {
  _$InventoryCommitRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? taskComment = null,
  }) {
    return _then(_value.copyWith(
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectRecord>,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryCommitRequestImplCopyWith<$Res>
    implements $InventoryCommitRequestCopyWith<$Res> {
  factory _$$InventoryCommitRequestImplCopyWith(
          _$InventoryCommitRequestImpl value,
          $Res Function(_$InventoryCommitRequestImpl) then) =
      __$$InventoryCommitRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'inventoryInfos') List<InventoryCollectRecord> records,
      @JsonKey(name: 'taskComment') String taskComment});
}

/// @nodoc
class __$$InventoryCommitRequestImplCopyWithImpl<$Res>
    extends _$InventoryCommitRequestCopyWithImpl<$Res,
        _$InventoryCommitRequestImpl>
    implements _$$InventoryCommitRequestImplCopyWith<$Res> {
  __$$InventoryCommitRequestImplCopyWithImpl(
      _$InventoryCommitRequestImpl _value,
      $Res Function(_$InventoryCommitRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = null,
    Object? taskComment = null,
  }) {
    return _then(_$InventoryCommitRequestImpl(
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<InventoryCollectRecord>,
      taskComment: null == taskComment
          ? _value.taskComment
          : taskComment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryCommitRequestImpl implements _InventoryCommitRequest {
  const _$InventoryCommitRequestImpl(
      {@JsonKey(name: 'inventoryInfos')
      final List<InventoryCollectRecord> records =
          const <InventoryCollectRecord>[],
      @JsonKey(name: 'taskComment') required this.taskComment})
      : _records = records;

  factory _$InventoryCommitRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryCommitRequestImplFromJson(json);

  final List<InventoryCollectRecord> _records;
  @override
  @JsonKey(name: 'inventoryInfos')
  List<InventoryCollectRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  @JsonKey(name: 'taskComment')
  final String taskComment;

  @override
  String toString() {
    return 'InventoryCommitRequest(records: $records, taskComment: $taskComment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryCommitRequestImpl &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_records), taskComment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryCommitRequestImplCopyWith<_$InventoryCommitRequestImpl>
      get copyWith => __$$InventoryCommitRequestImplCopyWithImpl<
          _$InventoryCommitRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryCommitRequestImplToJson(
      this,
    );
  }
}

abstract class _InventoryCommitRequest implements InventoryCommitRequest {
  const factory _InventoryCommitRequest(
          {@JsonKey(name: 'inventoryInfos')
          final List<InventoryCollectRecord> records,
          @JsonKey(name: 'taskComment') required final String taskComment}) =
      _$InventoryCommitRequestImpl;

  factory _InventoryCommitRequest.fromJson(Map<String, dynamic> json) =
      _$InventoryCommitRequestImpl.fromJson;

  @override
  @JsonKey(name: 'inventoryInfos')
  List<InventoryCollectRecord> get records;
  @override
  @JsonKey(name: 'taskComment')
  String get taskComment;
  @override
  @JsonKey(ignore: true)
  _$$InventoryCommitRequestImplCopyWith<_$InventoryCommitRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
