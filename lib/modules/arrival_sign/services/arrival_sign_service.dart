import 'package:dio/dio.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/models/arrival_receive_task.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/models/arrival_collect_submit_request.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';
import 'package:wms_app/services/api_response_handler.dart';

/// 到货签收模块服务封装
class ArrivalSignService {
  ArrivalSignService(this._dio);

  final Dio _dio;

  /// 获取到货签收任务列表
  Future<ArrivalSignTaskPage> getArrivalSignTasks({
    required ArrivalSignTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/arriveSignList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => ArrivalSignTaskPage.fromJson(data),
    );
  }

  /// 撤销到货签收单据
  Future<void> cancelArrivalSign({required String arrivalsBillId}) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/cancelArriveSign',
      data: {
        'arrivalsBillid': arrivalsBillId,
      },
    );
  }

  /// 获取到货签收明细
  Future<ArrivalSignDetailPage> getArrivalSignDetails({
    required ArrivalSignDetailQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/arriveSignDetailList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => ArrivalSignDetailPage.fromJson(data),
    );
  }

  /// 查询待接收到货任务列表
  Future<ArrivalReceiveTaskPage> getArrivalUnSignList({
    required ArrivalReceiveTaskQuery query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/arriveUnSignList',
      queryParameters: query.toJson(),
    );

    return ApiResponseHandler.handleResponse(
      response: response,
      dataExtractor: (data) => ArrivalReceiveTaskPage.fromJson(data),
    );
  }

  /// 接收到货单据
  Future<void> receiveArrivalOrder({required String arrivalsBillId}) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/receArriveSign',
      data: {'arrivalsBillid': arrivalsBillId},
    );
  }

  /// 提交采集数据
  Future<void> commitSignShelves(
    ArrivalCollectSubmitRequest request,
  ) async {
    await _dio.post<Map<String, dynamic>>(
      '/system/terminal/commitSign',
      data: request.toJson(),
      options: Options(contentType: Headers.jsonContentType),
    );
  }

  /// 根据二维码解析物料信息
  Future<String> getMaterialCodeByQr(String qr) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/system/terminal/materialInfo',
      queryParameters: {'QRstring': qr},
    );

    final data = response.data;
    if (data == null) {
      throw Exception('物料条码识别失败：返回数据为空');
    }

    final code = data['code'] as int?;
    if (code != 200) {
      throw Exception(data['msg']?.toString() ?? '物料条码识别失败');
    }

    final material = data['data'];
    final matCode = material is Map<String, dynamic>
        ? material['matcode']?.toString()
        : null;

    if (matCode == null || matCode.isEmpty) {
      throw Exception('物料条码识别失败：未获取到物料编码');
    }

    return matCode;
  }
}
