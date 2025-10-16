import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/task_receive/bloc/online_pick_receive_bloc.dart';
import 'package:wms_app/modules/aswh_down/task_receive/bloc/online_pick_receive_event.dart';
import 'package:wms_app/modules/aswh_down/task_receive/bloc/online_pick_receive_state.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/models/user_info_model.dart';

class MockAswhDownTaskService extends Mock implements AswhDownTaskService {}

class MockUserManager extends Mock implements UserManager {}

void main() {
  late MockAswhDownTaskService taskService;
  late MockUserManager userManager;
  late OnlinePickReceiveBloc bloc;
  final tasks = [
    OnlinePickTask(
      outTaskId: 1,
      outTaskNo: 'TASK-001',
      taskQty: 10,
      finishQty: 0,
    ),
    OnlinePickTask(
      outTaskId: 2,
      outTaskNo: 'TASK-002',
      taskQty: 5,
      finishQty: 1,
    ),
  ];
  final listData = OnlinePickTaskListData(rows: tasks, total: tasks.length);
  const user = UserInfoModel(
    userId: 1001,
    deptId: 1,
    userName: 'tester',
    nickName: 'tester',
    sex: 'M',
    status: '0',
    delFlag: '0',
  );

  setUpAll(() {
    registerFallbackValue(
      OnlinePickTaskQuery(userId: 'ALL', roleOrUserId: '1'),
    );
  });

  setUp(() {
    taskService = MockAswhDownTaskService();
    userManager = MockUserManager();
    when(() => userManager.userInfo).thenReturn(user);
    when(
      () => taskService.fetchTaskList(query: any(named: 'query')),
    ).thenAnswer((_) async => listData);

    bloc = OnlinePickReceiveBloc(
      taskService: taskService,
      userManager: userManager,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  test('loads tasks on start and updates record count', () async {
    expect(bloc.state.recordCount, 0);
    bloc.add(const OnlinePickReceiveStarted());

    await expectLater(
      bloc.gridBloc.stream,
      emitsThrough(
        predicate<CommonDataGridState<OnlinePickTask>>(
          (state) => state.status == GridStatus.loaded,
        ),
      ),
    );

    expect(bloc.state.recordCount, tasks.length);
    final captured = verify(
      () => taskService.fetchTaskList(query: captureAny(named: 'query')),
    ).captured;
    final query = captured.last as OnlinePickTaskQuery;
    expect(query.userId, 'ALL');
    expect(query.roleOrUserId, '${user.userId}');
  });

  test('search updates keyword and triggers reload', () async {
    bloc.add(const OnlinePickReceiveStarted());
    await expectLater(
      bloc.gridBloc.stream,
      emitsThrough(
        predicate<CommonDataGridState<OnlinePickTask>>(
          (state) => state.status == GridStatus.loaded,
        ),
      ),
    );

    bloc.add(const OnlinePickReceiveSearchRequested('TASK-001'));

    await expectLater(
      bloc.gridBloc.stream,
      emitsThrough(
        predicate<CommonDataGridState<OnlinePickTask>>(
          (state) => state.status == GridStatus.loaded,
        ),
      ),
    );

    expect(bloc.state.searchKeyword, 'TASK-001');
    expect(bloc.state.status.type, CollectionStatusType.success);

    final captured = verify(
      () => taskService.fetchTaskList(query: captureAny(named: 'query')),
    ).captured;
    final query = captured.last as OnlinePickTaskQuery;
    expect(query.searchKey, 'TASK-001');
  });

  test('refresh requests reload without changing visible state', () async {
    bloc.add(const OnlinePickReceiveStarted());
    await expectLater(
      bloc.gridBloc.stream,
      emitsThrough(
        predicate<CommonDataGridState<OnlinePickTask>>(
          (state) => state.status == GridStatus.loaded,
        ),
      ),
    );

    bloc.add(const OnlinePickReceiveRefreshRequested());

    await expectLater(
      bloc.gridBloc.stream,
      emitsThrough(
        predicate<CommonDataGridState<OnlinePickTask>>(
          (state) => state.status == GridStatus.loaded,
        ),
      ),
    );

    verify(
      () => taskService.fetchTaskList(query: any(named: 'query')),
    ).called(greaterThanOrEqualTo(2));
  });
}
