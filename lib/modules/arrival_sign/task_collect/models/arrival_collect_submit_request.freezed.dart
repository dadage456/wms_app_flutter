// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_collect_submit_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ArrivalCollectSubmitRequest _$ArrivalCollectSubmitRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ArrivalCollectSubmitRequest.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectSubmitRequest {
  @JsonKey(name: 'upShelvesInfos')
  List<ArrivalCollectSubmitItem> get upShelvesInfos =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'itemListInfos')
  List<ArrivalCollectSubmitItem> get itemListInfos =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'filter')
  ArrivalCollectSubmitFilter? get filter => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectSubmitRequestCopyWith<ArrivalCollectSubmitRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectSubmitRequestCopyWith<$Res> {
  factory $ArrivalCollectSubmitRequestCopyWith(
    ArrivalCollectSubmitRequest value,
    $Res Function(ArrivalCollectSubmitRequest) then,
  ) =
      _$ArrivalCollectSubmitRequestCopyWithImpl<
        $Res,
        ArrivalCollectSubmitRequest
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'upShelvesInfos')
    List<ArrivalCollectSubmitItem> upShelvesInfos,
    @JsonKey(name: 'itemListInfos')
    List<ArrivalCollectSubmitItem> itemListInfos,
    @JsonKey(name: 'filter') ArrivalCollectSubmitFilter? filter,
  });

  $ArrivalCollectSubmitFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class _$ArrivalCollectSubmitRequestCopyWithImpl<
  $Res,
  $Val extends ArrivalCollectSubmitRequest
>
    implements $ArrivalCollectSubmitRequestCopyWith<$Res> {
  _$ArrivalCollectSubmitRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upShelvesInfos = null,
    Object? itemListInfos = null,
    Object? filter = freezed,
  }) {
    return _then(
      _value.copyWith(
            upShelvesInfos: null == upShelvesInfos
                ? _value.upShelvesInfos
                : upShelvesInfos // ignore: cast_nullable_to_non_nullable
                      as List<ArrivalCollectSubmitItem>,
            itemListInfos: null == itemListInfos
                ? _value.itemListInfos
                : itemListInfos // ignore: cast_nullable_to_non_nullable
                      as List<ArrivalCollectSubmitItem>,
            filter: freezed == filter
                ? _value.filter
                : filter // ignore: cast_nullable_to_non_nullable
                      as ArrivalCollectSubmitFilter?,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $ArrivalCollectSubmitFilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $ArrivalCollectSubmitFilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArrivalCollectSubmitRequestImplCopyWith<$Res>
    implements $ArrivalCollectSubmitRequestCopyWith<$Res> {
  factory _$$ArrivalCollectSubmitRequestImplCopyWith(
    _$ArrivalCollectSubmitRequestImpl value,
    $Res Function(_$ArrivalCollectSubmitRequestImpl) then,
  ) = __$$ArrivalCollectSubmitRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'upShelvesInfos')
    List<ArrivalCollectSubmitItem> upShelvesInfos,
    @JsonKey(name: 'itemListInfos')
    List<ArrivalCollectSubmitItem> itemListInfos,
    @JsonKey(name: 'filter') ArrivalCollectSubmitFilter? filter,
  });

  @override
  $ArrivalCollectSubmitFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$$ArrivalCollectSubmitRequestImplCopyWithImpl<$Res>
    extends
        _$ArrivalCollectSubmitRequestCopyWithImpl<
          $Res,
          _$ArrivalCollectSubmitRequestImpl
        >
    implements _$$ArrivalCollectSubmitRequestImplCopyWith<$Res> {
  __$$ArrivalCollectSubmitRequestImplCopyWithImpl(
    _$ArrivalCollectSubmitRequestImpl _value,
    $Res Function(_$ArrivalCollectSubmitRequestImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upShelvesInfos = null,
    Object? itemListInfos = null,
    Object? filter = freezed,
  }) {
    return _then(
      _$ArrivalCollectSubmitRequestImpl(
        upShelvesInfos: null == upShelvesInfos
            ? _value._upShelvesInfos
            : upShelvesInfos // ignore: cast_nullable_to_non_nullable
                  as List<ArrivalCollectSubmitItem>,
        itemListInfos: null == itemListInfos
            ? _value._itemListInfos
            : itemListInfos // ignore: cast_nullable_to_non_nullable
                  as List<ArrivalCollectSubmitItem>,
        filter: freezed == filter
            ? _value.filter
            : filter // ignore: cast_nullable_to_non_nullable
                  as ArrivalCollectSubmitFilter?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArrivalCollectSubmitRequestImpl
    implements _ArrivalCollectSubmitRequest {
  const _$ArrivalCollectSubmitRequestImpl({
    @JsonKey(name: 'upShelvesInfos')
    final List<ArrivalCollectSubmitItem> upShelvesInfos =
        const <ArrivalCollectSubmitItem>[],
    @JsonKey(name: 'itemListInfos')
    final List<ArrivalCollectSubmitItem> itemListInfos =
        const <ArrivalCollectSubmitItem>[],
    @JsonKey(name: 'filter') this.filter,
  }) : _upShelvesInfos = upShelvesInfos,
       _itemListInfos = itemListInfos;

  factory _$ArrivalCollectSubmitRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ArrivalCollectSubmitRequestImplFromJson(json);

  final List<ArrivalCollectSubmitItem> _upShelvesInfos;
  @override
  @JsonKey(name: 'upShelvesInfos')
  List<ArrivalCollectSubmitItem> get upShelvesInfos {
    if (_upShelvesInfos is EqualUnmodifiableListView) return _upShelvesInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upShelvesInfos);
  }

  final List<ArrivalCollectSubmitItem> _itemListInfos;
  @override
  @JsonKey(name: 'itemListInfos')
  List<ArrivalCollectSubmitItem> get itemListInfos {
    if (_itemListInfos is EqualUnmodifiableListView) return _itemListInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemListInfos);
  }

  @override
  @JsonKey(name: 'filter')
  final ArrivalCollectSubmitFilter? filter;

  @override
  String toString() {
    return 'ArrivalCollectSubmitRequest(upShelvesInfos: $upShelvesInfos, itemListInfos: $itemListInfos, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectSubmitRequestImpl &&
            const DeepCollectionEquality().equals(
              other._upShelvesInfos,
              _upShelvesInfos,
            ) &&
            const DeepCollectionEquality().equals(
              other._itemListInfos,
              _itemListInfos,
            ) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_upShelvesInfos),
    const DeepCollectionEquality().hash(_itemListInfos),
    filter,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectSubmitRequestImplCopyWith<_$ArrivalCollectSubmitRequestImpl>
  get copyWith =>
      __$$ArrivalCollectSubmitRequestImplCopyWithImpl<
        _$ArrivalCollectSubmitRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectSubmitRequestImplToJson(this);
  }
}

abstract class _ArrivalCollectSubmitRequest
    implements ArrivalCollectSubmitRequest {
  const factory _ArrivalCollectSubmitRequest({
    @JsonKey(name: 'upShelvesInfos')
    final List<ArrivalCollectSubmitItem> upShelvesInfos,
    @JsonKey(name: 'itemListInfos')
    final List<ArrivalCollectSubmitItem> itemListInfos,
    @JsonKey(name: 'filter') final ArrivalCollectSubmitFilter? filter,
  }) = _$ArrivalCollectSubmitRequestImpl;

  factory _ArrivalCollectSubmitRequest.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectSubmitRequestImpl.fromJson;

  @override
  @JsonKey(name: 'upShelvesInfos')
  List<ArrivalCollectSubmitItem> get upShelvesInfos;
  @override
  @JsonKey(name: 'itemListInfos')
  List<ArrivalCollectSubmitItem> get itemListInfos;
  @override
  @JsonKey(name: 'filter')
  ArrivalCollectSubmitFilter? get filter;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectSubmitRequestImplCopyWith<_$ArrivalCollectSubmitRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ArrivalCollectSubmitItem _$ArrivalCollectSubmitItemFromJson(
  Map<String, dynamic> json,
) {
  return _ArrivalCollectSubmitItem.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectSubmitItem {
  @JsonKey(name: 'matcode')
  String get matCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'batchno')
  String? get batchNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sn')
  String? get serialNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'qty')
  double get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectSubmitItemCopyWith<ArrivalCollectSubmitItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectSubmitItemCopyWith<$Res> {
  factory $ArrivalCollectSubmitItemCopyWith(
    ArrivalCollectSubmitItem value,
    $Res Function(ArrivalCollectSubmitItem) then,
  ) = _$ArrivalCollectSubmitItemCopyWithImpl<$Res, ArrivalCollectSubmitItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') String matCode,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNumber,
    @JsonKey(name: 'qty') double quantity,
  });
}

/// @nodoc
class _$ArrivalCollectSubmitItemCopyWithImpl<
  $Res,
  $Val extends ArrivalCollectSubmitItem
>
    implements $ArrivalCollectSubmitItemCopyWith<$Res> {
  _$ArrivalCollectSubmitItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? quantity = null,
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
            serialNumber: freezed == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArrivalCollectSubmitItemImplCopyWith<$Res>
    implements $ArrivalCollectSubmitItemCopyWith<$Res> {
  factory _$$ArrivalCollectSubmitItemImplCopyWith(
    _$ArrivalCollectSubmitItemImpl value,
    $Res Function(_$ArrivalCollectSubmitItemImpl) then,
  ) = __$$ArrivalCollectSubmitItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'matcode') String matCode,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNumber,
    @JsonKey(name: 'qty') double quantity,
  });
}

/// @nodoc
class __$$ArrivalCollectSubmitItemImplCopyWithImpl<$Res>
    extends
        _$ArrivalCollectSubmitItemCopyWithImpl<
          $Res,
          _$ArrivalCollectSubmitItemImpl
        >
    implements _$$ArrivalCollectSubmitItemImplCopyWith<$Res> {
  __$$ArrivalCollectSubmitItemImplCopyWithImpl(
    _$ArrivalCollectSubmitItemImpl _value,
    $Res Function(_$ArrivalCollectSubmitItemImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matCode = null,
    Object? batchNo = freezed,
    Object? serialNumber = freezed,
    Object? quantity = null,
  }) {
    return _then(
      _$ArrivalCollectSubmitItemImpl(
        matCode: null == matCode
            ? _value.matCode
            : matCode // ignore: cast_nullable_to_non_nullable
                  as String,
        batchNo: freezed == batchNo
            ? _value.batchNo
            : batchNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        serialNumber: freezed == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArrivalCollectSubmitItemImpl implements _ArrivalCollectSubmitItem {
  const _$ArrivalCollectSubmitItemImpl({
    @JsonKey(name: 'matcode') required this.matCode,
    @JsonKey(name: 'batchno') this.batchNo,
    @JsonKey(name: 'sn') this.serialNumber,
    @JsonKey(name: 'qty') required this.quantity,
  });

  factory _$ArrivalCollectSubmitItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalCollectSubmitItemImplFromJson(json);

  @override
  @JsonKey(name: 'matcode')
  final String matCode;
  @override
  @JsonKey(name: 'batchno')
  final String? batchNo;
  @override
  @JsonKey(name: 'sn')
  final String? serialNumber;
  @override
  @JsonKey(name: 'qty')
  final double quantity;

  @override
  String toString() {
    return 'ArrivalCollectSubmitItem(matCode: $matCode, batchNo: $batchNo, serialNumber: $serialNumber, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectSubmitItemImpl &&
            (identical(other.matCode, matCode) || other.matCode == matCode) &&
            (identical(other.batchNo, batchNo) || other.batchNo == batchNo) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, matCode, batchNo, serialNumber, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectSubmitItemImplCopyWith<_$ArrivalCollectSubmitItemImpl>
  get copyWith =>
      __$$ArrivalCollectSubmitItemImplCopyWithImpl<
        _$ArrivalCollectSubmitItemImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectSubmitItemImplToJson(this);
  }
}

abstract class _ArrivalCollectSubmitItem implements ArrivalCollectSubmitItem {
  const factory _ArrivalCollectSubmitItem({
    @JsonKey(name: 'matcode') required final String matCode,
    @JsonKey(name: 'batchno') final String? batchNo,
    @JsonKey(name: 'sn') final String? serialNumber,
    @JsonKey(name: 'qty') required final double quantity,
  }) = _$ArrivalCollectSubmitItemImpl;

  factory _ArrivalCollectSubmitItem.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectSubmitItemImpl.fromJson;

  @override
  @JsonKey(name: 'matcode')
  String get matCode;
  @override
  @JsonKey(name: 'batchno')
  String? get batchNo;
  @override
  @JsonKey(name: 'sn')
  String? get serialNumber;
  @override
  @JsonKey(name: 'qty')
  double get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectSubmitItemImplCopyWith<_$ArrivalCollectSubmitItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ArrivalCollectSubmitFilter _$ArrivalCollectSubmitFilterFromJson(
  Map<String, dynamic> json,
) {
  return _ArrivalCollectSubmitFilter.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectSubmitFilter {
  @JsonKey(name: 'userCode')
  String get userCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'arrivalsBillid')
  String get arrivalsBillId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectSubmitFilterCopyWith<ArrivalCollectSubmitFilter>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectSubmitFilterCopyWith<$Res> {
  factory $ArrivalCollectSubmitFilterCopyWith(
    ArrivalCollectSubmitFilter value,
    $Res Function(ArrivalCollectSubmitFilter) then,
  ) =
      _$ArrivalCollectSubmitFilterCopyWithImpl<
        $Res,
        ArrivalCollectSubmitFilter
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'userCode') String userCode,
    @JsonKey(name: 'arrivalsBillid') String arrivalsBillId,
  });
}

/// @nodoc
class _$ArrivalCollectSubmitFilterCopyWithImpl<
  $Res,
  $Val extends ArrivalCollectSubmitFilter
>
    implements $ArrivalCollectSubmitFilterCopyWith<$Res> {
  _$ArrivalCollectSubmitFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userCode = null, Object? arrivalsBillId = null}) {
    return _then(
      _value.copyWith(
            userCode: null == userCode
                ? _value.userCode
                : userCode // ignore: cast_nullable_to_non_nullable
                      as String,
            arrivalsBillId: null == arrivalsBillId
                ? _value.arrivalsBillId
                : arrivalsBillId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArrivalCollectSubmitFilterImplCopyWith<$Res>
    implements $ArrivalCollectSubmitFilterCopyWith<$Res> {
  factory _$$ArrivalCollectSubmitFilterImplCopyWith(
    _$ArrivalCollectSubmitFilterImpl value,
    $Res Function(_$ArrivalCollectSubmitFilterImpl) then,
  ) = __$$ArrivalCollectSubmitFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'userCode') String userCode,
    @JsonKey(name: 'arrivalsBillid') String arrivalsBillId,
  });
}

/// @nodoc
class __$$ArrivalCollectSubmitFilterImplCopyWithImpl<$Res>
    extends
        _$ArrivalCollectSubmitFilterCopyWithImpl<
          $Res,
          _$ArrivalCollectSubmitFilterImpl
        >
    implements _$$ArrivalCollectSubmitFilterImplCopyWith<$Res> {
  __$$ArrivalCollectSubmitFilterImplCopyWithImpl(
    _$ArrivalCollectSubmitFilterImpl _value,
    $Res Function(_$ArrivalCollectSubmitFilterImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userCode = null, Object? arrivalsBillId = null}) {
    return _then(
      _$ArrivalCollectSubmitFilterImpl(
        userCode: null == userCode
            ? _value.userCode
            : userCode // ignore: cast_nullable_to_non_nullable
                  as String,
        arrivalsBillId: null == arrivalsBillId
            ? _value.arrivalsBillId
            : arrivalsBillId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ArrivalCollectSubmitFilterImpl implements _ArrivalCollectSubmitFilter {
  const _$ArrivalCollectSubmitFilterImpl({
    @JsonKey(name: 'userCode') required this.userCode,
    @JsonKey(name: 'arrivalsBillid') required this.arrivalsBillId,
  });

  factory _$ArrivalCollectSubmitFilterImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ArrivalCollectSubmitFilterImplFromJson(json);

  @override
  @JsonKey(name: 'userCode')
  final String userCode;
  @override
  @JsonKey(name: 'arrivalsBillid')
  final String arrivalsBillId;

  @override
  String toString() {
    return 'ArrivalCollectSubmitFilter(userCode: $userCode, arrivalsBillId: $arrivalsBillId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectSubmitFilterImpl &&
            (identical(other.userCode, userCode) ||
                other.userCode == userCode) &&
            (identical(other.arrivalsBillId, arrivalsBillId) ||
                other.arrivalsBillId == arrivalsBillId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userCode, arrivalsBillId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectSubmitFilterImplCopyWith<_$ArrivalCollectSubmitFilterImpl>
  get copyWith =>
      __$$ArrivalCollectSubmitFilterImplCopyWithImpl<
        _$ArrivalCollectSubmitFilterImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectSubmitFilterImplToJson(this);
  }
}

abstract class _ArrivalCollectSubmitFilter
    implements ArrivalCollectSubmitFilter {
  const factory _ArrivalCollectSubmitFilter({
    @JsonKey(name: 'userCode') required final String userCode,
    @JsonKey(name: 'arrivalsBillid') required final String arrivalsBillId,
  }) = _$ArrivalCollectSubmitFilterImpl;

  factory _ArrivalCollectSubmitFilter.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectSubmitFilterImpl.fromJson;

  @override
  @JsonKey(name: 'userCode')
  String get userCode;
  @override
  @JsonKey(name: 'arrivalsBillid')
  String get arrivalsBillId;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectSubmitFilterImplCopyWith<_$ArrivalCollectSubmitFilterImpl>
  get copyWith => throw _privateConstructorUsedError;
}
