import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/modules/inventory_query/models/inventory_barcode_material.dart';
import 'package:wms_app/modules/inventory_query/models/inventory_query_request.dart';
import 'package:wms_app/modules/inventory_query/models/inventory_record.dart';
import 'package:wms_app/modules/inventory_query/services/inventory_query_service.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late InventoryQueryService service;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    dio = _MockDio();
    service = InventoryQueryService(dio);
  });

  Response<Map<String, dynamic>> _buildResponse(Map<String, dynamic> data) {
    return Response<Map<String, dynamic>>(
      requestOptions: RequestOptions(path: ''),
      data: {'code': 200, 'msg': 'ok', 'data': data},
    );
  }

  test('getMaterialInfoByQr parses barcode material', () async {
    final payload = InventoryBarcodeMaterial(
      matcode: 'MAT001',
      matname: '物料A',
    ).toJson();

    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => _buildResponse(payload));

    final result = await service.getMaterialInfoByQr('barcode');

    expect(result.matcode, 'MAT001');
    expect(result.matname, '物料A');
  });

  test('getInventoryByBarcode returns inventory page', () async {
    final rows = [
      InventoryRecord(matcode: 'MAT001', repqty: 5).toJson(),
      InventoryRecord(matcode: 'MAT002', repqty: 3).toJson(),
    ];

    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => _buildResponse({'rows': rows, 'total': 2}));

    final page = await service.getInventoryByBarcode(
      InventoryQueryRequest(barcode: 'MAT001', queryType: 'M'),
    );

    expect(page.total, 2);
    expect(page.rows.length, 2);
    expect(page.rows.first.matcode, 'MAT001');
  });
}
