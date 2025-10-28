import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/services/user_manager.dart';

class _MockCollectionService extends Mock implements AswhDownCollectionService {}

class _MockUserManager extends Mock implements UserManager {}

void main() {
  late OnlinePickCollectionBloc bloc;
  late _MockCollectionService collectionService;
  late _MockUserManager userManager;

  setUpAll(() {
    registerFallbackValue<List<Map<String, dynamic>>>(<Map<String, dynamic>>[]);
  });

  setUp(() {
    collectionService = _MockCollectionService();
    userManager = _MockUserManager();
    bloc = OnlinePickCollectionBloc(
      collectionService: collectionService,
      userManager: userManager,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  Future<void> _drainQueue() async {
    await Future<void>.delayed(Duration.zero);
  }

  test('synchronising stocks updates cache maps and status', () async {
    final payload = [
      OnlinePickCollectionStock(
        stockId: 'S-1',
        materialCode: 'MAT-001',
        batchNo: 'B01',
        serialNumber: 'SN-A',
        taskQty: 10,
        collectQty: 3,
        outTaskItemId: 'OT-1',
        taskId: 'T-1',
        storeRoom: 'R-1',
        storeSite: 'LOC-01',
        erpStore: 'ERP-A',
        trayNo: 'TP-01',
      ).toJson(),
      OnlinePickCollectionStock(
        stockId: 'S-2',
        materialCode: 'MAT-001',
        batchNo: 'B01',
        serialNumber: 'SN-A',
        taskQty: 10,
        collectQty: 2,
        outTaskItemId: 'OT-1',
        taskId: 'T-1',
        storeRoom: 'R-1',
        storeSite: 'LOC-01',
        erpStore: 'ERP-A',
        trayNo: 'TP-01',
      ).toJson(),
    ];

    bloc.add(OnlinePickCollectionStocksSynced(payload));
    await _drainQueue();

    final OnlinePickCollectionState state = bloc.state;
    expect(state.collectedStocks, hasLength(2));
    expect(state.serialMap, contains('MAT-001@SN-A'));
    expect(state.inventoryQtyMap, isEmpty);

    final materialKey = 'OT-1';
    expect(state.materialQtyMap[materialKey], equals([10.0, 5.0]));
    expect(state.expectedErpStore, equals('ERP-A'));
    expect(state.status.type, equals(CollectionStatusType.success));
    expect(state.status.message, equals('采集结果已同步'));
    expect(state.barcodeContent, isNull);
    expect(state.pendingQuantity, isNull);
  });

  test('inventory recorded updates manual map and persists state', () async {
    bloc.seedForTest(
      stocks: [
        const OnlinePickCollectionStock(
          stockId: 'S-1',
          materialCode: 'MAT-002',
          batchNo: 'B01',
          serialNumber: null,
          taskQty: 5,
          collectQty: 5,
          outTaskItemId: '100',
          taskId: '200',
          storeRoom: 'RM',
          storeSite: 'LOC-88',
          erpStore: 'ERP-B',
          trayNo: '',
        ),
      ],
    );

    bloc.add(
      const OnlinePickCollectionInventoryRecorded(
        materialCode: 'MAT-002',
        storeSite: 'LOC-88',
        batchNo: 'B01',
        trayNo: '',
        quantity: 9.5,
      ),
    );
    await _drainQueue();

    expect(bloc.state.inventoryQtyMap['LOC-88|MAT-002|B01|'], closeTo(9.5, 0.0001));
    expect(bloc.state.status.message, equals('库存核对已更新'));
  });

  test('commit builds payload and clears state on success', () async {
    when(
      () => collectionService.commitAswhDownShelves(
        downShelvesInfos: any(named: 'downShelvesInfos'),
        itemListInfos: any(named: 'itemListInfos'),
        inventoryCheckInfos: any(named: 'inventoryCheckInfos'),
      ),
    ).thenAnswer((_) async => {'code': 200, 'msg': 'OK'});

    final task = const OnlinePickTask(outTaskId: 200, outTaskNo: 'TASK-001');
    final stocks = [
      const OnlinePickCollectionStock(
        stockId: 'S-1',
        materialCode: 'MAT-003',
        batchNo: 'B01',
        serialNumber: 'SN-1',
        taskQty: 10,
        collectQty: 6,
        outTaskItemId: '300',
        taskId: '200',
        storeRoom: 'RM-1',
        storeSite: 'LOC-01',
        erpStore: 'ERP-1',
        trayNo: 'TP-01',
      ),
      const OnlinePickCollectionStock(
        stockId: 'S-2',
        materialCode: 'MAT-003',
        batchNo: 'B01',
        serialNumber: 'SN-2',
        taskQty: 10,
        collectQty: 4,
        outTaskItemId: '300',
        taskId: '200',
        storeRoom: 'RM-1',
        storeSite: 'LOC-01',
        erpStore: 'ERP-1',
        trayNo: 'TP-01',
      ),
    ];

    final taskItems = [
      const OnlinePickTaskItem(
        outTaskItemId: 300,
        outTaskId: 200,
        outTaskNo: 'TASK-001',
        materialCode: 'MAT-003',
        materialName: '物料003',
        storeSiteNo: 'LOC-01',
        storeRoomNo: 'RM-1',
        hintQty: 10,
        collectedQty: 0,
      ),
    ];

    bloc.seedForTest(
      task: task,
      userId: 88,
      stocks: stocks,
      inventoryMap: {'LOC-01|MAT-003|B01|TP-01': 12},
      taskItems: taskItems,
    );

    bloc.add(const OnlinePickCollectionCommitRequested());
    await _drainQueue();

    final capturedDownShelves = verify(
      () => collectionService.commitAswhDownShelves(
        downShelvesInfos: captureAny(named: 'downShelvesInfos'),
        itemListInfos: captureAny(named: 'itemListInfos'),
        inventoryCheckInfos: captureAny(named: 'inventoryCheckInfos'),
      ),
    ).captured;

    final downShelves = capturedDownShelves[0] as List<Map<String, dynamic>>;
    final itemListInfos = capturedDownShelves[1] as List<Map<String, dynamic>>;
    final inventoryInfos = capturedDownShelves[2] as List<Map<String, dynamic>>;

    expect(downShelves, hasLength(2));
    expect(itemListInfos, [
      {
        'mtlQty': ['10', '10'],
        'outTaskItemid': '300',
        'mtlCode': 'MAT-003',
      }
    ]);
    expect(inventoryInfos, [
      {
        'matCode': 'MAT-003',
        'storeSite': 'LOC-01',
        'trayNo': 'TP-01',
        'batchNo': 'B01',
        'quantity': '12',
      }
    ]);

    expect(bloc.state.collectedStocks, isEmpty);
    expect(bloc.state.inventoryQtyMap, isEmpty);
    expect(bloc.state.status.message, equals('OK'));
  });
}
