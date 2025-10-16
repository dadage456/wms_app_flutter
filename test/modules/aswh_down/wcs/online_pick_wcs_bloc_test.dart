import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/modules/aswh_down/wcs/bloc/online_pick_wcs_bloc.dart';
import 'package:wms_app/modules/aswh_down/wcs/bloc/online_pick_wcs_event.dart';
import 'package:wms_app/modules/aswh_down/wcs/bloc/online_pick_wcs_state.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/services/user_manager.dart';

class MockAswhDownCollectionService extends Mock
    implements AswhDownCollectionService {}

void main() {
  late MockAswhDownCollectionService collectionService;
  late OnlinePickWcsBloc bloc;
  const args = <String, dynamic>{
    'taskId': 'task-1',
    'taskNo': 'taskNo-1',
    'taskComment': '任务备注',
    'trayNo': 'tray-1',
    'workStation': 'WS-1',
  };
  final commands = [
    const OnlinePickWcsCommand(
      commandId: 'cmd-1',
      taskId: 'task-1',
      taskNo: 'taskNo-1',
      palletNo: 'tray-1',
      startAddress: 'A-01',
      destinationAddress: 'B-02',
      state: '执行中',
    ),
    const OnlinePickWcsCommand(
      commandId: 'cmd-2',
      taskId: 'task-1',
      taskNo: 'taskNo-1',
      palletNo: 'tray-2',
      startAddress: 'A-02',
      destinationAddress: 'B-03',
      state: '完成',
    ),
  ];

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    collectionService = MockAswhDownCollectionService();
    when(
      () => collectionService.fetchWcsCommands(
        taskComment: any(named: 'taskComment'),
        taskId: any(named: 'taskId'),
        queryStr: any(named: 'queryStr'),
      ),
    ).thenAnswer((_) async => commands);

    when(
      () => collectionService.commitResetWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
      ),
    ).thenAnswer((_) async => <String, dynamic>{});

    when(
      () => collectionService.commitDownWmsToWcs(
        taskId: any(named: 'taskId'),
        taskNo: any(named: 'taskNo'),
        trayNo: any(named: 'trayNo'),
        startAddr: any(named: 'startAddr'),
        endAddr: any(named: 'endAddr'),
        singleFlag: any(named: 'singleFlag'),
      ),
    ).thenAnswer((_) async => <String, dynamic>{});

    bloc = OnlinePickWcsBloc(
      collectionService: collectionService,
      userManager: UserManager(),
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  Matcher _matchState({
    required int recordCount,
    CollectionStatusType statusType = CollectionStatusType.normal,
    String? statusMessage,
    bool shouldNotifyParent = false,
    String query = '',
  }) {
    return isA<OnlinePickWcsState>()
        .having((s) => s.taskId, 'taskId', args['taskId'])
        .having((s) => s.taskNo, 'taskNo', args['taskNo'])
        .having((s) => s.taskComment, 'taskComment', args['taskComment'])
        .having((s) => s.trayNo, 'trayNo', args['trayNo'])
        .having((s) => s.workStation, 'workStation', args['workStation'])
        .having((s) => s.recordCount, 'recordCount', recordCount)
        .having((s) => s.queryStr, 'queryStr', query)
        .having((s) => s.status.type, 'statusType', statusType)
        .having((s) => s.status.message, 'statusMessage', statusMessage)
        .having(
          (s) => s.shouldNotifyParent,
          'shouldNotifyParent',
          shouldNotifyParent,
        );
  }

  group('OnlinePickWcsBloc', () {
    blocTest<OnlinePickWcsBloc, OnlinePickWcsState>(
      'loads commands and updates record count on start',
      build: () => bloc,
      act: (bloc) => bloc.add(const OnlinePickWcsStarted(args)),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        _matchState(recordCount: 0),
        _matchState(recordCount: commands.length),
      ],
      verify: (_) {
        verify(
          () => collectionService.fetchWcsCommands(
            taskComment: args['taskComment']! as String,
            taskId: args['taskId']! as String,
            queryStr: '',
          ),
        ).called(greaterThanOrEqualTo(1));
      },
    );

    blocTest<OnlinePickWcsBloc, OnlinePickWcsState>(
      'submits reset command for selected records',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(const OnlinePickWcsStarted(args));
        await bloc.gridBloc.stream.firstWhere(
          (state) => state.status == GridStatus.loaded,
        );
        bloc.gridBloc.add(ChangeSelectedRowsEvent<OnlinePickWcsCommand>([0]));
        bloc.add(const OnlinePickWcsResetCommandRequested());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        _matchState(recordCount: 0),
        _matchState(recordCount: commands.length),
        _matchState(
          recordCount: commands.length,
          statusType: CollectionStatusType.loading,
        ),
        _matchState(
          recordCount: commands.length,
          statusType: CollectionStatusType.success,
          statusMessage: '撤销回指令成功',
          shouldNotifyParent: true,
        ),
      ],
      verify: (_) {
        verify(
          () => collectionService.commitResetWmsToWcs(
            taskId: commands.first.taskId!,
            taskNo: commands.first.taskNo!,
            trayNo: commands.first.palletNo!,
            startAddr: commands.first.startAddress!,
            endAddr: commands.first.destinationAddress!,
          ),
        ).called(1);
      },
    );

    blocTest<OnlinePickWcsBloc, OnlinePickWcsState>(
      'emits error when submitting command without selection',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(const OnlinePickWcsStarted(args));
        await bloc.gridBloc.stream.firstWhere(
          (state) => state.status == GridStatus.loaded,
        );
        bloc.add(const OnlinePickWcsDownCommandRequested());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        _matchState(recordCount: 0),
        _matchState(recordCount: commands.length),
        _matchState(
          recordCount: commands.length,
          statusType: CollectionStatusType.error,
          statusMessage: '请至少选择一条指令记录',
        ),
      ],
      verify: (_) {
        verifyNever(
          () => collectionService.commitDownWmsToWcs(
            taskId: any(named: 'taskId'),
            taskNo: any(named: 'taskNo'),
            trayNo: any(named: 'trayNo'),
            startAddr: any(named: 'startAddr'),
            endAddr: any(named: 'endAddr'),
            singleFlag: any(named: 'singleFlag'),
          ),
        );
      },
    );

    blocTest<OnlinePickWcsBloc, OnlinePickWcsState>(
      'refreshes data with search keyword',
      build: () => bloc,
      act: (bloc) async {
        bloc.add(const OnlinePickWcsStarted(args));
        await bloc.gridBloc.stream.firstWhere(
          (state) => state.status == GridStatus.loaded,
        );
        bloc.add(const OnlinePickWcsSearchSubmitted('PAL123'));
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        _matchState(recordCount: 0),
        _matchState(recordCount: commands.length),
        _matchState(recordCount: commands.length, query: 'PAL123'),
      ],
      verify: (_) {
        verify(
          () => collectionService.fetchWcsCommands(
            taskComment: args['taskComment']! as String,
            taskId: args['taskId']! as String,
            queryStr: 'PAL123',
          ),
        ).called(greaterThanOrEqualTo(1));
      },
    );
  });
}
