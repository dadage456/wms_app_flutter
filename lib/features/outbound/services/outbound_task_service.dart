import 'package:dio/dio.dart';
import 'package:wms_app/services/api_response_handler.dart';
import '../models/outbound_task.dart';
import '../models/outbound_task_item.dart';

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

  /// 获取出库任务明细列表
  ///
  /// [query] 查询参数
  /// 返回出库任务明细列表响应
  Future<OutboundTaskItemListData> getOutboundTaskItemList({
    required OutboundTaskItemQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/outTaskitemList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return OutboundTaskItemListData.fromJson(data);
      },
    );
  }

  /// 通过二维码获取物料信息
  ///
  /// [qrContent] 二维码内容
  /// 返回物料信息响应
  Future<MaterialInfoResponse> getMaterialInfoByQR(String qrContent) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getPmMaterialInfoByQR',
      data: {'qrContent': qrContent},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return MaterialInfoResponse.fromJson(data);
      },
    );
  }

  /// 撤销出库任务明细
  ///
  /// [taskItemIds] 任务明细ID列表
  /// [operationType] 操作类型（'0'表示撤销）
  /// [confirm] 确认标志
  /// 返回撤销操作响应
  Future<void> cancelOutboundTaskItems({
    required List<String> taskItemIds,
    String operationType = '0',
    String confirm = 'true',
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitRCOutTaskItem',
      data: {
        'outtaskitemids': taskItemIds,
        'roomTag': operationType,
        'isCanel': confirm,
      },
    );
  }

  /// 解析扫码内容获取物料编码
  ///
  /// [content] 扫码内容
  /// 返回物料编码，如果无法解析则返回null
  String? parseQRContent(String content) {
    if (content.isEmpty) {
      return null;
    }

    // 新格式二维码处理（包含'MC'标识）
    if (content.contains('MC')) {
      // 这里需要调用API解析，返回null表示需要异步处理
      return null;
    }

    // 旧格式条码处理（包含'\$KW\$'标识）
    if (content.contains(r'\$KW\$')) {
      final parts = content.split(r'\$');
      if (parts.length > 2) {
        return parts[2];
      }
    }

    // 直接返回内容作为物料编码
    return content;
  }
}
