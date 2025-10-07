import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wms_app/models/user_info_model.dart';
import 'package:wms_app/modules/goods_up/services/goods_up_task_service.dart';
import 'package:wms_app/modules/goods_up/task_details/models/goods_up_task_item.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';
import 'package:wms_app/modules/goods_up/task_receive/bloc/inbound_receive_task_bloc.dart';
import 'package:wms_app/modules/goods_up/task_receive/bloc/inbound_receive_task_detail_bloc.dart';
import 'package:wms_app/modules/goods_up/task_receive/bloc/inbound_receive_task_detail_event.dart';
import 'package:wms_app/modules/goods_up/task_receive/bloc/inbound_receive_task_event.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';

class FakeGoodsUpTaskService extends GoodsUpTaskService {
  FakeGoodsUpTaskService() : super(Dio());

  GoodsUpTaskQuery? lastListQuery;
  GoodsUpTaskItemQuery? lastDetailQuery;
  List<int>? committedIds;

  @override
  Future<GoodsUpTaskListData> getInboundTaskList({
    required GoodsUpTaskQuery query,
  }) async {
    lastListQuery = query;
    return const GoodsUpTaskListData(total: 0, rows: []);
  }

  @override
  Future<GoodsUpTaskItemListData> getInboundTaskItemList({
    required GoodsUpTaskItemQuery query,
  }) async {
    lastDetailQuery = query;
    return const GoodsUpTaskItemListData(total: 0, rows: []);
  }

  @override
  Future<void> commitInboundTaskItems({
    required List<int> inTaskItemIds,
    String roomTag = '0',
    bool isCancel = false,
  }) async {
    committedIds = inTaskItemIds;
  }
}

void main() {
  group('InboundReceiveTaskBloc', () {
    late FakeGoodsUpTaskService service;
    late InboundReceiveTaskBloc bloc;
    final userInfo = const UserInfoModel(
      userId: 1,
      deptId: 1,
      userName: 'tester',
      nickName: 'tester',
      sex: 'M',
      status: '0',
      delFlag: '0',
    );

    setUp(() {
      service = FakeGoodsUpTaskService();
      bloc = InboundReceiveTaskBloc(
        taskService: service,
        userManager: UserManager(),
        userInfoOverride: userInfo,
      );
    });

    tearDown(() async {
      await bloc.close();
    });

    test('search updates query and triggers service call with pageIndex reset', () async {
      bloc.add(const SearchInboundReceiveTasksEvent('ABC123'));

      // allow bloc and grid events to process
      await pumpEventQueue();
      await pumpEventQueue();

      expect(bloc.currentQuery.searchKey, 'ABC123');
      expect(service.lastListQuery?.pageIndex, 1);
      expect(service.lastListQuery?.searchKey, 'ABC123');
    });
  });

  group('InboundReceiveTaskDetailBloc', () {
    late FakeGoodsUpTaskService service;
    late InboundReceiveTaskDetailBloc bloc;
    late GoodsUpTask task;
    final userInfo = const UserInfoModel(
      userId: 1,
      deptId: 1,
      userName: 'tester',
      nickName: 'tester',
      sex: 'M',
      status: '0',
      delFlag: '0',
    );

    setUp(() {
      service = FakeGoodsUpTaskService();
      bloc = InboundReceiveTaskDetailBloc(
        service,
        UserManager(),
        userInfoOverride: userInfo,
      );
      task = const GoodsUpTask(
        inTaskId: 10,
        inTaskNo: 'IN0010',
        storeRoomNo: 'SR01',
        workStation: 'WS01',
        taskQty: 0,
        finishQty: 0,
      );
      bloc.initialize(task);
    });

    tearDown(() async {
      await bloc.close();
    });

    test('initialize builds query and loads first page', () async {
      await pumpEventQueue();
      expect(service.lastDetailQuery?.inTaskId, task.inTaskId);
      expect(service.lastDetailQuery?.pageIndex, 1);
    });

    test('receive selected items forwards ids to service', () async {
      bloc.gridBloc.add(const UpdateTableDataEvent<GoodsUpTaskItem>([
        GoodsUpTaskItem(
          inTaskItemId: 1,
          inTaskId: 10,
          quantity: 0,
          collectedQuantity: 0,
        ),
        GoodsUpTaskItem(
          inTaskItemId: 2,
          inTaskId: 10,
          quantity: 0,
          collectedQuantity: 0,
        ),
      ]));

      await pumpEventQueue();

      bloc.add(const ReceiveSelectedInboundItemsEvent([0, 1]));
      await pumpEventQueue();
      expect(service.committedIds, [1, 2]);
    });
  });
}
