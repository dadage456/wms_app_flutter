import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/services/api_response_handler.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_request.dart';

class CollectionService {
  final Dio _dio;

  CollectionService(this._dio);

  Future<List<OutTaskItem>> getOutTaskCollitemList(
    CollectionTaskItemQuery params,
  ) async {
    final response = await _dio.get(
      '/system/terminal/getOutTaskItem',
      queryParameters: params.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        return (data as List?)
                ?.map((item) => OutTaskItem.fromJson(item))
                .toList() ??
            [];
      },
    );
  }

  Future<String> getRoomMatControl(String taskId) async {
    final response = await _dio.get(
      '/system/terminal/getRoomMatControl',
      queryParameters: {'taskId': taskId},
    );

    return ApiResponseHandler.handleDirectResponse(
      response: response,
      fieldName: 'msg',
    );
  }

  Future<BarcodeContent> getMaterialInfoByQR(String barcode) async {
    final response = await _dio.get(
      '/system/terminal/materialInfo',
      queryParameters: {'QRstring': barcode},
    );

    if (response.data['code'] != 200 || response.data['data'] == null) {
      throw Exception(response.data['msg'] ?? '物料条码识别出现问题！');
    }

    return BarcodeContent.fromJson(response.data['data']);
  }

  Future<String> getMatControl(String matcode) async {
    final response = await _dio.get(
      '/system/terminal/getMatControl',
      queryParameters: {'matCode': matcode},
    );

    return response.data['msg'] ?? '';
  }

  Future<Map<String, dynamic>> getStoreSite(
    String storeRoomNo,
    String storeSiteNo,
  ) async {
    final response = await _dio.get(
      '/system/terminal/getStoreSite',
      queryParameters: {'storeRoomNo': storeRoomNo, 'storeSiteNo': storeSiteNo},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getRepertoryByStoreSiteNo(
    String storesiteno,
    String matcode,
  ) async {
    final response = await _dio.get(
      '/system/terminal/getRepertoryByStoresiteNo',
      queryParameters: {'storesiteno': storesiteno, 'matcode': matcode},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getRepertoryByStoreSiteNoSn(
    String storesiteno,
    String matcode,
    String? erpStoreroom,
    String? batchno,
    String? sn,
  ) async {
    final response = await _dio.get(
      '/system/terminal/getRepertoryByStoresiteNoSn',
      queryParameters: {
        'storesiteno': storesiteno,
        'matcode': matcode,
        if (erpStoreroom != null) 'erpStoreroom': erpStoreroom,
        if (batchno != null) 'batchno': batchno,
        if (sn != null) 'sn': sn,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getRepertoryByStoreSiteNoErp(
    String storesiteno,
    String matcode,
  ) async {
    final response = await _dio.get(
      '/system/terminal/getRepertoryByStoresiteNoErp',
      queryParameters: {'storesiteno': storesiteno, 'matcode': matcode},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> commitDownShelves(
    List<Map<String, dynamic>> downShelvesInfos,
    List<Map<String, dynamic>> itemListInfos,
  ) async {
    final response = await _dio.post(
      '/system/terminal/commitDownShelves',
      data: {
        'downShelvesInfos': downShelvesInfos,
        'itemListInfos': itemListInfos,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> commitFinishOutTaskItem(
    String outtaskitemid,
  ) async {
    final response = await _dio.post(
      '/system/terminal/commitFinishOutTaskItem',
      queryParameters: {'outtaskitemid': outtaskitemid},
    );
    return response.data;
  }

  Future<String?> getPalletStoreSite(String trayNo) async {
    final response = await _dio.get(
      '/system/terminal/getPalletSiteNo',
      queryParameters: {'taskNo': trayNo},
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('响应格式错误');
    }

    final code = data['code'] as int?;
    if (code != 200) {
      throw Exception(data['msg']?.toString() ?? '获取托盘库位失败');
    }

    final sites = data['data'];
    if (sites is List && sites.isNotEmpty) {
      final first = sites.first;
      if (first is Map<String, dynamic>) {
        final site = first['storesiteno'] ?? first['storeSiteNo'];
        if (site != null) {
          return site.toString();
        }
      }
    }

    return null;
  }

  Future<void> commitExceptionShelves(
    List<Map<String, dynamic>> exceptionInfos,
  ) async {
    final response = await _dio.post(
      '/system/terminal/commitExceptShelves',
      data: {'exceptShelvesInfos': exceptionInfos},
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw Exception('响应格式错误');
    }

    final code = data['code'] as int?;
    if (code != 200) {
      throw Exception(data['msg']?.toString() ?? '异常采集提交失败');
    }
  }
}
