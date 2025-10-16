import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/modules/aswh_down/task_receive/bloc/online_pick_receive_detail_bloc.dart';
import 'package:wms_app/modules/aswh_down/task_receive/bloc/online_pick_receive_detail_event.dart';
import 'package:wms_app/modules/aswh_down/task_receive/bloc/online_pick_receive_detail_state.dart';
import 'package:wms_app/services/user_manager.dart';

class MockAswhDownTaskService extends Mock implements AswhDownTaskService {}

class MockUserManager extends Mock implements UserManager {}

void main() {
  late MockAswhDownTaskService taskService;
  late MockUserManager userManager;
  late OnlinePickReceiveDetailBloc bloc;

  const user = UserInfoModel(
    userId: 1001,
    deptId: 1,
    userName: 'tester',
    nickName: 'tester',
    sex: 'M',
    status: '0',
    delFlag: '0',
  );

  final task = OnlinePickTask(
    outTaskId: 10,
    outTaskNo: 'TASK-010',
    taskComment: 'COMMENT-010',
    workStation: 'WS-1',
    taskQty: 12,
    finishQty: 3,
    forceBatch: 'Y',
    forceSite: 'Y',
  );

  final items = [
    OnlinePickTaskItem(
      outTaskItemId: 100,
      outTaskId: task.outTaskId,
      materialCode: 'MAT-001',
      storeSiteNo: 'LOC-01',
      taskQty: 5,
      collectedQty: 0,
    ),
  ];

  final listData = OnlinePickTaskItemListData(rows: items, total: items.length);

  setUpAll(() {
    registerFallbackValue(
      OnlinePickTaskItemQuery(outTaskId: 0, roleOrUserId: '', userId: 'ALL'),
    );
  });

  setUp(() {
    taskService = MockAswhDownTaskService();
    userManager = MockUserManager();
    when(() => userManager.userInfo).thenReturn(user);
    when(
      () => taskService.fetchTaskItemList(query: any(named: 'query')),
    ).thenAnswer((_) async => listData);
    when(
      () => taskService.commitTaskItems(
        taskItemIds: any(named: 'taskItemIds'),
        isCancel: any(named: 'isCancel'),
        roomTag: any(named: 'roomTag'),
      ),
    ).thenAnswer((_) async {});

    bloc = OnlinePickReceiveDetailBloc(
      taskService: taskService,
      userManager: userManager,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  Future<void> _awaitInitialLoad() async {
    bloc.add(
      OnlinePickReceiveDetailStarted(outTaskId: task.outTaskId, task: task),
    );
    await expectLater(
      bloc.gridBloc.stream,
      emitsThrough(
        predicate<CommonDataGridState<OnlinePickTaskItem>>(
          (state) => state.status == GridStatus.loaded,
        ),
      ),
    );
  }

  test('commit succeeds for selected items', () async {
    await _awaitInitialLoad();
    bloc.gridBloc.add(const ChangeSelectedRowsEvent([0]));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    bloc.add(const OnlinePickReceiveDetailCommitRequested());
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(bloc.state.status.type, CollectionStatusType.success);
    expect(bloc.state.status.message, '接收成功');
    expect(bloc.state.shouldNotifyParent, isTrue);

    verify(
      () => taskService.commitTaskItems(
        taskItemIds: ['100'],
        isCancel: false,
        roomTag: '1',
      ),
    ).called(1);
  });

  test('commit without selection emits error', () async {
    await _awaitInitialLoad();

    bloc.add(const OnlinePickReceiveDetailCommitRequested());
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(bloc.state.status.type, CollectionStatusType.error);
    expect(bloc.state.status.message, '请至少选择一条明细');

    verifyNever(
      () => taskService.commitTaskItems(
        taskItemIds: any(named: 'taskItemIds'),
        isCancel: any(named: 'isCancel'),
        roomTag: any(named: 'roomTag'),
      ),
    );
  });

  test('scan material code triggers search', () async {
    await _awaitInitialLoad();

    bloc.add(const OnlinePickReceiveDetailScanSubmitted('MC12345'));
    await Future<void>.delayed(const Duration(milliseconds: 30));

    expect(bloc.state.searchKeyword, '12345');
    expect(bloc.state.status.type, CollectionStatusType.success);

    final captured = verify(
      () => taskService.fetchTaskItemList(query: captureAny(named: 'query')),
    ).captured;
    final query = captured.last as OnlinePickTaskItemQuery;
    expect(query.searchKey, '12345');
  });
}
