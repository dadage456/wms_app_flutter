import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/models/mtl_senter_models.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/services/mtl_senter_service.dart';

class FakeHttpClientAdapter implements HttpClientAdapter {
  FakeHttpClientAdapter(this._handlers);

  final Map<String, ResponseBody Function(RequestOptions)> _handlers;
  RequestOptions? lastOptions;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastOptions = options;
    final handler = _handlers[options.path];
    if (handler == null) {
      throw Exception('No handler for ${options.path}');
    }
    return handler(options);
  }
}

ResponseBody jsonBody(Map<String, dynamic> payload) {
  final data = utf8.encode(jsonEncode(payload));
  return ResponseBody.fromBytes(
    data,
    200,
    headers: {
      Headers.contentTypeHeader: ['application/json'],
    },
  );
}

void main() {
  group('MtlSenterService', () {
    late Map<String, ResponseBody Function(RequestOptions)> handlers;
    late FakeHttpClientAdapter adapter;
    late Dio dio;
    late MtlSenterService service;

    setUp(() {
      handlers = {};
      adapter = FakeHttpClientAdapter(handlers);
      dio = Dio()..httpClientAdapter = adapter;
      service = MtlSenterService(dio);
    });

    test('fetchMaterialByQr parses map payload', () async {
      handlers['/system/terminal/getPmMaterialInfoByQR'] = (_) => jsonBody({
            'code': 200,
            'msg': 'success',
            'data': {
              'materialCode': 'MAT-001',
              'materialName': 'Bearing',
              'minPackageQty': 2,
            },
          });

      final result = await service.fetchMaterialByQr('QR-CONTENT');

      expect(result.materialCode, 'MAT-001');
      expect(result.materialName, 'Bearing');
      expect(adapter.lastOptions?.data, {'qrContent': 'QR-CONTENT'});
    });

    test('fetchInventoryByLocation returns numeric quantity from list', () async {
      handlers['/system/terminal/getLSMtlRepertoryByStoresiteNo'] = (_) => jsonBody({
            'code': 200,
            'msg': 'ok',
            'data': [
              {
                'repqty': 4.5,
              }
            ],
          });

      final result = await service.fetchInventoryByLocation(
        storeSite: 'LOC-1',
        materialCode: 'MAT-1',
      );

      expect(result, closeTo(4.5, 1e-6));
      expect(adapter.lastOptions?.queryParameters, {
        'storeSite': 'LOC-1',
        'matCode': 'MAT-1',
      });
    });

    test('fetchMtlQty maps delivery and min package information', () async {
      handlers['/system/terminal/getMtlQtyByMtlCode'] = (_) => jsonBody({
            'code': 200,
            'msg': 'ok',
            'data': [
              {
                'minQty': 3,
                'deliveryQty': 6,
              }
            ],
          });

      final result = await service.fetchMtlQty(
        materialCode: 'MAT-001',
        siteNo: 'LOC-1',
      );

      expect(result, isNotNull);
      expect(result!.minPackageQty, closeTo(3, 1e-6));
      expect(result.defaultDeliveryQty, closeTo(6, 1e-6));
      expect(adapter.lastOptions?.queryParameters, {
        'mtlCode': 'MAT-001',
        'siteNo': 'LOC-1',
      });
    });

    test('commitSender sends request body and throws on non-200 code', () async {
      handlers['/system/terminal/commitMtlSender'] = (options) {
        final payload = options.data as Map<String, dynamic>;
        expect(payload['mtlSenderInfos'], hasLength(1));
        expect(payload['taskNo'], 'TASK-1');
        expect(payload['operatorId'], 'OP-1');
        return jsonBody({
          'code': 500,
          'msg': 'failed',
          'data': {},
        });
      };

      final request = MtlSenterSubmitRequest(
        taskNo: 'TASK-1',
        operatorId: 'OP-1',
        mtlSenderInfos: const [
          MtlSenterCollectItem(
            id: '1',
            storeSiteNo: 'LOC-1',
            materialCode: 'MAT-1',
            quantity: 2,
          ),
        ],
      );

      expect(
        () => service.commitSender(request: request),
        throwsA(isA<Exception>()),
      );
    });

    test('commitSender completes when backend responds with 200', () async {
      handlers['/system/terminal/commitMtlSender'] = (_) => jsonBody({
            'code': 200,
            'msg': 'ok',
            'data': {},
          });

      final request = MtlSenterSubmitRequest(
        taskNo: 'TASK-1',
        operatorId: 'OP-1',
        mtlSenderInfos: const [
          MtlSenterCollectItem(
            id: '1',
            storeSiteNo: 'LOC-1',
            materialCode: 'MAT-1',
            quantity: 2,
          ),
        ],
      );

      await service.commitSender(request: request);
    });
  });
}
