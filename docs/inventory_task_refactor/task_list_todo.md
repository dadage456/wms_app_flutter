# 平库盘点任务列表页重构 TODO

## 页面现状回顾
- UniApp 列表页使用顶部扫码输入、任务表格与分页组件，提供“采集”和“撤销”操作，同时右上角可跳转到接收页。【F:GlodWind-Wms-App/pages/Inventorytask/InventoryTask.nvue†L3-L164】
- 任务数据通过 `getInventoryTask` 接口获取，并支持基于 `PageIndex`、`PageSize` 的分页查询；撤销操作调用 `commitInventoryTask`。【F:GlodWind-Wms-App/pages/Inventorytask/InventoryTask.nvue†L123-L189】【F:GlodWind-Wms-App/api/system/goodsDown.js†L224-L244】

## Flutter 重构参考
- 任务列表界面沿用 `CustomAppBar` + `ScannerWidget` + `CommonDataGrid` 组合模式，参考平库出库任务列表实现扫码、筛选与网格展示。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L173】
- 任务数据模型与响应结构采用 Freezed 定义，参考 `OutboundTask` 与列表响应建模方式，方便序列化与不可变数据管理。【F:lib/modules/outbound/task_list/models/outbound_task.dart†L7-L195】
- 服务层仿照出库模块的 Service+BLoC 组合，统一通过仓储接口管理分页加载与状态同步。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L31-L170】

## TODO 列表
- [x] 建立 `lib/modules/inventory_task/task_list` 目录，配置 `InventoryTaskListPage` 与模块路由，复用 `CustomAppBar` 右上角入口跳转到盘点接收页。
- [x] 编写 `InventoryTaskService` 列表方法，封装 `getInventoryTask` 与 `commitInventoryTask` 请求参数/响应解析逻辑，复用 Dio 客户端并处理分页入参（使用 Freezed 生成请求/响应模型）。【F:GlodWind-Wms-App/api/system/goodsDown.js†L224-L244】【F:lib/modules/outbound/task_list/models/outbound_task.dart†L7-L195】
- [x] 定义 Freezed 模型：`InventoryTask`（任务行）、`InventoryTaskQuery`（查询参数）、`InventoryTaskListResponse`（接口响应）。字段映射遵循 UniApp 使用的列（任务号、库房、盘库单号等）。【F:GlodWind-Wms-App/pages/Inventorytask/InventoryTask.nvue†L22-L85】
- [x] 基于 `CommonDataGridBloc` 建立 `InventoryTaskBloc`，实现分页加载、扫码过滤、任务撤销与刷新逻辑，并同步 `ScannerWidget` 的错误提示/清空行为。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L76-L161】
- [x] UI 层实现：
  - 顶部扫码输入（带筛选按钮），支持手动触发查询。
  - 表格列定义覆盖操作列（采集/撤销）、任务号、库房、任务备注。
  - 表格点击“采集”跳转采集页并携带任务对象，“撤销”弹出确认后调用 BLoC 撤销事件。
  - 无数据提示和加载状态复用 `LoadingDialogManager`。
- [x] 与盘点接收页约定导航路由（如 `/inventory/receive`），保留原 UniApp 的右上角“+”行为。确保路由参数包含用户信息以支持任务接收流程。【F:GlodWind-Wms-App/pages/Inventorytask/InventoryTask.nvue†L3-L164】
- [ ] 编写单元测试：验证 BLoC 触发接口调用、分页状态转换、撤销成功/失败提示流程；使用 Mock 服务覆盖异常分支。
