// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_collect_cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ArrivalCollectCache _$ArrivalCollectCacheFromJson(Map<String, dynamic> json) {
  return _ArrivalCollectCache.fromJson(json);
}

/// @nodoc
mixin _$ArrivalCollectCache {
  List<ArrivalCollectProgress> get progresses =>
      throw _privateConstructorUsedError;
  bool get hasPendingSubmit => throw _privateConstructorUsedError;
  String? get arrivalsBillId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArrivalCollectCacheCopyWith<ArrivalCollectCache> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalCollectCacheCopyWith<$Res> {
  factory $ArrivalCollectCacheCopyWith(
    ArrivalCollectCache value,
    $Res Function(ArrivalCollectCache) then,
  ) = _$ArrivalCollectCacheCopyWithImpl<$Res, ArrivalCollectCache>;
  @useResult
  $Res call({
    List<ArrivalCollectProgress> progresses,
    bool hasPendingSubmit,
    String? arrivalsBillId,
  });
}

/// @nodoc
class _$ArrivalCollectCacheCopyWithImpl<$Res, $Val extends ArrivalCollectCache>
    implements $ArrivalCollectCacheCopyWith<$Res> {
  _$ArrivalCollectCacheCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progresses = null,
    Object? hasPendingSubmit = null,
    Object? arrivalsBillId = freezed,
  }) {
    return _then(
      _value.copyWith(
            progresses: null == progresses
                ? _value.progresses
                : progresses // ignore: cast_nullable_to_non_nullable
                      as List<ArrivalCollectProgress>,
            hasPendingSubmit: null == hasPendingSubmit
                ? _value.hasPendingSubmit
                : hasPendingSubmit // ignore: cast_nullable_to_non_nullable
                      as bool,
            arrivalsBillId: freezed == arrivalsBillId
                ? _value.arrivalsBillId
                : arrivalsBillId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ArrivalCollectCacheImplCopyWith<$Res>
    implements $ArrivalCollectCacheCopyWith<$Res> {
  factory _$$ArrivalCollectCacheImplCopyWith(
    _$ArrivalCollectCacheImpl value,
    $Res Function(_$ArrivalCollectCacheImpl) then,
  ) = __$$ArrivalCollectCacheImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ArrivalCollectProgress> progresses,
    bool hasPendingSubmit,
    String? arrivalsBillId,
  });
}

/// @nodoc
class __$$ArrivalCollectCacheImplCopyWithImpl<$Res>
    extends _$ArrivalCollectCacheCopyWithImpl<$Res, _$ArrivalCollectCacheImpl>
    implements _$$ArrivalCollectCacheImplCopyWith<$Res> {
  __$$ArrivalCollectCacheImplCopyWithImpl(
    _$ArrivalCollectCacheImpl _value,
    $Res Function(_$ArrivalCollectCacheImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progresses = null,
    Object? hasPendingSubmit = null,
    Object? arrivalsBillId = freezed,
  }) {
    return _then(
      _$ArrivalCollectCacheImpl(
        progresses: null == progresses
            ? _value._progresses
            : progresses // ignore: cast_nullable_to_non_nullable
                  as List<ArrivalCollectProgress>,
        hasPendingSubmit: null == hasPendingSubmit
            ? _value.hasPendingSubmit
            : hasPendingSubmit // ignore: cast_nullable_to_non_nullable
                  as bool,
        arrivalsBillId: freezed == arrivalsBillId
            ? _value.arrivalsBillId
            : arrivalsBillId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ArrivalCollectCacheImpl implements _ArrivalCollectCache {
  const _$ArrivalCollectCacheImpl({
    final List<ArrivalCollectProgress> progresses =
        const <ArrivalCollectProgress>[],
    this.hasPendingSubmit = false,
    this.arrivalsBillId,
  }) : _progresses = progresses;

  factory _$ArrivalCollectCacheImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArrivalCollectCacheImplFromJson(json);

  final List<ArrivalCollectProgress> _progresses;
  @override
  @JsonKey()
  List<ArrivalCollectProgress> get progresses {
    if (_progresses is EqualUnmodifiableListView) return _progresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progresses);
  }

  @override
  @JsonKey()
  final bool hasPendingSubmit;
  @override
  final String? arrivalsBillId;

  @override
  String toString() {
    return 'ArrivalCollectCache(progresses: $progresses, hasPendingSubmit: $hasPendingSubmit, arrivalsBillId: $arrivalsBillId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalCollectCacheImpl &&
            const DeepCollectionEquality().equals(
              other._progresses,
              _progresses,
            ) &&
            (identical(other.hasPendingSubmit, hasPendingSubmit) ||
                other.hasPendingSubmit == hasPendingSubmit) &&
            (identical(other.arrivalsBillId, arrivalsBillId) ||
                other.arrivalsBillId == arrivalsBillId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_progresses),
    hasPendingSubmit,
    arrivalsBillId,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalCollectCacheImplCopyWith<_$ArrivalCollectCacheImpl> get copyWith =>
      __$$ArrivalCollectCacheImplCopyWithImpl<_$ArrivalCollectCacheImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ArrivalCollectCacheImplToJson(this);
  }
}

abstract class _ArrivalCollectCache implements ArrivalCollectCache {
  const factory _ArrivalCollectCache({
    final List<ArrivalCollectProgress> progresses,
    final bool hasPendingSubmit,
    final String? arrivalsBillId,
  }) = _$ArrivalCollectCacheImpl;

  factory _ArrivalCollectCache.fromJson(Map<String, dynamic> json) =
      _$ArrivalCollectCacheImpl.fromJson;

  @override
  List<ArrivalCollectProgress> get progresses;
  @override
  bool get hasPendingSubmit;
  @override
  String? get arrivalsBillId;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalCollectCacheImplCopyWith<_$ArrivalCollectCacheImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
