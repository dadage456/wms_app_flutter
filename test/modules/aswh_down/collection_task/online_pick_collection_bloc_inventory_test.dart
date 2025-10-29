import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/services/user_manager.dart';

class _MockCollectionService extends Mock implements AswhDownCollectionService {}

class _MockTaskService extends Mock implements AswhDownTaskService {}

class _MockUserManager extends Mock implements UserManager {}

class _TestableOnlinePickCollectionBloc extends OnlinePickCollectionBloc {
  _TestableOnlinePickCollectionBloc({
    required OnlinePickTask task,
    required AswhDownTaskService taskService,
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
  }) : super(
          task: task,
          taskService: taskService,
          collectionService: collectionService,
          userManager: userManager,
        );

  void seed(OnlinePickCollectionState seededState) {
    emit(seededState);
  }
}

Future<void> _pumpBloc() async {
  await Future<void>.delayed(Duration.zero);
}

void main() {
  final task = const OnlinePickTask(
    outTaskId: 1,
    outTaskNo: 'TASK-001',
    storeRoomNo: 'RM-1',
    taskComment: 'COMMENT-1',
  );

  final baseItem = OnlinePickTaskItem(
    outTaskItemId: 10,
    outTaskId: task.outTaskId,
    outTaskNo: task.outTaskNo,
    materialCode: 'MAT-001',
    storeSiteNo: 'LOC-01',
    storeRoomNo: 'RM-1',
    subInventoryCode: 'ERP-1',
    taskQty: 10,
    collectedQty: 0,
    batchNo: 'B01',
  );

  final barcode = OnlinePickBarcodeContent(
    materialCode: 'MAT-001',
    batchNo: 'B01',
    quantity: 2,
  );

  group('inventory validation', () {
    late _MockCollectionService collectionService;
    late _TestableOnlinePickCollectionBloc bloc;

    setUp(() {
      collectionService = _MockCollectionService();
      bloc = _TestableOnlinePickCollectionBloc(
        task: task,
        taskService: _MockTaskService(),
        collectionService: collectionService,
        userManager: _MockUserManager(),
      );
    });

    tearDown(() async {
      await bloc.close();
    });

    test('emits error when available inventory is insufficient', () async {
      when(
        () => collectionService.getRepertoryByStoreSite(
          storeSiteNo: 'LOC-01',
          materialCode: 'MAT-001',
          erpStoreroom: any(named: 'erpStoreroom'),
          batchNo: any(named: 'batchNo'),
          serialNumber: any(named: 'serialNumber'),
        ),
      ).thenAnswer(
        (_) async => [
          {
            'batchno': 'B01',
            'repqty': 5,
            'erpStoreroom': 'ERP-1',
          },
        ],
      );

      final seeded = OnlinePickCollectionState.initial(task).copyWith(
        location: 'LOC-01',
        trayNo: 'TP-01',
        currentItem: baseItem,
        barcodeContent: barcode,
        expectedErpStore: 'ERP-1',
        inventoryQtyMap: {'LOC-01|MAT-001|B01': 4},
      );

      bloc.seed(seeded);

      bloc.add(const OnlinePickCollectionQuantitySubmitted(2));
      await _pumpBloc();

      final state = bloc.state;
      expect(state.status.type, equals(CollectionStatusType.error));
      expect(state.collectedStocks, isEmpty);
      expect(state.pendingQuantity, isNull);
    });

    test('records stock when inventory validation passes', () async {
      when(
        () => collectionService.getRepertoryByStoreSite(
          storeSiteNo: 'LOC-01',
          materialCode: 'MAT-001',
          erpStoreroom: any(named: 'erpStoreroom'),
          batchNo: any(named: 'batchNo'),
          serialNumber: any(named: 'serialNumber'),
        ),
      ).thenAnswer(
        (_) async => [
          {
            'batchno': 'B01',
            'repqty': 8,
            'erpStoreroom': 'ERP-1',
          },
        ],
      );

      final existingStock = OnlinePickCollectionStock(
        stockId: 'S-1',
        materialCode: 'MAT-001',
        batchNo: 'B01',
        collectQty: 3,
        outTaskItemId: baseItem.outTaskItemId.toString(),
        taskId: baseItem.outTaskId.toString(),
        storeRoom: baseItem.storeRoomNo,
        storeSite: 'LOC-01',
        erpStore: 'ERP-1',
        trayNo: 'TP-01',
      );

      final seeded = OnlinePickCollectionState.initial(task).copyWith(
        location: 'LOC-01',
        trayNo: 'TP-01',
        currentItem: baseItem,
        barcodeContent: barcode,
        expectedErpStore: 'ERP-1',
        inventoryQtyMap: {'LOC-01|MAT-001|B01': 3},
        collectedStocks: [existingStock],
      );

      bloc.seed(seeded);

      bloc.add(const OnlinePickCollectionQuantitySubmitted(2));
      await _pumpBloc();

      final state = bloc.state;
      expect(state.status.type, equals(CollectionStatusType.success));
      expect(state.collectedStocks, hasLength(2));
      expect(state.collectedStocks.last.collectQty, equals(2));
      expect(state.collectedStocks.last.erpStore, equals('ERP-1'));
      expect(state.inventoryQtyMap['LOC-01|MAT-001|B01'], closeTo(5, 0.0001));
      expect(state.pendingQuantity, isNull);
    });
  });
}
