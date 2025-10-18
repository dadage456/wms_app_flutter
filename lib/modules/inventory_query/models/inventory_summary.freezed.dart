// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventorySummary _$InventorySummaryFromJson(Map<String, dynamic> json) {
  return _InventorySummary.fromJson(json);
}

/// @nodoc
mixin _$InventorySummary {
  String get materialCode => throw _privateConstructorUsedError;
  String get materialName => throw _privateConstructorUsedError;
  String get storeSite => throw _privateConstructorUsedError;
  String get trayNo => throw _privateConstructorUsedError;
  double get totalQuantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventorySummaryCopyWith<InventorySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventorySummaryCopyWith<$Res> {
  factory $InventorySummaryCopyWith(
          InventorySummary value, $Res Function(InventorySummary) then) =
      _$InventorySummaryCopyWithImpl<$Res, InventorySummary>;
  @useResult
  $Res call(
      {String materialCode,
      String materialName,
      String storeSite,
      String trayNo,
      double totalQuantity});
}

/// @nodoc
class _$InventorySummaryCopyWithImpl<$Res, $Val extends InventorySummary>
    implements $InventorySummaryCopyWith<$Res> {
  _$InventorySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = null,
    Object? storeSite = null,
    Object? trayNo = null,
    Object? totalQuantity = null,
  }) {
    return _then(_value.copyWith(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: null == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String,
      storeSite: null == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventorySummaryImplCopyWith<$Res>
    implements $InventorySummaryCopyWith<$Res> {
  factory _$$InventorySummaryImplCopyWith(_$InventorySummaryImpl value,
          $Res Function(_$InventorySummaryImpl) then) =
      __$$InventorySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String materialCode,
      String materialName,
      String storeSite,
      String trayNo,
      double totalQuantity});
}

/// @nodoc
class __$$InventorySummaryImplCopyWithImpl<$Res>
    extends _$InventorySummaryCopyWithImpl<$Res, _$InventorySummaryImpl>
    implements _$$InventorySummaryImplCopyWith<$Res> {
  __$$InventorySummaryImplCopyWithImpl(_$InventorySummaryImpl _value,
      $Res Function(_$InventorySummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialCode = null,
    Object? materialName = null,
    Object? storeSite = null,
    Object? trayNo = null,
    Object? totalQuantity = null,
  }) {
    return _then(_$InventorySummaryImpl(
      materialCode: null == materialCode
          ? _value.materialCode
          : materialCode // ignore: cast_nullable_to_non_nullable
              as String,
      materialName: null == materialName
          ? _value.materialName
          : materialName // ignore: cast_nullable_to_non_nullable
              as String,
      storeSite: null == storeSite
          ? _value.storeSite
          : storeSite // ignore: cast_nullable_to_non_nullable
              as String,
      trayNo: null == trayNo
          ? _value.trayNo
          : trayNo // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventorySummaryImpl implements _InventorySummary {
  const _$InventorySummaryImpl(
      {this.materialCode = '',
      this.materialName = '',
      this.storeSite = '',
      this.trayNo = '',
      this.totalQuantity = 0.0});

  factory _$InventorySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventorySummaryImplFromJson(json);

  @override
  @JsonKey()
  final String materialCode;
  @override
  @JsonKey()
  final String materialName;
  @override
  @JsonKey()
  final String storeSite;
  @override
  @JsonKey()
  final String trayNo;
  @override
  @JsonKey()
  final double totalQuantity;

  @override
  String toString() {
    return 'InventorySummary(materialCode: $materialCode, materialName: $materialName, storeSite: $storeSite, trayNo: $trayNo, totalQuantity: $totalQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventorySummaryImpl &&
            (identical(other.materialCode, materialCode) ||
                other.materialCode == materialCode) &&
            (identical(other.materialName, materialName) ||
                other.materialName == materialName) &&
            (identical(other.storeSite, storeSite) ||
                other.storeSite == storeSite) &&
            (identical(other.trayNo, trayNo) || other.trayNo == trayNo) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, materialCode, materialName,
      storeSite, trayNo, totalQuantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InventorySummaryImplCopyWith<_$InventorySummaryImpl> get copyWith =>
      __$$InventorySummaryImplCopyWithImpl<_$InventorySummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventorySummaryImplToJson(
      this,
    );
  }
}

abstract class _InventorySummary implements InventorySummary {
  const factory _InventorySummary(
      {final String materialCode,
      final String materialName,
      final String storeSite,
      final String trayNo,
      final double totalQuantity}) = _$InventorySummaryImpl;

  factory _InventorySummary.fromJson(Map<String, dynamic> json) =
      _$InventorySummaryImpl.fromJson;

  @override
  String get materialCode;
  @override
  String get materialName;
  @override
  String get storeSite;
  @override
  String get trayNo;
  @override
  double get totalQuantity;
  @override
  @JsonKey(ignore: true)
  _$$InventorySummaryImplCopyWith<_$InventorySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
