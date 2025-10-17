// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_query_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InventoryQueryRequest _$InventoryQueryRequestFromJson(
  Map<String, dynamic> json,
) {
  return _InventoryQueryRequest.fromJson(json);
}

/// @nodoc
mixin _$InventoryQueryRequest {
  /// 查询条件，物料/库位/托盘均通过 barcode 字段传递。
  @JsonKey(name: 'barcode')
  String get barcode => throw _privateConstructorUsedError;

  /// 查询类型，M=物料，S=库位，P=托盘。
  @JsonKey(name: 'currStep')
  String get queryType => throw _privateConstructorUsedError;

  /// 页码（后端接口使用大写字段名）。
  @JsonKey(name: 'PageIndex')
  int get pageIndex => throw _privateConstructorUsedError;

  /// 页大小（后端接口使用大写字段名）。
  @JsonKey(name: 'PageSize')
  int get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryQueryRequestCopyWith<InventoryQueryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryQueryRequestCopyWith<$Res> {
  factory $InventoryQueryRequestCopyWith(
    InventoryQueryRequest value,
    $Res Function(InventoryQueryRequest) then,
  ) = _$InventoryQueryRequestCopyWithImpl<$Res, InventoryQueryRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'barcode') String barcode,
    @JsonKey(name: 'currStep') String queryType,
    @JsonKey(name: 'PageIndex') int pageIndex,
    @JsonKey(name: 'PageSize') int pageSize,
  });
}

/// @nodoc
class _$InventoryQueryRequestCopyWithImpl<
  $Res,
  $Val extends InventoryQueryRequest
>
    implements $InventoryQueryRequestCopyWith<$Res> {
  _$InventoryQueryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
    Object? queryType = null,
    Object? pageIndex = null,
    Object? pageSize = null,
  }) {
    return _then(
      _value.copyWith(
            barcode: null == barcode
                ? _value.barcode
                : barcode // ignore: cast_nullable_to_non_nullable
                      as String,
            queryType: null == queryType
                ? _value.queryType
                : queryType // ignore: cast_nullable_to_non_nullable
                      as String,
            pageIndex: null == pageIndex
                ? _value.pageIndex
                : pageIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryQueryRequestImplCopyWith<$Res>
    implements $InventoryQueryRequestCopyWith<$Res> {
  factory _$$InventoryQueryRequestImplCopyWith(
    _$InventoryQueryRequestImpl value,
    $Res Function(_$InventoryQueryRequestImpl) then,
  ) = __$$InventoryQueryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'barcode') String barcode,
    @JsonKey(name: 'currStep') String queryType,
    @JsonKey(name: 'PageIndex') int pageIndex,
    @JsonKey(name: 'PageSize') int pageSize,
  });
}

/// @nodoc
class __$$InventoryQueryRequestImplCopyWithImpl<$Res>
    extends
        _$InventoryQueryRequestCopyWithImpl<$Res, _$InventoryQueryRequestImpl>
    implements _$$InventoryQueryRequestImplCopyWith<$Res> {
  __$$InventoryQueryRequestImplCopyWithImpl(
    _$InventoryQueryRequestImpl _value,
    $Res Function(_$InventoryQueryRequestImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
    Object? queryType = null,
    Object? pageIndex = null,
    Object? pageSize = null,
  }) {
    return _then(
      _$InventoryQueryRequestImpl(
        barcode: null == barcode
            ? _value.barcode
            : barcode // ignore: cast_nullable_to_non_nullable
                  as String,
        queryType: null == queryType
            ? _value.queryType
            : queryType // ignore: cast_nullable_to_non_nullable
                  as String,
        pageIndex: null == pageIndex
            ? _value.pageIndex
            : pageIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryQueryRequestImpl extends _InventoryQueryRequest {
  const _$InventoryQueryRequestImpl({
    @JsonKey(name: 'barcode') required this.barcode,
    @JsonKey(name: 'currStep') required this.queryType,
    @JsonKey(name: 'PageIndex') this.pageIndex = 1,
    @JsonKey(name: 'PageSize') this.pageSize = 10000,
  }) : super._();

  factory _$InventoryQueryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryQueryRequestImplFromJson(json);

  /// 查询条件，物料/库位/托盘均通过 barcode 字段传递。
  @override
  @JsonKey(name: 'barcode')
  final String barcode;

  /// 查询类型，M=物料，S=库位，P=托盘。
  @override
  @JsonKey(name: 'currStep')
  final String queryType;

  /// 页码（后端接口使用大写字段名）。
  @override
  @JsonKey(name: 'PageIndex')
  final int pageIndex;

  /// 页大小（后端接口使用大写字段名）。
  @override
  @JsonKey(name: 'PageSize')
  final int pageSize;

  @override
  String toString() {
    return 'InventoryQueryRequest(barcode: $barcode, queryType: $queryType, pageIndex: $pageIndex, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryQueryRequestImpl &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.queryType, queryType) ||
                other.queryType == queryType) &&
            (identical(other.pageIndex, pageIndex) ||
                other.pageIndex == pageIndex) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, barcode, queryType, pageIndex, pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryQueryRequestImplCopyWith<_$InventoryQueryRequestImpl>
  get copyWith =>
      __$$InventoryQueryRequestImplCopyWithImpl<_$InventoryQueryRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryQueryRequestImplToJson(this);
  }
}

abstract class _InventoryQueryRequest extends InventoryQueryRequest {
  const factory _InventoryQueryRequest({
    @JsonKey(name: 'barcode') required final String barcode,
    @JsonKey(name: 'currStep') required final String queryType,
    @JsonKey(name: 'PageIndex') final int pageIndex,
    @JsonKey(name: 'PageSize') final int pageSize,
  }) = _$InventoryQueryRequestImpl;
  const _InventoryQueryRequest._() : super._();

  factory _InventoryQueryRequest.fromJson(Map<String, dynamic> json) =
      _$InventoryQueryRequestImpl.fromJson;

  @override
  /// 查询条件，物料/库位/托盘均通过 barcode 字段传递。
  @JsonKey(name: 'barcode')
  String get barcode;
  @override
  /// 查询类型，M=物料，S=库位，P=托盘。
  @JsonKey(name: 'currStep')
  String get queryType;
  @override
  /// 页码（后端接口使用大写字段名）。
  @JsonKey(name: 'PageIndex')
  int get pageIndex;
  @override
  /// 页大小（后端接口使用大写字段名）。
  @JsonKey(name: 'PageSize')
  int get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$InventoryQueryRequestImplCopyWith<_$InventoryQueryRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
