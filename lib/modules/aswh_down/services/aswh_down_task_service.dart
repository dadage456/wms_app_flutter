import 'package:dio/dio.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/services/api_response_handler.dart';

/// 在线拣选任务与明细相关服务封装。
class AswhDownTaskService {
  AswhDownTaskService(this._dio);

  final Dio _dio;

  /// 获取在线拣选任务列表（对应 `getOutaskList`）
  Future<OnlinePickTaskListData> fetchTaskList({
    required OnlinePickTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/outList',
      queryParameters: query.toQueryParameters(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          OnlinePickTaskListData.fromJson(data as Map<String, dynamic>),
    );
  }

  /// 获取任务明细列表（对应 `getOutTaskitemList`）
  Future<OnlinePickTaskItemListData> fetchTaskItemList({
    required OnlinePickTaskItemQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/outTaskitemList',
      queryParameters: query.toQueryParameters(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          OnlinePickTaskItemListData.fromJson(data as Map<String, dynamic>),
    );
  }

  /// 批量接收/撤销出库任务明细（对应 `CommitRCOutTaskItem`）
  Future<void> commitTaskItems({
    required List<String> taskItemIds,
    bool isCancel = false,
    String roomTag = '0',
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitRCOutTaskItem',
      data: {
        'outtaskitemids': taskItemIds,
        'roomTag': roomTag,
        'isCanel': isCancel.toString(),
      },
    );
  }
}
