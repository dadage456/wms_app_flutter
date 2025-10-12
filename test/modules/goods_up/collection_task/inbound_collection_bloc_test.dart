import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_bloc.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_event.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_state.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_request.dart';
import 'package:wms_app/modules/goods_up/services/goods_up_task_service.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';

class StubGoodsUpTaskService extends GoodsUpTaskService {
  StubGoodsUpTaskService({
    required this.collectItems,
    required this.storeSiteRows,
    required this.barcodeContent,
    List<Map<String, dynamic>>? inventoryRows,
  }) : inventoryRows = inventoryRows ?? const [],
        super(Dio());

  List<InboundCollectTaskItem> collectItems;
  GoodsUpCollectTaskItemQuery? lastCollectQuery;
  List<Map<String, dynamic>> storeSiteRows;
  String? lastStoreRoom;
  String? lastStoreSite;
  String? lastBarcode;
  InboundBarcodeContent barcodeContent;
  final Map<String, InboundBarcodeContent> barcodeResponses = {};
  List<Map<String, dynamic>> inventoryRows;
  String? lastInventorySite;
  String? lastInventoryMaterial;

  @override
  Future<List<InboundCollectTaskItem>> getInboundCollectItems({
    required GoodsUpCollectTaskItemQuery query,
  }) async {
    lastCollectQuery = query;
    return collectItems;
  }

  @override
  Future<List<Map<String, dynamic>>> getStoreSiteByRoom({
    required String storeRoomNo,
    required String storeSiteNo,
  }) async {
    lastStoreRoom = storeRoomNo;
    lastStoreSite = storeSiteNo;
    return storeSiteRows;
  }

  @override
  Future<InboundBarcodeContent> getInboundBarcodeInfo(String barcode) async {
    lastBarcode = barcode;
    return barcodeResponses[barcode] ?? barcodeContent;
  }

  @override
  Future<List<Map<String, dynamic>>> getMtlRepertoryByStoreSite({
    required String storeSite,
    required String materialCode,
  }) async {
    lastInventorySite = storeSite;
    lastInventoryMaterial = materialCode;
    return inventoryRows;
  }
}

void main() {
  late Directory tempDir;
  late StubGoodsUpTaskService service;
  late InboundCollectionBloc bloc;
  const task = GoodsUpTask(
    inTaskId: 1,
    inTaskNo: 'TASK-1',
    storeRoomNo: 'RM1',
  );

  final sampleItem = InboundCollectTaskItem(
    inTaskItemId: 11,
    inTaskId: 1,
    materialCode: 'MAT-001',
    materialName: 'Test Material',
    storeSiteNo: 'SITE-1',
    storeRoomNo: 'RM1',
    subInventoryCode: 'ERP',
    planQty: 5,
    collectedQty: 0,
    repertoryQty: 2,
  );

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_goods_up_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(InboundCollectTaskItemAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(InboundBarcodeContentAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(InboundCollectionStockAdapter());
    }

    service = StubGoodsUpTaskService(
      collectItems: [
        InboundCollectTaskItem(
          inTaskItemId: sampleItem.inTaskItemId,
          inTaskId: sampleItem.inTaskId,
          materialCode: sampleItem.materialCode,
          materialName: sampleItem.materialName,
          storeSiteNo: sampleItem.storeSiteNo,
          storeRoomNo: sampleItem.storeRoomNo,
          subInventoryCode: sampleItem.subInventoryCode,
          planQty: sampleItem.planQty,
          collectedQty: sampleItem.collectedQty,
          repertoryQty: sampleItem.repertoryQty,
        ),
      ],
      storeSiteRows: [
        {'storesiteno': 'SITE-1'},
      ],
      barcodeContent: InboundBarcodeContent(
        materialCode: sampleItem.materialCode,
        materialName: sampleItem.materialName,
        batchNo: 'BATCH-1',
        quantity: 1,
      ),
      inventoryRows: [
        {'repqty': sampleItem.repertoryQty, 'erpStoreroom': 'ERP'},
      ],
    );
    service.barcodeResponses['BARCODE-1'] = service.barcodeContent;

    bloc = InboundCollectionBloc(service: service);
  });

  tearDown(() async {
    await bloc.close();
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  test('initialize loads collect items and cache metadata', () async {
    bloc.add(const InitializeInboundCollectionEvent(task: task, userId: 7));

    final state = await bloc.stream.firstWhere(
      (state) => state.status.isSuccess && state.detailList.isNotEmpty,
    );

    expect(state.detailList, isNotEmpty);
    expect(state.storeRoom, equals('RM1'));
    expect(service.lastCollectQuery, isNotNull);
    expect(service.lastCollectQuery!.inTaskNo, equals(task.inTaskNo));
  });

  test('site scan validates store site and switches to material step', () async {
    bloc.add(const InitializeInboundCollectionEvent(task: task, userId: 7));
    await bloc.stream.firstWhere((state) => state.status.isSuccess);

    bloc.add(const PerformInboundScanEvent('SITE-1'));

    final state = await bloc.stream.firstWhere(
      (state) =>
          state.scanStep == InboundScanStep.material &&
          state.status.isSuccess &&
          state.storeSite == 'SITE-1',
    );

    expect(state.placeholder, equals('请扫描物料二维码'));
    expect(service.lastStoreRoom, equals('RM1'));
    expect(service.lastStoreSite, equals('SITE-1'));
  });

  test('quantity scan exceeding remaining amount surfaces error', () async {
    bloc.add(const InitializeInboundCollectionEvent(task: task, userId: 7));
    await bloc.stream.firstWhere((state) => state.status.isSuccess);

    bloc.add(const PerformInboundScanEvent('SITE-1'));
    await bloc.stream.firstWhere(
      (state) => state.scanStep == InboundScanStep.material,
    );

    bloc.add(const PerformInboundScanEvent('BARCODE-1'));
    await bloc.stream.firstWhere(
      (state) => state.scanStep == InboundScanStep.quantity,
    );

    bloc.add(const PerformInboundScanEvent('10'));

    final state = await bloc.stream.firstWhere(
      (state) => state.status.isError,
    );

    expect(state.status.message, contains('超过剩余可采集数量'));
  });

  test('dangerous goods requires supplement before quantity', () async {
    service.barcodeResponses['BARCODE-DG'] = InboundBarcodeContent(
      materialCode: sampleItem.materialCode,
      materialName: sampleItem.materialName,
      batchNo: 'BATCH-1',
      quantity: 1,
      dgFlag: 'Y',
    );
    service.barcodeResponses['SUPP-1'] = InboundBarcodeContent(
      materialCode: sampleItem.materialCode,
      materialName: sampleItem.materialName,
      batchNo: 'BATCH-1',
      quantity: 1,
      dgFlag: 'Y',
      productionDate: '2024-01-01',
      expireDays: 180,
    );
    bloc.add(const InitializeInboundCollectionEvent(task: task, userId: 7));
    await bloc.stream.firstWhere((state) => state.status.isSuccess);

    bloc.add(const PerformInboundScanEvent('SITE-1'));
    await bloc.stream.firstWhere(
      (state) => state.scanStep == InboundScanStep.material,
    );

    bloc.add(const PerformInboundScanEvent('BARCODE-DG'));

    final hazardState = await bloc.stream.firstWhere(
      (state) => state.scanStep == InboundScanStep.dangerousSupplement,
    );

    expect(hazardState.requireDangerousSupplement, isTrue);
    expect(hazardState.placeholder, contains('供应商二维码'));

    bloc.add(const PerformInboundScanEvent('SUPP-1'));

    final readyState = await bloc.stream.firstWhere(
      (state) =>
          state.scanStep == InboundScanStep.quantity &&
          !state.requireDangerousSupplement,
    );

    expect(readyState.currentBarcode?.productionDate, '2024-01-01');
    expect(readyState.currentBarcode?.expireDays, 180);
  });
}
