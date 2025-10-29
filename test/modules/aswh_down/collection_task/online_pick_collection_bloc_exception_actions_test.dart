import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/services/user_manager.dart';

class _RecordingCollectionService extends AswhDownCollectionService {
  _RecordingCollectionService() : super(Dio());

  List<Map<String, dynamic>>? exceptionInfos;
  Map<String, String>? emptyTrayCall;
  Map<String, String>? resetCall;

  @override
  Future<Map<String, dynamic>> commitExceptionShelves({
    required List<Map<String, dynamic>> exceptionInfos,
  }) async {
    this.exceptionInfos = exceptionInfos;
    return {'code': '200'};
  }

  @override
  Future<Map<String, dynamic>> commitEmptyTrayWmsToWcs({
    required String taskId,
    required String taskNo,
    required String trayNo,
    required String startAddr,
    required String endAddr,
    String singleFlag = 'N',
  }) async {
    emptyTrayCall = {
      'taskId': taskId,
      'taskNo': taskNo,
      'trayNo': trayNo,
      'startAddr': startAddr,
      'endAddr': endAddr,
      'singleFlag': singleFlag,
    };
    return {'code': '200'};
  }

  @override
  Future<Map<String, dynamic>> commitResetWmsToWcs({
    required String taskId,
    required String taskNo,
    required String trayNo,
    required String startAddr,
    required String endAddr,
    bool isInventory = false,
  }) async {
    resetCall = {
      'taskId': taskId,
      'taskNo': taskNo,
      'trayNo': trayNo,
      'startAddr': startAddr,
      'endAddr': endAddr,
      'isInventory': isInventory.toString(),
    };
    return {'code': '200'};
  }
}

class _MockTaskService extends Mock implements AswhDownTaskService {}

class _MockUserManager extends Mock implements UserManager {}

class _TestableBloc extends OnlinePickCollectionBloc {
  _TestableBloc({
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
  TestWidgetsFlutterBinding.ensureInitialized();

  const task = OnlinePickTask(
    outTaskId: 99,
    outTaskNo: 'TASK-99',
    storeRoomNo: 'ROOM-1',
    taskComment: 'COMMENT-1',
  );

  final baseItem = OnlinePickTaskItem(
    outTaskItemId: 1,
    outTaskId: task.outTaskId,
    outTaskNo: task.outTaskNo,
    materialCode: 'MAT-001',
    materialName: '物料A',
    storeSiteNo: 'LOC-01',
    palletNo: 'TP-01',
    taskQty: 5,
  );

  late _RecordingCollectionService collectionService;
  late _MockTaskService taskService;
  late _MockUserManager userManager;
  late _TestableBloc bloc;

  setUp(() {
    collectionService = _RecordingCollectionService();
    taskService = _MockTaskService();
    userManager = _MockUserManager();
    when(() => userManager.userInfo).thenReturn(
      const UserInfoModel(
        userId: 1,
        deptId: 1,
        userName: 'tester',
        nickName: 'tester',
        sex: '1',
        status: '0',
        delFlag: '0',
      ),
    );

    bloc = _TestableBloc(
      task: task,
      taskService: taskService,
      collectionService: collectionService,
      userManager: userManager,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  test('提交异常补录时会调用异常接口并返回成功状态', () async {
    bloc.seed(
      OnlinePickCollectionState.initial(task).copyWith(
        location: 'LOC-01',
        trayNo: 'TP-01',
        currentItem: baseItem,
      ),
    );

    bloc.add(
      OnlinePickCollectionExceptionSubmitted(
        const OnlinePickExceptionSubmission(
          materialCode: 'MAT-001',
          materialName: '物料A',
          quantity: 2,
          storeSite: 'LOC-01',
          exceptionType: '006',
          description: '测试异常',
        ),
      ),
    );

    await _pumpBloc();

    expect(bloc.state.status.type, CollectionStatusType.success);
    expect(collectionService.exceptionInfos, isNotNull);
    final payload = collectionService.exceptionInfos!.single;
    expect(payload['matCode'], 'MAT-001');
    expect(payload['excepttype'], '006');
    expect(payload['collectQty'], 2);
  });

  test('物料编码为空时异常补录会提示错误', () async {
    bloc.seed(OnlinePickCollectionState.initial(task));

    bloc.add(
      OnlinePickCollectionExceptionSubmitted(
        const OnlinePickExceptionSubmission(
          materialCode: '',
          quantity: 1,
          storeSite: 'LOC-01',
          exceptionType: '006',
        ),
      ),
    );

    await _pumpBloc();

    expect(bloc.state.status.type, CollectionStatusType.error);
    expect(collectionService.exceptionInfos, isNull);
  });

  test('空盘出库会写入WCS指令', () async {
    bloc.seed(
      OnlinePickCollectionState.initial(task).copyWith(
        trayNo: 'TP-02',
        selectedLocation: const OnlinePickLocationOption(
          label: '拣选口A',
          value: 'OUT-01',
        ),
      ),
    );

    bloc.add(const OnlinePickCollectionEmptyTrayOutboundRequested());
    await _pumpBloc();

    expect(bloc.state.status.type, CollectionStatusType.success);
    expect(collectionService.emptyTrayCall, isNotNull);
    expect(collectionService.emptyTrayCall!['endAddr'], '1111');
  });

  test('托盘回库会写入重置指令', () async {
    bloc.seed(
      OnlinePickCollectionState.initial(task).copyWith(
        trayNo: 'TP-01',
        selectedLocation: const OnlinePickLocationOption(
          label: '拣选口A',
          value: 'OUT-01',
        ),
        detailList: [baseItem],
      ),
    );

    bloc.add(const OnlinePickCollectionTrayReturnRequested());
    await _pumpBloc();

    expect(bloc.state.status.type, CollectionStatusType.success);
    expect(collectionService.resetCall, isNotNull);
    expect(collectionService.resetCall!['endAddr'], 'LOC-01');
  });

  test('找不到托盘原始库位时回库会提示错误', () async {
    bloc.seed(
      OnlinePickCollectionState.initial(task).copyWith(
        trayNo: 'UNKNOWN',
        selectedLocation: const OnlinePickLocationOption(
          label: '拣选口A',
          value: 'OUT-01',
        ),
      ),
    );

    bloc.add(const OnlinePickCollectionTrayReturnRequested());
    await _pumpBloc();

    expect(bloc.state.status.type, CollectionStatusType.error);
    expect(collectionService.resetCall, isNull);
  });
}
