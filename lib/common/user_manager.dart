import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms_app/common/token_manager.dart';
import 'package:wms_app/models/user_info_model.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  UserInfoModel? _userInfo;
  static const String _userInfoKey = 'user_info';

  String? _token;
  String? get token => _token;

  UserInfoModel? get userInfo => _userInfo;

  /// 保存用户信息到内存和本地存储
  Future<void> saveUserInfo(UserInfoModel userInfo, String token) async {
    _userInfo = userInfo;
    _token = token;

    // 保存用户信息到本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userInfoKey, jsonEncode(userInfo.toJson()));

    // 同时将 Token 保存到安全存储
    if (_token != null && _token!.isNotEmpty) {
      await TokenManager.instance.saveToken(_token!);
    }
  }

  /// 从本地存储加载用户信息
  Future<void> loadUserInfo() async {
    try {
      // 从本地存储加载用户信息
      final prefs = await SharedPreferences.getInstance();
      final userInfoString = prefs.getString(_userInfoKey);
      if (userInfoString != null) {
        try {
          final userInfoJson = jsonDecode(userInfoString);
          _userInfo = UserInfoModel.fromJson(userInfoJson);
        } catch (e) {
          // 如果解析失败，清除损坏的数据
          await prefs.remove(_userInfoKey);
          _userInfo = null;
        }
      }

      // 从安全存储加载token
      _token = await TokenManager.instance.readToken();

      // 验证token和用户信息的一致性
      if (_userInfo == null || _token == null || _token!.isEmpty) {
        // 如果任一为空，清除所有信息
        _userInfo = null;
        _token = null;
        await clearUserInfo();
      }
    } catch (e) {
      // 如果出现错误，清除所有信息
      _userInfo = null;
      _token = null;
      await clearUserInfo();
    }
  }

  /// 清除用户信息
  Future<void> clearUserInfo() async {
    _userInfo = null;
    _token = null;

    // 清除本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);

    // 同时清除安全存储中的 Token
    await TokenManager.instance.deleteToken();
  }

  /// 检查是否已登录
  bool get isLoggedIn {
    return _userInfo != null && _token != null && _token!.isNotEmpty;
  }

  /// 从安全存储中读取 Token
  Future<String?> readSecureToken() async {
    return await TokenManager.instance.readToken();
  }

  /// 检查是否有有效的安全存储 Token
  Future<bool> hasValidToken() async {
    return await TokenManager.instance.hasToken();
  }

  /// 获取用户名
  String? get username => _userInfo?.username;

  /// 检查用户信息是否完整
  bool get hasCompleteUserInfo => _userInfo != null && _token != null;
}
