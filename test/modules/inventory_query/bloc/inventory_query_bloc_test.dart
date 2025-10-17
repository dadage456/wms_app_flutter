import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/modules/inventory_query/bloc/inventory_query_bloc.dart';
import 'package:wms_app/modules/inventory_query/bloc/inventory_query_event.dart';
import 'package:wms_app/modules/inventory_query/bloc/inventory_query_state.dart';
import 'package:wms_app/modules/inventory_query/models/inventory_barcode_material.dart';
import 'package:wms_app/modules/inventory_query/models/inventory_query_request.dart';
import 'package:wms_app/modules/inventory_query/models/inventory_record.dart';
import 'package:wms_app/modules/inventory_query/services/inventory_query_service.dart';

class _MockInventoryQueryService extends Mock
    implements InventoryQueryService {}

void main() {
  late InventoryQueryService service;

  setUpAll(() {
    registerFallbackValue(
      const InventoryQueryRequest(barcode: '', queryType: 'M'),
    );
  });

  setUp(() {
    service = _MockInventoryQueryService();
  });

  InventoryQueryBloc buildBloc() => InventoryQueryBloc(service: service);

  blocTest<InventoryQueryBloc, InventoryQueryState>(
    'initialized event triggers focus request',
    build: buildBloc,
    act: (bloc) => bloc.add(const InventoryQueryEvent.initialized()),
    expect: () => [const InventoryQueryState(focusTick: 1)],
  );

  blocTest<InventoryQueryBloc, InventoryQueryState>(
    'barcode scan success emits loading and success states',
    build: () {
      final material = const InventoryBarcodeMaterial(
        matcode: 'MAT001',
        matname: '叶轮',
      );
      final page = InventoryRecordPage(
        rows: const [InventoryRecord(matcode: 'MAT001', repqty: 5)],
        total: 1,
      );

      when(
        () => service.getMaterialInfoByQr(any()),
      ).thenAnswer((_) async => material);
      when(
        () => service.getInventoryByBarcode(any()),
      ).thenAnswer((_) async => page);
      return buildBloc();
    },
    act: (bloc) =>
        bloc.add(const InventoryQueryEvent.barcodeScanned('MC123456')),
    expect: () => [
      isA<InventoryQueryState>().having(
        (s) => s.status,
        'status',
        PageStatus.loading,
      ),
      isA<InventoryQueryState>()
          .having((s) => s.status, 'status', PageStatus.success)
          .having((s) => s.records.length, 'records', 1)
          .having((s) => s.summary.totalQuantity, 'totalQuantity', 5)
          .having((s) => s.summary.materialCode, 'materialCode', 'MAT001'),
    ],
    verify: (bloc) {
      verify(() => service.getMaterialInfoByQr(any())).called(1);
      verify(() => service.getInventoryByBarcode(any())).called(1);
    },
  );

  blocTest<InventoryQueryBloc, InventoryQueryState>(
    'manual submit empty input emits failure state',
    build: buildBloc,
    act: (bloc) =>
        bloc.add(const InventoryQueryEvent.manualSubmitted(input: ' ')),
    expect: () => [
      isA<InventoryQueryState>()
          .having((s) => s.status, 'status', PageStatus.failure)
          .having((s) => s.errorMessage, 'error', isNotNull),
    ],
  );
}
