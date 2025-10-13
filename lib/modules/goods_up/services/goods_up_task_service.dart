import 'package:dio/dio.dart';
import 'package:wms_app/modules/outbound/task_details/models/outbound_task_item.dart';
import 'package:wms_app/services/api_response_handler.dart';

import '../collection_task/models/inbound_collection_models.dart';
import '../collection_task/models/inbound_collection_request.dart';
import '../task_details/models/goods_up_task_item.dart';
import '../task_list/models/goods_up_task.dart';

/// 平库上架任务服务
class GoodsUpTaskService {
  GoodsUpTaskService(this._dio);

  final Dio _dio;

  /// 获取上架任务列表
  Future<GoodsUpTaskListData> getInboundTaskList({
    required GoodsUpTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/intaskList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          GoodsUpTaskListData.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// 获取上架任务明细
  Future<GoodsUpTaskItemListData> getInboundTaskItemList({
    required GoodsUpTaskItemQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/intaskitemList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => GoodsUpTaskItemListData.fromJson(
        Map<String, dynamic>.from(data as Map),
      ),
    );
  }

  /// 获取上架采集任务明细
  Future<List<InboundCollectTaskItem>> getInboundCollectItems({
    required GoodsUpCollectTaskItemQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/intaskitemList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        final rows = map['rows'] as List? ?? const [];
        return rows
            .map(
              (e) => InboundCollectTaskItem.fromJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList();
      },
    );
  }

  /// 提交接收/撤销入库任务明细
  Future<void> commitInboundTaskItems({
    required List<int> inTaskItemIds,
    String roomTag = '0',
    bool isCancel = false,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitRCInTaskItem',
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
      data: {
        'intaskitemids': inTaskItemIds,
        'roomTag': roomTag,
        'isCanel': isCancel.toString(),
      },
    );
  }

  /// 根据库房编码和库位编码校验库位
  ///
  /// 对应接口：`GET /system/terminal/getStoreSite`
  Future<List<Map<String, dynamic>>> getStoreSiteByRoom({
    required String storeRoomNo,
    required String storeSiteNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getStoreSite',
      queryParameters: {'storeRoomNo': storeRoomNo, 'storeSiteNo': storeSiteNo},
    );

    final data = response.data?['data'];
    if (data is List) {
      return data
          .where((item) => item is Map)
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    return const [];
  }

  /// 根据二维码获取物料信息
  Future<InboundBarcodeContent> getInboundBarcodeInfo(String barcode) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/materialInfo',
      queryParameters: {'QRstring': barcode},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('物料条码识别出现问题');
    }

    final code = data['code'] as int?;
    if (code != 200) {
      throw Exception(data['msg']?.toString() ?? '物料条码识别出现问题');
    }

    final content = data['data'];
    if (content is! Map<String, dynamic>) {
      throw Exception('物料条码识别出现问题');
    }

    return InboundBarcodeContent.fromJson(content);
  }

  /// 根据库位与物料编码获取库存
  Future<List<Map<String, dynamic>>> getMtlRepertoryByStoreSite({
    required String storeSite,
    required String materialCode,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMtlRepertory',
      queryParameters: {'storeSite': storeSite, 'matCode': materialCode},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return List<Map<String, dynamic>>.from(
          (map['rows'] as List? ?? []).map(
            (e) => Map<String, dynamic>.from(e as Map),
          ),
        );
      },
    );
  }

  /// 根据库位与物料编码获取库存（批次校验版本）
  Future<List<Map<String, dynamic>>> getRepertoryBySiteNoMatCode({
    required String storeSiteNo,
    required String materialCode,
    String batchNo = '',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/GetRepertoryBySiteNoMatCode',
      queryParameters: {
        'storesiteno': storeSiteNo,
        'matcode': materialCode,
        'batchno': batchNo,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return List<Map<String, dynamic>>.from(
          (map['rows'] as List? ?? []).map(
            (e) => Map<String, dynamic>.from(e as Map),
          ),
        );
      },
    );
  }

  /// 查询库位转储信息
  Future<List<Map<String, dynamic>>> getRepertoryByStoresiteNoTransfer({
    required String sourceStoreSiteNo,
    required String targetStoreSiteNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/GetRepertoryByStoresiteNoTransfer',
      queryParameters: {
        'sourceStoresiteNo': sourceStoreSiteNo,
        'targetStoresiteNo': targetStoreSiteNo,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return List<Map<String, dynamic>>.from(
          (map['rows'] as List? ?? []).map(
            (e) => Map<String, dynamic>.from(e as Map),
          ),
        );
      },
    );
  }

  /// 提交平库上架采集结果
  Future<Map<String, dynamic>> commitUpShelves({
    required List<Map<String, dynamic>> upShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
    String filter = '',
  }) async {
    final request = InboundCommitRequest(
      upShelvesInfos: upShelvesInfos,
      itemListInfos: itemListInfos,
      filter: filter,
    );

    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitUp',
      data: request.toJson(),
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
    );

    return response.data ?? const {};
  }

  /// 查询托盘可用库位
  Future<List<Map<String, dynamic>>> getInTaskPalletNoByUser({
    required int userId,
    String? inTaskNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getInTaskPalletNoByUserID',
      queryParameters: {
        'userId': userId,
        if (inTaskNo != null) 'intaskno': inTaskNo,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return List<Map<String, dynamic>>.from(
          (map['rows'] as List? ?? []).map(
            (e) => Map<String, dynamic>.from(e as Map),
          ),
        );
      },
    );
  }

  /// 托盘接收/撤销
  Future<void> commitInboundTaskPallet({
    required int inTaskId,
    required String palletNo,
    String roomTag = '0',
    bool isCancel = false,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitRCInTaskPalletNo',
      queryParameters: {
        'inTaskId': inTaskId,
        'palletNo': palletNo,
        'roomTag': roomTag,
        'isCanel': isCancel ? 'true' : 'false',
      },
    );
  }

  /// 根据物料和库位查询库存数量
  Future<List<Map<String, dynamic>>> getMtlQtyByMtlCode({
    required String materialCode,
    required String siteNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMtlQtyByMtlCode',
      queryParameters: {'mtlCode': materialCode, 'siteNo': siteNo},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return List<Map<String, dynamic>>.from(
          (map['rows'] as List? ?? []).map(
            (e) => Map<String, dynamic>.from(e as Map),
          ),
        );
      },
    );
  }

  /// 获取最新公告
  Future<List<Map<String, dynamic>>> getLatestNotice() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getLatestNotice',
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final list = data as List? ?? [];
        return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      },
    );
  }

  /// 获取更多公告
  Future<List<Map<String, dynamic>>> getMoreNotice() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMorNotice',
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final list = data as List? ?? [];
        return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      },
    );
  }

  /// 查询公告详情
  Future<Map<String, dynamic>> getNoticeDetail(String noticeId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getNoticeDetail',
      queryParameters: {'noticeId': noticeId},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => Map<String, dynamic>.from(data as Map),
    );
  }

  /// 查询任务消息列表
  Future<List<Map<String, dynamic>>> getTaskMessageList({
    required int userId,
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/selectTaskMessageList',
      queryParameters: {
        'userId': userId,
        'PageIndex': pageIndex.toString(),
        'PageSize': pageSize.toString(),
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return List<Map<String, dynamic>>.from(
          (map['rows'] as List? ?? []).map(
            (e) => Map<String, dynamic>.from(e as Map),
          ),
        );
      },
    );
  }

  /// 查询系统消息数量
  Future<int> getSysMessageCount({required int userId}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/selectSysMessageCount',
      queryParameters: {'userId': userId},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final map = Map<String, dynamic>.from(data as Map);
        return int.tryParse(map['count']?.toString() ?? '0') ?? 0;
      },
    );
  }
}
