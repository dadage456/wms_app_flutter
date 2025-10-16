# 立库盘点接收页（task_receive/aswhInventorytaskReceive.nvue）重构 TODO

## 背景概述
- UniApp 接收页支持扫码/输入单号，列表展示待接收任务，仅提供“接收”操作，调用 `getInventoryTask`、`commitInventoryTask` 并在接收后刷新列表。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_receive/aswhInventorytaskReceive.nvue†L1-L158】
- 返回逻辑通过 `reLaunch` 跳回任务列表，同时移除扫码监听，需要在 Flutter 中协调导航栈与扫码订阅。
- Flutter 参考：`lib/modules/outbound/task_receive` 模块实现接收流程，可借鉴 BLoC 状态机、对话框与 UI 布局。【F:lib/modules/outbound/task_receive/outbound_task_receive_page.dart†L18-L165】

## 实施目标
- 在 `lib/modules/aswh_inventory/task_receive` 下重构接收页，实现扫码输入、分页与批量接收。
- 共享任务列表的模型与服务，保持接口复用。
- 完成 Freezed 状态建模，覆盖加载、提交、完成、错误四种状态。

## TODO 清单
- [x] **结构与路由**：
  - [x] 在 `AswhInventoryModule` 中注册接收页路由 `/aswh-inventory/receive`。
  - [x] 确保接收页可从任务列表 `AppBar` 右侧入口跳转并支持 `Navigator.pop` 返回。
- [x] **BLoC 设计**：
  - [x] 创建 `AswhInventoryReceiveBloc`，继承 `Bloc<AswhInventoryReceiveEvent, AswhInventoryReceiveState>`。
  - [x] 事件类：`AswhInventoryReceiveStarted`、`AswhInventoryReceiveSearchSubmitted`、`AswhInventoryReceiveScanCaptured`、`AswhInventoryReceiveConfirmed`、`AswhInventoryReceivePageChanged`。
  - [x] 状态字段：`status`、`filter`、`tasks`、`selectedTask`、`message`、`pagination`。
  - [x] 接收操作需弹出确认对话框，并在成功后更新列表、清空扫码输入。
- [x] **UI 实现**：
  - [x] 顶部 `AppBar` + 扫码输入框（复用任务列表组件）。
  - [x] 数据表格使用 `CommonDataGrid`，仅包含“接收”按钮列。
  - [x] 分页组件保持与列表页一致。
  - [x] 接收成功后通过 `SnackBar` 或 `Toast` 反馈结果。
- [x] **服务调用**：
  - [x] 复用 `AswhInventoryTaskService` 的 `getInventoryTask` 和 `commitInventoryTask`，并支持 userId 参数覆盖（接收页默认 `userId = 'ALL'`）。
  - [x] 处理并发点击或重复扫码，通过 BLoC 状态防抖。
- [x] **扫码监听**：
  - [x] 集成全局扫码流（参考 `OutboundTaskReceivePage` 中的 `GlobalScanListener`）。
  - [x] 实现自动聚焦逻辑：捕获扫码后填充输入并触发查询。
  - [x] 页面销毁时取消订阅，防止内存泄漏。
- [ ] **测试**：
  - [ ] BLoC 单测覆盖：加载失败、接收成功、接收失败、分页切换。
  - [ ] Widget 测试验证扫码输入自动查询与接收按钮对话框。

## 依赖与参考
- API：`/system/terminal/getInventoryTask`、`/system/terminal/commitInventoryTask`。【F:GlodWind-Wms-App/api/system/goodsDown.js†L224-L268】
- Flutter 参考模块：`lib/modules/outbound/task_receive`、`lib/modules/goods_up/task_receive`（如存在）。
