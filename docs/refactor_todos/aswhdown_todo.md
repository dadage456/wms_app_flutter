1. 通过对比OutboundTaskListPage和GoodsUpTaskListPage，我发现了以下共同点和差异：

   

    📊 共同点分析

   

   1. **页面结构完全一致**：

     \- AppBar + 扫码输入框 + 表格主体

     \- 都使用CommonDataGrid展示数据

     \- 都有搜索功能和导航功能

   2. **BLoC模式一致**：

     \- 都使用CommonDataGridBloc管理表格状态

     \- 都有自己的任务BLoC处理业务逻辑

     \- 事件处理模式相同

   3. **交互逻辑一致**：

     \- 扫码 → 搜索任务

     \- 点击行 → 导航到采集或明细页面

     \- 加载状态和错误处理相同

   

    🔧 主要差异点

   

   1. **数据模型不同**：

     \- 出库：OutboundTask

     \- 入库：GoodsUpTask

   2. **表格列配置不同**：

     \- 出库：OutboundTaskGridConfig.getColumns()

     \- 入库：GoodsUpTaskGridConfig.columns()

   3. **导航路径不同**：

     \- 出库：/outbound/collect/ 和 /outbound/detail/

     \- 入库：/goods-up/collect/ 和 /goods-up/detail/

   4. **页面标题和文案不同**：

     \- 出库：'出库任务列表'、'请扫描单号'

     \- 入库：'平库上架任务'、'请扫描单号'

   5. **筛选功能**：

     \- 出库有筛选对话框，入库目前没有

   

    **🎯 列表页面重用方案**

   

    基于以上分析，我建议以下重用方案：

   

    方案1：配置化通用列表页面

   

    创建一个BaseTaskListPage<T>组件，通过配置对象来定制差异：

   

    // 配置接口

    abstract class TaskListConfig<T> {

     String get pageTitle;

     String get scanPlaceholder;

     List<GridColumnConfig<T>> get gridColumns;

     void navigateToCollect(BuildContext context, T task);

     void navigateToDetail(BuildContext context, T task);

     Widget? buildFilterWidget(BuildContext context, dynamic bloc); // 可选的筛选功能

     String get addButtonText; // AppBar按钮文本

     String get addRoutePath; // 添加按钮的路由路径

    }

   

    // 通用列表页面

    class BaseTaskListPage<T> extends StatefulWidget {

     final TaskListConfig<T> config;

     final Widget? filterWidget; // 额外的筛选组件

   

     const BaseTaskListPage({

      super.key,

      required this.config,

      this.filterWidget,

     });

    }

   

    方案2：模板方法模式

   

    创建抽象基类，定义页面结构，子类实现具体细节：

   

    abstract class BaseTaskListPage<T> extends StatefulWidget {

     // 抽象方法 - 子类必须实现

     String get pageTitle();

     String get scanPlaceholder();

     List<GridColumnConfig<T>> getGridColumns();

     void navigateToCollect(BuildContext context, T task);

     void navigateToDetail(BuildContext context, T task);

     String getAddRoutePath();

   

     // 可选重写方法

     Widget? buildFilterWidget(BuildContext context, dynamic bloc) => null;

     String getAddButtonText() => '添加';

     bool showFilterButton() => false;

    }

   

    方案3：组合式组件

   

    将页面拆分为更小的可重用组件：

   

    // 通用页面容器

    class TaskListPageContainer extends StatelessWidget {

     final String title;

     final Widget scannerWidget;

     final Widget tableWidget;

     final List<Widget>? actions;

    }

   

    // 通用扫码组件

    class TaskListScanner<T> extends StatelessWidget {

     final String placeholder;

     final Function(String) onScanResult;

     final Widget? suffix;

    }

   

    // 通用表格组件

    class TaskListTable<T> extends StatelessWidget {

     final List<GridColumnConfig<T>> columns;

     final CommonDataGridBloc<T> gridBloc;

     final Function(T, int) onCellTap;

    }

   

    **💡 推荐方案**

   

    我推荐**方案1：配置化通用列表页面**，原因：

   

   1. **灵活性高** - 通过配置对象可以轻松定制各种差异
   2. **代码简洁** - 子类只需要提供配置，无需重复页面结构
   3. **易于测试** - 配置可以独立测试
   4. **扩展性好** - 新增配置项不影响现有代码
   5. **类型安全** - 泛型保证类型安全

   

    具体实现示例

   

    // 出库模块配置

    class OutboundTaskListConfig extends TaskListConfig<OutboundTask> {

     @override

     String get pageTitle => '出库任务列表';

   

     @override

     String get scanPlaceholder => '请扫描单号';

   

     @override

     List<GridColumnConfig<OutboundTask>> get gridColumns =>

   ​    OutboundTaskGridConfig.getColumns(_handleCellTap);

   

     @override

     void navigateToCollect(BuildContext context, OutboundTask task) {

      Modular.to.pushNamed('/outbound/collect/${task.outTaskNo}');

     }

   

     @override

     void navigateToDetail(BuildContext context, OutboundTask task) {

      Modular.to.pushNamed('/outbound/detail/${task.outTaskId}');

     }

   

     @override

     Widget? buildFilterWidget(BuildContext context, OutboundTaskBloc bloc) {

      return IconButton(

   ​    icon: SvgPicture.asset('assets/images/icon_filter.svg'),

   ​    onPressed: () => OutboundTaskFilterDialog.show(context: context),

      );

     }

   

     @override

     String getAddButtonText() => '';

     @override

     String getAddRoutePath() => '/outbound/receive';

    }

   

    这样，出库和入库模块只需要提供各自的配置，页面代码可以完全复用。你觉得这个方案如何？有什么需要调整的地方吗？
