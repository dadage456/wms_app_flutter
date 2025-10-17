import 'package:dio/dio.dart';

import '../../../../services/api_response_handler.dart';
import '../models/mtl_senter_models.dart';

class MtlSenterService {
  MtlSenterService(this._dio);

  final Dio _dio;

  Future<MtlSenterMaterial> fetchMaterialByQr(String qrContent) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/getPmMaterialInfoByQR',
      data: {'qrContent': qrContent},
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) {
        if (data is Map<String, dynamic>) {
          return MtlSenterMaterial.fromJson(Map<String, dynamic>.from(data));
        }
        if (data is List && data.isNotEmpty) {
          return MtlSenterMaterial.fromJson(
            Map<String, dynamic>.from(data.first as Map),
          );
        }
        throw Exception('物料条码识别出现问题');
      },
    );
  }

  Future<double?> fetchInventoryByLocation({
    required String storeSite,
    required String materialCode,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getLSMtlRepertoryByStoresiteNo',
      queryParameters: {
        'storeSite': storeSite,
        'matCode': materialCode,
      },
    );

    return ApiResponseHandler.handleResponse<double?>(
      response: response,
      dataExtractor: (data) {
        if (data is List) {
          final list = data.cast<Map>();
          if (list.isEmpty) {
            return 0;
          }
          final first = Map<String, dynamic>.from(list.first as Map);
          final qty = first['repqty'] ?? first['qty'] ?? first['repertoryQty'];
          return qty is num ? qty.toDouble() : 0;
        }
        if (data is Map) {
          final qty = data['repqty'] ?? data['qty'] ?? data['repertoryQty'];
          return qty is num ? qty.toDouble() : 0;
        }
        return 0;
      },
    );
  }

  Future<MtlSenterMaterial?> fetchMtlQty({
    required String materialCode,
    String? siteNo,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/getMtlQtyByMtlCode',
      queryParameters: {
        'mtlCode': materialCode,
        'siteNo': siteNo,
      },
    );

    return ApiResponseHandler.handleResponse<MtlSenterMaterial?>(
      response: response,
      dataExtractor: (data) {
        if (data is List && data.isNotEmpty) {
          final json = Map<String, dynamic>.from(data.first as Map);
          return MtlSenterMaterial(
            materialCode: materialCode,
            minPackageQty: (json['minQty'] as num?)?.toDouble(),
            defaultDeliveryQty: (json['deliveryQty'] as num?)?.toDouble(),
          );
        }
        return null;
      },
    );
  }

  Future<void> commitSender({
    required MtlSenterSubmitRequest request,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitMtlSender',
      options: Options(
        headers: {'content-type': 'application/json;charset=UTF-8'},
      ),
      data: {
        'mtlSenderInfos': request.mtlSenderInfos
            .map(
              (item) => {
                'locationNo': item.storeSiteNo,
                'matCode': item.materialCode,
                'qty': item.quantity,
              },
            )
            .toList(),
        'taskNo': request.taskNo,
        'operatorId': request.operatorId,
      },
    );
    final body = response.data;
    if (body is Map<String, dynamic>) {
      final code = body['code'] as int?;
      if (code != 200) {
        final message = body['msg']?.toString() ?? '提交失败';
        throw Exception(message);
      }
    }
  }
}
