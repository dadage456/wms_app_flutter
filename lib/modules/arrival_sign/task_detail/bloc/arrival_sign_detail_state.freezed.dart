// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_sign_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArrivalSignDetailState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ArrivalSignDetail> get details => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArrivalSignDetailStateCopyWith<ArrivalSignDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalSignDetailStateCopyWith<$Res> {
  factory $ArrivalSignDetailStateCopyWith(ArrivalSignDetailState value,
          $Res Function(ArrivalSignDetailState) then) =
      _$ArrivalSignDetailStateCopyWithImpl<$Res, ArrivalSignDetailState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<ArrivalSignDetail> details,
      int currentPage,
      int totalPages,
      String? errorMessage});
}

/// @nodoc
class _$ArrivalSignDetailStateCopyWithImpl<$Res,
        $Val extends ArrivalSignDetailState>
    implements $ArrivalSignDetailStateCopyWith<$Res> {
  _$ArrivalSignDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? details = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<ArrivalSignDetail>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArrivalSignDetailStateImplCopyWith<$Res>
    implements $ArrivalSignDetailStateCopyWith<$Res> {
  factory _$$ArrivalSignDetailStateImplCopyWith(
          _$ArrivalSignDetailStateImpl value,
          $Res Function(_$ArrivalSignDetailStateImpl) then) =
      __$$ArrivalSignDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<ArrivalSignDetail> details,
      int currentPage,
      int totalPages,
      String? errorMessage});
}

/// @nodoc
class __$$ArrivalSignDetailStateImplCopyWithImpl<$Res>
    extends _$ArrivalSignDetailStateCopyWithImpl<$Res,
        _$ArrivalSignDetailStateImpl>
    implements _$$ArrivalSignDetailStateImplCopyWith<$Res> {
  __$$ArrivalSignDetailStateImplCopyWithImpl(
      _$ArrivalSignDetailStateImpl _value,
      $Res Function(_$ArrivalSignDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? details = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ArrivalSignDetailStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      details: null == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<ArrivalSignDetail>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ArrivalSignDetailStateImpl implements _ArrivalSignDetailState {
  const _$ArrivalSignDetailStateImpl(
      {this.isLoading = false,
      final List<ArrivalSignDetail> details = const <ArrivalSignDetail>[],
      this.currentPage = 1,
      this.totalPages = 1,
      this.errorMessage})
      : _details = details;

  @override
  @JsonKey()
  final bool isLoading;
  final List<ArrivalSignDetail> _details;
  @override
  @JsonKey()
  List<ArrivalSignDetail> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ArrivalSignDetailState(isLoading: $isLoading, details: $details, currentPage: $currentPage, totalPages: $totalPages, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalSignDetailStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_details),
      currentPage,
      totalPages,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalSignDetailStateImplCopyWith<_$ArrivalSignDetailStateImpl>
      get copyWith => __$$ArrivalSignDetailStateImplCopyWithImpl<
          _$ArrivalSignDetailStateImpl>(this, _$identity);
}

abstract class _ArrivalSignDetailState implements ArrivalSignDetailState {
  const factory _ArrivalSignDetailState(
      {final bool isLoading,
      final List<ArrivalSignDetail> details,
      final int currentPage,
      final int totalPages,
      final String? errorMessage}) = _$ArrivalSignDetailStateImpl;

  @override
  bool get isLoading;
  @override
  List<ArrivalSignDetail> get details;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalSignDetailStateImplCopyWith<_$ArrivalSignDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
