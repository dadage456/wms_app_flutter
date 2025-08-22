import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wms_app/common/token_manager.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/services/api_response_handler.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl:
            'http://10.12.8.123:8086', // TODO: Replace with your API base URL
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    // Add interceptors for logging or authentication if needed
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(responseBody: true));
    }

    // Attach Authorization header from secure storage token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = await TokenManager.instance.readToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (_) {}
          handler.next(options);
        },
      ),
    );
  }

  // 登录
  Future<String> login(String account, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'username': account,
          'password': password,
        },
      );

      // 使用ApiResponseHandler处理响应
      return ApiResponseHandler.handleDirectResponse<String>(
        response: response,
        fieldName: 'token',
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    } catch (e) {
      throw Exception('未知错误：$e');
    }
  }

  // 获取用户信息
  Future<UserInfoModel> getUserInfo() async {
    try {
      final response = await _dio.get('/user/info');

      return ApiResponseHandler.handleResponse<UserInfoModel>(
        response: response,
        dataExtractor: (data) => UserInfoModel.fromJson(data),
        successCode: 200,
        codeField: 'code',
        messageField: 'msg',
        dataField: 'data',
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    } catch (e) {
      throw Exception('获取用户信息失败：$e');
    }
  }

  // 更新用户信息
  Future<void> updateUserInfo(UserInfoModel userInfo) async {
    try {
      final response = await _dio.put(
        '/user/info',
        data: userInfo.toJson(),
      );

      ApiResponseHandler.handleResponse<void>(
        response: response,
        dataExtractor: (_) {},
        successCode: 200,
        codeField: 'code',
        messageField: 'msg',
        dataField: 'data',
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    } catch (e) {
      throw Exception('更新用户信息失败：$e');
    }
  }

  // 获取列表数据
  Future<List<dynamic>> getListData({int page = 1, int size = 10}) async {
    try {
      final response = await _dio.get('/list', queryParameters: {
        'page': page,
        'size': size,
      });

      return ApiResponseHandler.handleResponse<List<dynamic>>(
        response: response,
        dataExtractor: (data) => data as List<dynamic>,
        successCode: 200,
        codeField: 'code',
        messageField: 'msg',
        dataField: 'data',
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    } catch (e) {
      throw Exception('获取列表数据失败：$e');
    }
  }
}
