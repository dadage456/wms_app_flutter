import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_request.dart';
import 'package:wms_app/modules/goods_up/services/goods_up_task_service.dart';
import 'package:wms_app/modules/transfer/collection_task/models/transfer_collection_models.dart';
import 'package:wms_app/modules/transfer/services/transfer_task_service.dart';

class MockGoodsUpTaskService extends Mock implements GoodsUpTaskService {}

class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.onFetch);

  final Future<ResponseBody> Function(
    RequestOptions options,
    Stream<List<int>>? requestStream,
  ) onFetch;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return onFetch(options, requestStream);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late MockGoodsUpTaskService goodsUpService;
  late Dio dio;
  late TransferTaskService service;

  setUpAll(() {
    registerFallbackValue(GoodsUpTransferRequest(transferInfos: const []));
  });

  setUp(() {
    goodsUpService = MockGoodsUpTaskService();
    dio = Dio();
    service = TransferTaskService(dio, goodsUpService);
  });

  test('validateStoreSite returns parsed info when service finds record', () async {
    when(
      () => goodsUpService.getStoreSiteByRoom(
        storeRoomNo: any(named: 'storeRoomNo'),
        storeSiteNo: any(named: 'storeSiteNo'),
      ),
    ).thenAnswer(
      (_) async => [
        {
          'storeroomno': 'RM1',
          'erpStoreroom': 'ERP1',
          'isFrozen': 0,
        },
      ],
    );

    final info = await service.validateStoreSite(
      storeRoomNo: 'RM1',
      storeSiteNo: 'SITE-1',
    );

    expect(info, isNotNull);
    expect(info!.storeRoomNo, 'RM1');
    expect(info.resolvedErpStoreRoom, 'ERP1');
    expect(info.isFrozen, isFalse);
  });

  test('fetchMaterialByQr maps dio payload to material detail', () async {
    dio.httpClientAdapter = FakeAdapter((options, _) async {
      expect(options.path, '/system/terminal/getPmMaterialInfoByQR');
      expect(options.data, {'qrContent': 'QR123'});
      final payload = {
        'data': {
          'matCode': 'MAT-001',
          'matname': '演示物料',
          'qty': 3,
        },
      };
      return ResponseBody.fromString(
        jsonEncode(payload),
        200,
        headers: {Headers.contentTypeHeader: ['application/json']},
      );
    });

    final detail = await service.fetchMaterialByQr('QR123');

    expect(detail.resolvedMaterialCode, 'MAT-001');
    expect(detail.materialName, '演示物料');
    expect(detail.resolvedQuantity, 3);
  });

  test('fetchTransferInventory delegates to goods up service', () async {
    when(
      () => goodsUpService.getRepertoryByStoresiteNoTransfer(
        sourceStoreSiteNo: any(named: 'sourceStoreSiteNo'),
        targetStoreSiteNo: any(named: 'targetStoreSiteNo'),
      ),
    ).thenAnswer(
      (_) async => [
        {
          'storesiteno': 'SRC-1',
          'matcode': 'MAT-001',
          'repqty': 5.5,
        },
      ],
    );

    final rows = await service.fetchTransferInventory(
      sourceSite: 'SRC-1',
      targetSite: 'TGT-1',
    );

    expect(rows, hasLength(1));
    expect(rows.first.storeSiteNo, 'SRC-1');
    expect(rows.first.materialCode, 'MAT-001');
    expect(rows.first.quantity, 5.5);
  });

  test('submitTransfer builds GoodsUpTransferRequest correctly', () async {
    when(
      () => goodsUpService.commitTransfer(
        request: any(named: 'request'),
      ),
    ).thenAnswer((_) async {});

    final payload = TransferSubmitPayload(
      entries: const [
        TransferSubmitEntry(
          outSite: 'SRC-1',
          inSite: 'TGT-1',
          materialCode: 'MAT-001',
          quantity: 2,
          batchNo: 'B1',
        ),
      ],
      filter: 'SRC-1',
    );

    await service.submitTransfer(payload);

    verify(
      () => goodsUpService.commitTransfer(
        request: any(
          named: 'request',
          that: isA<GoodsUpTransferRequest>()
              .having((req) => req.filter, 'filter', 'SRC-1')
              .having((req) => req.transferInfos.length, 'entries', 1)
              .having(
                (req) => req.transferInfos.first['qty'],
                'quantity',
                2,
              )
              .having(
                (req) => req.transferInfos.first['batchNo'],
                'batch',
                'B1',
              ),
        ),
      ),
    ).called(1);
  });
}
