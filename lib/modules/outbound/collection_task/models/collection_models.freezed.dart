// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutTaskItem _$OutTaskItemFromJson(Map<String, dynamic> json) {
  return _OutTaskItem.fromJson(json);
}

/// @nodoc
mixin _$OutTaskItem {
  @HiveField(0)
  int get outtaskitemid => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get matcode => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get matname => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get storesiteno => throw _privateConstructorUsedError;
  @HiveField(4)
  double get hintqty => throw _privateConstructorUsedError;
  @HiveField(5)
  double get collectedqty => throw _privateConstructorUsedError;
  @HiveField(6)
  double get repqty => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get hintbatchno => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get sn => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get storeroomno => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get subinventoryCode => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get orderno => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get matinnercode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutTaskItemCopyWith<OutTaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutTaskItemCopyWith<$Res> {
  factory $OutTaskItemCopyWith(
          OutTaskItem value, $Res Function(OutTaskItem) then) =
      _$OutTaskItemCopyWithImpl<$Res, OutTaskItem>;
  @useResult
  $Res call(
      {@HiveField(0) int outtaskitemid,
      @HiveField(1) String? matcode,
      @HiveField(2) String? matname,
      @HiveField(3) String? storesiteno,
      @HiveField(4) double hintqty,
      @HiveField(5) double collectedqty,
      @HiveField(6) double repqty,
      @HiveField(7) String? hintbatchno,
      @HiveField(8) String? sn,
      @HiveField(9) String? storeroomno,
      @HiveField(10) String? subinventoryCode,
      @HiveField(11) String? orderno,
      @HiveField(12) String? matinnercode});
}

/// @nodoc
class _$OutTaskItemCopyWithImpl<$Res, $Val extends OutTaskItem>
    implements $OutTaskItemCopyWith<$Res> {
  _$OutTaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outtaskitemid = null,
    Object? matcode = freezed,
    Object? matname = freezed,
    Object? storesiteno = freezed,
    Object? hintqty = null,
    Object? collectedqty = null,
    Object? repqty = null,
    Object? hintbatchno = freezed,
    Object? sn = freezed,
    Object? storeroomno = freezed,
    Object? subinventoryCode = freezed,
    Object? orderno = freezed,
    Object? matinnercode = freezed,
  }) {
    return _then(_value.copyWith(
      outtaskitemid: null == outtaskitemid
          ? _value.outtaskitemid
          : outtaskitemid // ignore: cast_nullable_to_non_nullable
              as int,
      matcode: freezed == matcode
          ? _value.matcode
          : matcode // ignore: cast_nullable_to_non_nullable
              as String?,
      matname: freezed == matname
          ? _value.matname
          : matname // ignore: cast_nullable_to_non_nullable
              as String?,
      storesiteno: freezed == storesiteno
          ? _value.storesiteno
          : storesiteno // ignore: cast_nullable_to_non_nullable
              as String?,
      hintqty: null == hintqty
          ? _value.hintqty
          : hintqty // ignore: cast_nullable_to_non_nullable
              as double,
      collectedqty: null == collectedqty
          ? _value.collectedqty
          : collectedqty // ignore: cast_nullable_to_non_nullable
              as double,
      repqty: null == repqty
          ? _value.repqty
          : repqty // ignore: cast_nullable_to_non_nullable
              as double,
      hintbatchno: freezed == hintbatchno
          ? _value.hintbatchno
          : hintbatchno // ignore: cast_nullable_to_non_nullable
              as String?,
      sn: freezed == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String?,
      storeroomno: freezed == storeroomno
          ? _value.storeroomno
          : storeroomno // ignore: cast_nullable_to_non_nullable
              as String?,
      subinventoryCode: freezed == subinventoryCode
          ? _value.subinventoryCode
          : subinventoryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      orderno: freezed == orderno
          ? _value.orderno
          : orderno // ignore: cast_nullable_to_non_nullable
              as String?,
      matinnercode: freezed == matinnercode
          ? _value.matinnercode
          : matinnercode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutTaskItemImplCopyWith<$Res>
    implements $OutTaskItemCopyWith<$Res> {
  factory _$$OutTaskItemImplCopyWith(
          _$OutTaskItemImpl value, $Res Function(_$OutTaskItemImpl) then) =
      __$$OutTaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int outtaskitemid,
      @HiveField(1) String? matcode,
      @HiveField(2) String? matname,
      @HiveField(3) String? storesiteno,
      @HiveField(4) double hintqty,
      @HiveField(5) double collectedqty,
      @HiveField(6) double repqty,
      @HiveField(7) String? hintbatchno,
      @HiveField(8) String? sn,
      @HiveField(9) String? storeroomno,
      @HiveField(10) String? subinventoryCode,
      @HiveField(11) String? orderno,
      @HiveField(12) String? matinnercode});
}

/// @nodoc
class __$$OutTaskItemImplCopyWithImpl<$Res>
    extends _$OutTaskItemCopyWithImpl<$Res, _$OutTaskItemImpl>
    implements _$$OutTaskItemImplCopyWith<$Res> {
  __$$OutTaskItemImplCopyWithImpl(
      _$OutTaskItemImpl _value, $Res Function(_$OutTaskItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outtaskitemid = null,
    Object? matcode = freezed,
    Object? matname = freezed,
    Object? storesiteno = freezed,
    Object? hintqty = null,
    Object? collectedqty = null,
    Object? repqty = null,
    Object? hintbatchno = freezed,
    Object? sn = freezed,
    Object? storeroomno = freezed,
    Object? subinventoryCode = freezed,
    Object? orderno = freezed,
    Object? matinnercode = freezed,
  }) {
    return _then(_$OutTaskItemImpl(
      outtaskitemid: null == outtaskitemid
          ? _value.outtaskitemid
          : outtaskitemid // ignore: cast_nullable_to_non_nullable
              as int,
      matcode: freezed == matcode
          ? _value.matcode
          : matcode // ignore: cast_nullable_to_non_nullable
              as String?,
      matname: freezed == matname
          ? _value.matname
          : matname // ignore: cast_nullable_to_non_nullable
              as String?,
      storesiteno: freezed == storesiteno
          ? _value.storesiteno
          : storesiteno // ignore: cast_nullable_to_non_nullable
              as String?,
      hintqty: null == hintqty
          ? _value.hintqty
          : hintqty // ignore: cast_nullable_to_non_nullable
              as double,
      collectedqty: null == collectedqty
          ? _value.collectedqty
          : collectedqty // ignore: cast_nullable_to_non_nullable
              as double,
      repqty: null == repqty
          ? _value.repqty
          : repqty // ignore: cast_nullable_to_non_nullable
              as double,
      hintbatchno: freezed == hintbatchno
          ? _value.hintbatchno
          : hintbatchno // ignore: cast_nullable_to_non_nullable
              as String?,
      sn: freezed == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String?,
      storeroomno: freezed == storeroomno
          ? _value.storeroomno
          : storeroomno // ignore: cast_nullable_to_non_nullable
              as String?,
      subinventoryCode: freezed == subinventoryCode
          ? _value.subinventoryCode
          : subinventoryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      orderno: freezed == orderno
          ? _value.orderno
          : orderno // ignore: cast_nullable_to_non_nullable
              as String?,
      matinnercode: freezed == matinnercode
          ? _value.matinnercode
          : matinnercode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutTaskItemImpl extends _OutTaskItem {
  _$OutTaskItemImpl(
      {@HiveField(0) required this.outtaskitemid,
      @HiveField(1) required this.matcode,
      @HiveField(2) required this.matname,
      @HiveField(3) required this.storesiteno,
      @HiveField(4) required this.hintqty,
      @HiveField(5) required this.collectedqty,
      @HiveField(6) required this.repqty,
      @HiveField(7) required this.hintbatchno,
      @HiveField(8) required this.sn,
      @HiveField(9) required this.storeroomno,
      @HiveField(10) required this.subinventoryCode,
      @HiveField(11) required this.orderno,
      @HiveField(12) required this.matinnercode})
      : super._();

  factory _$OutTaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutTaskItemImplFromJson(json);

  @override
  @HiveField(0)
  final int outtaskitemid;
  @override
  @HiveField(1)
  final String? matcode;
  @override
  @HiveField(2)
  final String? matname;
  @override
  @HiveField(3)
  final String? storesiteno;
  @override
  @HiveField(4)
  final double hintqty;
  @override
  @HiveField(5)
  final double collectedqty;
  @override
  @HiveField(6)
  final double repqty;
  @override
  @HiveField(7)
  final String? hintbatchno;
  @override
  @HiveField(8)
  final String? sn;
  @override
  @HiveField(9)
  final String? storeroomno;
  @override
  @HiveField(10)
  final String? subinventoryCode;
  @override
  @HiveField(11)
  final String? orderno;
  @override
  @HiveField(12)
  final String? matinnercode;

  @override
  String toString() {
    return 'OutTaskItem(outtaskitemid: $outtaskitemid, matcode: $matcode, matname: $matname, storesiteno: $storesiteno, hintqty: $hintqty, collectedqty: $collectedqty, repqty: $repqty, hintbatchno: $hintbatchno, sn: $sn, storeroomno: $storeroomno, subinventoryCode: $subinventoryCode, orderno: $orderno, matinnercode: $matinnercode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutTaskItemImpl &&
            (identical(other.outtaskitemid, outtaskitemid) ||
                other.outtaskitemid == outtaskitemid) &&
            (identical(other.matcode, matcode) || other.matcode == matcode) &&
            (identical(other.matname, matname) || other.matname == matname) &&
            (identical(other.storesiteno, storesiteno) ||
                other.storesiteno == storesiteno) &&
            (identical(other.hintqty, hintqty) || other.hintqty == hintqty) &&
            (identical(other.collectedqty, collectedqty) ||
                other.collectedqty == collectedqty) &&
            (identical(other.repqty, repqty) || other.repqty == repqty) &&
            (identical(other.hintbatchno, hintbatchno) ||
                other.hintbatchno == hintbatchno) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.storeroomno, storeroomno) ||
                other.storeroomno == storeroomno) &&
            (identical(other.subinventoryCode, subinventoryCode) ||
                other.subinventoryCode == subinventoryCode) &&
            (identical(other.orderno, orderno) || other.orderno == orderno) &&
            (identical(other.matinnercode, matinnercode) ||
                other.matinnercode == matinnercode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      outtaskitemid,
      matcode,
      matname,
      storesiteno,
      hintqty,
      collectedqty,
      repqty,
      hintbatchno,
      sn,
      storeroomno,
      subinventoryCode,
      orderno,
      matinnercode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutTaskItemImplCopyWith<_$OutTaskItemImpl> get copyWith =>
      __$$OutTaskItemImplCopyWithImpl<_$OutTaskItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutTaskItemImplToJson(
      this,
    );
  }
}

abstract class _OutTaskItem extends OutTaskItem {
  factory _OutTaskItem(
      {@HiveField(0) required final int outtaskitemid,
      @HiveField(1) required final String? matcode,
      @HiveField(2) required final String? matname,
      @HiveField(3) required final String? storesiteno,
      @HiveField(4) required final double hintqty,
      @HiveField(5) required final double collectedqty,
      @HiveField(6) required final double repqty,
      @HiveField(7) required final String? hintbatchno,
      @HiveField(8) required final String? sn,
      @HiveField(9) required final String? storeroomno,
      @HiveField(10) required final String? subinventoryCode,
      @HiveField(11) required final String? orderno,
      @HiveField(12) required final String? matinnercode}) = _$OutTaskItemImpl;
  _OutTaskItem._() : super._();

  factory _OutTaskItem.fromJson(Map<String, dynamic> json) =
      _$OutTaskItemImpl.fromJson;

  @override
  @HiveField(0)
  int get outtaskitemid;
  @override
  @HiveField(1)
  String? get matcode;
  @override
  @HiveField(2)
  String? get matname;
  @override
  @HiveField(3)
  String? get storesiteno;
  @override
  @HiveField(4)
  double get hintqty;
  @override
  @HiveField(5)
  double get collectedqty;
  @override
  @HiveField(6)
  double get repqty;
  @override
  @HiveField(7)
  String? get hintbatchno;
  @override
  @HiveField(8)
  String? get sn;
  @override
  @HiveField(9)
  String? get storeroomno;
  @override
  @HiveField(10)
  String? get subinventoryCode;
  @override
  @HiveField(11)
  String? get orderno;
  @override
  @HiveField(12)
  String? get matinnercode;
  @override
  @JsonKey(ignore: true)
  _$$OutTaskItemImplCopyWith<_$OutTaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BarcodeContent _$BarcodeContentFromJson(Map<String, dynamic> json) {
  return _BarcodeContent.fromJson(json);
}

/// @nodoc
mixin _$BarcodeContent {
  @HiveField(0)
  String? get matcode => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get matname => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get batchno => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get sn => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get seqctrl => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get id_old => throw _privateConstructorUsedError;
  @HiveField(6)
  double? get qty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BarcodeContentCopyWith<BarcodeContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeContentCopyWith<$Res> {
  factory $BarcodeContentCopyWith(
          BarcodeContent value, $Res Function(BarcodeContent) then) =
      _$BarcodeContentCopyWithImpl<$Res, BarcodeContent>;
  @useResult
  $Res call(
      {@HiveField(0) String? matcode,
      @HiveField(1) String? matname,
      @HiveField(2) String? batchno,
      @HiveField(3) String? sn,
      @HiveField(4) String? seqctrl,
      @HiveField(5) String? id_old,
      @HiveField(6) double? qty});
}

/// @nodoc
class _$BarcodeContentCopyWithImpl<$Res, $Val extends BarcodeContent>
    implements $BarcodeContentCopyWith<$Res> {
  _$BarcodeContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matcode = freezed,
    Object? matname = freezed,
    Object? batchno = freezed,
    Object? sn = freezed,
    Object? seqctrl = freezed,
    Object? id_old = freezed,
    Object? qty = freezed,
  }) {
    return _then(_value.copyWith(
      matcode: freezed == matcode
          ? _value.matcode
          : matcode // ignore: cast_nullable_to_non_nullable
              as String?,
      matname: freezed == matname
          ? _value.matname
          : matname // ignore: cast_nullable_to_non_nullable
              as String?,
      batchno: freezed == batchno
          ? _value.batchno
          : batchno // ignore: cast_nullable_to_non_nullable
              as String?,
      sn: freezed == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String?,
      seqctrl: freezed == seqctrl
          ? _value.seqctrl
          : seqctrl // ignore: cast_nullable_to_non_nullable
              as String?,
      id_old: freezed == id_old
          ? _value.id_old
          : id_old // ignore: cast_nullable_to_non_nullable
              as String?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarcodeContentImplCopyWith<$Res>
    implements $BarcodeContentCopyWith<$Res> {
  factory _$$BarcodeContentImplCopyWith(_$BarcodeContentImpl value,
          $Res Function(_$BarcodeContentImpl) then) =
      __$$BarcodeContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? matcode,
      @HiveField(1) String? matname,
      @HiveField(2) String? batchno,
      @HiveField(3) String? sn,
      @HiveField(4) String? seqctrl,
      @HiveField(5) String? id_old,
      @HiveField(6) double? qty});
}

/// @nodoc
class __$$BarcodeContentImplCopyWithImpl<$Res>
    extends _$BarcodeContentCopyWithImpl<$Res, _$BarcodeContentImpl>
    implements _$$BarcodeContentImplCopyWith<$Res> {
  __$$BarcodeContentImplCopyWithImpl(
      _$BarcodeContentImpl _value, $Res Function(_$BarcodeContentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matcode = freezed,
    Object? matname = freezed,
    Object? batchno = freezed,
    Object? sn = freezed,
    Object? seqctrl = freezed,
    Object? id_old = freezed,
    Object? qty = freezed,
  }) {
    return _then(_$BarcodeContentImpl(
      matcode: freezed == matcode
          ? _value.matcode
          : matcode // ignore: cast_nullable_to_non_nullable
              as String?,
      matname: freezed == matname
          ? _value.matname
          : matname // ignore: cast_nullable_to_non_nullable
              as String?,
      batchno: freezed == batchno
          ? _value.batchno
          : batchno // ignore: cast_nullable_to_non_nullable
              as String?,
      sn: freezed == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String?,
      seqctrl: freezed == seqctrl
          ? _value.seqctrl
          : seqctrl // ignore: cast_nullable_to_non_nullable
              as String?,
      id_old: freezed == id_old
          ? _value.id_old
          : id_old // ignore: cast_nullable_to_non_nullable
              as String?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BarcodeContentImpl extends _BarcodeContent {
  _$BarcodeContentImpl(
      {@HiveField(0) this.matcode,
      @HiveField(1) this.matname,
      @HiveField(2) this.batchno,
      @HiveField(3) this.sn,
      @HiveField(4) this.seqctrl,
      @HiveField(5) this.id_old,
      @HiveField(6) this.qty})
      : super._();

  factory _$BarcodeContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarcodeContentImplFromJson(json);

  @override
  @HiveField(0)
  final String? matcode;
  @override
  @HiveField(1)
  final String? matname;
  @override
  @HiveField(2)
  final String? batchno;
  @override
  @HiveField(3)
  final String? sn;
  @override
  @HiveField(4)
  final String? seqctrl;
  @override
  @HiveField(5)
  final String? id_old;
  @override
  @HiveField(6)
  final double? qty;

  @override
  String toString() {
    return 'BarcodeContent(matcode: $matcode, matname: $matname, batchno: $batchno, sn: $sn, seqctrl: $seqctrl, id_old: $id_old, qty: $qty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeContentImpl &&
            (identical(other.matcode, matcode) || other.matcode == matcode) &&
            (identical(other.matname, matname) || other.matname == matname) &&
            (identical(other.batchno, batchno) || other.batchno == batchno) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.seqctrl, seqctrl) || other.seqctrl == seqctrl) &&
            (identical(other.id_old, id_old) || other.id_old == id_old) &&
            (identical(other.qty, qty) || other.qty == qty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, matcode, matname, batchno, sn, seqctrl, id_old, qty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeContentImplCopyWith<_$BarcodeContentImpl> get copyWith =>
      __$$BarcodeContentImplCopyWithImpl<_$BarcodeContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BarcodeContentImplToJson(
      this,
    );
  }
}

abstract class _BarcodeContent extends BarcodeContent {
  factory _BarcodeContent(
      {@HiveField(0) final String? matcode,
      @HiveField(1) final String? matname,
      @HiveField(2) final String? batchno,
      @HiveField(3) final String? sn,
      @HiveField(4) final String? seqctrl,
      @HiveField(5) final String? id_old,
      @HiveField(6) final double? qty}) = _$BarcodeContentImpl;
  _BarcodeContent._() : super._();

  factory _BarcodeContent.fromJson(Map<String, dynamic> json) =
      _$BarcodeContentImpl.fromJson;

  @override
  @HiveField(0)
  String? get matcode;
  @override
  @HiveField(1)
  String? get matname;
  @override
  @HiveField(2)
  String? get batchno;
  @override
  @HiveField(3)
  String? get sn;
  @override
  @HiveField(4)
  String? get seqctrl;
  @override
  @HiveField(5)
  String? get id_old;
  @override
  @HiveField(6)
  double? get qty;
  @override
  @JsonKey(ignore: true)
  _$$BarcodeContentImplCopyWith<_$BarcodeContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CollectionStock _$CollectionStockFromJson(Map<String, dynamic> json) {
  return _CollectionStock.fromJson(json);
}

/// @nodoc
mixin _$CollectionStock {
  @HiveField(0)
  String get stockid => throw _privateConstructorUsedError;
  @HiveField(1)
  String get matcode => throw _privateConstructorUsedError;
  @HiveField(2)
  String get batchno => throw _privateConstructorUsedError;
  @HiveField(3)
  String get sn => throw _privateConstructorUsedError;
  @HiveField(4)
  double get taskQty => throw _privateConstructorUsedError;
  @HiveField(5)
  double get collectQty => throw _privateConstructorUsedError;
  @HiveField(6)
  String get outtaskitemid => throw _privateConstructorUsedError;
  @HiveField(7)
  String get taskid => throw _privateConstructorUsedError;
  @HiveField(8)
  String get storeRoom => throw _privateConstructorUsedError;
  @HiveField(9)
  String get storeSite => throw _privateConstructorUsedError;
  @HiveField(10)
  String get erpStore => throw _privateConstructorUsedError;
  @HiveField(11)
  String get trayNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionStockCopyWith<CollectionStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionStockCopyWith<$Res> {
  factory $CollectionStockCopyWith(
          CollectionStock value, $Res Function(CollectionStock) then) =
      _$CollectionStockCopyWithImpl<$Res, CollectionStock>;
  @useResult
  $Res call(
      {@HiveField(0) String stockid,
      @HiveField(1) String matcode,
      @HiveField(2) String batchno,
      @HiveField(3) String sn,
      @HiveField(4) double taskQty,
      @HiveField(5) double collectQty,
      @HiveField(6) String outtaskitemid,
      @HiveField(7) String taskid,
      @HiveField(8) String storeRoom,
      @HiveField(9) String storeSite,
      @HiveField(10) String erpStore,
      @HiveField(11) String trayNo});
}

/// @nodoc
class _$CollectionStockCopyWithImpl<$Res, $Val extends CollectionStock>
    implements $CollectionStockCopyWith<$Res> {
  _$CollectionStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockid = null,
    Object? matcode = null,
    Object? batchno = null,
    Object? sn = null,
    Object? taskQty = null,
    Object? collectQty = null,
    Object? outtaskitemid = null,
    Object? taskid = null,
    Object? storeRoom = null,
    Object? storeSite = null,
    Object? erpStore = null,
    Object? trayNo = null,
  }) {
    return _then(_value.copyWith(
      stockid: null == stockid
          ? _value.stockid
          : stockid // ignore: cast_nullable_to_non_nullable
              as String,
      matcode: null == matcode
          ? _value.matcode
          : matcode // ignore: cast_nullable_to_non_nullable
              as String,
      batchno: null == batchno
          ? _value.batchno
          : batchno // ignore: cast_nullable_to_non_nullable
              as String,
      sn: null == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as double,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      outtaskitemid: null == outtaskitemid
          ? _value.outtaskitemid
          : outtaskitemid // ignore: cast_nullable_to_non_nullable
              as String,
      taskid: null == taskid
          ? _value.taskid
          : taskid // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoom: null == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String,
      storeSite: null == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String,
      erpStore: null == erpStore
          ? _value.erpStore
          : erpStore // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionStockImplCopyWith<$Res>
    implements $CollectionStockCopyWith<$Res> {
  factory _$$CollectionStockImplCopyWith(_$CollectionStockImpl value,
          $Res Function(_$CollectionStockImpl) then) =
      __$$CollectionStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String stockid,
      @HiveField(1) String matcode,
      @HiveField(2) String batchno,
      @HiveField(3) String sn,
      @HiveField(4) double taskQty,
      @HiveField(5) double collectQty,
      @HiveField(6) String outtaskitemid,
      @HiveField(7) String taskid,
      @HiveField(8) String storeRoom,
      @HiveField(9) String storeSite,
      @HiveField(10) String erpStore,
      @HiveField(11) String trayNo});
}

/// @nodoc
class __$$CollectionStockImplCopyWithImpl<$Res>
    extends _$CollectionStockCopyWithImpl<$Res, _$CollectionStockImpl>
    implements _$$CollectionStockImplCopyWith<$Res> {
  __$$CollectionStockImplCopyWithImpl(
      _$CollectionStockImpl _value, $Res Function(_$CollectionStockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockid = null,
    Object? matcode = null,
    Object? batchno = null,
    Object? sn = null,
    Object? taskQty = null,
    Object? collectQty = null,
    Object? outtaskitemid = null,
    Object? taskid = null,
    Object? storeRoom = null,
    Object? storeSite = null,
    Object? erpStore = null,
    Object? trayNo = null,
  }) {
    return _then(_$CollectionStockImpl(
      stockid: null == stockid
          ? _value.stockid
          : stockid // ignore: cast_nullable_to_non_nullable
              as String,
      matcode: null == matcode
          ? _value.matcode
          : matcode // ignore: cast_nullable_to_non_nullable
              as String,
      batchno: null == batchno
          ? _value.batchno
          : batchno // ignore: cast_nullable_to_non_nullable
              as String,
      sn: null == sn
          ? _value.sn
          : sn // ignore: cast_nullable_to_non_nullable
              as String,
      taskQty: null == taskQty
          ? _value.taskQty
          : taskQty // ignore: cast_nullable_to_non_nullable
              as double,
      collectQty: null == collectQty
          ? _value.collectQty
          : collectQty // ignore: cast_nullable_to_non_nullable
              as double,
      outtaskitemid: null == outtaskitemid
          ? _value.outtaskitemid
          : outtaskitemid // ignore: cast_nullable_to_non_nullable
              as String,
      taskid: null == taskid
          ? _value.taskid
          : taskid // ignore: cast_nullable_to_non_nullable
              as String,
      storeRoom: null == storeRoom
          ? _value.storeRoom
          : storeRoom // ignore: cast_nullable_to_non_nullable
              as String,
      storeSite: null == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String,
      erpStore: null == erpStore
          ? _value.erpStore
          : erpStore // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionStockImpl extends _CollectionStock {
  _$CollectionStockImpl(
      {@HiveField(0) required this.stockid,
      @HiveField(1) required this.matcode,
      @HiveField(2) required this.batchno,
      @HiveField(3) required this.sn,
      @HiveField(4) required this.taskQty,
      @HiveField(5) required this.collectQty,
      @HiveField(6) required this.outtaskitemid,
      @HiveField(7) required this.taskid,
      @HiveField(8) required this.storeRoom,
      @HiveField(9) required this.storeSite,
      @HiveField(10) required this.erpStore,
      @HiveField(11) required this.trayNo})
      : super._();

  factory _$CollectionStockImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionStockImplFromJson(json);

  @override
  @HiveField(0)
  final String stockid;
  @override
  @HiveField(1)
  final String matcode;
  @override
  @HiveField(2)
  final String batchno;
  @override
  @HiveField(3)
  final String sn;
  @override
  @HiveField(4)
  final double taskQty;
  @override
  @HiveField(5)
  final double collectQty;
  @override
  @HiveField(6)
  final String outtaskitemid;
  @override
  @HiveField(7)
  final String taskid;
  @override
  @HiveField(8)
  final String storeRoom;
  @override
  @HiveField(9)
  final String storeSite;
  @override
  @HiveField(10)
  final String erpStore;
  @override
  @HiveField(11)
  final String trayNo;

  @override
  String toString() {
    return 'CollectionStock(stockid: $stockid, matcode: $matcode, batchno: $batchno, sn: $sn, taskQty: $taskQty, collectQty: $collectQty, outtaskitemid: $outtaskitemid, taskid: $taskid, storeRoom: $storeRoom, storeSite: $storeSite, erpStore: $erpStore, trayNo: $trayNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionStockImpl &&
            (identical(other.stockid, stockid) || other.stockid == stockid) &&
            (identical(other.matcode, matcode) || other.matcode == matcode) &&
            (identical(other.batchno, batchno) || other.batchno == batchno) &&
            (identical(other.sn, sn) || other.sn == sn) &&
            (identical(other.taskQty, taskQty) || other.taskQty == taskQty) &&
            (identical(other.collectQty, collectQty) ||
                other.collectQty == collectQty) &&
            (identical(other.outtaskitemid, outtaskitemid) ||
                other.outtaskitemid == outtaskitemid) &&
            (identical(other.taskid, taskid) || other.taskid == taskid) &&
            (identical(other.storeRoom, storeRoom) ||
                other.storeRoom == storeRoom) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.erpStore, erpStore) ||
                other.erpStore == erpStore) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stockid,
      matcode,
      batchno,
      sn,
      taskQty,
      collectQty,
      outtaskitemid,
      taskid,
      storeRoom,
      storeSite,
      erpStore,
      trayNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionStockImplCopyWith<_$CollectionStockImpl> get copyWith =>
      __$$CollectionStockImplCopyWithImpl<_$CollectionStockImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionStockImplToJson(
      this,
    );
  }
}

abstract class _CollectionStock extends CollectionStock {
  factory _CollectionStock(
      {@HiveField(0) required final String stockid,
      @HiveField(1) required final String matcode,
      @HiveField(2) required final String batchno,
      @HiveField(3) required final String sn,
      @HiveField(4) required final double taskQty,
      @HiveField(5) required final double collectQty,
      @HiveField(6) required final String outtaskitemid,
      @HiveField(7) required final String taskid,
      @HiveField(8) required final String storeRoom,
      @HiveField(9) required final String storeSite,
      @HiveField(10) required final String erpStore,
      @HiveField(11) required final String trayNo}) = _$CollectionStockImpl;
  _CollectionStock._() : super._();

  factory _CollectionStock.fromJson(Map<String, dynamic> json) =
      _$CollectionStockImpl.fromJson;

  @override
  @HiveField(0)
  String get stockid;
  @override
  @HiveField(1)
  String get matcode;
  @override
  @HiveField(2)
  String get batchno;
  @override
  @HiveField(3)
  String get sn;
  @override
  @HiveField(4)
  double get taskQty;
  @override
  @HiveField(5)
  double get collectQty;
  @override
  @HiveField(6)
  String get outtaskitemid;
  @override
  @HiveField(7)
  String get taskid;
  @override
  @HiveField(8)
  String get storeRoom;
  @override
  @HiveField(9)
  String get storeSite;
  @override
  @HiveField(10)
  String get erpStore;
  @override
  @HiveField(11)
  String get trayNo;
  @override
  @JsonKey(ignore: true)
  _$$CollectionStockImplCopyWith<_$CollectionStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
