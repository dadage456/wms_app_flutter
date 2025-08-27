import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/models/user_login_info_model.dart';

class UserManager {
  // 用户用来再次的登录信息
  UserLoginInfoModel? _userLoginInfo;
  UserLoginInfoModel? get userLoginInfo => _userLoginInfo;

  // 用户登录后获取的信息
  UserInfoModel? _userInfo;
  UserInfoModel? get userInfo => _userInfo;

  UserManager._internal();

  factory UserManager() => _instance;

  static final UserManager _instance = UserManager._internal();

  // 用户是否登录
  bool get isLogin => _userInfo != null;

  /// 用户登录
  void login(UserInfoModel userInfo, String name, String password) {
    _userInfo = userInfo;
    _userLoginInfo = UserLoginInfoModel(username: name, password: password);
    UserLoginInfoManage.saveUserLoginInfo(_userLoginInfo!);
  }

  /// 清除用户信息
  void logout() async {
    _userInfo = null;
  }

  Future<void> clear() async {
    _userLoginInfo = null;
    _userInfo = null;
  }

  Future<void> loadUserLoginInfo() async {
    _userLoginInfo = await UserLoginInfoManage.loadUserLoginInfo();
  }
}

class UserLoginInfoManage {
  static const String _userLoginInfoKey = 'user_login_info';

  /// 保存用户登录信息
  static Future<void> saveUserLoginInfo(UserLoginInfoModel userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userLoginInfoKey, jsonEncode(userInfo.toJson()));
  }

  /// 从本地存储加载用户登录信息
  static Future<UserLoginInfoModel?> loadUserLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoString = prefs.getString(_userLoginInfoKey);
    if (userInfoString != null) {
      final userInfoJson = jsonDecode(userInfoString);
      return UserLoginInfoModel.fromJson(userInfoJson);
    }
    return null;
  }

  /// 清除用户登录信息
  static Future<void> clearUserLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userLoginInfoKey);
  }
}
