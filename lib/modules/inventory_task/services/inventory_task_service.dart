import 'package:dio/dio.dart';

import '../../services/api_response_handler.dart';
import '../collection_task/models/inventory_collect_models.dart';
import '../task_list/models/inventory_task.dart';

/// 平库盘点模块服务
class InventoryTaskService {
  InventoryTaskService(this._dio);

  final Dio _dio;

  /// 查询盘点任务列表
  Future<InventoryTaskListResponse> fetchInventoryTasks({
    required InventoryTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getInventoryTask',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => InventoryTaskListResponse.fromJson(
        Map<String, dynamic>.from(data as Map),
      ),
    );
  }

  /// 查询待接收盘点任务列表
  Future<InventoryTaskListResponse> fetchReceivableTasks({
    required InventoryTaskQuery query,
  }) async {
    return fetchInventoryTasks(query: query);
  }

  /// 撤销盘点任务
  Future<void> cancelTask({
    required String taskComment,
    required String userId,
  }) async {
    await _commitInventoryTask(
      taskComment: taskComment,
      userId: userId,
      isCancel: true,
    );
  }

  /// 接收盘点任务
  Future<void> receiveTask({
    required String taskComment,
    required String userId,
  }) async {
    await _commitInventoryTask(
      taskComment: taskComment,
      userId: userId,
      isCancel: false,
    );
  }

  Future<void> _commitInventoryTask({
    required String taskComment,
    required String userId,
    required bool isCancel,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/commitInventoryTask',
      queryParameters: {
        'taskcomment': taskComment,
        'userId': userId,
        'isCanel': isCancel.toString(),
      },
    );

    ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data,
    );
  }

  /// 查询盘点任务明细
  Future<List<InventoryTaskItem>> fetchInventoryTaskItems({
    required InventoryTaskItemQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getInventoryTaskItem',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data
              .map(
                (e) => InventoryTaskItem.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList();
        }
        if (data is Map<String, dynamic>) {
          final items = data['items'] as List? ?? const [];
          return items
              .map(
                (e) => InventoryTaskItem.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList();
        }
        throw Exception('盘点任务明细返回格式异常');
      },
    );
  }

  /// 解析二维码信息
  Future<InventoryBarcodeContent> fetchBarcodeContent(String qrContent) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/materialInfo',
      queryParameters: {'QRstring': qrContent},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => InventoryBarcodeContent.fromJson(
        Map<String, dynamic>.from(data as Map),
      ),
    );
  }

  /// 提交盘点采集结果
  Future<void> submitInventoryInfos(InventoryCommitRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitInventoryInfos',
      data: request.toJson(),
      options: Options(
        headers: const {
          'content-type': 'application/json;charset=UTF-8',
        },
      ),
    );

    ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data,
    );
  }

  /// 校验库位
  Future<bool> validateStoreSite({
    required String storeRoomNo,
    required String storeSiteNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getStoreSite',
      queryParameters: {
        'storeRoomNo': storeRoomNo,
        'storeSiteNo': storeSiteNo,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List && data.isNotEmpty) {
          return true;
        }
        return false;
      },
    );
  }
}
