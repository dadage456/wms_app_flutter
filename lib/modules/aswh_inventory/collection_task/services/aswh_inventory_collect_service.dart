import 'package:dio/dio.dart';

import '../../../../services/api_response_handler.dart';
import '../models/inventory_collect_models.dart';

/// 立库盘点采集服务
class AswhInventoryCollectService {
  AswhInventoryCollectService(this._dio);

  final Dio _dio;

  /// 查询盘点任务明细
  Future<List<InventoryTaskItem>> fetchTaskItems({
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
              .map((e) =>
                  InventoryTaskItem.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw Exception('盘点任务明细返回格式异常');
      },
    );
  }

  /// 提交盘点采集结果
  Future<void> submitCollectionRecords({
    required List<InventoryCollectingRecord> records,
    required String taskComment,
  }) async {
    final payload = {
      'inventoryInfos': records
          .map((record) => record.copyWith(taskComment: taskComment).toJson())
          .toList(),
      'taskComment': taskComment,
    };

    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitInventoryInfos',
      data: payload,
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
  Future<List<InventorySiteInfo>> validateStoreSite({
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
        if (data is List) {
          return data
              .map((e) =>
                  InventorySiteInfo.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw Exception('库位校验返回格式异常');
      },
    );
  }

  /// 查询库位库存
  Future<List<InventoryPalletInfo>> fetchInventoryBySite({
    required String storeSiteNo,
    required String materialCode,
    String? erpStoreRoom,
    String? batchNo,
    String? serialNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByStoresiteNo',
      queryParameters: {
        'storesiteno': storeSiteNo,
        'matcode': materialCode,
        if (erpStoreRoom != null) 'erpStoreroom': erpStoreRoom,
        if (batchNo != null) 'batchno': batchNo,
        if (serialNo != null) 'sn': serialNo,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data
              .map((e) =>
                  InventoryPalletInfo.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw Exception('库存查询返回格式异常');
      },
    );
  }

  /// 查询拣选口位置
  Future<List<InventoryPickLocation>> fetchPickLocations({
    String locationType = '1',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getInOutLocation',
      queryParameters: {'locationType': locationType},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data
              .map(
                (e) => InventoryPickLocation.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList();
        }
        throw Exception('拣选口位置返回格式异常');
      },
    );
  }

  /// 查询物料控制参数
  Future<InventoryMatControl?> fetchMaterialControl(String materialCode) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMatControl',
      queryParameters: {'matCode': materialCode},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          if (data.isEmpty) return null;
          return InventoryMatControl.fromJson(
            data.first as Map<String, dynamic>,
          );
        }
        if (data is Map<String, dynamic>) {
          return InventoryMatControl.fromJson(data);
        }
        throw Exception('物料控制参数返回格式异常');
      },
    );
  }

  /// 查询任务对应的物料控制参数
  Future<List<InventoryMatControl>> fetchRoomMaterialControls(
    String taskId,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRoomMatControl',
      queryParameters: {'taskId': taskId},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data
              .map((e) =>
                  InventoryMatControl.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        throw Exception('任务物料控制返回格式异常');
      },
    );
  }

  /// 下发 WCS 指令
  Future<void> dispatchCommand(InventoryCollectCommand command) async {
    final endpoint = switch (command.action) {
      InventoryCollectCommandAction.inventoryDown =>
        '/system/terminal/commitInvDownWmsToWcs',
      InventoryCollectCommandAction.inventoryReset =>
        '/system/terminal/commitInvResetWmsToWcs',
      InventoryCollectCommandAction.emptyTray =>
        '/system/terminal/commitEmptyTrayWmsToWcs',
    };

    final response = await _dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: {
        'taskId': command.taskId,
        'taskNo': command.taskNo,
        'trayNo': command.trayNo,
        'startAddr': command.startAddr,
        'endAddr': command.endAddr,
        'singleFlag': command.singleFlag,
      },
    );

    ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data,
    );
  }
}
