import 'package:dio/dio.dart';
import 'package:wms_app/modules/inbound/goods_up_task/models/goods_up_models.dart';
import 'package:wms_app/modules/inbound/goods_up_task/models/goods_up_request.dart';
import 'package:wms_app/services/api_response_handler.dart';

/// 入库上架业务接口服务
class GoodsUpService {
  GoodsUpService(this._dio);

  final Dio _dio;

  Future<List<InTaskItem>> getInTaskItemList(
    GoodsUpTaskItemQuery params,
  ) async {
    try {
      final response = await _dio.get(
        '/system/terminal/intaskitemList',
        queryParameters: params.toJson(),
      );

      return ApiResponseHandler.handleResponse(
        response: response,
        dataExtractor: (data) {
          if (data is List) {
            return data
                .whereType<Map>()
                .map((item) => Map<String, dynamic>.from(item as Map))
                .map(InTaskItem.fromJson)
                .toList(growable: false);
          }

          if (data is Map) {
            final rows = data['rows'];
            if (rows is List) {
              return rows
                  .whereType<Map>()
                  .map((item) => Map<String, dynamic>.from(item as Map))
                  .map(InTaskItem.fromJson)
                  .toList(growable: false);
            }
          }

          throw Exception('入库任务明细返回格式不正确');
        },
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    }
  }

  Future<Map<String, dynamic>> getStoreSite(
    String storeRoomNo,
    String storeSiteNo,
  ) async {
    try {
      final response = await _dio.get(
        '/system/terminal/getStoreSite',
        queryParameters: {
          'storeRoomNo': storeRoomNo,
          'storeSiteNo': storeSiteNo,
        },
      );

      return ApiResponseHandler.handleResponse(
        response: response,
        dataExtractor: _normalizeMapData,
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    }
  }

  Future<Map<String, dynamic>> getMtlRepertory(
    String storeSite,
    String matCode,
  ) async {
    try {
      final response = await _dio.get(
        '/system/terminal/getMtlRepertory',
        queryParameters: {
          'storeSite': storeSite,
          'matCode': matCode,
        },
      );

      return ApiResponseHandler.handleResponse(
        response: response,
        dataExtractor: _normalizeMapData,
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    }
  }

  Future<Map<String, dynamic>> commitUpShelves(
    List<Map<String, dynamic>> infos,
    List<Map<String, dynamic>> items,
    String filter,
  ) async {
    try {
      final response = await _dio.post(
        '/system/terminal/commitUp',
        data: {
          'infos': infos,
          'items': items,
          'filter': filter,
        },
        options: Options(
          headers: {'content-type': 'application/json;charset=UTF-8'},
        ),
      );

      return ApiResponseHandler.handleResponse(
        response: response,
        dataExtractor: _normalizeMapData,
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    }
  }

  Future<UpBarcodeContent> getMaterialInfo(String qrString) async {
    try {
      final response = await _dio.get(
        '/system/terminal/materialInfo',
        queryParameters: {'QRstring': qrString},
      );

      return ApiResponseHandler.handleResponse(
        response: response,
        dataExtractor: (data) {
          if (data is Map<String, dynamic>) {
            return UpBarcodeContent.fromJson(data);
          }

          if (data is Map) {
            return UpBarcodeContent.fromJson(
              Map<String, dynamic>.from(data as Map),
            );
          }

          throw Exception('二维码解析数据格式不正确');
        },
      );
    } on DioException catch (e) {
      throw Exception(ApiResponseHandler.handleDioException(e));
    }
  }

  Map<String, dynamic> _normalizeMapData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return _normalizeRows(data);
    }

    if (data is Map) {
      return _normalizeRows(Map<String, dynamic>.from(data as Map));
    }

    if (data is List) {
      return {
        'rows': data
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList(growable: false),
      };
    }

    throw Exception('接口返回数据格式不正确');
  }

  Map<String, dynamic> _normalizeRows(Map<String, dynamic> source) {
    final map = Map<String, dynamic>.from(source);
    final dataField = map['data'];
    if (dataField is List) {
      map['data'] = dataField
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(growable: false);
    }

    final rows = map['rows'];
    if (rows is List) {
      map['rows'] = rows
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(growable: false);
    }

    return map;
  }
}
