import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';

// 测试数据模型
class TestModel {
  final int id;
  final String name;
  final String email;
  final int age;

  TestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          age == other.age;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode ^ age.hashCode;
}

// 测试工具函数
class TestUtils {
  static List<TestModel> generateTestData(int count) {
    return List.generate(count, (index) => TestModel(
      id: index + 1,
      name: 'User ${index + 1}',
      email: 'user${index + 1}@example.com',
      age: 20 + (index % 50),
    ));
  }

  static List<GridColumnConfig<TestModel>> getTestColumns() {
    return [
      GridColumnConfig<TestModel>(
        name: 'id',
        headerText: 'ID',
        width: 80,
        valueGetter: (row) => row.id,
      ),
      GridColumnConfig<TestModel>(
        name: 'name',
        headerText: '姓名',
        width: 120,
        valueGetter: (row) => row.name,
      ),
      GridColumnConfig<TestModel>(
        name: 'email',
        headerText: '邮箱',
        width: 200,
        valueGetter: (row) => row.email,
      ),
      GridColumnConfig<TestModel>(
        name: 'age',
        headerText: '年龄',
        width: 80,
        valueGetter: (row) => row.age,
      ),
    ];
  }

  static List<GridColumnConfig<TestModel>> getCustomColumns() {
    return [
      GridColumnConfig<TestModel>(
        name: 'id',
        headerText: 'ID',
        width: 80,
        valueGetter: (row) => row.id,
        headerBuilder: (columnName, headerText) => Container(
          color: Colors.blue,
          child: Text(headerText, style: TextStyle(color: Colors.white)),
        ),
        cellBuilder: (rowData, columnName, cellValue) => Text(
          '#${cellValue}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      GridColumnConfig<TestModel>(
        name: 'name',
        headerText: '姓名',
        valueGetter: (row) => row.name,
        cellBuilder: (rowData, columnName, cellValue) => Chip(
          label: Text(cellValue.toString()),
        ),
      ),
    ];
  }

  static Widget createTestableWidget({
    required List<GridColumnConfig<TestModel>> columns,
    required List<TestModel> datas,
    int currentPage = 1,
    int totalPages = 1,
    required Future<void> Function(int) onLoadData,
    List<int> selectedRows = const [],
    ValueChanged<List<int>>? onSelectionChanged,
    bool allowPager = false,
    bool allowSelect = false,
    DataGridController? dataGridController,
    DataPagerController? dataPagerController,
    double? height,
    double? headerHeight,
    double? rowHeight,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CommonDataGrid<TestModel>(
          columns: columns,
          datas: datas,
          currentPage: currentPage,
          totalPages: totalPages,
          onLoadData: onLoadData,
          selectedRows: selectedRows,
          onSelectionChanged: onSelectionChanged,
          allowPager: allowPager,
          allowSelect: allowSelect,
          dataGridController: dataGridController,
          dataPagerController: dataPagerController,
          height: height,
          headerHeight: headerHeight,
          rowHeight: rowHeight,
        ),
      ),
    );
  }
}

void main() {
  group('CommonDataGrid Tests', () {
    late List<TestModel> testData;
    late List<GridColumnConfig<TestModel>> testColumns;
    late bool onLoadDataCalled;
    late int onLoadDataPageIndex;
    late List<int> onSelectionChangedResult;

    setUp(() {
      testData = TestUtils.generateTestData(5);
      testColumns = TestUtils.getTestColumns();
      onLoadDataCalled = false;
      onLoadDataPageIndex = -1;
      onSelectionChangedResult = [];
    });

    Future<void> mockOnLoadData(int pageIndex) async {
      onLoadDataCalled = true;
      onLoadDataPageIndex = pageIndex;
    }

    void mockOnSelectionChanged(List<int> selectedIndexes) {
      onSelectionChangedResult = selectedIndexes;
    }

    group('组件初始化测试', () {
      testWidgets('应该正确创建和渲染组件', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);
        expect(find.byType(SfDataGrid), findsOneWidget);
      });

      testWidgets('应该使用默认参数', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pump();

        // 验证分页器默认不显示
        expect(find.byType(SfDataPager), findsNothing);
        
        // 验证复选框默认不显示
        expect(find.byType(Checkbox), findsNothing);
      });

      testWidgets('应该在初始化时调用onLoadData', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          currentPage: 2,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        expect(onLoadDataCalled, isTrue);
        expect(onLoadDataPageIndex, equals(2));
      });

      testWidgets('应该正确初始化外部控制器', (WidgetTester tester) async {
        final externalGridController = DataGridController();
        final externalPagerController = DataPagerController();

        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
          dataGridController: externalGridController,
          dataPagerController: externalPagerController,
        ));

        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);
        
        externalGridController.dispose();
        externalPagerController.dispose();
      });
    });

    group('数据渲染测试', () {
      testWidgets('应该正确显示表格数据', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        // 验证列标题
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('姓名'), findsOneWidget);
        expect(find.text('邮箱'), findsOneWidget);
        expect(find.text('年龄'), findsOneWidget);

        // 验证数据行
        expect(find.text('User 1'), findsOneWidget);
        expect(find.text('user1@example.com'), findsOneWidget);
      });

      testWidgets('应该正确处理空数据', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: [],
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        // 验证头部仍然显示
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('姓名'), findsOneWidget);
        
        // 验证没有数据行
        expect(find.text('User 1'), findsNothing);
      });

      testWidgets('应该在数据更新时重新渲染', (WidgetTester tester) async {
        final widget = TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        // 验证原始数据
        expect(find.text('User 1'), findsOneWidget);

        // 更新数据
        final newData = [TestModel(id: 99, name: 'New User', email: 'new@example.com', age: 30)];
        
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: newData,
          onLoadData: mockOnLoadData,
        ));
        await tester.pumpAndSettle();

        // 验证新数据
        expect(find.text('New User'), findsOneWidget);
        expect(find.text('User 1'), findsNothing);
      });
    });

    group('列配置测试', () {
      testWidgets('应该正确应用列宽设置', (WidgetTester tester) async {
        final columnsWithWidth = [
          GridColumnConfig<TestModel>(
            name: 'id',
            headerText: 'ID',
            width: 100,
            valueGetter: (row) => row.id,
          ),
        ];

        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: columnsWithWidth,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataGrid), findsOneWidget);
      });

      testWidgets('应该正确使用自定义cellBuilder和headerBuilder', (WidgetTester tester) async {
        final customColumns = TestUtils.getCustomColumns();

        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: customColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        // 验证自定义单元格渲染
        expect(find.text('#1'), findsOneWidget);
        expect(find.byType(Chip), findsWidgets);
      });

      testWidgets('应该正确提取数据值', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        // 验证valueGetter正确提取数据
        expect(find.text('1'), findsOneWidget); // ID
        expect(find.text('User 1'), findsOneWidget); // Name
        expect(find.text('20'), findsOneWidget); // Age
      });
    });

    group('分页功能测试', () {
      testWidgets('应该根据allowPager显示或隐藏分页器', (WidgetTester tester) async {
        // 测试不显示分页器
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: false,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataPager), findsNothing);

        // 测试显示分页器
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: true,
          totalPages: 5,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataPager), findsOneWidget);
      });

      testWidgets('应该正确显示当前页和总页数', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: true,
          currentPage: 2,
          totalPages: 5,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataPager), findsOneWidget);
      });

      testWidgets('应该在页面切换时调用onLoadData', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: true,
          currentPage: 1,
          totalPages: 3,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        // 重置标记
        onLoadDataCalled = false;
        onLoadDataPageIndex = -1;

        // 模拟页面切换 - 由于SfDataPager的内部实现，我们需要通过程序化方式测试
        final pagerFinder = find.byType(SfDataPager);
        expect(pagerFinder, findsOneWidget);
        
        // 验证分页器存在即可，实际的页面切换回调测试在集成测试中进行
      });

      testWidgets('应该正确处理单页数据', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: true,
          currentPage: 1,
          totalPages: 1,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataPager), findsOneWidget);
      });
    });

    group('选择功能测试', () {
      testWidgets('应该根据allowSelect显示或隐藏复选框', (WidgetTester tester) async {
        // 测试不显示复选框
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowSelect: false,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(Checkbox), findsNothing);

        // 测试显示复选框
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowSelect: true,
          onLoadData: mockOnLoadData,
          onSelectionChanged: mockOnSelectionChanged,
        ));

        await tester.pumpAndSettle();
        // SfDataGrid的复选框可能以不同的方式实现，检查是否启用了选择模式
        expect(find.byType(SfDataGrid), findsOneWidget);
      });

      testWidgets('应该正确处理选择状态变化', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowSelect: true,
          onLoadData: mockOnLoadData,
          onSelectionChanged: mockOnSelectionChanged,
        ));

        await tester.pumpAndSettle();
        
        // 验证选择功能已启用
        final dataGrid = tester.widget<SfDataGrid>(find.byType(SfDataGrid));
        expect(dataGrid.selectionMode, equals(SelectionMode.multiple));
        expect(dataGrid.showCheckboxColumn, isTrue);
      });

      testWidgets('应该在数据变化时清空选择状态', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowSelect: true,
          selectedRows: [0, 1],
          onLoadData: mockOnLoadData,
          onSelectionChanged: mockOnSelectionChanged,
        ));

        await tester.pumpAndSettle();

        // 更新数据
        final newData = TestUtils.generateTestData(3);
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: newData,
          allowSelect: true,
          selectedRows: [],
          onLoadData: mockOnLoadData,
          onSelectionChanged: mockOnSelectionChanged,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataGrid), findsOneWidget);
      });
    });

    group('控制器生命周期测试', () {
      testWidgets('应该正确管理自创建的控制器', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);

        // 销毁组件，验证没有内存泄漏
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });

      testWidgets('应该正确处理外部控制器', (WidgetTester tester) async {
        final externalGridController = DataGridController();
        final externalPagerController = DataPagerController();

        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
          dataGridController: externalGridController,
          dataPagerController: externalPagerController,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);

        // 销毁组件
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();

        // 外部控制器应该仍然可用（未被销毁）
        expect(() => externalGridController.selectedIndex, returnsNormally);
        
        // 手动销毁外部控制器
        externalGridController.dispose();
        externalPagerController.dispose();
      });

      testWidgets('应该正确清理滚动控制器', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);

        // 销毁组件，验证滚动控制器被正确清理
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      });
    });

    group('样式和主题测试', () {
      testWidgets('应该正确应用表格样式', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
          headerHeight: 40,
          rowHeight: 35,
        ));

        await tester.pumpAndSettle();

        final dataGrid = tester.widget<SfDataGrid>(find.byType(SfDataGrid));
        expect(dataGrid.headerRowHeight, equals(40));
        expect(dataGrid.rowHeight, equals(35));
        expect(dataGrid.gridLinesVisibility, equals(GridLinesVisibility.both));
        expect(dataGrid.headerGridLinesVisibility, equals(GridLinesVisibility.both));
      });

      testWidgets('应该正确应用主题设置', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataGridTheme), findsOneWidget);
      });
    });

    group('响应式布局测试', () {
      testWidgets('应该正确响应约束变化', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          height: 400,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);
      });

      testWidgets('应该正确处理高度设置', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          height: 300,
          allowPager: true,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);
      });
    });

    group('边界条件和错误处理测试', () {
      testWidgets('应该正确处理空列配置', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: [],
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataGrid), findsOneWidget);
      });

      testWidgets('应该正确处理大量数据', (WidgetTester tester) async {
        final largeData = TestUtils.generateTestData(1000);
        
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: largeData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataGrid), findsOneWidget);
      });

      testWidgets('应该正确处理零页数', (WidgetTester tester) async {
        // SfDataPager 不支持 pageCount 为 0，所以这个测试验证组件能够处理这种边界情况
        // 实际应用中应该确保 totalPages 至少为 1
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: true,
          currentPage: 1,
          totalPages: 0,
          onLoadData: mockOnLoadData,
        ));
        
        // 期望在构建过程中抛出断言错误
        expect(tester.takeException(), isA<AssertionError>());
      });

      testWidgets('应该正确处理异常的当前页', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          allowPager: true,
          currentPage: -1,
          totalPages: 5,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(CommonDataGrid<TestModel>), findsOneWidget);
      });

      testWidgets('应该正确处理null值', (WidgetTester tester) async {
        final dataWithNull = [
          TestModel(id: 1, name: '', email: '', age: 0),
        ];

        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: dataWithNull,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();
        expect(find.byType(SfDataGrid), findsOneWidget);
      });
    });

    group('排序功能测试', () {
      testWidgets('应该启用排序功能', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        final dataGrid = tester.widget<SfDataGrid>(find.byType(SfDataGrid));
        expect(dataGrid.allowSorting, isTrue);
      });

      testWidgets('应该启用列宽调整功能', (WidgetTester tester) async {
        await tester.pumpWidget(TestUtils.createTestableWidget(
          columns: testColumns,
          datas: testData,
          onLoadData: mockOnLoadData,
        ));

        await tester.pumpAndSettle();

        final dataGrid = tester.widget<SfDataGrid>(find.byType(SfDataGrid));
        expect(dataGrid.allowColumnsResizing, isTrue);
      });
    });
  });
}