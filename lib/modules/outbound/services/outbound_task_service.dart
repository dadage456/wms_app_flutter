import 'package:dio/dio.dart';
import 'package:wms_app/services/api_response_handler.dart';
import '../task_list/models/outbound_task.dart';
import '../task_details/models/outbound_task_item.dart';
import '../collection_task/models/outbound_collect_models.dart';

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

  /// 获取出库任务采集明细列表
  ///
  /// [query] 查询参数
  /// 返回出库任务采集明细列表响应
  Future<OutboundTaskItemListData> getOutTaskCollectItemList({
    required CollectTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getOutTaskItem',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return OutboundTaskItemListData.fromJson(data);
      },
    );
  }

  /// 通过库位查询库存
  ///
  /// [query] 库存查询参数
  /// 返回库存信息列表
  Future<List<InventoryInfo>> getMtlRepertoryByStoresiteNo({
    required InventoryQuery query,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getMtlRepertoryByStoresiteNo',
      data: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data.map((item) => InventoryInfo.fromJson(item)).toList();
        }
        return <InventoryInfo>[];
      },
    );
  }

  /// 通过库位和序列号查询库存
  ///
  /// [query] 库存查询参数（包含序列号）
  /// 返回库存信息列表
  Future<List<InventoryInfo>> getMtlRepertoryByStoresiteNosn({
    required InventoryQuery query,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByStoresiteNoSn',
      data: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data.map((item) => InventoryInfo.fromJson(item)).toList();
        }
        return <InventoryInfo>[];
      },
    );
  }

  /// ERP库存查询
  ///
  /// [query] 库存查询参数
  /// 返回库存信息列表
  Future<List<InventoryInfo>> getMtlRepertoryByStoresiteNoErp({
    required InventoryQuery query,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByStoresiteNoErp',
      data: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data.map((item) => InventoryInfo.fromJson(item)).toList();
        }
        return <InventoryInfo>[];
      },
    );
  }

  /// 提交出库采集数据
  ///
  /// [collectRecords] 采集记录列表
  /// 返回提交结果
  Future<SubmitCollectResponse> commitDownShelves({
    required List<CollectRecord> collectRecords,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitDownShelves',
      data: collectRecords.map((record) => record.toJson()).toList(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return SubmitCollectResponse.fromJson({
          'code': response.data?['code'] ?? '200',
          'msg': response.data?['msg'] ?? 'success',
          'data': data,
        });
      },
    );
  }

  /// 报缺出库任务明细
  ///
  /// [outTaskItemId] 任务明细ID
  /// 返回报缺结果
  Future<ReportShortageResponse> commitFinishOutTaskItem({
    required String outTaskItemId,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitFinishOutTaskItem',
      data: {'outtaskitemid': outTaskItemId},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return ReportShortageResponse.fromJson({
          'code': response.data?['code'] ?? '200',
          'msg': response.data?['msg'] ?? 'success',
          'data': data,
        });
      },
    );
  }

  /// 解析扫码内容为BarcodeContent
  ///
  /// [content] 扫码内容
  /// 返回解析后的条码内容
  BarcodeContent parseBarcodeContent(String content) {
    if (content.isEmpty) {
      throw ArgumentError('扫码内容不能为空');
    }

    // 新格式二维码处理（包含'MC'标识）
    if (content.contains('MC')) {
      return BarcodeContent(
        matCode: '',
        originalContent: content,
        needsApiParsing: true,
      );
    }

    // 旧格式条码处理（包含'\$KW\$'标识）
    if (content.contains(r'\$KW\$')) {
      final parts = content.split(r'\$');
      if (parts.length > 2) {
        return BarcodeContent(
          matCode: parts[2],
          originalContent: content,
          needsApiParsing: false,
        );
      }
    }

    // 直接返回内容作为物料编码
    return BarcodeContent(
      matCode: content,
      originalContent: content,
      needsApiParsing: false,
    );
  }
}
