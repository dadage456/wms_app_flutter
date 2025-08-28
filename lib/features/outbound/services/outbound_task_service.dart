import 'package:dio/dio.dart';
import 'package:wms_app/services/api_response_handler.dart';
import '../models/outbound_task.dart';

/// 出库任务服务
class OutboundTaskService {
  final Dio _dio;

  OutboundTaskService(this._dio);

  /// 获取出库任务列表
  Future<OutboundTaskListData> getOutboundTaskList({
    required OutboundTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/outList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return OutboundTaskListData.fromJson(data);
      },
    );
  }
}
