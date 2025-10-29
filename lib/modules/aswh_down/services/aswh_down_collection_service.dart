import 'package:dio/dio.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';
import 'package:wms_app/services/api_response_handler.dart';

/// 在线拣选采集与 WCS 指令相关服务封装。
class AswhDownCollectionService {
  AswhDownCollectionService(this._dio);

  final Dio _dio;

  /// 获取采集任务明细（对应 `getOutTaskCollitemList`）。
  Future<List<OnlinePickTaskItem>> fetchCollectionTaskItems({
    required OnlinePickCollectionQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getOutTaskItem',
      queryParameters: query.toQueryParameters(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => (data as List<dynamic>)
          .map((item) =>
              OnlinePickTaskItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// 获取条码信息（对应 `getPmMaterialInfoByQR`）。
  Future<OnlinePickBarcodeContent> getMaterialInfoByQr(String qrContent) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getPmMaterialInfoByQR',
      data: {'qrContent': qrContent},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          OnlinePickBarcodeContent.fromJson(data as Map<String, dynamic>),
    );
  }

  /// 获取任务级物料控制配置（对应 `GetRoomMatControl`）。
  Future<String> getRoomMatControl(String taskId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRoomMatControl',
      queryParameters: {'taskId': taskId},
    );

    return ApiResponseHandler.handleDirectResponse<String>(
      response: response,
      fieldName: 'msg',
    );
  }

  /// 获取拣选出/入口配置列表（对应 `getInOutLocation`）。
  Future<List<OnlinePickLocationOption>> fetchInOutLocations({
    String locationType = '1',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getInOutLocation',
      queryParameters: {
        'locationType': locationType,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is! List) {
          throw Exception('拣选口数据格式异常');
        }

        return data
            .map((item) {
              if (item is Map<String, dynamic>) {
                final label =
                    (item['label'] ?? item['text'] ?? item['value'] ?? '')
                        .toString();
                final value =
                    (item['value'] ?? item['code'] ?? item['label'] ?? label)
                        .toString();
                if (label.isEmpty && value.isEmpty) {
                  return null;
                }
                return OnlinePickLocationOption(label: label, value: value);
              }

              final text = item?.toString() ?? '';
              if (text.isEmpty) {
                return null;
              }
              return OnlinePickLocationOption(label: text, value: text);
            })
            .whereType<OnlinePickLocationOption>()
            .toList();
      },
    );
  }

  /// 获取物料控制模式（对应 `GetMatControl`）。
  Future<String> getMatControl(String materialCode) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMatControl',
      queryParameters: {'matCode': materialCode},
    );

    return ApiResponseHandler.handleDirectResponse<String>(
      response: response,
      fieldName: 'msg',
    );
  }

  /// 根据库位查询库存（对应 `getRepertoryByStoresiteNo`）。
  Future<List<Map<String, dynamic>>> getRepertoryByStoreSite({
    required String storeSiteNo,
    required String materialCode,
    String? erpStoreroom,
    String? batchNo,
    String? serialNumber,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByStoresiteNo',
      queryParameters: {
        'storesiteno': storeSiteNo,
        'matcode': materialCode,
        if (erpStoreroom != null && erpStoreroom.isNotEmpty)
          'erpStoreroom': erpStoreroom,
        if (batchNo != null && batchNo.isNotEmpty) 'batchno': batchNo,
        if (serialNumber != null && serialNumber.isNotEmpty) 'sn': serialNumber,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => (data as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }

  /// 根据库位查询库存（对应 `getMtlRepertoryByStoresiteNoSn`）。
  Future<List<Map<String, dynamic>>> getRepertoryByStoreSiteSn({
    required String storeSiteNo,
    required String materialCode,
    String? erpStoreroom,
    String? batchNo,
    String? serialNumber,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByStoresiteNoSn',
      queryParameters: {
        'storesiteno': storeSiteNo,
        'matcode': materialCode,
        if (erpStoreroom != null) 'erpStoreroom': erpStoreroom,
        if (batchNo != null) 'batchno': batchNo,
        if (serialNumber != null) 'sn': serialNumber,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => (data as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }

  /// 根据库位查询库存（ERP 子库校验，`getRepertoryByStoresiteNoErp`）。
  Future<List<Map<String, dynamic>>> getRepertoryByStoreSiteErp({
    required String storeSiteNo,
    required String materialCode,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByStoresiteNoErp',
      queryParameters: {
        'storesiteno': storeSiteNo,
        'matcode': materialCode,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => (data as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }

  /// 提交自动化仓库下架（对应 `CommitASWHDownShelves`）。
  Future<Map<String, dynamic>> commitAswhDownShelves({
    required List<Map<String, dynamic>> downShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
    List<Map<String, dynamic>> inventoryCheckInfos = const [],
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitASWHDownShelves',
      data: {
        'downShelvesInfos': downShelvesInfos,
        'itemListInfos': itemListInfos,
        'invCheckInfos': inventoryCheckInfos,
      },
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 提交立库下架（对应 `CommitDownShelves`）。
  Future<Map<String, dynamic>> commitDownShelves({
    required List<Map<String, dynamic>> downShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
    List<Map<String, dynamic>> inventoryCheckInfos = const [],
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitDownShelves',
      data: {
        'downShelvesInfos': downShelvesInfos,
        'itemListInfos': itemListInfos,
        'invCheckInfos': inventoryCheckInfos,
      },
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 提交托盘下架（对应 `commitTrayDownShelves`）。
  Future<Map<String, dynamic>> commitTrayDownShelves({
    required List<Map<String, dynamic>> downShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
    List<Map<String, dynamic>> inventoryCheckInfos = const [],
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitTrayDownShelves',
      data: {
        'downShelvesInfos': downShelvesInfos,
        'itemListInfos': itemListInfos,
        'invCheckInfos': inventoryCheckInfos,
      },
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 写入出库指令（对应 `CommitDownWmsToWcs`/`commitInvDownWmsToWcs`）。
  Future<Map<String, dynamic>> commitDownWmsToWcs({
    required String taskId,
    required String taskNo,
    required String trayNo,
    required String startAddr,
    required String endAddr,
    String singleFlag = 'N',
    bool isInventory = false,
  }) async {
    final uri = isInventory
        ? '/system/terminal/commitInvDownWmsToWcs'
        : '/system/terminal/commitDownWmsToWcs';
    final response = await _dio.get<Map<String, dynamic>>(
      uri,
      queryParameters: {
        'taskId': taskId,
        'taskNo': taskNo,
        'trayNo': trayNo,
        'startAddr': startAddr,
        'endAddr': endAddr,
        'singleFlag': singleFlag,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 空托盘指令写入WCS（对应 `commitEmptyTrayWmsToWcs`）。
  Future<Map<String, dynamic>> commitEmptyTrayWmsToWcs({
    required String taskId,
    required String taskNo,
    required String trayNo,
    required String startAddr,
    required String endAddr,
    String singleFlag = 'N',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/commitEmptyTrayWmsToWcs',
      queryParameters: {
        'taskId': taskId,
        'taskNo': taskNo,
        'trayNo': trayNo,
        'startAddr': startAddr,
        'endAddr': endAddr,
        'singleFlag': singleFlag,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 重置指令写入WCS（对应 `commitResetWmsToWcs`/`CommitInvResetWmsToWcs`）。
  Future<Map<String, dynamic>> commitResetWmsToWcs({
    required String taskId,
    required String taskNo,
    required String trayNo,
    required String startAddr,
    required String endAddr,
    bool isInventory = false,
  }) async {
    final uri = isInventory
        ? '/system/terminal/commitInvResetWmsToWcs'
        : '/system/terminal/commitResetWmsToWcs';

    final response = await _dio.get<Map<String, dynamic>>(
      uri,
      queryParameters: {
        'taskId': taskId,
        'taskNo': taskNo,
        'trayNo': trayNo,
        'startAddr': startAddr,
        'endAddr': endAddr,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 完成出库任务明细（对应 `commitFinishOutTaskItem`）。
  Future<Map<String, dynamic>> commitFinishOutTaskItem({
    required String outTaskItemId,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitFinishOutTaskItem',
      queryParameters: {'outtaskitemid': outTaskItemId},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

  /// 查询指令记录（对应 `getWmsToWcsByTaskID`）
  Future<List<OnlinePickWcsCommand>> fetchWcsCommands({
    required String taskComment,
    required String taskId,
    String taskType = '03',
    String queryStr = '',
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getWmsToWcsByTaskID',
      queryParameters: {
        'taskComment': taskComment,
        'taskId': taskId,
        'TaskType': taskType,
        'queryStr': queryStr,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => (data as List<dynamic>)
          .map((item) =>
              OnlinePickWcsCommand.fromJson(item as Map<String, dynamic>))
          .toList(),
      dataField: 'data',
    );
  }

  /// 执行异常采集提交（`CommitExceptShelves`）。
  Future<Map<String, dynamic>> commitExceptionShelves({
    required List<Map<String, dynamic>> exceptionInfos,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitExceptShelves',
      data: {'exceptShelvesInfos': exceptionInfos},
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => data as Map<String, dynamic>,
    );
  }

}
