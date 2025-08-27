import 'package:dio/dio.dart';

/// 错误处理工具类
class ErrorHandler {
  /// 处理登录错误，提取具体的错误信息
  static String handleError(dynamic error) {
    if (error is DioException) {
      // 如果是 DioException，直接返回 message（已经被我们的拦截器处理过）
      return error.message ?? '网络请求失败';
    } else if (error is Exception) {
      // 如果是其他 Exception，提取错误信息
      String errorMessage = error.toString();
      if (errorMessage.startsWith('Exception: ')) {
        return errorMessage.substring(11); // 移除 'Exception: ' 前缀
      }
      return errorMessage;
    } else {
      // 其他类型的错误
      return error.toString();
    }
  }

  /// 处理网络错误的特殊情况
  static String handleNetworkError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时，请检查网络连接';
      case DioExceptionType.sendTimeout:
        return '发送数据超时，请检查网络连接';
      case DioExceptionType.receiveTimeout:
        return '接收数据超时，请检查网络连接';
      case DioExceptionType.connectionError:
        return '网络连接失败，请检查网络设置';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return '登录已过期，请重新登录';
        } else if (statusCode == 403) {
          return '没有权限访问此功能';
        } else if (statusCode == 500) {
          return '服务器内部错误，请稍后重试';
        } else {
          return '请求失败：HTTP $statusCode';
        }
      case DioExceptionType.cancel:
        return '请求已取消';
      case DioExceptionType.unknown:
      default:
        return e.message ?? '网络异常，请检查网络连接';
    }
  }

  /// 处理业务逻辑错误
  static String handleBusinessError(Map<String, dynamic> responseData) {
    // 从响应数据中提取错误信息
    if (responseData.containsKey('msg')) {
      return responseData['msg'].toString();
    } else if (responseData.containsKey('message')) {
      return responseData['message'].toString();
    } else if (responseData.containsKey('error')) {
      return responseData['error'].toString();
    } else {
      return '操作失败';
    }
  }
}
