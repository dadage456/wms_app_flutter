import 'package:dio/dio.dart';

import '../../../../services/api_response_handler.dart';
import '../models/inventory_pallet_item.dart';

class AswhInventoryPalletService {
  AswhInventoryPalletService(this._dio);

  final Dio _dio;

  Future<List<InventoryPalletItem>> fetchPalletItems({
    required String trayNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getPalletItemByTaskID',
      queryParameters: {
        'palletNo': trayNo,
      },
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          return data
              .map((item) => InventoryPalletItem.fromJson(
                    Map<String, dynamic>.from(item as Map),
                  ))
              .toList();
        }
        throw Exception('托盘明细返回格式异常');
      },
    );
  }
}
