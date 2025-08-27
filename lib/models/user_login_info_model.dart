import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login_info_model.freezed.dart';
part 'user_login_info_model.g.dart';

@freezed
class UserLoginInfoModel with _$UserLoginInfoModel {
  const factory UserLoginInfoModel({
    required String username,
    required String password,
  }) = _UserLoginInfoModel;

  factory UserLoginInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginInfoModelFromJson(json);
}
