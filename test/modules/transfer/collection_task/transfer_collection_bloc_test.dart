import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/transfer/collection_task/bloc/transfer_collection_bloc.dart';
import 'package:wms_app/modules/transfer/collection_task/bloc/transfer_collection_event.dart';
import 'package:wms_app/modules/transfer/collection_task/bloc/transfer_collection_state.dart';
import 'package:wms_app/modules/transfer/collection_task/models/transfer_collection_models.dart';
import 'package:wms_app/modules/transfer/services/transfer_task_service.dart';

class MockTransferTaskService extends Mock implements TransferTaskService {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const TransferSubmitPayload(entries: <TransferSubmitEntry>[], filter: ''),
    );
  });

  blocTest<TransferCollectionBloc, TransferCollectionState>(
    'initializes store room and placeholder on start',
    build: () => TransferCollectionBloc(service: MockTransferTaskService()),
    act: (bloc) => bloc.add(const TransferStarted(storeRoom: 'RM1', erpStoreRoom: 'ERP1')),
    expect: () => [
      isA<TransferCollectionState>()
          .having((state) => state.context.storeRoom, 'storeRoom', 'RM1')
          .having((state) => state.context.erpStoreRoom, 'erpStoreRoom', 'ERP1')
          .having(
            (state) => state.context.placeholder,
            'placeholder',
            '请扫描来源库位',
          ),
    ],
  );

  group('scan flow', () {
    late MockTransferTaskService service;

    blocTest<TransferCollectionBloc, TransferCollectionState>(
      'handles source site scan and advances to target step',
      build: () {
        service = MockTransferTaskService();
        when(
          () => service.validateStoreSite(
            storeRoomNo: any(named: 'storeRoomNo'),
            storeSiteNo: any(named: 'storeSiteNo'),
          ),
        ).thenAnswer(
          (invocation) async => TransferStoreSiteInfo(
            storeRoomNo: invocation.namedArguments[#storeRoomNo] as String?,
            erpStoreRoom: 'ERP1',
          ),
        );
        return TransferCollectionBloc(service: service);
      },
      act: (bloc) async {
        bloc.add(const TransferStarted(storeRoom: 'RM1'));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ScanInputSubmitted(input: 'SITE-1'));
      },
      expect: () => [
        isA<TransferCollectionState>()
            .having((state) => state.context.storeRoom, 'storeRoom', 'RM1')
            .having((state) => state.context.targetSite, 'target', 'RM1MOVESITE'),
        isA<TransferCollectionState>()
            .having((state) => state.status.type, 'status', CollectionStatusType.loading),
        isA<TransferCollectionState>()
            .having((state) => state.context.sourceSite, 'source', 'SITE-1')
            .having((state) => state.status.type, 'status', CollectionStatusType.success)
            .having(
              (state) => state.context.step,
              'step',
              TransferScanStep.material,
            ),
      ],
      verify: (_) {
        verify(
          () => service.validateStoreSite(
            storeRoomNo: 'RM1',
            storeSiteNo: 'SITE-1',
          ),
        ).called(1);
      },
    );

    blocTest<TransferCollectionBloc, TransferCollectionState>(
      'quantity confirmation records collected item and resets context',
      build: () => TransferCollectionBloc(service: MockTransferTaskService()),
      seed: () => TransferCollectionState(
        context: const TransferScanContext(
          mode: TransferMode.moveOut,
          step: TransferScanStep.quantity,
          storeRoom: 'RM1',
          sourceSite: 'SRC-1',
          targetSite: 'TGT-1',
          materialCode: 'MAT-1',
          materialName: '物料',
          batchNo: 'B1',
          erpStoreRoom: 'ERP1',
        ),
        inventoryRows: const [
          TransferInventoryRow(
            storeSiteNo: 'SRC-1',
            materialCode: 'MAT-1',
            quantity: 5,
            batchNo: 'B1',
          ),
        ],
      ),
      act: (bloc) => bloc.add(const QuantityConfirmed(2)),
      expect: () => [
        isA<TransferCollectionState>()
            .having((state) => state.status.type, 'status', CollectionStatusType.success)
            .having((state) => state.collectedItems.length, 'items', 1)
            .having(
              (state) => state.context.step,
              'step',
              TransferScanStep.sourceSite,
            ),
      ],
    );

    blocTest<TransferCollectionBloc, TransferCollectionState>(
      'quantity confirmation fails when available inventory is insufficient',
      build: () => TransferCollectionBloc(service: MockTransferTaskService()),
      seed: () => TransferCollectionState(
        context: const TransferScanContext(
          mode: TransferMode.moveOut,
          step: TransferScanStep.quantity,
          storeRoom: 'RM1',
          sourceSite: 'SRC-1',
          targetSite: 'TGT-1',
          materialCode: 'MAT-1',
          batchNo: 'B1',
        ),
        inventoryRows: const [
          TransferInventoryRow(
            storeSiteNo: 'SRC-1',
            materialCode: 'MAT-1',
            quantity: 1,
            batchNo: 'B1',
          ),
        ],
      ),
      act: (bloc) => bloc.add(const QuantityConfirmed(5)),
      expect: () => [
        isA<TransferCollectionState>()
            .having((state) => state.status.type, 'status', CollectionStatusType.error),
      ],
    );
  });

  late MockTransferTaskService submitService;

  blocTest<TransferCollectionBloc, TransferCollectionState>(
    'submit event forwards payload and clears collected items',
    build: () {
      submitService = MockTransferTaskService();
      when(() => submitService.submitTransfer(any())).thenAnswer((_) async {});
      return TransferCollectionBloc(service: submitService);
    },
    seed: () => TransferCollectionState(
      context: const TransferScanContext(
        storeRoom: 'RM1',
        sourceSite: 'SRC-1',
        targetSite: 'TGT-1',
        materialCode: 'MAT-1',
      ),
      collectedItems: const [
        TransferCollectedItem(
          id: '1',
          sourceSite: 'SRC-1',
          targetSite: 'TGT-1',
          materialCode: 'MAT-1',
          quantity: 2,
        ),
      ],
    ),
    act: (bloc) => bloc.add(const TransferSubmitRequested()),
    expect: () => [
      isA<TransferCollectionState>()
          .having((state) => state.submitStatus.type, 'submitStatus', CollectionStatusType.loading),
      isA<TransferCollectionState>()
          .having((state) => state.submitStatus.type, 'submitStatus', CollectionStatusType.success)
          .having((state) => state.collectedItems, 'items', isEmpty),
    ],
    verify: (_) {
      verify(
        () => submitService.submitTransfer(
          any(
            that: isA<TransferSubmitPayload>()
                .having((payload) => payload.entries.length, 'entries', 1)
                .having((payload) => payload.filter, 'filter', 'SRC-1')
                .having(
                  (payload) => payload.entries.first.materialCode,
                  'material',
                  'MAT-1',
                ),
          ),
        ),
      ).called(1);
    },
  );
}
