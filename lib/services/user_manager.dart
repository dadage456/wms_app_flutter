import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms_app/models/user_info_model.dart';

class UserManager {
  UserInfoModel? _userInfo;
  UserInfoModel? get userInfo => _userInfo;

  UserManager._internal();

  factory UserManager() => _instance;

  static final UserManager _instance = UserManager._internal();

  bool get isLogin => _userInfo != null;

  static const String _userInfoKey = 'user_info';

  /// 保存用户信息到内存和本地存储
  Future<void> saveUserInfo(UserInfoModel userInfo) async {
    _userInfo = userInfo;

    // 保存用户信息到本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userInfoKey, jsonEncode(userInfo.toJson()));
  }

  /// 从本地存储加载用户信息
  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoString = prefs.getString(_userInfoKey);
    if (userInfoString != null) {
      final userInfoJson = jsonDecode(userInfoString);
      _userInfo = UserInfoModel.fromJson(userInfoJson);
    }
  }

  /// 清除用户信息
  Future<void> logout() async {
    _userInfo = null;

    // 清除本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);
  }

  /// 检查是否已登录
  bool get isLoggedIn {
    return _userInfo != null;
  }
}
