import 'package:dio/dio.dart';

import '../../../services/api_response_handler.dart';
import '../models/inventory_barcode_material.dart';
import '../models/inventory_query_request.dart';
import '../models/inventory_record.dart';

class InventoryQueryService {
  InventoryQueryService(this._dio);

  final Dio _dio;

  Future<InventoryBarcodeMaterial> getMaterialInfoByQr(String barcode) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/materialInfo',
      queryParameters: {'QRstring': barcode},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => InventoryBarcodeMaterial.fromJson(
        Map<String, dynamic>.from(data as Map),
      ),
    );
  }

  Future<InventoryRecordPage> getInventoryByBarcode(
    InventoryQueryRequest request,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getRepertoryByBarCode',
      queryParameters: request.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) =>
          InventoryRecordPage.fromJson(Map<String, dynamic>.from(data as Map)),
    );
  }

  Future<InventoryRecordPage> getInventoryByMode({
    required InventoryQueryMode mode,
    required String value,
    int pageIndex = 1,
    int pageSize = 10000,
  }) {
    return getInventoryByBarcode(
      InventoryQueryRequest(
        barcode: value,
        queryType: mode.apiCode,
        pageIndex: pageIndex,
        pageSize: pageSize,
      ),
    );
  }
}
