import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wms_app/services/api_response_handler.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late final Dio dio;

  String? _token;
  String? _username;
  String? _password;

  /// 配置认证信息
  void configToken({
    required String? token,
    required String? username,
    required String? password,
  }) {
    _token = token;
    _username = username;
    _password = password;
  }

  /// 清除认证信息
  void clearToken() {
    _token = null;
    _username = null;
    _password = null;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://10.12.8.123:8086", // 基础请求地址
        connectTimeout: const Duration(seconds: 10), // 连接超时时间
        receiveTimeout: const Duration(seconds: 10), // 接收数据超时时间
        sendTimeout: const Duration(seconds: 10), // 发送数据超时时间
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    // 添加拦截器
    dio.interceptors.addAll([
      if (kDebugMode) _logInterceptor(), // 仅在调试模式下添加日志拦截器
      _authInterceptor(),
    ]);
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // 在请求之前添加 token
        if (_token?.isNotEmpty == true) {
          options.headers["Authorization"] = "Bearer $_token";
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // 检查是否为网络异常
        if (_isNetworkError(e)) {
          return handler.reject(_createNetworkException(e));
        }

        // 如果是 401，说明 token 过期
        if (e.response?.statusCode == 401 &&
            _username?.isNotEmpty == true &&
            _password?.isNotEmpty == true) {
          try {
            // 刷新 token
            final newToken = await _refreshAccessToken();
            if (newToken != null) {
              _token = newToken;

              // 重新执行原始请求
              final retryResponse = await dio.fetch(e.requestOptions);
              return handler.resolve(retryResponse);
            }
          } catch (_) {
            return handler.reject(e);
          }
        }
        return handler.next(e);
      },
    );
  }

  /// 模拟刷新 token
  Future<String?> _refreshAccessToken() async {
    try {
      final response = await dio.post(
        '/login',
        data: {'username': _username, 'password': _password},
      );

      // 使用ApiResponseHandler处理响应
      return ApiResponseHandler.handleDirectResponse<String>(
        response: response,
        fieldName: 'token',
      );
    } catch (e) {
      throw Exception('刷新 token 失败：$e');
    }
  }

  /// 检查是否为网络异常
  bool _isNetworkError(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown;
  }

  /// 创建网络异常
  DioException _createNetworkException(DioException originalException) {
    String message;
    switch (originalException.type) {
      case DioExceptionType.connectionTimeout:
        message = '连接超时，请检查网络连接';
        break;
      case DioExceptionType.sendTimeout:
        message = '发送数据超时，请检查网络连接';
        break;
      case DioExceptionType.receiveTimeout:
        message = '接收数据超时，请检查网络连接';
        break;
      case DioExceptionType.connectionError:
        message = '网络连接失败，请检查网络设置';
        break;
      case DioExceptionType.unknown:
        message = '网络异常，请检查网络连接';
        break;
      default:
        message = '网络请求失败';
    }

    return DioException(
      requestOptions: originalException.requestOptions,
      message: message,
      type: originalException.type,
      error: originalException.error,
    );
  }

  /// 日志拦截器（开发阶段很有用）
  Interceptor _logInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    );
  }
}
