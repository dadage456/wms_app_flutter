import 'package:dio/dio.dart';

import '../../../services/api_response_handler.dart';
import '../task_list/models/inventory_task.dart';

/// 立库盘点任务服务
class AswhInventoryTaskService {
  AswhInventoryTaskService(this._dio);

  final Dio _dio;

  /// 查询立库盘点任务
  Future<InventoryTaskListData> fetchInventoryTasks({
    required InventoryTaskFilter filter,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getInventoryTask',
      queryParameters: filter.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          InventoryTaskListData.fromJson(data as Map<String, dynamic>),
    );
  }

  /// 撤销盘点任务
  Future<void> cancelInventoryTask({
    required String taskComment,
    required String userId,
    bool confirm = true,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/commitInventoryTask',
      queryParameters: {
        'taskcomment': taskComment,
        'userId': userId,
        'isCanel': confirm.toString(),
      },
    );

    ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data,
    );
  }
}
