import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/goods_up/services/goods_up_task_service.dart';
import 'package:wms_app/modules/goods_up/task_list/bloc/goods_up_task_bloc.dart';
import 'package:wms_app/modules/goods_up/task_list/bloc/goods_up_task_event.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/models/user_info_model.dart';

Future<void> pumpEventQueue([int times = 5]) async {
  for (var i = 0; i < times; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

class RecordingGoodsUpTaskService extends GoodsUpTaskService {
  RecordingGoodsUpTaskService() : super(Dio());

  final List<GoodsUpTaskQuery> recordedQueries = [];

  @override
  Future<GoodsUpTaskListData> getInboundTaskList({
    required GoodsUpTaskQuery query,
  }) async {
    recordedQueries.add(query);
    return const GoodsUpTaskListData(total: 0, rows: <GoodsUpTask>[]);
  }
}

void main() {
  late RecordingGoodsUpTaskService service;
  late GoodsUpTaskBloc bloc;
  late UserInfoModel user;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    service = RecordingGoodsUpTaskService();
    user = const UserInfoModel(
      userId: 42,
      deptId: 1,
      userName: 'tester',
      nickName: 'tester',
      sex: 'M',
      status: '0',
      delFlag: '0',
    );
    UserManager().login(user, 'tester', 'password');
    bloc = GoodsUpTaskBloc(
      taskService: service,
      userManager: UserManager(),
    );
  });

  tearDown(() async {
    await bloc.close();
    await UserManager().clear();
  });

  test('initial load uses logged in user for query parameters', () async {
    bloc.gridBloc.add(LoadDataEvent<GoodsUpTask>(0));
    await pumpEventQueue();

    expect(service.recordedQueries, isNotEmpty);
    final query = service.recordedQueries.last;
    expect(query.userId, equals('${user.userId}'));
    expect(query.roleOrUserId, equals('${user.userId}'));
    expect(query.pageIndex, equals(1));
  });

  test('search event updates query and reloads grid data', () async {
    bloc.gridBloc.add(LoadDataEvent<GoodsUpTask>(0));
    await pumpEventQueue();

    bloc.add(const SearchGoodsUpTasksEvent('TASK123'));
    await pumpEventQueue();

    expect(service.recordedQueries.length, greaterThan(1));
    final query = service.recordedQueries.last;
    expect(query.searchKey, equals('TASK123'));
    expect(query.pageIndex, equals(1));
  });

  test('filter event updates finish flag and triggers reload', () async {
    bloc.gridBloc.add(LoadDataEvent<GoodsUpTask>(0));
    await pumpEventQueue();

    bloc.add(const FilterGoodsUpTasksEvent('1'));
    await pumpEventQueue();

    expect(bloc.state.finishFlag, equals('1'));
    expect(service.recordedQueries.length, greaterThan(1));
    final query = service.recordedQueries.last;
    expect(query.finishFlag, equals('1'));
  });
}
