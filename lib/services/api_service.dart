import 'package:dio/dio.dart';
import 'package:wms_app/services/api_response_handler.dart';
import 'package:wms_app/services/dio_client.dart';
import 'package:wms_app/services/user_manager.dart';

class ApiService {
  ApiService(DioClient dioClient, UserManager userManager)
    : _dioClient = dioClient,
      _userManager = userManager;

  final DioClient _dioClient;

  final UserManager _userManager;

  Dio get _dio => _dioClient.dio;

  // 登录
  Future<String> login(String account, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'username': account, 'password': password},
      );

      final token = ApiResponseHandler.handleDirectResponse<String>(
        response: response,
        fieldName: 'token',
      );

      // 保存token
      _dioClient.configToken(
        token: token,
        username: account,
        password: password,
      );

      // 使用ApiResponseHandler处理响应
      return token;
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    } catch (e) {
      throw Exception('未知错误：$e');
    }
  }

  /// 退出登录
  Future<void> logout() async {
    _dioClient.clearToken();
    _userManager.logout();
  }
}
