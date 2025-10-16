# 在线拣选指令页（task_collect/aswhInventoryWmsToWcs.nvue）重构 TODO

## 背景概述
- 页面展示 WMS→WCS 指令列表，列包含托盘、起始/目标地址、堆垛机、状态、重量/高度等级、任务/凭证信息等；底部提供“撤销回指令”“撤销出库指令”“刷新”操作。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventoryWmsToWcs.nvue†L1-L87】
- 数据来源 `getWmsToWcsByTaskID`（来自 `api/system/aswhUp`），根据任务号、任务 ID 与任务类型过滤。
- 需要与采集页的“更多→查询指令”操作联动。

## 实施目标
- 构建 `lib/modules/aswh_inventory/command_list` 页面，复用 `CommonDataGrid` 展示指令记录。
- 提供 WCS 指令撤销与刷新操作，支持实时反馈。
- 使用 Freezed 定义 `InventoryWcsCommand` 数据模型。

## TODO 清单
- [x] **路由与参数**：
  - [x] 注册 `/aswh-inventory/commands`，接受 `taskComment`、`taskId`、`taskType` 参数。
  - [x] 在采集页的“更多→查询指令”中导航到该页面，并支持返回。
- [x] **数据模型**：
  - [x] 定义 `InventoryWcsCommand`（字段：palNo、startAddr、destAddr、stackerNo、sendTime、state、weightGrade、highGrade、taskNo、proofNo、taskType、changeType、ioType、wcsErrMessage、taskId、proofId、interfaceId）。
  - [x] 建立 `InventoryCommandAction` 枚举区分回指令、出库指令撤销。
- [x] **服务层**：
  - [x] 创建 `AswhInventoryCommandService` 封装 `getWmsToWcsByTaskID`、`commitInvDownWmsToWcs`（或对应撤销接口）。
  - [x] 支持状态刷新、错误提示、重试。
- [x] **BLoC 设计**：
  - [x] 事件：`CommandPageStarted`、`CommandRefreshRequested`、`CommandRevokeRequested`（携带类型）。
  - [x] 状态：`commands`、`status`、`message`、`pendingAction`。
  - [x] 撤销成功后刷新列表并显示提示。
- [x] **UI 实现**：
  - [x] 使用 `AppScaffold` + `CommonDataGrid` 渲染列。
  - [x] 底部操作栏映射到三个按钮（撤销回指令、撤销出库指令、刷新）。
  - [x] 撤销操作前弹出确认对话框。
- [ ] **测试计划**：
  - [ ] BLoC 单测覆盖：初始化加载、刷新、撤销成功/失败。
  - [ ] Widget 测试验证按钮交互与加载状态。

## 依赖与参考
- API：`getWmsToWcsByTaskID` 及相关撤销接口（位于 `api/system/aswhUp.js`、`api/system/goodsDown.js`）。
- Flutter 参考：`lib/modules/outbound/exception_collection/command_list`（若存在）或同类指令列表实现。
