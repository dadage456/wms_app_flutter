// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outbound_collect_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CollectRecord _$CollectRecordFromJson(Map<String, dynamic> json) {
  return _CollectRecord.fromJson(json);
}

/// @nodoc
mixin _$CollectRecord {
  /// 物料编码
  @JsonKey(name: 'matcode')
  String get matCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matname')
  String get matName => throw _privateConstructorUsedError;

  /// 库位编号
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo => throw _privateConstructorUsedError;

  /// 采集数量
  @JsonKey(name: 'qty')
  int get qty => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get sn => throw _privateConstructorUsedError;

  /// 生产日期
  @JsonKey(name: 'pdate')
  String? get pdate => throw _privateConstructorUsedError;

  /// 保质期
  @JsonKey(name: 'vdays')
  String? get vdays => throw _privateConstructorUsedError;

  /// 控制方式
  @JsonKey(name: 'seqctrl')
  String? get seqCtrl => throw _privateConstructorUsedError;

  /// 编码方式
  @JsonKey(name: 'id_old')
  String? get idOld => throw _privateConstructorUsedError;

  /// 任务明细ID
  @JsonKey(name: 'outtaskitemid')
  int? get outTaskItemId => throw _privateConstructorUsedError;

  /// 采集时间
  @JsonKey(name: 'collecttime')
  String? get collectTime => throw _privateConstructorUsedError;

  /// Serializes this CollectRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectRecordCopyWith<CollectRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectRecordCopyWith<$Res> {
  factory $CollectRecordCopyWith(
    CollectRecord value,
    $Res Function(CollectRecord) then,
  ) = _$CollectRecordCopyWithImpl<$Res, CollectRecord>;
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') String matCode,
    @JsonKey(name: 'matname') String matName,
    @JsonKey(name: 'storesiteno') String storeSiteNo,
    @JsonKey(name: 'qty') int qty,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? sn,
    @JsonKey(name: 'pdate') String? pdate,
    @JsonKey(name: 'vdays') String? vdays,
    @JsonKey(name: 'seqctrl') String? seqCtrl,
    @JsonKey(name: 'id_old') String? idOld,
    @JsonKey(name: 'outtaskitemid') int? outTaskItemId,
    @JsonKey(name: 'collecttime') String? collectTime,
  });
}

/// @nodoc
class _$CollectRecordCopyWithImpl<$Res, $Val extends CollectRecord>
    implements $CollectRecordCopyWith<$Res> {
  _$CollectRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? matName = null,
    Object? storeSiteNo = null,
    Object? qty = null,
    Object? batchNo = freezed,
    Object? sn = freezed,
    Object? pdate = freezed,
    Object? vdays = freezed,
    Object? seqCtrl = freezed,
    Object? idOld = freezed,
    Object? outTaskItemId = freezed,
    Object? collectTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            matCode: null == matCode
                ? _value.matCode
                : matCode // ignore: cast_nullable_to_non_nullable
                      as String,
            matName: null == matName
                ? _value.matName
                : matName // ignore: cast_nullable_to_non_nullable
                      as String,
            storeSiteNo: null == storeSiteNo
                ? _value.storeSiteNo
                : storeSiteNo // ignore: cast_nullable_to_non_nullable
                      as String,
            qty: null == qty
                ? _value.qty
                : qty // ignore: cast_nullable_to_non_nullable
                      as int,
            batchNo: freezed == batchNo
                ? _value.batchNo
                : batchNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            sn: freezed == sn
                ? _value.sn
                : sn // ignore: cast_nullable_to_non_nullable
                      as String?,
            pdate: freezed == pdate
                ? _value.pdate
                : pdate // ignore: cast_nullable_to_non_nullable
                      as String?,
            vdays: freezed == vdays
                ? _value.vdays
                : vdays // ignore: cast_nullable_to_non_nullable
                      as String?,
            seqCtrl: freezed == seqCtrl
                ? _value.seqCtrl
                : seqCtrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            idOld: freezed == idOld
                ? _value.idOld
                : idOld // ignore: cast_nullable_to_non_nullable
                      as String?,
            outTaskItemId: freezed == outTaskItemId
                ? _value.outTaskItemId
                : outTaskItemId // ignore: cast_nullable_to_non_nullable
                      as int?,
            collectTime: freezed == collectTime
                ? _value.collectTime
                : collectTime // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CollectRecordImplCopyWith<$Res>
    implements $CollectRecordCopyWith<$Res> {
  factory _$$CollectRecordImplCopyWith(
    _$CollectRecordImpl value,
    $Res Function(_$CollectRecordImpl) then,
  ) = __$$CollectRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') String matCode,
    @JsonKey(name: 'matname') String matName,
    @JsonKey(name: 'storesiteno') String storeSiteNo,
    @JsonKey(name: 'qty') int qty,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? sn,
    @JsonKey(name: 'pdate') String? pdate,
    @JsonKey(name: 'vdays') String? vdays,
    @JsonKey(name: 'seqctrl') String? seqCtrl,
    @JsonKey(name: 'id_old') String? idOld,
    @JsonKey(name: 'outtaskitemid') int? outTaskItemId,
    @JsonKey(name: 'collecttime') String? collectTime,
  });
}

/// @nodoc
class __$$CollectRecordImplCopyWithImpl<$Res>
    extends _$CollectRecordCopyWithImpl<$Res, _$CollectRecordImpl>
    implements _$$CollectRecordImplCopyWith<$Res> {
  __$$CollectRecordImplCopyWithImpl(
    _$CollectRecordImpl _value,
    $Res Function(_$CollectRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CollectRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? matName = null,
    Object? storeSiteNo = null,
    Object? qty = null,
    Object? batchNo = freezed,
    Object? sn = freezed,
    Object? pdate = freezed,
    Object? vdays = freezed,
    Object? seqCtrl = freezed,
    Object? idOld = freezed,
    Object? outTaskItemId = freezed,
    Object? collectTime = freezed,
  }) {
    return _then(
      _$CollectRecordImpl(
        matCode: null == matCode
            ? _value.matCode
            : matCode // ignore: cast_nullable_to_non_nullable
                  as String,
        matName: null == matName
            ? _value.matName
            : matName // ignore: cast_nullable_to_non_nullable
                  as String,
        storeSiteNo: null == storeSiteNo
            ? _value.storeSiteNo
            : storeSiteNo // ignore: cast_nullable_to_non_nullable
                  as String,
        qty: null == qty
            ? _value.qty
            : qty // ignore: cast_nullable_to_non_nullable
                  as int,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        sn: freezed == sn
            ? _value.sn
            : sn // ignore: cast_nullable_to_non_nullable
                  as String?,
        pdate: freezed == pdate
            ? _value.pdate
            : pdate // ignore: cast_nullable_to_non_nullable
                  as String?,
        vdays: freezed == vdays
            ? _value.vdays
            : vdays // ignore: cast_nullable_to_non_nullable
                  as String?,
        seqCtrl: freezed == seqCtrl
            ? _value.seqCtrl
            : seqCtrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        idOld: freezed == idOld
            ? _value.idOld
            : idOld // ignore: cast_nullable_to_non_nullable
                  as String?,
        outTaskItemId: freezed == outTaskItemId
            ? _value.outTaskItemId
            : outTaskItemId // ignore: cast_nullable_to_non_nullable
                  as int?,
        collectTime: freezed == collectTime
            ? _value.collectTime
            : collectTime // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectRecordImpl implements _CollectRecord {
  const _$CollectRecordImpl({
    @JsonKey(name: 'matcode') required this.matCode,
    @JsonKey(name: 'matname') required this.matName,
    @JsonKey(name: 'storesiteno') required this.storeSiteNo,
    @JsonKey(name: 'qty') required this.qty,
    @JsonKey(name: 'batchno') this.batchNo,
    @JsonKey(name: 'sn') this.sn,
    @JsonKey(name: 'pdate') this.pdate,
    @JsonKey(name: 'vdays') this.vdays,
    @JsonKey(name: 'seqctrl') this.seqCtrl,
    @JsonKey(name: 'id_old') this.idOld,
    @JsonKey(name: 'outtaskitemid') this.outTaskItemId,
    @JsonKey(name: 'collecttime') this.collectTime,
  });

  factory _$CollectRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectRecordImplFromJson(json);

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String matCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  final String matName;

  /// 库位编号
  @override
  @JsonKey(name: 'storesiteno')
  final String storeSiteNo;

  /// 采集数量
  @override
  @JsonKey(name: 'qty')
  final int qty;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? sn;

  /// 生产日期
  @override
  @JsonKey(name: 'pdate')
  final String? pdate;

  /// 保质期
  @override
  @JsonKey(name: 'vdays')
  final String? vdays;

  /// 控制方式
  @override
  @JsonKey(name: 'seqctrl')
  final String? seqCtrl;

  /// 编码方式
  @override
  @JsonKey(name: 'id_old')
  final String? idOld;

  /// 任务明细ID
  @override
  @JsonKey(name: 'outtaskitemid')
  final int? outTaskItemId;

  /// 采集时间
  @override
  @JsonKey(name: 'collecttime')
  final String? collectTime;

  @override
  String toString() {
    return 'CollectRecord(matCode: $matCode, matName: $matName, storeSiteNo: $storeSiteNo, qty: $qty, batchNo: $batchNo, sn: $sn, pdate: $pdate, vdays: $vdays, seqCtrl: $seqCtrl, idOld: $idOld, outTaskItemId: $outTaskItemId, collectTime: $collectTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectRecordImpl &&
            (identical(other.matCode, matCode) || other.matCode == matCode) &&
            (identical(other.matName, matName) || other.matName == matName) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.pdate, pdate) || other.pdate == pdate) &&
            (identical(other.vdays, vdays) || other.vdays == vdays) &&
            (identical(other.seqCtrl, seqCtrl) || other.seqCtrl == seqCtrl) &&
            (identical(other.idOld, idOld) || other.idOld == idOld) &&
            (identical(other.outTaskItemId, outTaskItemId) ||
                other.outTaskItemId == outTaskItemId) &&
            (identical(other.collectTime, collectTime) ||
                other.collectTime == collectTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    matCode,
    matName,
    storeSiteNo,
    qty,
    batchNo,
    sn,
    pdate,
    vdays,
    seqCtrl,
    idOld,
    outTaskItemId,
    collectTime,
  );

  /// Create a copy of CollectRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectRecordImplCopyWith<_$CollectRecordImpl> get copyWith =>
      __$$CollectRecordImplCopyWithImpl<_$CollectRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectRecordImplToJson(this);
  }
}

abstract class _CollectRecord implements CollectRecord {
  const factory _CollectRecord({
    @JsonKey(name: 'matcode') required final String matCode,
    @JsonKey(name: 'matname') required final String matName,
    @JsonKey(name: 'storesiteno') required final String storeSiteNo,
    @JsonKey(name: 'qty') required final int qty,
    @JsonKey(name: 'batchno') final String? batchNo,
    @JsonKey(name: 'sn') final String? sn,
    @JsonKey(name: 'pdate') final String? pdate,
    @JsonKey(name: 'vdays') final String? vdays,
    @JsonKey(name: 'seqctrl') final String? seqCtrl,
    @JsonKey(name: 'id_old') final String? idOld,
    @JsonKey(name: 'outtaskitemid') final int? outTaskItemId,
    @JsonKey(name: 'collecttime') final String? collectTime,
  }) = _$CollectRecordImpl;

  factory _CollectRecord.fromJson(Map<String, dynamic> json) =
      _$CollectRecordImpl.fromJson;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  String get matCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  String get matName;

  /// 库位编号
  @override
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo;

  /// 采集数量
  @override
  @JsonKey(name: 'qty')
  int get qty;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  String? get sn;

  /// 生产日期
  @override
  @JsonKey(name: 'pdate')
  String? get pdate;

  /// 保质期
  @override
  @JsonKey(name: 'vdays')
  String? get vdays;

  /// 控制方式
  @override
  @JsonKey(name: 'seqctrl')
  String? get seqCtrl;

  /// 编码方式
  @override
  @JsonKey(name: 'id_old')
  String? get idOld;

  /// 任务明细ID
  @override
  @JsonKey(name: 'outtaskitemid')
  int? get outTaskItemId;

  /// 采集时间
  @override
  @JsonKey(name: 'collecttime')
  String? get collectTime;

  /// Create a copy of CollectRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectRecordImplCopyWith<_$CollectRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryInfo _$InventoryInfoFromJson(Map<String, dynamic> json) {
  return _InventoryInfo.fromJson(json);
}

/// @nodoc
mixin _$InventoryInfo {
  /// 物料编码
  @JsonKey(name: 'matcode')
  String get matCode => throw _privateConstructorUsedError;

  /// 物料名称
  @JsonKey(name: 'matname')
  String get matName => throw _privateConstructorUsedError;

  /// 库位编号
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo => throw _privateConstructorUsedError;

  /// 库存数量
  @JsonKey(name: 'qty')
  int get qty => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get sn => throw _privateConstructorUsedError;

  /// 库房编号
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo => throw _privateConstructorUsedError;

  /// 子库编码
  @JsonKey(name: 'subinventorycode')
  String? get subInventoryCode => throw _privateConstructorUsedError;

  /// Serializes this InventoryInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryInfoCopyWith<InventoryInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryInfoCopyWith<$Res> {
  factory $InventoryInfoCopyWith(
    InventoryInfo value,
    $Res Function(InventoryInfo) then,
  ) = _$InventoryInfoCopyWithImpl<$Res, InventoryInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') String matCode,
    @JsonKey(name: 'matname') String matName,
    @JsonKey(name: 'storesiteno') String storeSiteNo,
    @JsonKey(name: 'qty') int qty,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? sn,
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    @JsonKey(name: 'subinventorycode') String? subInventoryCode,
  });
}

/// @nodoc
class _$InventoryInfoCopyWithImpl<$Res, $Val extends InventoryInfo>
    implements $InventoryInfoCopyWith<$Res> {
  _$InventoryInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? matName = null,
    Object? storeSiteNo = null,
    Object? qty = null,
    Object? batchNo = freezed,
    Object? sn = freezed,
    Object? storeRoomNo = freezed,
    Object? subInventoryCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            matCode: null == matCode
                ? _value.matCode
                : matCode // ignore: cast_nullable_to_non_nullable
                      as String,
            matName: null == matName
                ? _value.matName
                : matName // ignore: cast_nullable_to_non_nullable
                      as String,
            storeSiteNo: null == storeSiteNo
                ? _value.storeSiteNo
                : storeSiteNo // ignore: cast_nullable_to_non_nullable
                      as String,
            qty: null == qty
                ? _value.qty
                : qty // ignore: cast_nullable_to_non_nullable
                      as int,
            batchNo: freezed == batchNo
                ? _value.batchNo
                : batchNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            sn: freezed == sn
                ? _value.sn
                : sn // ignore: cast_nullable_to_non_nullable
                      as String?,
            storeRoomNo: freezed == storeRoomNo
                ? _value.storeRoomNo
                : storeRoomNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            subInventoryCode: freezed == subInventoryCode
                ? _value.subInventoryCode
                : subInventoryCode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryInfoImplCopyWith<$Res>
    implements $InventoryInfoCopyWith<$Res> {
  factory _$$InventoryInfoImplCopyWith(
    _$InventoryInfoImpl value,
    $Res Function(_$InventoryInfoImpl) then,
  ) = __$$InventoryInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') String matCode,
    @JsonKey(name: 'matname') String matName,
    @JsonKey(name: 'storesiteno') String storeSiteNo,
    @JsonKey(name: 'qty') int qty,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? sn,
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    @JsonKey(name: 'subinventorycode') String? subInventoryCode,
  });
}

/// @nodoc
class __$$InventoryInfoImplCopyWithImpl<$Res>
    extends _$InventoryInfoCopyWithImpl<$Res, _$InventoryInfoImpl>
    implements _$$InventoryInfoImplCopyWith<$Res> {
  __$$InventoryInfoImplCopyWithImpl(
    _$InventoryInfoImpl _value,
    $Res Function(_$InventoryInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? matName = null,
    Object? storeSiteNo = null,
    Object? qty = null,
    Object? batchNo = freezed,
    Object? sn = freezed,
    Object? storeRoomNo = freezed,
    Object? subInventoryCode = freezed,
  }) {
    return _then(
      _$InventoryInfoImpl(
        matCode: null == matCode
            ? _value.matCode
            : matCode // ignore: cast_nullable_to_non_nullable
                  as String,
        matName: null == matName
            ? _value.matName
            : matName // ignore: cast_nullable_to_non_nullable
                  as String,
        storeSiteNo: null == storeSiteNo
            ? _value.storeSiteNo
            : storeSiteNo // ignore: cast_nullable_to_non_nullable
                  as String,
        qty: null == qty
            ? _value.qty
            : qty // ignore: cast_nullable_to_non_nullable
                  as int,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        sn: freezed == sn
            ? _value.sn
            : sn // ignore: cast_nullable_to_non_nullable
                  as String?,
        storeRoomNo: freezed == storeRoomNo
            ? _value.storeRoomNo
            : storeRoomNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        subInventoryCode: freezed == subInventoryCode
            ? _value.subInventoryCode
            : subInventoryCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryInfoImpl implements _InventoryInfo {
  const _$InventoryInfoImpl({
    @JsonKey(name: 'matcode') required this.matCode,
    @JsonKey(name: 'matname') required this.matName,
    @JsonKey(name: 'storesiteno') required this.storeSiteNo,
    @JsonKey(name: 'qty') required this.qty,
    @JsonKey(name: 'batchno') this.batchNo,
    @JsonKey(name: 'sn') this.sn,
    @JsonKey(name: 'storeroomno') this.storeRoomNo,
    @JsonKey(name: 'subinventorycode') this.subInventoryCode,
  });

  factory _$InventoryInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryInfoImplFromJson(json);

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String matCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  final String matName;

  /// 库位编号
  @override
  @JsonKey(name: 'storesiteno')
  final String storeSiteNo;

  /// 库存数量
  @override
  @JsonKey(name: 'qty')
  final int qty;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? sn;

  /// 库房编号
  @override
  @JsonKey(name: 'storeroomno')
  final String? storeRoomNo;

  /// 子库编码
  @override
  @JsonKey(name: 'subinventorycode')
  final String? subInventoryCode;

  @override
  String toString() {
    return 'InventoryInfo(matCode: $matCode, matName: $matName, storeSiteNo: $storeSiteNo, qty: $qty, batchNo: $batchNo, sn: $sn, storeRoomNo: $storeRoomNo, subInventoryCode: $subInventoryCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryInfoImpl &&
            (identical(other.matCode, matCode) || other.matCode == matCode) &&
            (identical(other.matName, matName) || other.matName == matName) &&
            (identical(other.storeSiteNo, storeSiteNo) ||
                other.storeSiteNo == storeSiteNo) &&
            (identical(other.qty, qty) || other.qty == qty) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.storeRoomNo, storeRoomNo) ||
                other.storeRoomNo == storeRoomNo) &&
            (identical(other.subInventoryCode, subInventoryCode) ||
                other.subInventoryCode == subInventoryCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    matCode,
    matName,
    storeSiteNo,
    qty,
    batchNo,
    sn,
    storeRoomNo,
    subInventoryCode,
  );

  /// Create a copy of InventoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryInfoImplCopyWith<_$InventoryInfoImpl> get copyWith =>
      __$$InventoryInfoImplCopyWithImpl<_$InventoryInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryInfoImplToJson(this);
  }
}

abstract class _InventoryInfo implements InventoryInfo {
  const factory _InventoryInfo({
    @JsonKey(name: 'matcode') required final String matCode,
    @JsonKey(name: 'matname') required final String matName,
    @JsonKey(name: 'storesiteno') required final String storeSiteNo,
    @JsonKey(name: 'qty') required final int qty,
    @JsonKey(name: 'batchno') final String? batchNo,
    @JsonKey(name: 'sn') final String? sn,
    @JsonKey(name: 'storeroomno') final String? storeRoomNo,
    @JsonKey(name: 'subinventorycode') final String? subInventoryCode,
  }) = _$InventoryInfoImpl;

  factory _InventoryInfo.fromJson(Map<String, dynamic> json) =
      _$InventoryInfoImpl.fromJson;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  String get matCode;

  /// 物料名称
  @override
  @JsonKey(name: 'matname')
  String get matName;

  /// 库位编号
  @override
  @JsonKey(name: 'storesiteno')
  String get storeSiteNo;

  /// 库存数量
  @override
  @JsonKey(name: 'qty')
  int get qty;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  String? get sn;

  /// 库房编号
  @override
  @JsonKey(name: 'storeroomno')
  String? get storeRoomNo;

  /// 子库编码
  @override
  @JsonKey(name: 'subinventorycode')
  String? get subInventoryCode;

  /// Create a copy of InventoryInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryInfoImplCopyWith<_$InventoryInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryQuery _$InventoryQueryFromJson(Map<String, dynamic> json) {
  return _InventoryQuery.fromJson(json);
}

/// @nodoc
mixin _$InventoryQuery {
  /// 库位编号
  @JsonKey(name: 'storesite')
  String get storeSite => throw _privateConstructorUsedError;

  /// 物料编码
  @JsonKey(name: 'matcode')
  String? get matCode => throw _privateConstructorUsedError;

  /// 批次号
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  @JsonKey(name: 'sn')
  String? get sn => throw _privateConstructorUsedError;

  /// Serializes this InventoryQuery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryQueryCopyWith<InventoryQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryQueryCopyWith<$Res> {
  factory $InventoryQueryCopyWith(
    InventoryQuery value,
    $Res Function(InventoryQuery) then,
  ) = _$InventoryQueryCopyWithImpl<$Res, InventoryQuery>;
  @useResult
  $Res call({
    @JsonKey(name: 'storesite') String storeSite,
    @JsonKey(name: 'matcode') String? matCode,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? sn,
  });
}

/// @nodoc
class _$InventoryQueryCopyWithImpl<$Res, $Val extends InventoryQuery>
    implements $InventoryQueryCopyWith<$Res> {
  _$InventoryQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeSite = null,
    Object? matCode = freezed,
    Object? batchNo = freezed,
    Object? sn = freezed,
  }) {
    return _then(
      _value.copyWith(
            storeSite: null == storeSite
                ? _value.storeSite
                : storeSite // ignore: cast_nullable_to_non_nullable
                      as String,
            matCode: freezed == matCode
                ? _value.matCode
                : matCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            batchNo: freezed == batchNo
                ? _value.batchNo
                : batchNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            sn: freezed == sn
                ? _value.sn
                : sn // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryQueryImplCopyWith<$Res>
    implements $InventoryQueryCopyWith<$Res> {
  factory _$$InventoryQueryImplCopyWith(
    _$InventoryQueryImpl value,
    $Res Function(_$InventoryQueryImpl) then,
  ) = __$$InventoryQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'storesite') String storeSite,
    @JsonKey(name: 'matcode') String? matCode,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? sn,
  });
}

/// @nodoc
class __$$InventoryQueryImplCopyWithImpl<$Res>
    extends _$InventoryQueryCopyWithImpl<$Res, _$InventoryQueryImpl>
    implements _$$InventoryQueryImplCopyWith<$Res> {
  __$$InventoryQueryImplCopyWithImpl(
    _$InventoryQueryImpl _value,
    $Res Function(_$InventoryQueryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeSite = null,
    Object? matCode = freezed,
    Object? batchNo = freezed,
    Object? sn = freezed,
  }) {
    return _then(
      _$InventoryQueryImpl(
        storeSite: null == storeSite
            ? _value.storeSite
            : storeSite // ignore: cast_nullable_to_non_nullable
                  as String,
        matCode: freezed == matCode
            ? _value.matCode
            : matCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        sn: freezed == sn
            ? _value.sn
            : sn // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryQueryImpl implements _InventoryQuery {
  const _$InventoryQueryImpl({
    @JsonKey(name: 'storesite') required this.storeSite,
    @JsonKey(name: 'matcode') this.matCode,
    @JsonKey(name: 'batchno') this.batchNo,
    @JsonKey(name: 'sn') this.sn,
  });

  factory _$InventoryQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryQueryImplFromJson(json);

  /// 库位编号
  @override
  @JsonKey(name: 'storesite')
  final String storeSite;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  final String? matCode;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  final String? sn;

  @override
  String toString() {
    return 'InventoryQuery(storeSite: $storeSite, matCode: $matCode, batchNo: $batchNo, sn: $sn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryQueryImpl &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.matCode, matCode) || other.matCode == matCode) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.sn, sn) || other.sn == sn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storeSite, matCode, batchNo, sn);

  /// Create a copy of InventoryQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryQueryImplCopyWith<_$InventoryQueryImpl> get copyWith =>
      __$$InventoryQueryImplCopyWithImpl<_$InventoryQueryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryQueryImplToJson(this);
  }
}

abstract class _InventoryQuery implements InventoryQuery {
  const factory _InventoryQuery({
    @JsonKey(name: 'storesite') required final String storeSite,
    @JsonKey(name: 'matcode') final String? matCode,
    @JsonKey(name: 'batchno') final String? batchNo,
    @JsonKey(name: 'sn') final String? sn,
  }) = _$InventoryQueryImpl;

  factory _InventoryQuery.fromJson(Map<String, dynamic> json) =
      _$InventoryQueryImpl.fromJson;

  /// 库位编号
  @override
  @JsonKey(name: 'storesite')
  String get storeSite;

  /// 物料编码
  @override
  @JsonKey(name: 'matcode')
  String? get matCode;

  /// 批次号
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;

  /// 序列号
  @override
  @JsonKey(name: 'sn')
  String? get sn;

  /// Create a copy of InventoryQuery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryQueryImplCopyWith<_$InventoryQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryResponse _$InventoryResponseFromJson(Map<String, dynamic> json) {
  return _InventoryResponse.fromJson(json);
}

/// @nodoc
mixin _$InventoryResponse {
  /// 响应码
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;

  /// 库存信息列表
  @JsonKey(name: 'data')
  List<InventoryInfo> get data => throw _privateConstructorUsedError;

  /// Serializes this InventoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryResponseCopyWith<InventoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryResponseCopyWith<$Res> {
  factory $InventoryResponseCopyWith(
    InventoryResponse value,
    $Res Function(InventoryResponse) then,
  ) = _$InventoryResponseCopyWithImpl<$Res, InventoryResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'code') String code,
    @JsonKey(name: 'msg') String message,
    @JsonKey(name: 'data') List<InventoryInfo> data,
  });
}

/// @nodoc
class _$InventoryResponseCopyWithImpl<$Res, $Val extends InventoryResponse>
    implements $InventoryResponseCopyWith<$Res> {
  _$InventoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
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
                      as List<InventoryInfo>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryResponseImplCopyWith<$Res>
    implements $InventoryResponseCopyWith<$Res> {
  factory _$$InventoryResponseImplCopyWith(
    _$InventoryResponseImpl value,
    $Res Function(_$InventoryResponseImpl) then,
  ) = __$$InventoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'code') String code,
    @JsonKey(name: 'msg') String message,
    @JsonKey(name: 'data') List<InventoryInfo> data,
  });
}

/// @nodoc
class __$$InventoryResponseImplCopyWithImpl<$Res>
    extends _$InventoryResponseCopyWithImpl<$Res, _$InventoryResponseImpl>
    implements _$$InventoryResponseImplCopyWith<$Res> {
  __$$InventoryResponseImplCopyWithImpl(
    _$InventoryResponseImpl _value,
    $Res Function(_$InventoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$InventoryResponseImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<InventoryInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryResponseImpl implements _InventoryResponse {
  const _$InventoryResponseImpl({
    @JsonKey(name: 'code') required this.code,
    @JsonKey(name: 'msg') required this.message,
    @JsonKey(name: 'data') required final List<InventoryInfo> data,
  }) : _data = data;

  factory _$InventoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryResponseImplFromJson(json);

  /// 响应码
  @override
  @JsonKey(name: 'code')
  final String code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  final String message;

  /// 库存信息列表
  final List<InventoryInfo> _data;

  /// 库存信息列表
  @override
  @JsonKey(name: 'data')
  List<InventoryInfo> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'InventoryResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of InventoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryResponseImplCopyWith<_$InventoryResponseImpl> get copyWith =>
      __$$InventoryResponseImplCopyWithImpl<_$InventoryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryResponseImplToJson(this);
  }
}

abstract class _InventoryResponse implements InventoryResponse {
  const factory _InventoryResponse({
    @JsonKey(name: 'code') required final String code,
    @JsonKey(name: 'msg') required final String message,
    @JsonKey(name: 'data') required final List<InventoryInfo> data,
  }) = _$InventoryResponseImpl;

  factory _InventoryResponse.fromJson(Map<String, dynamic> json) =
      _$InventoryResponseImpl.fromJson;

  /// 响应码
  @override
  @JsonKey(name: 'code')
  String get code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  String get message;

  /// 库存信息列表
  @override
  @JsonKey(name: 'data')
  List<InventoryInfo> get data;

  /// Create a copy of InventoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryResponseImplCopyWith<_$InventoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BarcodeContent _$BarcodeContentFromJson(Map<String, dynamic> json) {
  return _BarcodeContent.fromJson(json);
}

/// @nodoc
mixin _$BarcodeContent {
  /// 物料编码
  String get matCode => throw _privateConstructorUsedError;

  /// 批次号
  String? get batchNo => throw _privateConstructorUsedError;

  /// 序列号
  String? get sn => throw _privateConstructorUsedError;

  /// 生产日期
  String? get pdate => throw _privateConstructorUsedError;

  /// 保质期
  String? get vdays => throw _privateConstructorUsedError;

  /// 原始扫码内容
  String get originalContent => throw _privateConstructorUsedError;

  /// 是否需要API解析
  bool get needsApiParsing => throw _privateConstructorUsedError;

  /// Serializes this BarcodeContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BarcodeContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarcodeContentCopyWith<BarcodeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeContentCopyWith<$Res> {
  factory $BarcodeContentCopyWith(
    BarcodeContent value,
    $Res Function(BarcodeContent) then,
  ) = _$BarcodeContentCopyWithImpl<$Res, BarcodeContent>;
  @useResult
  $Res call({
    String matCode,
    String? batchNo,
    String? sn,
    String? pdate,
    String? vdays,
    String originalContent,
    bool needsApiParsing,
  });
}

/// @nodoc
class _$BarcodeContentCopyWithImpl<$Res, $Val extends BarcodeContent>
    implements $BarcodeContentCopyWith<$Res> {
  _$BarcodeContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BarcodeContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? batchNo = freezed,
    Object? sn = freezed,
    Object? pdate = freezed,
    Object? vdays = freezed,
    Object? originalContent = null,
    Object? needsApiParsing = null,
  }) {
    return _then(
      _value.copyWith(
            matCode: null == matCode
                ? _value.matCode
                : matCode // ignore: cast_nullable_to_non_nullable
                      as String,
            batchNo: freezed == batchNo
                ? _value.batchNo
                : batchNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            sn: freezed == sn
                ? _value.sn
                : sn // ignore: cast_nullable_to_non_nullable
                      as String?,
            pdate: freezed == pdate
                ? _value.pdate
                : pdate // ignore: cast_nullable_to_non_nullable
                      as String?,
            vdays: freezed == vdays
                ? _value.vdays
                : vdays // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalContent: null == originalContent
                ? _value.originalContent
                : originalContent // ignore: cast_nullable_to_non_nullable
                      as String,
            needsApiParsing: null == needsApiParsing
                ? _value.needsApiParsing
                : needsApiParsing // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BarcodeContentImplCopyWith<$Res>
    implements $BarcodeContentCopyWith<$Res> {
  factory _$$BarcodeContentImplCopyWith(
    _$BarcodeContentImpl value,
    $Res Function(_$BarcodeContentImpl) then,
  ) = __$$BarcodeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String matCode,
    String? batchNo,
    String? sn,
    String? pdate,
    String? vdays,
    String originalContent,
    bool needsApiParsing,
  });
}

/// @nodoc
class __$$BarcodeContentImplCopyWithImpl<$Res>
    extends _$BarcodeContentCopyWithImpl<$Res, _$BarcodeContentImpl>
    implements _$$BarcodeContentImplCopyWith<$Res> {
  __$$BarcodeContentImplCopyWithImpl(
    _$BarcodeContentImpl _value,
    $Res Function(_$BarcodeContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BarcodeContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? batchNo = freezed,
    Object? sn = freezed,
    Object? pdate = freezed,
    Object? vdays = freezed,
    Object? originalContent = null,
    Object? needsApiParsing = null,
  }) {
    return _then(
      _$BarcodeContentImpl(
        matCode: null == matCode
            ? _value.matCode
            : matCode // ignore: cast_nullable_to_non_nullable
                  as String,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        sn: freezed == sn
            ? _value.sn
            : sn // ignore: cast_nullable_to_non_nullable
                  as String?,
        pdate: freezed == pdate
            ? _value.pdate
            : pdate // ignore: cast_nullable_to_non_nullable
                  as String?,
        vdays: freezed == vdays
            ? _value.vdays
            : vdays // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalContent: null == originalContent
            ? _value.originalContent
            : originalContent // ignore: cast_nullable_to_non_nullable
                  as String,
        needsApiParsing: null == needsApiParsing
            ? _value.needsApiParsing
            : needsApiParsing // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BarcodeContentImpl implements _BarcodeContent {
  const _$BarcodeContentImpl({
    required this.matCode,
    this.batchNo,
    this.sn,
    this.pdate,
    this.vdays,
    required this.originalContent,
    this.needsApiParsing = false,
  });

  factory _$BarcodeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarcodeContentImplFromJson(json);

  /// 物料编码
  @override
  final String matCode;

  /// 批次号
  @override
  final String? batchNo;

  /// 序列号
  @override
  final String? sn;

  /// 生产日期
  @override
  final String? pdate;

  /// 保质期
  @override
  final String? vdays;

  /// 原始扫码内容
  @override
  final String originalContent;

  /// 是否需要API解析
  @override
  @JsonKey()
  final bool needsApiParsing;

  @override
  String toString() {
    return 'BarcodeContent(matCode: $matCode, batchNo: $batchNo, sn: $sn, pdate: $pdate, vdays: $vdays, originalContent: $originalContent, needsApiParsing: $needsApiParsing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeContentImpl &&
            (identical(other.matCode, matCode) || other.matCode == matCode) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.pdate, pdate) || other.pdate == pdate) &&
            (identical(other.vdays, vdays) || other.vdays == vdays) &&
            (identical(other.originalContent, originalContent) ||
                other.originalContent == originalContent) &&
            (identical(other.needsApiParsing, needsApiParsing) ||
                other.needsApiParsing == needsApiParsing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    matCode,
    batchNo,
    sn,
    pdate,
    vdays,
    originalContent,
    needsApiParsing,
  );

  /// Create a copy of BarcodeContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeContentImplCopyWith<_$BarcodeContentImpl> get copyWith =>
      __$$BarcodeContentImplCopyWithImpl<_$BarcodeContentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BarcodeContentImplToJson(this);
  }
}

abstract class _BarcodeContent implements BarcodeContent {
  const factory _BarcodeContent({
    required final String matCode,
    final String? batchNo,
    final String? sn,
    final String? pdate,
    final String? vdays,
    required final String originalContent,
    final bool needsApiParsing,
  }) = _$BarcodeContentImpl;

  factory _BarcodeContent.fromJson(Map<String, dynamic> json) =
      _$BarcodeContentImpl.fromJson;

  /// 物料编码
  @override
  String get matCode;

  /// 批次号
  @override
  String? get batchNo;

  /// 序列号
  @override
  String? get sn;

  /// 生产日期
  @override
  String? get pdate;

  /// 保质期
  @override
  String? get vdays;

  /// 原始扫码内容
  @override
  String get originalContent;

  /// 是否需要API解析
  @override
  bool get needsApiParsing;

  /// Create a copy of BarcodeContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarcodeContentImplCopyWith<_$BarcodeContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubmitCollectResponse _$SubmitCollectResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SubmitCollectResponse.fromJson(json);
}

/// @nodoc
mixin _$SubmitCollectResponse {
  /// 响应码
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;

  /// 响应数据
  @JsonKey(name: 'data')
  dynamic get data => throw _privateConstructorUsedError;

  /// Serializes this SubmitCollectResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubmitCollectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitCollectResponseCopyWith<SubmitCollectResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitCollectResponseCopyWith<$Res> {
  factory $SubmitCollectResponseCopyWith(
    SubmitCollectResponse value,
    $Res Function(SubmitCollectResponse) then,
  ) = _$SubmitCollectResponseCopyWithImpl<$Res, SubmitCollectResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'code') String code,
    @JsonKey(name: 'msg') String message,
    @JsonKey(name: 'data') dynamic data,
  });
}

/// @nodoc
class _$SubmitCollectResponseCopyWithImpl<
  $Res,
  $Val extends SubmitCollectResponse
>
    implements $SubmitCollectResponseCopyWith<$Res> {
  _$SubmitCollectResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitCollectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubmitCollectResponseImplCopyWith<$Res>
    implements $SubmitCollectResponseCopyWith<$Res> {
  factory _$$SubmitCollectResponseImplCopyWith(
    _$SubmitCollectResponseImpl value,
    $Res Function(_$SubmitCollectResponseImpl) then,
  ) = __$$SubmitCollectResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'code') String code,
    @JsonKey(name: 'msg') String message,
    @JsonKey(name: 'data') dynamic data,
  });
}

/// @nodoc
class __$$SubmitCollectResponseImplCopyWithImpl<$Res>
    extends
        _$SubmitCollectResponseCopyWithImpl<$Res, _$SubmitCollectResponseImpl>
    implements _$$SubmitCollectResponseImplCopyWith<$Res> {
  __$$SubmitCollectResponseImplCopyWithImpl(
    _$SubmitCollectResponseImpl _value,
    $Res Function(_$SubmitCollectResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubmitCollectResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$SubmitCollectResponseImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitCollectResponseImpl implements _SubmitCollectResponse {
  const _$SubmitCollectResponseImpl({
    @JsonKey(name: 'code') required this.code,
    @JsonKey(name: 'msg') required this.message,
    @JsonKey(name: 'data') this.data,
  });

  factory _$SubmitCollectResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmitCollectResponseImplFromJson(json);

  /// 响应码
  @override
  @JsonKey(name: 'code')
  final String code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  final String message;

  /// 响应数据
  @override
  @JsonKey(name: 'data')
  final dynamic data;

  @override
  String toString() {
    return 'SubmitCollectResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitCollectResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(data),
  );

  /// Create a copy of SubmitCollectResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitCollectResponseImplCopyWith<_$SubmitCollectResponseImpl>
  get copyWith =>
      __$$SubmitCollectResponseImplCopyWithImpl<_$SubmitCollectResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitCollectResponseImplToJson(this);
  }
}

abstract class _SubmitCollectResponse implements SubmitCollectResponse {
  const factory _SubmitCollectResponse({
    @JsonKey(name: 'code') required final String code,
    @JsonKey(name: 'msg') required final String message,
    @JsonKey(name: 'data') final dynamic data,
  }) = _$SubmitCollectResponseImpl;

  factory _SubmitCollectResponse.fromJson(Map<String, dynamic> json) =
      _$SubmitCollectResponseImpl.fromJson;

  /// 响应码
  @override
  @JsonKey(name: 'code')
  String get code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  String get message;

  /// 响应数据
  @override
  @JsonKey(name: 'data')
  dynamic get data;

  /// Create a copy of SubmitCollectResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitCollectResponseImplCopyWith<_$SubmitCollectResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ReportShortageResponse _$ReportShortageResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ReportShortageResponse.fromJson(json);
}

/// @nodoc
mixin _$ReportShortageResponse {
  /// 响应码
  @JsonKey(name: 'code')
  String get code => throw _privateConstructorUsedError;

  /// 响应消息
  @JsonKey(name: 'msg')
  String get message => throw _privateConstructorUsedError;

  /// 响应数据
  @JsonKey(name: 'data')
  dynamic get data => throw _privateConstructorUsedError;

  /// Serializes this ReportShortageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportShortageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportShortageResponseCopyWith<ReportShortageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportShortageResponseCopyWith<$Res> {
  factory $ReportShortageResponseCopyWith(
    ReportShortageResponse value,
    $Res Function(ReportShortageResponse) then,
  ) = _$ReportShortageResponseCopyWithImpl<$Res, ReportShortageResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'code') String code,
    @JsonKey(name: 'msg') String message,
    @JsonKey(name: 'data') dynamic data,
  });
}

/// @nodoc
class _$ReportShortageResponseCopyWithImpl<
  $Res,
  $Val extends ReportShortageResponse
>
    implements $ReportShortageResponseCopyWith<$Res> {
  _$ReportShortageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportShortageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportShortageResponseImplCopyWith<$Res>
    implements $ReportShortageResponseCopyWith<$Res> {
  factory _$$ReportShortageResponseImplCopyWith(
    _$ReportShortageResponseImpl value,
    $Res Function(_$ReportShortageResponseImpl) then,
  ) = __$$ReportShortageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'code') String code,
    @JsonKey(name: 'msg') String message,
    @JsonKey(name: 'data') dynamic data,
  });
}

/// @nodoc
class __$$ReportShortageResponseImplCopyWithImpl<$Res>
    extends
        _$ReportShortageResponseCopyWithImpl<$Res, _$ReportShortageResponseImpl>
    implements _$$ReportShortageResponseImplCopyWith<$Res> {
  __$$ReportShortageResponseImplCopyWithImpl(
    _$ReportShortageResponseImpl _value,
    $Res Function(_$ReportShortageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportShortageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$ReportShortageResponseImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportShortageResponseImpl implements _ReportShortageResponse {
  const _$ReportShortageResponseImpl({
    @JsonKey(name: 'code') required this.code,
    @JsonKey(name: 'msg') required this.message,
    @JsonKey(name: 'data') this.data,
  });

  factory _$ReportShortageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportShortageResponseImplFromJson(json);

  /// 响应码
  @override
  @JsonKey(name: 'code')
  final String code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  final String message;

  /// 响应数据
  @override
  @JsonKey(name: 'data')
  final dynamic data;

  @override
  String toString() {
    return 'ReportShortageResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportShortageResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(data),
  );

  /// Create a copy of ReportShortageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportShortageResponseImplCopyWith<_$ReportShortageResponseImpl>
  get copyWith =>
      __$$ReportShortageResponseImplCopyWithImpl<_$ReportShortageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportShortageResponseImplToJson(this);
  }
}

abstract class _ReportShortageResponse implements ReportShortageResponse {
  const factory _ReportShortageResponse({
    @JsonKey(name: 'code') required final String code,
    @JsonKey(name: 'msg') required final String message,
    @JsonKey(name: 'data') final dynamic data,
  }) = _$ReportShortageResponseImpl;

  factory _ReportShortageResponse.fromJson(Map<String, dynamic> json) =
      _$ReportShortageResponseImpl.fromJson;

  /// 响应码
  @override
  @JsonKey(name: 'code')
  String get code;

  /// 响应消息
  @override
  @JsonKey(name: 'msg')
  String get message;

  /// 响应数据
  @override
  @JsonKey(name: 'data')
  dynamic get data;

  /// Create a copy of ReportShortageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportShortageResponseImplCopyWith<_$ReportShortageResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
