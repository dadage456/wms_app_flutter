// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_login_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserLoginInfoModel _$UserLoginInfoModelFromJson(Map<String, dynamic> json) {
  return _UserLoginInfoModel.fromJson(json);
}

/// @nodoc
mixin _$UserLoginInfoModel {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserLoginInfoModelCopyWith<UserLoginInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLoginInfoModelCopyWith<$Res> {
  factory $UserLoginInfoModelCopyWith(
          UserLoginInfoModel value, $Res Function(UserLoginInfoModel) then) =
      _$UserLoginInfoModelCopyWithImpl<$Res, UserLoginInfoModel>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$UserLoginInfoModelCopyWithImpl<$Res, $Val extends UserLoginInfoModel>
    implements $UserLoginInfoModelCopyWith<$Res> {
  _$UserLoginInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserLoginInfoModelImplCopyWith<$Res>
    implements $UserLoginInfoModelCopyWith<$Res> {
  factory _$$UserLoginInfoModelImplCopyWith(_$UserLoginInfoModelImpl value,
          $Res Function(_$UserLoginInfoModelImpl) then) =
      __$$UserLoginInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$UserLoginInfoModelImplCopyWithImpl<$Res>
    extends _$UserLoginInfoModelCopyWithImpl<$Res, _$UserLoginInfoModelImpl>
    implements _$$UserLoginInfoModelImplCopyWith<$Res> {
  __$$UserLoginInfoModelImplCopyWithImpl(_$UserLoginInfoModelImpl _value,
      $Res Function(_$UserLoginInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$UserLoginInfoModelImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLoginInfoModelImpl implements _UserLoginInfoModel {
  const _$UserLoginInfoModelImpl(
      {required this.username, required this.password});

  factory _$UserLoginInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLoginInfoModelImplFromJson(json);

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'UserLoginInfoModel(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLoginInfoModelImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLoginInfoModelImplCopyWith<_$UserLoginInfoModelImpl> get copyWith =>
      __$$UserLoginInfoModelImplCopyWithImpl<_$UserLoginInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLoginInfoModelImplToJson(
      this,
    );
  }
}

abstract class _UserLoginInfoModel implements UserLoginInfoModel {
  const factory _UserLoginInfoModel(
      {required final String username,
      required final String password}) = _$UserLoginInfoModelImpl;

  factory _UserLoginInfoModel.fromJson(Map<String, dynamic> json) =
      _$UserLoginInfoModelImpl.fromJson;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$UserLoginInfoModelImplCopyWith<_$UserLoginInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
