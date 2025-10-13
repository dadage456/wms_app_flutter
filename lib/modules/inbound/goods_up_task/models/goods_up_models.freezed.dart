// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_up_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InTaskItem _$InTaskItemFromJson(Map<String, dynamic> json) {
  return _InTaskItem.fromJson(json);
}

/// @nodoc
mixin _$InTaskItem {
  @JsonKey(name: 'intaskitemid')
  @HiveField(0)
  int get inTaskItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'intaskid')
  @HiveField(1)
  int get inTaskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'intaskno')
  @HiveField(2)
  String? get inTaskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  @HiveField(3)
  String? get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  @HiveField(4)
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'matinnercode')
  @HiveField(5)
  String? get oldMaterialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeroomno')
  @HiveField(6)
  String? get storeRoomNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'storesiteno')
  @HiveField(7)
  String? get storeSiteNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  @HiveField(8)
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'collectedqty')
  @HiveField(9)
  double get collectedQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  @HiveField(10)
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  @HiveField(11)
  String? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'subinventoryCode')
  @HiveField(12)
  String? get subInventoryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'orderno')
  @HiveField(13)
  String? get inboundOrderNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskcomment')
  @HiveField(14)
  String? get taskComment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InTaskItemCopyWith<InTaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InTaskItemCopyWith<$Res> {
  factory $InTaskItemCopyWith(
    InTaskItem value,
    $Res Function(InTaskItem) then,
  ) = _$InTaskItemCopyWithImpl<$Res, InTaskItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'intaskitemid') @HiveField(0) int inTaskItemId,
    @JsonKey(name: 'intaskid') @HiveField(1) int inTaskId,
    @JsonKey(name: 'intaskno') @HiveField(2) String? inTaskNo,
    @JsonKey(name: 'matcode') @HiveField(3) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(4) String? materialName,
    @JsonKey(name: 'matinnercode') @HiveField(5) String? oldMaterialCode,
    @JsonKey(name: 'storeroomno') @HiveField(6) String? storeRoomNo,
    @JsonKey(name: 'storesiteno') @HiveField(7) String? storeSiteNo,
    @JsonKey(name: 'qty') @HiveField(8) double quantity,
    @JsonKey(name: 'collectedqty') @HiveField(9) double collectedQuantity,
    @JsonKey(name: 'batchno') @HiveField(10) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(11) String? serialNumber,
    @JsonKey(name: 'subinventoryCode') @HiveField(12) String? subInventoryCode,
    @JsonKey(name: 'orderno') @HiveField(13) String? inboundOrderNo,
    @JsonKey(name: 'taskcomment') @HiveField(14) String? taskComment,
  });
}

/// @nodoc
class _$InTaskItemCopyWithImpl<$Res, $Val extends InTaskItem>
    implements $InTaskItemCopyWith<$Res> {
  _$InTaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inTaskItemId = null,
    Object? inTaskId = null,
    Object? inTaskNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? oldMaterialCode = freezed,
    Object? storeRoomNo = freezed,
    Object? storeSiteNo = freezed,
    Object? quantity = null,
    Object? collectedQuantity = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? subInventoryCode = freezed,
    Object? inboundOrderNo = freezed,
    Object? taskComment = freezed,
  }) {
    return _then(
      _value.copyWith(
            inTaskItemId: null == inTaskItemId
                ? _value.inTaskItemId
                : inTaskItemId // ignore: cast_nullable_to_non_nullable
                      as int,
            inTaskId: null == inTaskId
                ? _value.inTaskId
                : inTaskId // ignore: cast_nullable_to_non_nullable
                      as int,
            inTaskNo: freezed == inTaskNo
                ? _value.inTaskNo
                : inTaskNo // ignore: cast_nullable_to_non_nullable
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
            storeRoomNo: freezed == storeRoomNo
                ? _value.storeRoomNo
                : storeRoomNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeSiteNo: freezed == storeSiteNo
                ? _value.storeSiteNo
                : storeSiteNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            collectedQuantity: null == collectedQuantity
                ? _value.collectedQuantity
                : collectedQuantity // ignore: cast_nullable_to_non_nullable
                      as double,
            batchNo: freezed == batchNo
                ? _value.batchNo
                : batchNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            serialNumber: freezed == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            subInventoryCode: freezed == subInventoryCode
                ? _value.subInventoryCode
                : subInventoryCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            inboundOrderNo: freezed == inboundOrderNo
                ? _value.inboundOrderNo
                : inboundOrderNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            taskComment: freezed == taskComment
                ? _value.taskComment
                : taskComment // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InTaskItemImplCopyWith<$Res>
    implements $InTaskItemCopyWith<$Res> {
  factory _$$InTaskItemImplCopyWith(
    _$InTaskItemImpl value,
    $Res Function(_$InTaskItemImpl) then,
  ) = __$$InTaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'intaskitemid') @HiveField(0) int inTaskItemId,
    @JsonKey(name: 'intaskid') @HiveField(1) int inTaskId,
    @JsonKey(name: 'intaskno') @HiveField(2) String? inTaskNo,
    @JsonKey(name: 'matcode') @HiveField(3) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(4) String? materialName,
    @JsonKey(name: 'matinnercode') @HiveField(5) String? oldMaterialCode,
    @JsonKey(name: 'storeroomno') @HiveField(6) String? storeRoomNo,
    @JsonKey(name: 'storesiteno') @HiveField(7) String? storeSiteNo,
    @JsonKey(name: 'qty') @HiveField(8) double quantity,
    @JsonKey(name: 'collectedqty') @HiveField(9) double collectedQuantity,
    @JsonKey(name: 'batchno') @HiveField(10) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(11) String? serialNumber,
    @JsonKey(name: 'subinventoryCode') @HiveField(12) String? subInventoryCode,
    @JsonKey(name: 'orderno') @HiveField(13) String? inboundOrderNo,
    @JsonKey(name: 'taskcomment') @HiveField(14) String? taskComment,
  });
}

/// @nodoc
class __$$InTaskItemImplCopyWithImpl<$Res>
    extends _$InTaskItemCopyWithImpl<$Res, _$InTaskItemImpl>
    implements _$$InTaskItemImplCopyWith<$Res> {
  __$$InTaskItemImplCopyWithImpl(
    _$InTaskItemImpl _value,
    $Res Function(_$InTaskItemImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inTaskItemId = null,
    Object? inTaskId = null,
    Object? inTaskNo = freezed,
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? oldMaterialCode = freezed,
    Object? storeRoomNo = freezed,
    Object? storeSiteNo = freezed,
    Object? quantity = null,
    Object? collectedQuantity = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? subInventoryCode = freezed,
    Object? inboundOrderNo = freezed,
    Object? taskComment = freezed,
  }) {
    return _then(
      _$InTaskItemImpl(
        inTaskItemId: null == inTaskItemId
            ? _value.inTaskItemId
            : inTaskItemId // ignore: cast_nullable_to_non_nullable
                  as int,
        inTaskId: null == inTaskId
            ? _value.inTaskId
            : inTaskId // ignore: cast_nullable_to_non_nullable
                  as int,
        inTaskNo: freezed == inTaskNo
            ? _value.inTaskNo
            : inTaskNo // ignore: cast_nullable_to_non_nullable
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
        storeRoomNo: freezed == storeRoomNo
            ? _value.storeRoomNo
            : storeRoomNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeSiteNo: freezed == storeSiteNo
            ? _value.storeSiteNo
            : storeSiteNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        collectedQuantity: null == collectedQuantity
            ? _value.collectedQuantity
            : collectedQuantity // ignore: cast_nullable_to_non_nullable
                  as double,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        serialNumber: freezed == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        subInventoryCode: freezed == subInventoryCode
            ? _value.subInventoryCode
            : subInventoryCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        inboundOrderNo: freezed == inboundOrderNo
            ? _value.inboundOrderNo
            : inboundOrderNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        taskComment: freezed == taskComment
            ? _value.taskComment
            : taskComment // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InTaskItemImpl extends _InTaskItem {
  _$InTaskItemImpl({
    @JsonKey(name: 'intaskitemid') @HiveField(0) required this.inTaskItemId,
    @JsonKey(name: 'intaskid') @HiveField(1) required this.inTaskId,
    @JsonKey(name: 'intaskno') @HiveField(2) this.inTaskNo,
    @JsonKey(name: 'matcode') @HiveField(3) this.materialCode,
    @JsonKey(name: 'matname') @HiveField(4) this.materialName,
    @JsonKey(name: 'matinnercode') @HiveField(5) this.oldMaterialCode,
    @JsonKey(name: 'storeroomno') @HiveField(6) this.storeRoomNo,
    @JsonKey(name: 'storesiteno') @HiveField(7) this.storeSiteNo,
    @JsonKey(name: 'qty') @HiveField(8) required this.quantity,
    @JsonKey(name: 'collectedqty')
    @HiveField(9)
    required this.collectedQuantity,
    @JsonKey(name: 'batchno') @HiveField(10) this.batchNo,
    @JsonKey(name: 'sn') @HiveField(11) this.serialNumber,
    @JsonKey(name: 'subinventoryCode') @HiveField(12) this.subInventoryCode,
    @JsonKey(name: 'orderno') @HiveField(13) this.inboundOrderNo,
    @JsonKey(name: 'taskcomment') @HiveField(14) this.taskComment,
  }) : super._();

  factory _$InTaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InTaskItemImplFromJson(json);

  @override
  @JsonKey(name: 'intaskitemid')
  @HiveField(0)
  final int inTaskItemId;
  @override
  @JsonKey(name: 'intaskid')
  @HiveField(1)
  final int inTaskId;
  @override
  @JsonKey(name: 'intaskno')
  @HiveField(2)
  final String? inTaskNo;
  @override
  @JsonKey(name: 'matcode')
  @HiveField(3)
  final String? materialCode;
  @override
  @JsonKey(name: 'matname')
  @HiveField(4)
  final String? materialName;
  @override
  @JsonKey(name: 'matinnercode')
  @HiveField(5)
  final String? oldMaterialCode;
  @override
  @JsonKey(name: 'storeroomno')
  @HiveField(6)
  final String? storeRoomNo;
  @override
  @JsonKey(name: 'storesiteno')
  @HiveField(7)
  final String? storeSiteNo;
  @override
  @JsonKey(name: 'qty')
  @HiveField(8)
  final double quantity;
  @override
  @JsonKey(name: 'collectedqty')
  @HiveField(9)
  final double collectedQuantity;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(10)
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(11)
  final String? serialNumber;
  @override
  @JsonKey(name: 'subinventoryCode')
  @HiveField(12)
  final String? subInventoryCode;
  @override
  @JsonKey(name: 'orderno')
  @HiveField(13)
  final String? inboundOrderNo;
  @override
  @JsonKey(name: 'taskcomment')
  @HiveField(14)
  final String? taskComment;

  @override
  String toString() {
    return 'InTaskItem(inTaskItemId: $inTaskItemId, inTaskId: $inTaskId, inTaskNo: $inTaskNo, materialCode: $materialCode, materialName: $materialName, oldMaterialCode: $oldMaterialCode, storeRoomNo: $storeRoomNo, storeSiteNo: $storeSiteNo, quantity: $quantity, collectedQuantity: $collectedQuantity, batchNo: $batchNo, serialNumber: $serialNumber, subInventoryCode: $subInventoryCode, inboundOrderNo: $inboundOrderNo, taskComment: $taskComment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InTaskItemImpl &&
            (identical(other.inTaskItemId, inTaskItemId) ||
                other.inTaskItemId == inTaskItemId) &&
            (identical(other.inTaskId, inTaskId) ||
                other.inTaskId == inTaskId) &&
            (identical(other.inTaskNo, inTaskNo) ||
                other.inTaskNo == inTaskNo) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.oldMaterialCode, oldMaterialCode) ||
                other.oldMaterialCode == oldMaterialCode) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.collectedQuantity, collectedQuantity) ||
                other.collectedQuantity == collectedQuantity) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.subInventoryCode, subInventoryCode) ||
                other.subInventoryCode == subInventoryCode) &&
            (identical(other.inboundOrderNo, inboundOrderNo) ||
                other.inboundOrderNo == inboundOrderNo) &&
            (identical(other.taskComment, taskComment) ||
                other.taskComment == taskComment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    inTaskItemId,
    inTaskId,
    inTaskNo,
    materialCode,
    materialName,
    oldMaterialCode,
    storeRoomNo,
    storeSiteNo,
    quantity,
    collectedQuantity,
    batchNo,
    serialNumber,
    subInventoryCode,
    inboundOrderNo,
    taskComment,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InTaskItemImplCopyWith<_$InTaskItemImpl> get copyWith =>
      __$$InTaskItemImplCopyWithImpl<_$InTaskItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InTaskItemImplToJson(this);
  }
}

abstract class _InTaskItem extends InTaskItem {
  factory _InTaskItem({
    @JsonKey(name: 'intaskitemid')
    @HiveField(0)
    required final int inTaskItemId,
    @JsonKey(name: 'intaskid') @HiveField(1) required final int inTaskId,
    @JsonKey(name: 'intaskno') @HiveField(2) final String? inTaskNo,
    @JsonKey(name: 'matcode') @HiveField(3) final String? materialCode,
    @JsonKey(name: 'matname') @HiveField(4) final String? materialName,
    @JsonKey(name: 'matinnercode') @HiveField(5) final String? oldMaterialCode,
    @JsonKey(name: 'storeroomno') @HiveField(6) final String? storeRoomNo,
    @JsonKey(name: 'storesiteno') @HiveField(7) final String? storeSiteNo,
    @JsonKey(name: 'qty') @HiveField(8) required final double quantity,
    @JsonKey(name: 'collectedqty')
    @HiveField(9)
    required final double collectedQuantity,
    @JsonKey(name: 'batchno') @HiveField(10) final String? batchNo,
    @JsonKey(name: 'sn') @HiveField(11) final String? serialNumber,
    @JsonKey(name: 'subinventoryCode')
    @HiveField(12)
    final String? subInventoryCode,
    @JsonKey(name: 'orderno') @HiveField(13) final String? inboundOrderNo,
    @JsonKey(name: 'taskcomment') @HiveField(14) final String? taskComment,
  }) = _$InTaskItemImpl;
  _InTaskItem._() : super._();

  factory _InTaskItem.fromJson(Map<String, dynamic> json) =
      _$InTaskItemImpl.fromJson;

  @override
  @JsonKey(name: 'intaskitemid')
  @HiveField(0)
  int get inTaskItemId;
  @override
  @JsonKey(name: 'intaskid')
  @HiveField(1)
  int get inTaskId;
  @override
  @JsonKey(name: 'intaskno')
  @HiveField(2)
  String? get inTaskNo;
  @override
  @JsonKey(name: 'matcode')
  @HiveField(3)
  String? get materialCode;
  @override
  @JsonKey(name: 'matname')
  @HiveField(4)
  String? get materialName;
  @override
  @JsonKey(name: 'matinnercode')
  @HiveField(5)
  String? get oldMaterialCode;
  @override
  @JsonKey(name: 'storeroomno')
  @HiveField(6)
  String? get storeRoomNo;
  @override
  @JsonKey(name: 'storesiteno')
  @HiveField(7)
  String? get storeSiteNo;
  @override
  @JsonKey(name: 'qty')
  @HiveField(8)
  double get quantity;
  @override
  @JsonKey(name: 'collectedqty')
  @HiveField(9)
  double get collectedQuantity;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(10)
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(11)
  String? get serialNumber;
  @override
  @JsonKey(name: 'subinventoryCode')
  @HiveField(12)
  String? get subInventoryCode;
  @override
  @JsonKey(name: 'orderno')
  @HiveField(13)
  String? get inboundOrderNo;
  @override
  @JsonKey(name: 'taskcomment')
  @HiveField(14)
  String? get taskComment;
  @override
  @JsonKey(ignore: true)
  _$$InTaskItemImplCopyWith<_$InTaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpBarcodeContent _$UpBarcodeContentFromJson(Map<String, dynamic> json) {
  return _UpBarcodeContent.fromJson(json);
}

/// @nodoc
mixin _$UpBarcodeContent {
  @JsonKey(name: 'matcode')
  @HiveField(0)
  String? get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'matname')
  @HiveField(1)
  String? get materialName => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  @HiveField(2)
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  @HiveField(3)
  String? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'seqctrl')
  @HiveField(4)
  String? get seqctrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'idOld')
  @HiveField(5)
  String? get idOld => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  @HiveField(6)
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'pdate')
  @HiveField(7)
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vdays')
  @HiveField(8)
  String? get validDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'dgFlg')
  @HiveField(9)
  String? get dgFlag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpBarcodeContentCopyWith<UpBarcodeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpBarcodeContentCopyWith<$Res> {
  factory $UpBarcodeContentCopyWith(
    UpBarcodeContent value,
    $Res Function(UpBarcodeContent) then,
  ) = _$UpBarcodeContentCopyWithImpl<$Res, UpBarcodeContent>;
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') @HiveField(0) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(1) String? materialName,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNumber,
    @JsonKey(name: 'seqctrl') @HiveField(4) String? seqctrl,
    @JsonKey(name: 'idOld') @HiveField(5) String? idOld,
    @JsonKey(name: 'qty') @HiveField(6) double? quantity,
    @JsonKey(name: 'pdate') @HiveField(7) String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(8) String? validDays,
    @JsonKey(name: 'dgFlg') @HiveField(9) String? dgFlag,
  });
}

/// @nodoc
class _$UpBarcodeContentCopyWithImpl<$Res, $Val extends UpBarcodeContent>
    implements $UpBarcodeContentCopyWith<$Res> {
  _$UpBarcodeContentCopyWithImpl(this._value, this._then);

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
    Object? serialNumber = freezed,
    Object? seqctrl = freezed,
    Object? idOld = freezed,
    Object? quantity = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? dgFlag = freezed,
  }) {
    return _then(
      _value.copyWith(
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
            serialNumber: freezed == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            seqctrl: freezed == seqctrl
                ? _value.seqctrl
                : seqctrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            idOld: freezed == idOld
                ? _value.idOld
                : idOld // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: freezed == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double?,
            productionDate: freezed == productionDate
                ? _value.productionDate
                : productionDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            validDays: freezed == validDays
                ? _value.validDays
                : validDays // ignore: cast_nullable_to_non_nullable
                      as String?,
            dgFlag: freezed == dgFlag
                ? _value.dgFlag
                : dgFlag // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpBarcodeContentImplCopyWith<$Res>
    implements $UpBarcodeContentCopyWith<$Res> {
  factory _$$UpBarcodeContentImplCopyWith(
    _$UpBarcodeContentImpl value,
    $Res Function(_$UpBarcodeContentImpl) then,
  ) = __$$UpBarcodeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') @HiveField(0) String? materialCode,
    @JsonKey(name: 'matname') @HiveField(1) String? materialName,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNumber,
    @JsonKey(name: 'seqctrl') @HiveField(4) String? seqctrl,
    @JsonKey(name: 'idOld') @HiveField(5) String? idOld,
    @JsonKey(name: 'qty') @HiveField(6) double? quantity,
    @JsonKey(name: 'pdate') @HiveField(7) String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(8) String? validDays,
    @JsonKey(name: 'dgFlg') @HiveField(9) String? dgFlag,
  });
}

/// @nodoc
class __$$UpBarcodeContentImplCopyWithImpl<$Res>
    extends _$UpBarcodeContentCopyWithImpl<$Res, _$UpBarcodeContentImpl>
    implements _$$UpBarcodeContentImplCopyWith<$Res> {
  __$$UpBarcodeContentImplCopyWithImpl(
    _$UpBarcodeContentImpl _value,
    $Res Function(_$UpBarcodeContentImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = freezed,
    Object? materialName = freezed,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? seqctrl = freezed,
    Object? idOld = freezed,
    Object? quantity = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? dgFlag = freezed,
  }) {
    return _then(
      _$UpBarcodeContentImpl(
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
        serialNumber: freezed == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        seqctrl: freezed == seqctrl
            ? _value.seqctrl
            : seqctrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        idOld: freezed == idOld
            ? _value.idOld
            : idOld // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: freezed == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double?,
        productionDate: freezed == productionDate
            ? _value.productionDate
            : productionDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        validDays: freezed == validDays
            ? _value.validDays
            : validDays // ignore: cast_nullable_to_non_nullable
                  as String?,
        dgFlag: freezed == dgFlag
            ? _value.dgFlag
            : dgFlag // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpBarcodeContentImpl extends _UpBarcodeContent {
  _$UpBarcodeContentImpl({
    @JsonKey(name: 'matcode') @HiveField(0) this.materialCode,
    @JsonKey(name: 'matname') @HiveField(1) this.materialName,
    @JsonKey(name: 'batchno') @HiveField(2) this.batchNo,
    @JsonKey(name: 'sn') @HiveField(3) this.serialNumber,
    @JsonKey(name: 'seqctrl') @HiveField(4) this.seqctrl,
    @JsonKey(name: 'idOld') @HiveField(5) this.idOld,
    @JsonKey(name: 'qty') @HiveField(6) this.quantity,
    @JsonKey(name: 'pdate') @HiveField(7) this.productionDate,
    @JsonKey(name: 'vdays') @HiveField(8) this.validDays,
    @JsonKey(name: 'dgFlg') @HiveField(9) this.dgFlag,
  }) : super._();

  factory _$UpBarcodeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpBarcodeContentImplFromJson(json);

  @override
  @JsonKey(name: 'matcode')
  @HiveField(0)
  final String? materialCode;
  @override
  @JsonKey(name: 'matname')
  @HiveField(1)
  final String? materialName;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(2)
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(3)
  final String? serialNumber;
  @override
  @JsonKey(name: 'seqctrl')
  @HiveField(4)
  final String? seqctrl;
  @override
  @JsonKey(name: 'idOld')
  @HiveField(5)
  final String? idOld;
  @override
  @JsonKey(name: 'qty')
  @HiveField(6)
  final double? quantity;
  @override
  @JsonKey(name: 'pdate')
  @HiveField(7)
  final String? productionDate;
  @override
  @JsonKey(name: 'vdays')
  @HiveField(8)
  final String? validDays;
  @override
  @JsonKey(name: 'dgFlg')
  @HiveField(9)
  final String? dgFlag;

  @override
  String toString() {
    return 'UpBarcodeContent(materialCode: $materialCode, materialName: $materialName, batchNo: $batchNo, serialNumber: $serialNumber, seqctrl: $seqctrl, idOld: $idOld, quantity: $quantity, productionDate: $productionDate, validDays: $validDays, dgFlag: $dgFlag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpBarcodeContentImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.seqctrl, seqctrl) || other.seqctrl == seqctrl) &&
            (identical(other.idOld, idOld) || other.idOld == idOld) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays) &&
            (identical(other.dgFlag, dgFlag) || other.dgFlag == dgFlag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    materialCode,
    materialName,
    batchNo,
    serialNumber,
    seqctrl,
    idOld,
    quantity,
    productionDate,
    validDays,
    dgFlag,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpBarcodeContentImplCopyWith<_$UpBarcodeContentImpl> get copyWith =>
      __$$UpBarcodeContentImplCopyWithImpl<_$UpBarcodeContentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpBarcodeContentImplToJson(this);
  }
}

abstract class _UpBarcodeContent extends UpBarcodeContent {
  factory _UpBarcodeContent({
    @JsonKey(name: 'matcode') @HiveField(0) final String? materialCode,
    @JsonKey(name: 'matname') @HiveField(1) final String? materialName,
    @JsonKey(name: 'batchno') @HiveField(2) final String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) final String? serialNumber,
    @JsonKey(name: 'seqctrl') @HiveField(4) final String? seqctrl,
    @JsonKey(name: 'idOld') @HiveField(5) final String? idOld,
    @JsonKey(name: 'qty') @HiveField(6) final double? quantity,
    @JsonKey(name: 'pdate') @HiveField(7) final String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(8) final String? validDays,
    @JsonKey(name: 'dgFlg') @HiveField(9) final String? dgFlag,
  }) = _$UpBarcodeContentImpl;
  _UpBarcodeContent._() : super._();

  factory _UpBarcodeContent.fromJson(Map<String, dynamic> json) =
      _$UpBarcodeContentImpl.fromJson;

  @override
  @JsonKey(name: 'matcode')
  @HiveField(0)
  String? get materialCode;
  @override
  @JsonKey(name: 'matname')
  @HiveField(1)
  String? get materialName;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(2)
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(3)
  String? get serialNumber;
  @override
  @JsonKey(name: 'seqctrl')
  @HiveField(4)
  String? get seqctrl;
  @override
  @JsonKey(name: 'idOld')
  @HiveField(5)
  String? get idOld;
  @override
  @JsonKey(name: 'qty')
  @HiveField(6)
  double? get quantity;
  @override
  @JsonKey(name: 'pdate')
  @HiveField(7)
  String? get productionDate;
  @override
  @JsonKey(name: 'vdays')
  @HiveField(8)
  String? get validDays;
  @override
  @JsonKey(name: 'dgFlg')
  @HiveField(9)
  String? get dgFlag;
  @override
  @JsonKey(ignore: true)
  _$$UpBarcodeContentImplCopyWith<_$UpBarcodeContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpCollectionStock _$UpCollectionStockFromJson(Map<String, dynamic> json) {
  return _UpCollectionStock.fromJson(json);
}

/// @nodoc
mixin _$UpCollectionStock {
  @JsonKey(name: 'stockid')
  @HiveField(0)
  String get stockId => throw _privateConstructorUsedError;
  @JsonKey(name: 'matcode')
  @HiveField(1)
  String get materialCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  @HiveField(2)
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  @HiveField(3)
  String? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskQty')
  @HiveField(4)
  double? get taskQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'collectQty')
  @HiveField(5)
  double? get collectedQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskNo')
  @HiveField(6)
  String? get taskNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'taskid')
  @HiveField(7)
  String? get taskId => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeRoom')
  @HiveField(8)
  String? get storeRoom => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeSite')
  @HiveField(9)
  String? get storeSite => throw _privateConstructorUsedError;
  @JsonKey(name: 'pdate')
  @HiveField(10)
  String? get productionDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vdays')
  @HiveField(11)
  String? get validDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'erpStore')
  @HiveField(12)
  String? get erpStore => throw _privateConstructorUsedError;
  @JsonKey(name: 'trayNo')
  @HiveField(13)
  String? get trayNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpCollectionStockCopyWith<UpCollectionStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpCollectionStockCopyWith<$Res> {
  factory $UpCollectionStockCopyWith(
    UpCollectionStock value,
    $Res Function(UpCollectionStock) then,
  ) = _$UpCollectionStockCopyWithImpl<$Res, UpCollectionStock>;
  @useResult
  $Res call({
    @JsonKey(name: 'stockid') @HiveField(0) String stockId,
    @JsonKey(name: 'matcode') @HiveField(1) String materialCode,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNumber,
    @JsonKey(name: 'taskQty') @HiveField(4) double? taskQuantity,
    @JsonKey(name: 'collectQty') @HiveField(5) double? collectedQuantity,
    @JsonKey(name: 'taskNo') @HiveField(6) String? taskNo,
    @JsonKey(name: 'taskid') @HiveField(7) String? taskId,
    @JsonKey(name: 'storeRoom') @HiveField(8) String? storeRoom,
    @JsonKey(name: 'storeSite') @HiveField(9) String? storeSite,
    @JsonKey(name: 'pdate') @HiveField(10) String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(11) String? validDays,
    @JsonKey(name: 'erpStore') @HiveField(12) String? erpStore,
    @JsonKey(name: 'trayNo') @HiveField(13) String? trayNo,
  });
}

/// @nodoc
class _$UpCollectionStockCopyWithImpl<$Res, $Val extends UpCollectionStock>
    implements $UpCollectionStockCopyWith<$Res> {
  _$UpCollectionStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? materialCode = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? taskQuantity = freezed,
    Object? collectedQuantity = freezed,
    Object? taskNo = freezed,
    Object? taskId = freezed,
    Object? storeRoom = freezed,
    Object? storeSite = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? erpStore = freezed,
    Object? trayNo = freezed,
  }) {
    return _then(
      _value.copyWith(
            stockId: null == stockId
                ? _value.stockId
                : stockId // ignore: cast_nullable_to_non_nullable
                      as String,
            materialCode: null == materialCode
                ? _value.materialCode
                : materialCode // ignore: cast_nullable_to_non_nullable
                      as String,
            batchNo: freezed == batchNo
                ? _value.batchNo
                : batchNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            serialNumber: freezed == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            taskQuantity: freezed == taskQuantity
                ? _value.taskQuantity
                : taskQuantity // ignore: cast_nullable_to_non_nullable
                      as double?,
            collectedQuantity: freezed == collectedQuantity
                ? _value.collectedQuantity
                : collectedQuantity // ignore: cast_nullable_to_non_nullable
                      as double?,
            taskNo: freezed == taskNo
                ? _value.taskNo
                : taskNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            taskId: freezed == taskId
                ? _value.taskId
                : taskId // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeRoom: freezed == storeRoom
                ? _value.storeRoom
                : storeRoom // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeSite: freezed == storeSite
                ? _value.storeSite
                : storeSite // ignore: cast_nullable_to_non_nullable
                      as String?,
            productionDate: freezed == productionDate
                ? _value.productionDate
                : productionDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            validDays: freezed == validDays
                ? _value.validDays
                : validDays // ignore: cast_nullable_to_non_nullable
                      as String?,
            erpStore: freezed == erpStore
                ? _value.erpStore
                : erpStore // ignore: cast_nullable_to_non_nullable
                      as String?,
            trayNo: freezed == trayNo
                ? _value.trayNo
                : trayNo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpCollectionStockImplCopyWith<$Res>
    implements $UpCollectionStockCopyWith<$Res> {
  factory _$$UpCollectionStockImplCopyWith(
    _$UpCollectionStockImpl value,
    $Res Function(_$UpCollectionStockImpl) then,
  ) = __$$UpCollectionStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'stockid') @HiveField(0) String stockId,
    @JsonKey(name: 'matcode') @HiveField(1) String materialCode,
    @JsonKey(name: 'batchno') @HiveField(2) String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) String? serialNumber,
    @JsonKey(name: 'taskQty') @HiveField(4) double? taskQuantity,
    @JsonKey(name: 'collectQty') @HiveField(5) double? collectedQuantity,
    @JsonKey(name: 'taskNo') @HiveField(6) String? taskNo,
    @JsonKey(name: 'taskid') @HiveField(7) String? taskId,
    @JsonKey(name: 'storeRoom') @HiveField(8) String? storeRoom,
    @JsonKey(name: 'storeSite') @HiveField(9) String? storeSite,
    @JsonKey(name: 'pdate') @HiveField(10) String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(11) String? validDays,
    @JsonKey(name: 'erpStore') @HiveField(12) String? erpStore,
    @JsonKey(name: 'trayNo') @HiveField(13) String? trayNo,
  });
}

/// @nodoc
class __$$UpCollectionStockImplCopyWithImpl<$Res>
    extends _$UpCollectionStockCopyWithImpl<$Res, _$UpCollectionStockImpl>
    implements _$$UpCollectionStockImplCopyWith<$Res> {
  __$$UpCollectionStockImplCopyWithImpl(
    _$UpCollectionStockImpl _value,
    $Res Function(_$UpCollectionStockImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = null,
    Object? materialCode = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? taskQuantity = freezed,
    Object? collectedQuantity = freezed,
    Object? taskNo = freezed,
    Object? taskId = freezed,
    Object? storeRoom = freezed,
    Object? storeSite = freezed,
    Object? productionDate = freezed,
    Object? validDays = freezed,
    Object? erpStore = freezed,
    Object? trayNo = freezed,
  }) {
    return _then(
      _$UpCollectionStockImpl(
        stockId: null == stockId
            ? _value.stockId
            : stockId // ignore: cast_nullable_to_non_nullable
                  as String,
        materialCode: null == materialCode
            ? _value.materialCode
            : materialCode // ignore: cast_nullable_to_non_nullable
                  as String,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        serialNumber: freezed == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        taskQuantity: freezed == taskQuantity
            ? _value.taskQuantity
            : taskQuantity // ignore: cast_nullable_to_non_nullable
                  as double?,
        collectedQuantity: freezed == collectedQuantity
            ? _value.collectedQuantity
            : collectedQuantity // ignore: cast_nullable_to_non_nullable
                  as double?,
        taskNo: freezed == taskNo
            ? _value.taskNo
            : taskNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        taskId: freezed == taskId
            ? _value.taskId
            : taskId // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeRoom: freezed == storeRoom
            ? _value.storeRoom
            : storeRoom // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeSite: freezed == storeSite
            ? _value.storeSite
            : storeSite // ignore: cast_nullable_to_non_nullable
                  as String?,
        productionDate: freezed == productionDate
            ? _value.productionDate
            : productionDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        validDays: freezed == validDays
            ? _value.validDays
            : validDays // ignore: cast_nullable_to_non_nullable
                  as String?,
        erpStore: freezed == erpStore
            ? _value.erpStore
            : erpStore // ignore: cast_nullable_to_non_nullable
                  as String?,
        trayNo: freezed == trayNo
            ? _value.trayNo
            : trayNo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpCollectionStockImpl extends _UpCollectionStock {
  _$UpCollectionStockImpl({
    @JsonKey(name: 'stockid') @HiveField(0) required this.stockId,
    @JsonKey(name: 'matcode') @HiveField(1) required this.materialCode,
    @JsonKey(name: 'batchno') @HiveField(2) this.batchNo,
    @JsonKey(name: 'sn') @HiveField(3) this.serialNumber,
    @JsonKey(name: 'taskQty') @HiveField(4) this.taskQuantity,
    @JsonKey(name: 'collectQty') @HiveField(5) this.collectedQuantity,
    @JsonKey(name: 'taskNo') @HiveField(6) this.taskNo,
    @JsonKey(name: 'taskid') @HiveField(7) this.taskId,
    @JsonKey(name: 'storeRoom') @HiveField(8) this.storeRoom,
    @JsonKey(name: 'storeSite') @HiveField(9) this.storeSite,
    @JsonKey(name: 'pdate') @HiveField(10) this.productionDate,
    @JsonKey(name: 'vdays') @HiveField(11) this.validDays,
    @JsonKey(name: 'erpStore') @HiveField(12) this.erpStore,
    @JsonKey(name: 'trayNo') @HiveField(13) this.trayNo,
  }) : super._();

  factory _$UpCollectionStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpCollectionStockImplFromJson(json);

  @override
  @JsonKey(name: 'stockid')
  @HiveField(0)
  final String stockId;
  @override
  @JsonKey(name: 'matcode')
  @HiveField(1)
  final String materialCode;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(2)
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(3)
  final String? serialNumber;
  @override
  @JsonKey(name: 'taskQty')
  @HiveField(4)
  final double? taskQuantity;
  @override
  @JsonKey(name: 'collectQty')
  @HiveField(5)
  final double? collectedQuantity;
  @override
  @JsonKey(name: 'taskNo')
  @HiveField(6)
  final String? taskNo;
  @override
  @JsonKey(name: 'taskid')
  @HiveField(7)
  final String? taskId;
  @override
  @JsonKey(name: 'storeRoom')
  @HiveField(8)
  final String? storeRoom;
  @override
  @JsonKey(name: 'storeSite')
  @HiveField(9)
  final String? storeSite;
  @override
  @JsonKey(name: 'pdate')
  @HiveField(10)
  final String? productionDate;
  @override
  @JsonKey(name: 'vdays')
  @HiveField(11)
  final String? validDays;
  @override
  @JsonKey(name: 'erpStore')
  @HiveField(12)
  final String? erpStore;
  @override
  @JsonKey(name: 'trayNo')
  @HiveField(13)
  final String? trayNo;

  @override
  String toString() {
    return 'UpCollectionStock(stockId: $stockId, materialCode: $materialCode, batchNo: $batchNo, serialNumber: $serialNumber, taskQuantity: $taskQuantity, collectedQuantity: $collectedQuantity, taskNo: $taskNo, taskId: $taskId, storeRoom: $storeRoom, storeSite: $storeSite, productionDate: $productionDate, validDays: $validDays, erpStore: $erpStore, trayNo: $trayNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpCollectionStockImpl &&
            (identical(other.stockId, stockId) || other.stockId == stockId) &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.taskQuantity, taskQuantity) ||
                other.taskQuantity == taskQuantity) &&
            (identical(other.collectedQuantity, collectedQuantity) ||
                other.collectedQuantity == collectedQuantity) &&
            (identical(other.taskNo, taskNo) || other.taskNo == taskNo) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.productionDate, productionDate) ||
                other.productionDate == productionDate) &&
            (identical(other.validDays, validDays) ||
                other.validDays == validDays) &&
            (identical(other.erpStore, erpStore) ||
                other.erpStore == erpStore) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    stockId,
    materialCode,
    batchNo,
    serialNumber,
    taskQuantity,
    collectedQuantity,
    taskNo,
    taskId,
    storeRoom,
    storeSite,
    productionDate,
    validDays,
    erpStore,
    trayNo,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpCollectionStockImplCopyWith<_$UpCollectionStockImpl> get copyWith =>
      __$$UpCollectionStockImplCopyWithImpl<_$UpCollectionStockImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpCollectionStockImplToJson(this);
  }
}

abstract class _UpCollectionStock extends UpCollectionStock {
  factory _UpCollectionStock({
    @JsonKey(name: 'stockid') @HiveField(0) required final String stockId,
    @JsonKey(name: 'matcode') @HiveField(1) required final String materialCode,
    @JsonKey(name: 'batchno') @HiveField(2) final String? batchNo,
    @JsonKey(name: 'sn') @HiveField(3) final String? serialNumber,
    @JsonKey(name: 'taskQty') @HiveField(4) final double? taskQuantity,
    @JsonKey(name: 'collectQty') @HiveField(5) final double? collectedQuantity,
    @JsonKey(name: 'taskNo') @HiveField(6) final String? taskNo,
    @JsonKey(name: 'taskid') @HiveField(7) final String? taskId,
    @JsonKey(name: 'storeRoom') @HiveField(8) final String? storeRoom,
    @JsonKey(name: 'storeSite') @HiveField(9) final String? storeSite,
    @JsonKey(name: 'pdate') @HiveField(10) final String? productionDate,
    @JsonKey(name: 'vdays') @HiveField(11) final String? validDays,
    @JsonKey(name: 'erpStore') @HiveField(12) final String? erpStore,
    @JsonKey(name: 'trayNo') @HiveField(13) final String? trayNo,
  }) = _$UpCollectionStockImpl;
  _UpCollectionStock._() : super._();

  factory _UpCollectionStock.fromJson(Map<String, dynamic> json) =
      _$UpCollectionStockImpl.fromJson;

  @override
  @JsonKey(name: 'stockid')
  @HiveField(0)
  String get stockId;
  @override
  @JsonKey(name: 'matcode')
  @HiveField(1)
  String get materialCode;
  @override
  @JsonKey(name: 'batchno')
  @HiveField(2)
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  @HiveField(3)
  String? get serialNumber;
  @override
  @JsonKey(name: 'taskQty')
  @HiveField(4)
  double? get taskQuantity;
  @override
  @JsonKey(name: 'collectQty')
  @HiveField(5)
  double? get collectedQuantity;
  @override
  @JsonKey(name: 'taskNo')
  @HiveField(6)
  String? get taskNo;
  @override
  @JsonKey(name: 'taskid')
  @HiveField(7)
  String? get taskId;
  @override
  @JsonKey(name: 'storeRoom')
  @HiveField(8)
  String? get storeRoom;
  @override
  @JsonKey(name: 'storeSite')
  @HiveField(9)
  String? get storeSite;
  @override
  @JsonKey(name: 'pdate')
  @HiveField(10)
  String? get productionDate;
  @override
  @JsonKey(name: 'vdays')
  @HiveField(11)
  String? get validDays;
  @override
  @JsonKey(name: 'erpStore')
  @HiveField(12)
  String? get erpStore;
  @override
  @JsonKey(name: 'trayNo')
  @HiveField(13)
  String? get trayNo;
  @override
  @JsonKey(ignore: true)
  _$$UpCollectionStockImplCopyWith<_$UpCollectionStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
