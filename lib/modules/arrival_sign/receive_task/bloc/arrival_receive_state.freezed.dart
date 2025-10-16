// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arrival_receive_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ArrivalReceiveState {
  bool get isProcessing => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArrivalReceiveStateCopyWith<ArrivalReceiveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArrivalReceiveStateCopyWith<$Res> {
  factory $ArrivalReceiveStateCopyWith(
          ArrivalReceiveState value, $Res Function(ArrivalReceiveState) then) =
      _$ArrivalReceiveStateCopyWithImpl<$Res, ArrivalReceiveState>;
  @useResult
  $Res call({bool isProcessing, String? errorMessage, String? successMessage});
}

/// @nodoc
class _$ArrivalReceiveStateCopyWithImpl<$Res, $Val extends ArrivalReceiveState>
    implements $ArrivalReceiveStateCopyWith<$Res> {
  _$ArrivalReceiveStateCopyWithImpl(this._value, this._then);

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
abstract class _$$ArrivalReceiveStateImplCopyWith<$Res>
    implements $ArrivalReceiveStateCopyWith<$Res> {
  factory _$$ArrivalReceiveStateImplCopyWith(_$ArrivalReceiveStateImpl value,
          $Res Function(_$ArrivalReceiveStateImpl) then) =
      __$$ArrivalReceiveStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isProcessing, String? errorMessage, String? successMessage});
}

/// @nodoc
class __$$ArrivalReceiveStateImplCopyWithImpl<$Res>
    extends _$ArrivalReceiveStateCopyWithImpl<$Res, _$ArrivalReceiveStateImpl>
    implements _$$ArrivalReceiveStateImplCopyWith<$Res> {
  __$$ArrivalReceiveStateImplCopyWithImpl(_$ArrivalReceiveStateImpl _value,
      $Res Function(_$ArrivalReceiveStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_$ArrivalReceiveStateImpl(
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

class _$ArrivalReceiveStateImpl implements _ArrivalReceiveState {
  const _$ArrivalReceiveStateImpl(
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
    return 'ArrivalReceiveState(isProcessing: $isProcessing, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArrivalReceiveStateImpl &&
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
  _$$ArrivalReceiveStateImplCopyWith<_$ArrivalReceiveStateImpl> get copyWith =>
      __$$ArrivalReceiveStateImplCopyWithImpl<_$ArrivalReceiveStateImpl>(
          this, _$identity);
}

abstract class _ArrivalReceiveState implements ArrivalReceiveState {
  const factory _ArrivalReceiveState(
      {final bool isProcessing,
      final String? errorMessage,
      final String? successMessage}) = _$ArrivalReceiveStateImpl;

  @override
  bool get isProcessing;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;
  @override
  @JsonKey(ignore: true)
  _$$ArrivalReceiveStateImplCopyWith<_$ArrivalReceiveStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
