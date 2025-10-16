import 'package:dio/dio.dart';

import '../../../services/api_response_handler.dart';
import '../models/aswh_up_collection_models.dart';
import '../models/aswh_up_task.dart';
import '../models/aswh_up_wcs_instruction.dart';
import '../task_details/models/aswh_up_task_detail_item.dart';

class AswhUpTaskService {
  AswhUpTaskService(this._dio);

  final Dio _dio;

  /// 获取立库组盘任务列表
  Future<AswhUpTaskListData> fetchTasks(AswhUpTaskQuery query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/intaskList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          AswhUpTaskListData.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// 获取立库组盘任务明细
  Future<AswhUpTaskDetailListData> fetchTaskItems({
    required AswhUpTaskDetailQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/intaskitemList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => AswhUpTaskDetailListData.fromJson(
        Map<String, dynamic>.from(data as Map),
      ),
    );
  }

  /// 根据托盘号查询已经提交的采集记录
  Future<List<AswhUpCollectionStock>> fetchPalletItems(String trayNo) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getPalletItemByTaskID',
      queryParameters: {'palletNo': trayNo},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final list = data as List? ?? [];
        return list
            .map(
              (item) => AswhUpCollectionStock.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            )
            .toList();
      },
    );
  }

  /// 提交立库组盘采集数据
  Future<void> commitUpShelves({
    required List<Map<String, dynamic>> upShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
    required String filter,
    required String weight,
    required String capacity,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitASWHUpShelves',
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
      data: {
        'upShelvesInfos': upShelvesInfos,
        'itemListInfos': itemListInfos,
        'filter': filter,
        'weight': weight,
        'capacity': capacity,
      },
    );
  }

  /// 撤销/接收立库组盘任务明细
  Future<void> commitTaskItems({
    required List<int> inTaskItemIds,
    String roomTag = '1',
    bool isCancel = true,
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

  /// 将托盘上架信息写入 WCS 指令
  Future<void> commitUpWmsToWcs({
    required int taskId,
    required String taskNo,
    required String trayNo,
    String? startAddr,
    String? endAddr,
  }) async {
    await _dio.get<Map<String, dynamic>>(
      '/system/terminal/commitUpWmsToWcs',
      queryParameters: {
        'taskId': taskId,
        'taskNo': taskNo,
        'trayNo': trayNo,
        if (startAddr != null) 'startAddr': startAddr,
        if (endAddr != null) 'endAddr': endAddr,
      },
    );
  }

  /// 校验托盘基础信息
  Future<Map<String, dynamic>> checkBindingTray(String trayNo) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/checkTray',
      queryParameters: {'trayNo': trayNo},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => Map<String, dynamic>.from(data as Map),
    );
  }

  /// 校验托盘与任务绑定关系
  Future<Map<String, dynamic>> checkBindingTrayByTask({
    required int taskId,
    required String trayNo,
    required String taskType,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/checkBindingTray',
      queryParameters: {
        'taskId': taskId,
        'trayNo': trayNo,
        'taskType': taskType,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => Map<String, dynamic>.from(data as Map),
    );
  }

  /// 解析物料二维码，获取物料基础信息
  Future<AswhUpBarcodeContent> getMaterialInfoByQR(String qrContent) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getPmMaterialInfoByQR',
      data: {'qrContent': qrContent},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          AswhUpBarcodeContent.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  /// 获取物料控制属性
  Future<Map<String, dynamic>> getMatControl(String materialCode) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMatControl',
      queryParameters: {'matCode': materialCode},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => Map<String, dynamic>.from(data as Map),
    );
  }

  /// 根据库房/库位校验库位是否存在
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
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    return const [];
  }

  /// 根据库位与物料编码获取库存
  Future<List<Map<String, dynamic>>> getMtlRepertoryByStoresiteNo({
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
        if (data is List) {
          return data
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();
        }
        return const <Map<String, dynamic>>[];
      },
    );
  }

  /// 查询任务对应的 WMS → WCS 指令
  Future<List<AswhUpWcsInstruction>> getWmsToWcsByTaskID({
    required String taskComment,
    required int taskId,
    required String taskType,
    String? queryStr,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getWmsToWcsByTaskID',
      queryParameters: {
        'taskComment': taskComment,
        'taskId': taskId,
        'TaskType': taskType,
        if (queryStr != null) 'queryStr': queryStr,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        final list = data as List? ?? [];
        return list
            .map(
              (item) => AswhUpWcsInstruction.fromJson(
                Map<String, dynamic>.from(item as Map),
              ),
            )
            .toList();
      },
    );
  }
}
