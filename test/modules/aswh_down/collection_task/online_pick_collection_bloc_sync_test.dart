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
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/services/user_manager.dart';

class _MockTaskService extends Mock implements AswhDownTaskService {}

class _MockCollectionService extends Mock implements AswhDownCollectionService {}

class _MockUserManager extends Mock implements UserManager {}

void main() {
  late OnlinePickCollectionBloc bloc;

  setUp(() {
    bloc = OnlinePickCollectionBloc(
      task: const OnlinePickTask(
        outTaskId: 1,
        outTaskNo: 'TASK-001',
      ),
      taskService: _MockTaskService(),
      collectionService: _MockCollectionService(),
      userManager: _MockUserManager(),
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
    expect(state.inventoryQtyMap['LOC-01|MAT-001|B01'], closeTo(5, 0.0001));

    final materialKey = 'MAT-001|B01|LOC-01|TP-01';
    expect(state.materialQtyMap[materialKey], equals([3.0, 5.0]));
    expect(state.expectedErpStore, equals('ERP-A'));
    expect(state.status.type, equals(CollectionStatusType.success));
    expect(state.status.message, equals('采集结果已同步'));
    expect(state.barcodeContent, isNull);
    expect(state.pendingQuantity, isNull);
  });
}
