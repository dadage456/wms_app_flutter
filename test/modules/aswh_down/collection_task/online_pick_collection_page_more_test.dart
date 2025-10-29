import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/collection_task/online_pick_collection_page.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

class _MockOnlinePickCollectionBloc extends MockBloc<OnlinePickCollectionEvent,
        OnlinePickCollectionState>
    implements OnlinePickCollectionBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue(const OnlinePickCollectionStatusResetRequested());
  });

  testWidgets('more actions bottom sheet shows WCS commands and triggers events',
      (tester) async {
    final bloc = _MockOnlinePickCollectionBloc();
    const task = OnlinePickTask(
      outTaskId: 200,
      outTaskNo: 'TASK-200',
      storeRoomNo: 'RM-01',
      taskComment: 'COMMENT-1',
    );

    final state = OnlinePickCollectionState(
      status: CollectionStatus.normal(),
      locationOptions: const [
        OnlinePickLocationOption(label: '一号拣选口', value: 'DEST-01'),
      ],
      selectedDestination: 'DEST-01',
      currentTray: 'TP01',
      currentLocation: 'LOC-01',
    );

    when(() => bloc.state).thenReturn(state);
    when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
    when(() => bloc.add(any())).thenAnswer((_) {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnlinePickCollectionBloc>.value(
          value: bloc,
          child: const OnlinePickCollectionPage(task: task),
        ),
      ),
    );
    await tester.pump();

    clearInteractions(bloc);
    when(() => bloc.state).thenReturn(state);

    await tester.tap(find.widgetWithText(OutlinedButton, '更多'));
    await tester.pumpAndSettle();

    expect(find.text('拣选位置'), findsOneWidget);
    expect(find.text('空盘出库'), findsOneWidget);
    expect(find.text('空盘入库'), findsOneWidget);
    expect(find.text('单个托盘'), findsOneWidget);
    expect(find.text('回库'), findsOneWidget);
    expect(find.text('全部托盘'), findsOneWidget);

    await tester.tap(find.text('空盘出库'));
    await tester.pumpAndSettle();

    verify(() => bloc.add(const OnlinePickCollectionEmptyTrayOutRequested()))
        .called(1);
  });

  testWidgets('inventory dialog renders recorded details and submits quantity',
      (tester) async {
    final bloc = _MockOnlinePickCollectionBloc();
    const task = OnlinePickTask(
      outTaskId: 300,
      outTaskNo: 'TASK-300',
      storeRoomNo: 'RM-02',
    );

    final state = OnlinePickCollectionState(
      status: CollectionStatus.normal(),
      collectedStocks: const [
        OnlinePickCollectionStock(
          stockId: 'S1',
          materialCode: 'MAT-001',
          batchNo: 'B01',
          serialNumber: null,
          taskQty: 10,
          collectQty: 5,
          outTaskItemId: '1',
          taskId: 'T1',
          storeRoom: 'RM-02',
          storeSite: 'LOC-01',
          erpStore: 'ERP-1',
          trayNo: 'TP01',
        ),
      ],
      inventoryCheckDetails: const [
        OnlinePickInventoryCheckDetail(
          key: 'LOC-01|MAT-001|B01|TP01',
          storeSite: 'LOC-01',
          materialCode: 'MAT-001',
          batchNo: 'B01',
          trayNo: 'TP01',
          quantity: 5,
        ),
      ],
      inventoryQtyMap: const {
        'LOC-01|MAT-001|B01|TP01': 5,
      },
      locationOptions: const [
        OnlinePickLocationOption(label: '一号拣选口', value: 'DEST-01'),
      ],
      selectedDestination: 'DEST-01',
    );

    when(() => bloc.state).thenReturn(state);
    when(() => bloc.stream).thenAnswer((_) => Stream.value(state));
    when(() => bloc.add(any())).thenAnswer((_) {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<OnlinePickCollectionBloc>.value(
          value: bloc,
          child: const OnlinePickCollectionPage(task: task),
        ),
      ),
    );
    await tester.pump();

    clearInteractions(bloc);
    when(() => bloc.state).thenReturn(state);

    await tester.tap(find.widgetWithText(OutlinedButton, '库存核对(1)'));
    await tester.pumpAndSettle();

    expect(find.text('库存核对'), findsOneWidget);
    expect(find.text('已记录的结余：'), findsOneWidget);
    expect(
      find.text('库位 LOC-01 · 物料 MAT-001 · 批次 B01 · 托盘 TP01'),
      findsOneWidget,
    );
    expect(find.text('5'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '8');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    verify(
      () => bloc.add(
        const OnlinePickCollectionInventoryRecorded(
          materialCode: 'MAT-001',
          storeSite: 'LOC-01',
          batchNo: 'B01',
          trayNo: 'TP01',
          quantity: 8,
        ),
      ),
    ).called(1);
  });
}
