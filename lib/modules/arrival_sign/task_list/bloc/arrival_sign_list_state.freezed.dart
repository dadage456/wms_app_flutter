// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_sign_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArrivalSignListState {
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArrivalSignListStateCopyWith<ArrivalSignListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalSignListStateCopyWith<$Res> {
  factory $ArrivalSignListStateCopyWith(ArrivalSignListState value,
          $Res Function(ArrivalSignListState) then) =
      _$ArrivalSignListStateCopyWithImpl<$Res, ArrivalSignListState>;
  @useResult
  $Res call({bool isProcessing, String? errorMessage, String? successMessage});
}

/// @nodoc
class _$ArrivalSignListStateCopyWithImpl<$Res,
        $Val extends ArrivalSignListState>
    implements $ArrivalSignListStateCopyWith<$Res> {
  _$ArrivalSignListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArrivalSignListStateImplCopyWith<$Res>
    implements $ArrivalSignListStateCopyWith<$Res> {
  factory _$$ArrivalSignListStateImplCopyWith(_$ArrivalSignListStateImpl value,
          $Res Function(_$ArrivalSignListStateImpl) then) =
      __$$ArrivalSignListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isProcessing, String? errorMessage, String? successMessage});
}

/// @nodoc
class __$$ArrivalSignListStateImplCopyWithImpl<$Res>
    extends _$ArrivalSignListStateCopyWithImpl<$Res, _$ArrivalSignListStateImpl>
    implements _$$ArrivalSignListStateImplCopyWith<$Res> {
  __$$ArrivalSignListStateImplCopyWithImpl(_$ArrivalSignListStateImpl _value,
      $Res Function(_$ArrivalSignListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_$ArrivalSignListStateImpl(
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ArrivalSignListStateImpl implements _ArrivalSignListState {
  const _$ArrivalSignListStateImpl(
      {this.isProcessing = false, this.errorMessage, this.successMessage});

  @override
  @JsonKey()
  final bool isProcessing;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'ArrivalSignListState(isProcessing: $isProcessing, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalSignListStateImpl &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isProcessing, errorMessage, successMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArrivalSignListStateImplCopyWith<_$ArrivalSignListStateImpl>
      get copyWith =>
          __$$ArrivalSignListStateImplCopyWithImpl<_$ArrivalSignListStateImpl>(
              this, _$identity);
}

abstract class _ArrivalSignListState implements ArrivalSignListState {
  const factory _ArrivalSignListState(
      {final bool isProcessing,
      final String? errorMessage,
      final String? successMessage}) = _$ArrivalSignListStateImpl;

  @override
  bool get isProcessing;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalSignListStateImplCopyWith<_$ArrivalSignListStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
