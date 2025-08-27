import 'package:dio/dio.dart';
import 'package:wms_app/models/user_info_model.dart';
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
  Future<void> login(String account, String password) async {
    final response = await _dio.post(
      '/login',
      data: {'username': account, 'password': password},
    );

    final token = ApiResponseHandler.handleDirectResponse<String>(
      response: response,
      fieldName: 'token',
    );

    // 保存token
    _dioClient.configToken(token: token, username: account, password: password);

    // 获取用户信息
    final userInfo = await getUserInfo();

    // 登录成功，保存用户信息
    _userManager.login(userInfo, account, password);
  }

  /// 获取用户信息
  Future<UserInfoModel> getUserInfo() async {
    final response = await _dio.get('/getInfo');
    final userInfo = ApiResponseHandler.handleResponse<UserInfoModel>(
      response: response,
      dataField: 'user',
      dataExtractor: (data) => UserInfoModel.fromJson(data),
    );
    return userInfo;
  }

  /// 退出登录
  Future<void> logout() async {
    _dioClient.clearToken();
    _userManager.logout();
  }
}
