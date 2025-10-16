# 立库盘点任务列表页（aswhInventoryTask.nvue）重构 TODO

## 背景概述
- UniApp 页面提供盘点任务列表、扫码查询、分页以及“采集/撤销”操作按钮，并在导航栏右侧跳转至接收页。【F:GlodWind-Wms-App/pages/aswhInventorytask/aswhInventoryTask.nvue†L1-L158】
- 当前接口调用 `getInventoryTask` 获取任务，`commitInventoryTask` 执行撤销操作，需要迁移至 Flutter 服务层。
- Flutter 参考：`lib/modules/outbound/task_list`、`lib/modules/goods_up/task_list` 中的数据网格与 BLoC 结构，可复用 `CommonDataGrid` + `BlocConsumer` 模式构建列表与分页。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L21-L177】【F:lib/modules/goods_up/task_list/goods_up_task_list_page.dart†L18-L162】

## 实施目标
- 建立 `lib/modules/aswh_inventory/task_list` 目录，包含页面、BLoC、模型、仓储服务。
- 支持扫码器监听、分页查询、撤销任务、跳转采集/接收页的完整工作流。
- 使用 Freezed 定义任务查询参数与任务行数据模型，配合 `json_serializable`。

## TODO 清单
- [x] **项目结构初始化**：
  - [x] 新建 `AswhInventoryModule` 并注册任务列表路由（参考 `OutboundModule`）。
  - [x] 在 `app_module.dart` 中声明依赖注入，绑定列表页所需的 BLoC 与服务。
- [x] **数据模型（Freezed）**：
  - [x] 定义 `InventoryTaskFilter`（字段：sortType、sortColumn、searchKey、userId、roleOrUserId、roomTag、pageIndex、pageSize 等）。
  - [x] 定义 `InventoryTaskSummary`（字段：taskComment、storeroomNo、storeroomName、checkTaskNo、状态等）。
  - [x] 提供 `fromJson/toJson`、`copyWith`，并与 API 参数命名保持一致。
- [x] **服务层实现**：
  - [x] 创建 `AswhInventoryTaskService`，封装 `getInventoryTask`、`commitInventoryTask`。
  - [x] 整合公共 `DioClient`，补充分页与错误处理逻辑，复用出库模块的响应包装格式。
- [x] **BLoC 设计**：
  - [x] 事件：`TaskListStarted`、`FilterSubmitted`、`ScanContentReceived`、`TaskCancelRequested`、`PageChanged`。
  - [x] 状态：`TaskListState` 包含 `status`、`filter`、`tasks`、`pagination`、`message`。
  - [x] 在取消任务成功后刷新列表并提示 UI。
- [x] **UI 构建**：
  - [x] 页面结构：`AppScaffold` + `AppBar`（左返回、右跳转接收）、扫码输入框、`CommonDataGrid`、`PaginationBar`。
  - [x] “采集”按钮触发导航到采集页，并携带完整任务 JSON。
  - [x] “撤销”按钮触发确认对话框（复用 `ConfirmDialog` 组件）。
  - [x] 集成扫码组件（参考 `lib/modules/outbound/collection_task/widgets/scanner_overlay.dart`）。
- [x] **导航集成**：
  - [x] 成功加载任务后允许通过按钮跳转至 `/aswh-inventory/collect/:taskId` 与 `/aswh-inventory/receive`。
  - [x] 保持返回首页逻辑与 UniApp 相同（必要时使用 `Navigator.popUntil`）。
- [ ] **测试与验收**：
  - [ ] 编写 BLoC 单元测试覆盖加载成功、加载失败、撤销成功/失败分支。
  - [ ] Widget 测试验证分页点击、按钮行为与扫码输入调用事件。
  - [ ] 手动测试包含扫码触发、任务为空提示、撤销后刷新。

## 依赖与参考
- API 文档：`/system/terminal/getInventoryTask`、`/system/terminal/commitInventoryTask`。【F:GlodWind-Wms-App/api/system/goodsDown.js†L224-L268】
- Flutter 参考：
  - 任务列表页：`OutboundTaskListPage`、`GoodsUpTaskListPage`。
  - 公共组件：`CommonDataGrid`、`ScannerListener`、`AppDialog`。
