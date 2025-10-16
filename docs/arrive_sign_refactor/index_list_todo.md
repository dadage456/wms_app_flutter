# 到货签收列表页重构 TODO（原 `pages/arrive_sign/index.nvue`）

## 目标
- 复刻 uni-app 已签收待采集列表的业务逻辑，并对标 Flutter 已有的“平库出库任务列表”页面（`lib/modules/outbound/task_list/outbound_task_list_page.dart`）。
- 支持扫码搜索、分页、到货单撤销、跳转到采集/明细/接收页面。
- 采用模块化、BLoC、Freezed 数据模型等既有 Flutter 架构。

## 待办清单
### 模块与路由
- [x] 在 `lib/modules` 下创建 `arrival_sign` 模块目录（参照 `lib/modules/outbound` 与 `lib/modules/goods_up` 结构），新增 `arrival_sign_module.dart` 注册列表页、详情页、采集页、采集结果页、接收页、接收明细页路由。
- [x] 在 `AppModule` 中挂载新模块或在父模块中声明 `/arrival-sign/...` 路径，保持与现有路由风格一致。

### 数据模型（Freezed）
- [x] 使用 `freezed` + `json_serializable` 定义 `ArrivalSignTask`、`ArrivalSignTaskPage` 等实体，字段覆盖接口 `/system/terminal/arriveSignList` 返回的 `rows` 与分页元数据，参考 `lib/modules/outbound/task_list/models/outbound_task.dart`。
- [x] 增加 `ArrivalSignSummaryAction`（或在 UI 层定义按钮配置）枚举/模型用于描述“采集/明细/撤销”操作按钮。

### 服务层
- [x] 在 `lib/modules/arrival_sign/services/arrival_sign_service.dart` 内封装接口：`getArrivalSignTasks`、`cancelArrivalSign`，请求参数对齐 `api.md` 4.1，复用 `ApiService`/`DioClient` 模板。
- [x] 为扫码搜索补充查询参数（searchKey、sortType、PageIndex、PageSize 等），并在服务层设置默认分页大小 100。

### 状态管理
- [x] 创建 `ArrivalSignListBloc`，事件包括：初始化加载、扫码/输入搜索、分页跳转、撤销单据、刷新（参照 `OutboundTaskBloc`）。
- [x] 使用 `freezed` 定义事件、状态（含 `GridStatus` 对应字段），并内嵌/组合 `CommonDataGridBloc<ArrivalSignTask>` 或复用现有 `CommonDataGridBloc` 逻辑。
- [x] 确保撤销成功后派发刷新事件并处理 loading/error/empty 状态。

### UI 实现
- [x] 新建 `arrival_sign_list_page.dart`（命名可为 `arrival_sign_task_list_page.dart`）沿用 `CustomAppBar` 与 `ScannerWidget`，标题“到货接收”，右上角 `IconButton` 跳转到接收任务页 `/arrival-sign/receive`。
- [x] 页面主体使用 `CommonDataGrid` 构建表格列（“操作/装箱单号/采购单号/到货日期/到货单号/工厂/供应商/到货单ID”），列配置参考原始表头与 `OutboundTaskGridConfig`。
- [x] 在 `CommonDataGrid` 的操作列中渲染 3 个按钮（采集/明细/撤销），调用 bloc 发出 `NavigateToCollect`/`NavigateToDetail`/`CancelOrder` 等事件。
- [x] 集成扫码输入：`ScannerWidget` 成功回调触发搜索事件，错误回调使用 `LoadingDialogManager` 弹窗。
- [x] 为分页器实现事件：调用 `CommonDataGridBloc` 的 `LoadDataEvent` 或自定义分页事件。
- [x] 撤销操作需通过 `showDialog`/`LoadingDialogManager` 弹出确认框，成功后提示 `SnackBar`/`Dialog`。

### 交互 & 导航
- [x] 完成导航逻辑：
  - 采集按钮 -> `/arrival-sign/collect`，传递整行数据（使用 `jsonEncode` 或模型实例）。
  - 明细按钮 -> `/arrival-sign/detail?arrivalsBillId=...`。
  - 右上角 + 按钮 -> `/arrival-sign/receive`。
- [x] 离开页面时释放扫码监听（在 `dispose` 中调 `ScannerController.dispose()`，无需手动事件总线）。

### 校验 & 反馈
- [x] 当返回数据为空时展示与出库模块一致的空态提示（`CommonDataGrid` 支持/或手动 `Center(Text('暂无数据'))`）。
- [x] 捕获服务异常并通过 Bloc 状态传递错误信息，统一展示。

### 代码生成
- [x] 变更模型/Bloc 后更新 `build_runner` 指令（记入 README 或脚本）。

### 验收要点
- [x] 列表数据与 uni-app 版本字段一致，功能流程（搜索/分页/撤销/导航）完整。
- [x] UI 风格与“平库出库任务列表”一致，包括背景色、Padding、表格主题。
- [ ] 单元/集成测试：至少覆盖 Bloc 数据加载成功、失败、撤销成功路径（可以参考现有 `*_bloc_test.dart`）。
