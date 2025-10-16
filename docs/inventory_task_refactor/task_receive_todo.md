# 平库盘点接收页重构 TODO

## 页面现状回顾
- UniApp 接收页沿用列表页布局，顶部扫码、表格展示以及分页控制，操作列仅提供“接收”按钮。【F:GlodWind-Wms-App/pages/Inventorytask/task_receive/InventorytaskReceive.nvue†L3-L148】
- 接口依赖 `getInventoryTask`（userId 默认为 `ALL`）加载待接收任务，并通过 `commitInventoryTask` 完成接收；成功后刷新列表并提示信息。【F:GlodWind-Wms-App/pages/Inventorytask/task_receive/InventorytaskReceive.nvue†L63-L148】【F:GlodWind-Wms-App/api/system/goodsDown.js†L224-L244】

## Flutter 重构参考
- UI 结构可直接复用出库/入库接收页的 `CustomAppBar`、`ScannerWidget` 与 `CommonDataGrid` 模式，保证扫码输入与分页一致体验。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L173】
- 接收流程可参照现有平库入库模块的接收页状态管理，使用 BLoC 控制加载、成功提示与刷新逻辑。【F:lib/modules/goods_up/collection_task/goods_up_collection_page.dart†L97-L188】
- 数据模型与服务层复用任务列表定义的 Freezed 结构，避免重复解析。

## TODO 列表
- [x] 在 `lib/modules/inventory_task/task_receive` 下创建接收页、BLoC、事件与状态类，复用任务列表的服务实例并共享 Freezed 模型。
- [x] 扩展 `InventoryTaskService`，提供 `fetchReceivableTasks`（userId 可覆盖为 `ALL`）与 `receiveTask`（`commitInventoryTask`，`isCanel=false`）方法，封装错误提示。
- [x] 构建 `InventoryTaskReceiveBloc`：处理初始化加载、扫码过滤、接收提交及成功/失败反馈，触发表格刷新和 Loading 弹窗。
- [x] UI 实现：
  - 顶部扫码输入（可直接录入单号触发查询）。
  - 表格列展示盘库单号、库房号、任务号等基础字段，并在操作列提供“接收”按钮。
  - 点击接收后显示确认对话框，调用 BLoC 事件并在成功后刷新当前页。
  - 无待接收数据时展示空状态提示。
- [x] 集成路由：支持从任务列表页导航至 `/inventory/receive`，返回后可自动刷新列表任务。
- [ ] 编写测试：验证接收事件触发接口、成功后刷新与错误提示；同时覆盖扫码搜索行为。
