import 'package:dio/dio.dart';

/// API响应处理工具类
class ApiResponseHandler {
  /// 处理API响应，提取数据或抛出异常
  /// [T] 期望返回的数据类型
  /// [response] Dio响应对象
  /// [dataExtractor] 从响应中提取数据的函数
  /// [successCode] 成功的状态码，默认为200
  /// [codeField] 状态码字段名，默认为'code'
  /// [messageField] 消息字段名，默认为'msg'
  /// [dataField] 数据字段名，默认为'data'
  static T handleResponse<T>({
    required Response response,
    required T Function(dynamic data) dataExtractor,
    int successCode = 200,
    String codeField = 'code',
    String messageField = 'msg',
    String dataField = 'data',
  }) {
    final dynamic responseData = response.data;

    if (responseData is! Map<String, dynamic>) {
      throw Exception('响应格式错误');
    }

    // 检查状态码
    final int? code = responseData[codeField] as int?;
    if (code != successCode) {
      final String message = responseData[messageField]?.toString() ?? '请求失败';
      throw Exception(message);
    }

    // 提取数据
    final dynamic data = responseData[dataField];
    if (data == null) {
      throw Exception('响应数据为空');
    }

    try {
      return dataExtractor(data);
    } catch (e) {
      throw Exception('数据解析失败: $e');
    }
  }

  /// 处理登录等特殊接口的响应（直接返回token等字段）
  /// [T] 期望返回的数据类型
  /// [response] Dio响应对象
  /// [fieldName] 要提取的字段名
  /// [codeField] 状态码字段名，默认为'code'
  /// [messageField] 消息字段名，默认为'msg'
  /// [successCode] 成功的状态码，默认为200
  static T handleDirectResponse<T>({
    required Response response,
    required String fieldName,
    String codeField = 'code',
    String messageField = 'msg',
    int successCode = 200,
  }) {
    final dynamic responseData = response.data;

    if (responseData is! Map<String, dynamic>) {
      throw Exception('响应格式错误');
    }

    // 检查状态码
    final int? code = responseData[codeField] as int?;
    if (code != successCode) {
      final String message = responseData[messageField]?.toString() ?? '请求失败';
      throw Exception(message);
    }

    // 提取指定字段
    final dynamic value = responseData[fieldName];
    if (value == null) {
      throw Exception('字段 $fieldName 不存在');
    }

    if (value is! T) {
      throw Exception('数据类型不匹配，期望 $T，实际 ${value.runtimeType}');
    }

    return value;
  }

  /// 处理Dio异常，提取错误信息
  static String handleDioException(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      return data['msg']?.toString() ?? e.message ?? '网络请求失败';
    }
    return e.message ?? '网络请求失败';
  }
}
