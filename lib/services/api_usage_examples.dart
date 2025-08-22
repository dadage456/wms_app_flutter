

import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/services/api_service.dart';

/// API使用示例类
/// 展示如何使用ApiService和ApiResponseHandler
class ApiUsageExamples {
  final ApiService _apiService = ApiService();

  /// 登录示例
  Future<void> loginExample() async {
    try {
      // 登录成功时返回token
      final String token = await _apiService.login('username', 'password');
      print('登录成功，获取到token: $token');

      // 登录失败时会抛出异常，包含服务端的msg信息
    } catch (e) {
      print('登录失败: ${e.toString()}');
    }
  }

  /// 获取用户信息示例
  Future<void> getUserInfoExample() async {
    try {
      // 成功时返回UserInfoModel对象
      final UserInfoModel userInfo = await _apiService.getUserInfo();
      print('获取用户信息成功: ${userInfo.username}');

      // 失败时会抛出异常，包含服务端的msg信息
    } catch (e) {
      print('获取用户信息失败: ${e.toString()}');
    }
  }

  /// 更新用户信息示例
  Future<void> updateUserInfoExample() async {
    try {
      final userInfo = UserInfoModel(username: 'newUsername');

      // 成功时不返回数据，失败时抛出异常
      await _apiService.updateUserInfo(userInfo);
      print('更新用户信息成功');
    } catch (e) {
      print('更新用户信息失败: ${e.toString()}');
    }
  }

  /// 获取列表数据示例
  Future<void> getListDataExample() async {
    try {
      // 成功时返回List<dynamic>数据
      final List<dynamic> listData =
          await _apiService.getListData(page: 1, size: 10);
      print('获取列表数据成功，共${listData.length}条');

      // 失败时会抛出异常，包含服务端的msg信息
    } catch (e) {
      print('获取列表数据失败: ${e.toString()}');
    }
  }

  /// 自定义API调用示例
  Future<void> customApiExample() async {
    try {
      // 这里可以添加自定义的API调用
      // 使用ApiResponseHandler.handleResponse来处理响应
      print('自定义API调用示例');
    } catch (e) {
      print('自定义API调用失败: ${e.toString()}');
    }
  }
}

/// 响应格式说明
/// 
/// 标准响应格式：
/// {
///   "code": 200,           // 状态码，200表示成功
///   "msg": "操作成功",      // 消息
///   "data": {              // 数据字段
///     // 具体数据内容
///   }
/// }
/// 
/// 登录等特殊接口响应格式：
/// {
///   "code": 200,           // 状态码，200表示成功
///   "msg": "登录成功",      // 消息
///   "token": "token"       // 直接返回的字段
/// }
/// 
/// 错误响应格式：
/// {
///   "code": 400,           // 错误状态码
///   "msg": "用户名或密码错误"  // 错误消息
/// }
