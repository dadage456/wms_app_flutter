import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/services/user_manager.dart';

class _StubCollectionService extends AswhDownCollectionService {
  _StubCollectionService({
    required this.items,
    required this.wcsCommands,
    required this.locations,
  }) : super(Dio());

  List<OnlinePickTaskItem> items;
  List<OnlinePickWcsCommand> wcsCommands;
  List<OnlinePickLocationOption> locations;
  OnlinePickCollectionQuery? lastQuery;
  String? lastTaskComment;
  String? lastTaskId;
  List<Map<String, dynamic>>? lastDownShelvesInfos;
  List<Map<String, dynamic>>? lastItemListInfos;
  OnlinePickSubmissionChannel? lastSubmitChannel;
  int fetchItemsCount = 0;
  int fetchWcsCount = 0;

  @override
  Future<List<OnlinePickTaskItem>> fetchCollectionTaskItems({
    required OnlinePickCollectionQuery query,
  }) async {
    lastQuery = query;
    fetchItemsCount++;
    return items;
  }

  @override
  Future<List<OnlinePickWcsCommand>> fetchWcsCommands({
    required String taskComment,
    required String taskId,
    String taskType = '03',
    String queryStr = '',
  }) async {
    lastTaskComment = taskComment;
    lastTaskId = taskId;
    fetchWcsCount++;
    return wcsCommands;
  }

  @override
  Future<List<OnlinePickLocationOption>> fetchInOutLocations({
    String locationType = '1',
  }) async {
    return locations;
  }

  Future<Map<String, dynamic>> _recordSubmit(
    OnlinePickSubmissionChannel channel,
    List<Map<String, dynamic>> downShelvesInfos,
    List<Map<String, dynamic>> itemListInfos,
  ) async {
    lastSubmitChannel = channel;
    lastDownShelvesInfos = downShelvesInfos;
    lastItemListInfos = itemListInfos;
    return {'code': '0'};
  }

  @override
  Future<Map<String, dynamic>> commitAswhDownShelves({
    required List<Map<String, dynamic>> downShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
    List<Map<String, dynamic>> inventoryCheckInfos = const [],
  }) {
    return _recordSubmit(
      OnlinePickSubmissionChannel.aswh,
      downShelvesInfos,
      itemListInfos,
    );
  }

  @override
  Future<Map<String, dynamic>> commitDownShelves({
    required List<Map<String, dynamic>> downShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
  }) {
    return _recordSubmit(
      OnlinePickSubmissionChannel.standard,
      downShelvesInfos,
      itemListInfos,
    );
  }

  @override
  Future<Map<String, dynamic>> commitTrayDownShelves({
    required List<Map<String, dynamic>> downShelvesInfos,
    required List<Map<String, dynamic>> itemListInfos,
  }) {
    return _recordSubmit(
      OnlinePickSubmissionChannel.tray,
      downShelvesInfos,
      itemListInfos,
    );
  }
}

class _MockTaskService extends Mock implements AswhDownTaskService {}

class _MockUserManager extends Mock implements UserManager {}

void main() {
  late Directory tempDir;
  late _StubCollectionService collectionService;
  late OnlinePickCollectionBloc bloc;
  late _MockTaskService taskService;
  late _MockUserManager userManager;

  const task = OnlinePickTask(
    outTaskId: 101,
    outTaskNo: 'TASK-101',
    storeRoomNo: 'RM-1',
    taskComment: 'COMMENT-1',
  );

  final baseItem = OnlinePickTaskItem(
    outTaskItemId: 11,
    outTaskId: task.outTaskId,
    outTaskNo: task.outTaskNo,
    materialCode: 'MAT-001',
    materialName: '物料A',
    storeSiteNo: 'SITE-1',
    storeRoomNo: 'RM-1',
    subInventoryCode: 'ERP-1',
    taskQty: 5,
    collectedQty: 0,
    palletNo: 'PAL-1',
  );

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('aswh_down_submit_test');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(40)) {
      Hive.registerAdapter(OnlinePickBarcodeContentAdapter());
    }
    if (!Hive.isAdapterRegistered(41)) {
      Hive.registerAdapter(OnlinePickCollectionStockAdapter());
    }
    if (!Hive.isAdapterRegistered(42)) {
      Hive.registerAdapter(OnlinePickCollectionCacheSnapshotAdapter());
    }

    collectionService = _StubCollectionService(
      items: [baseItem],
      wcsCommands: const [OnlinePickWcsCommand(commandId: 'CMD-1')],
      locations: const [OnlinePickLocationOption(label: '口1', value: 'LOC-1')],
    );

    taskService = _MockTaskService();
    userManager = _MockUserManager();
    when(() => userManager.userInfo).thenReturn(
      const UserInfoModel(
        userId: 7,
        deptId: 1,
        userName: 'tester',
        nickName: 'Tester',
        sex: 'M',
        status: '0',
        delFlag: '0',
      ),
    );

    bloc = OnlinePickCollectionBloc(
      task: task,
      taskService: taskService,
      collectionService: collectionService,
      userManager: userManager,
      hive: Hive,
    );

    bloc.add(const OnlinePickCollectionStarted(restoreCache: false));
    await bloc.stream.firstWhere(
      (state) => state.status.isSuccess && state.detailList.isNotEmpty,
    );

    final stock = OnlinePickCollectionStock(
      stockId: 'STK-1',
      materialCode: baseItem.materialCode ?? '',
      batchNo: baseItem.batchNo,
      serialNumber: baseItem.serialNumber,
      taskQty: baseItem.taskQty,
      collectQty: 2,
      outTaskItemId: baseItem.outTaskItemId.toString(),
      taskId: baseItem.outTaskId.toString(),
      storeRoom: baseItem.storeRoomNo,
      storeSite: baseItem.storeSiteNo,
      erpStore: baseItem.subInventoryCode,
      trayNo: 'TRAY-1',
    );

    bloc.add(OnlinePickCollectionStocksSynced([stock.toJson()]));
    await bloc.stream.firstWhere(
      (state) => state.collectedStocks.isNotEmpty,
    );

    final cacheBox = Hive.box<OnlinePickCollectionCacheSnapshot>(
      'aswh_down_collect_${task.outTaskId}',
    );
    expect(cacheBox.isEmpty, isFalse);
  });

  tearDown(() async {
    await bloc.close();
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  test('submit clears caches and refreshes task detail state', () async {
    collectionService.items = [
      baseItem.copyWith(collectedQty: 3),
    ];
    collectionService.wcsCommands = const [
      OnlinePickWcsCommand(commandId: 'CMD-2'),
    ];

    final successFuture = bloc.stream.firstWhere(
      (state) =>
          state.status.isSuccess &&
          state.status.message == 'ASWH 下架提交成功',
    );

    bloc.add(const OnlinePickCollectionSubmitRequested());
    final successState = await successFuture;

    expect(collectionService.lastSubmitChannel,
        equals(OnlinePickSubmissionChannel.aswh));
    expect(collectionService.lastDownShelvesInfos, isNotNull);
    expect(collectionService.lastDownShelvesInfos, isNotEmpty);
    expect(collectionService.lastItemListInfos, isNotNull);
    expect(collectionService.lastItemListInfos, isNotEmpty);
    expect(collectionService.fetchItemsCount, equals(2));
    expect(collectionService.fetchWcsCount, equals(2));

    expect(successState.collectedStocks, isEmpty);
    expect(successState.serialMap, isEmpty);
    expect(successState.materialQtyMap, isEmpty);
    expect(successState.inventoryQtyMap, isEmpty);
    expect(successState.detailList.first.collectedQty, equals(3));
    expect(successState.collectingList, isNotEmpty);
    expect(successState.wcsCommands.first.commandId, equals('CMD-2'));

    final cacheBox = Hive.box<OnlinePickCollectionCacheSnapshot>(
      'aswh_down_collect_${task.outTaskId}',
    );
    expect(cacheBox.isEmpty, isTrue);
  });
}
