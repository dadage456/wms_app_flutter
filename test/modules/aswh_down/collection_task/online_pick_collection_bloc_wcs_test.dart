import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/services/user_manager.dart';

class _MockCollectionService extends Mock implements AswhDownCollectionService {}

class _MockUserManager extends Mock implements UserManager {}

Future<void> _pumpBloc() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(const Duration(milliseconds: 10));
}

void main() {
  late Directory tempDir;
  late OnlinePickCollectionBloc bloc;
  late _MockCollectionService collectionService;
  late _MockUserManager userManager;

  const task = OnlinePickTask(
    outTaskId: 200,
    outTaskNo: 'TASK-200',
    storeRoomNo: 'RM-01',
    taskComment: 'COMMENT-1',
  );

  const locationOptions = [
    OnlinePickLocationOption(label: '一号拣选口', value: 'DEST-01'),
    OnlinePickLocationOption(label: '二号拣选口', value: 'DEST-02'),
  ];

  const primaryItem = OnlinePickTaskItem(
    outTaskItemId: 301,
    outTaskId: 200,
    outTaskNo: 'TASK-200',
    materialCode: 'MAT-001',
    storeSiteNo: 'LOC-01',
    storeRoomNo: 'RM-01',
    palletNo: 'TP01',
  );

  const secondaryItem = OnlinePickTaskItem(
    outTaskItemId: 302,
    outTaskId: 200,
    outTaskNo: 'TASK-200',
    materialCode: 'MAT-002',
    storeSiteNo: 'LOC-02',
    storeRoomNo: 'RM-01',
    palletNo: 'TP02',
  );

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    tempDir = await Directory.systemTemp.createTemp('online_pick_bloc_wcs_test');
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

    registerFallbackValue(const OnlinePickCollectionQuery());
    registerFallbackValue<List<Map<String, dynamic>>>(<Map<String, dynamic>>[]);
  });

  tearDownAll(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  setUp(() {
    collectionService = _MockCollectionService();
    userManager = _MockUserManager();

    when(() => userManager.userInfo).thenReturn(
      const UserInfoModel(
        userId: 9,
        deptId: 1,
        userName: 'tester',
        nickName: 'tester',
        sex: 'M',
        status: '0',
        delFlag: '0',
      ),
    );

    when(() => collectionService.getRoomMatControl(any())).thenAnswer(
      (_) async => '1!1!1!1!0',
    );

    when(
      () => collectionService.fetchInOutLocations(
        locationType: any(named: 'locationType'),
      ),
    ).thenAnswer((_) async => locationOptions);

    when(
      () => collectionService.fetchCollectionTaskItems(
        query: any(named: 'query'),
      ),
    ).thenAnswer((_) async => const [primaryItem, secondaryItem]);

    bloc = OnlinePickCollectionBloc(
      collectionService: collectionService,
      userManager: userManager,
    );
  });

  tearDown(() async {
    await bloc.close();
    final boxName = 'aswh_down_collect_${task.outTaskId}';
    if (await Hive.boxExists(boxName)) {
      await Hive.deleteBoxFromDisk(boxName);
    }
    reset(collectionService);
    reset(userManager);
  });

  test('empty tray out success updates status and sends command', () async {
    when(
      () => collectionService.commitEmptyTrayWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer(
      (invocation) async => {
        'code': 200,
        'msg': '指令下发成功',
      },
    );

    bloc.add(const OnlinePickCollectionInitialized(task));
    await _pumpBloc();
    await _pumpBloc();

    bloc.add(const OnlinePickCollectionScanSubmitted(r'$TP$TP01'));
    await _pumpBloc();

    expect(bloc.state.currentTray, equals('TP01'));
    expect(bloc.state.selectedDestination, equals('DEST-01'));

    bloc.add(const OnlinePickCollectionEmptyTrayOutRequested());
    await _pumpBloc();

    expect(bloc.state.status.type, equals(CollectionStatusType.success));
    expect(bloc.state.status.message, equals('空托盘出库成功,请等待'));

    verify(
      () => collectionService.commitEmptyTrayWmsToWcs(
        taskId: task.outTaskId.toString(),
        taskNo: task.outTaskNo,
        trayNo: 'TP01',
        startAddr: 'DEST-01',
        endAddr: '1111',
        singleFlag: '1',
      ),
    ).called(1);
  });

  test('empty tray in failure surfaces backend message', () async {
    when(
      () => collectionService.commitEmptyTrayWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer((invocation) async {
      final endAddr = invocation.namedArguments[#endAddr] as String;
      if (endAddr == '1111') {
        return {'code': 200, 'msg': 'OK'};
      }
      return {'code': 500, 'msg': '空盘入库失败'};
    });

    bloc.add(const OnlinePickCollectionInitialized(task));
    await _pumpBloc();
    await _pumpBloc();

    bloc.add(const OnlinePickCollectionScanSubmitted(r'$TP$TP01'));
    await _pumpBloc();

    bloc.add(const OnlinePickCollectionEmptyTrayInRequested());
    await _pumpBloc();

    expect(bloc.state.status.type, equals(CollectionStatusType.error));
    expect(bloc.state.status.message, equals('空盘入库失败'));
  });

  test('all tray request success emits success status', () async {
    when(
      () => collectionService.commitEmptyTrayWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer((_) async => {'code': 200, 'msg': 'OK'});

    when(
      () => collectionService.commitDownWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer((_) async => {'code': 200, 'msg': 'success'});

    bloc.add(const OnlinePickCollectionInitialized(task));
    await _pumpBloc();
    await _pumpBloc();

    bloc.add(const OnlinePickCollectionAllTrayRequested(2));
    await _pumpBloc();
    await _pumpBloc();

    expect(bloc.state.status.type, equals(CollectionStatusType.success));
    expect(bloc.state.status.message, equals('获取来料托盘成功,请等待'));

    verify(
      () => collectionService.commitDownWmsToWcs(
        taskId: task.outTaskId.toString(),
        taskNo: task.outTaskNo,
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: 'DEST-01',
        singleFlag: '0',
      ),
    ).called(greaterThanOrEqualTo(2));
  });

  test('all tray request partial failures report failed trays', () async {
    when(
      () => collectionService.commitEmptyTrayWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer((_) async => {'code': 200, 'msg': 'OK'});

    when(
      () => collectionService.commitDownWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer((invocation) async {
      final tray = invocation.namedArguments[#trayNo] as String;
      if (tray == 'TP01') {
        return {'code': 200, 'msg': 'success'};
      }
      return {'code': 400, 'msg': 'error'};
    });

    bloc.add(const OnlinePickCollectionInitialized(task));
    await _pumpBloc();
    await _pumpBloc();

    bloc.add(const OnlinePickCollectionAllTrayRequested(2));
    await _pumpBloc();
    await _pumpBloc();

    expect(bloc.state.status.type, equals(CollectionStatusType.success));
    expect(
      bloc.state.status.message,
      equals('部分托盘已下发，失败托盘：TP02'),
    );
  });
}
