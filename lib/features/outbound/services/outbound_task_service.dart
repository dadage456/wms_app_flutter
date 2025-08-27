import 'package:dio/dio.dart';
import '../models/outbound_task.dart';

/// 出库任务服务
class OutboundTaskService {
  final Dio _dio;

  OutboundTaskService(this._dio);

  /// 获取出库任务列表
  Future<OutboundTaskListResponse> getOutboundTaskList({
    required OutboundTaskQuery query,
  }) async {
    try {
      final response = await _dio.post(
        '/system/terminal/outList',
        data: query.toJson(),
      );

      return OutboundTaskListResponse.fromJson(response.data);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw Exception('网络连接超时，请检查网络设置');
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 401) {
            throw Exception('登录已过期，请重新登录');
          } else if (statusCode == 403) {
            throw Exception('没有权限访问此功能');
          } else if (statusCode == 500) {
            throw Exception('服务器内部错误，请稍后重试');
          } else {
            throw Exception('请求失败：HTTP $statusCode');
          }
        case DioExceptionType.cancel:
          throw Exception('请求已取消');
        case DioExceptionType.unknown:
        default:
          throw Exception('网络错误：${e.message}');
      }
    } catch (e) {
      throw Exception('获取出库任务列表失败：$e');
    }
  }
}