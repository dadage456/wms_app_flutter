# 立库盘点采集结果页（task_collect/aswhInventorytaskCollectDetail.nvue）重构 TODO

## 背景概述
- 页面从本地缓存 `up_stocks`、`up_inTaskItemList` 恢复采集结果列表，展示托盘、物料、批次、序列等信息，并支持勾选后批量删除。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventorytaskCollectDetail.nvue†L31-L200】
- 依赖底部导航触发删除操作，删除时更新缓存并同步任务采集数量。
- Flutter 中需替换为仓储层 + BLoC 状态管理，实现一致的删除、缓存更新与页面跳转。

## 实施目标
- 将采集结果列表抽象为独立页面/对话框，与采集主流程共享模型与缓存。
- 支持多选删除、数量回滚、缓存更新，提供一致的用户反馈。
- 使用 Freezed 定义 `InventoryCollectedItem` 模型和 BLoC 状态，确保序列化与复制便利。

## TODO 清单
- [x] **路由与导航**：
  - [x] 注册 `/aswh-inventory/collect/result`（或对话框形式），从采集页导航并传入当前缓存快照。
  - [x] 完成返回时将更新后的采集结果回传给采集页。
- [x] **数据模型**：
  - [x] 使用 `InventoryCollectedItem`（继承自采集记录模型）追加 `stockId`、`invTaskItemId`、`sourceQty` 等字段。
  - [x] 定义 `InventoryCollectDetailState`（`items`、`selectedIds`、`status`、`message`）。
- [x] **服务/仓储集成**：
  - [x] 利用 `InventoryCollectCacheRepository` 加载/保存结果列表，替换 `uni.getStorageSync`、`uni.setStorage` 逻辑。
  - [x] 删除后同步更新任务明细缓存（减少 `collectdataqty`）。
- [x] **BLoC 设计**：
  - [x] 事件：`DetailPageStarted`、`SelectionChanged`、`SelectAllToggled`、`DeleteRequested`、`DeletionConfirmed`。
  - [x] 状态：包含 `isAllSelected`、`pendingDeletion` 标识，删除成功后发出 `itemsUpdated`。
  - [x] 删除流程：触发确认弹窗→调用缓存仓储→回传成功消息。
- [x] **UI 实现**：
  - [x] 使用 `CommonDataGrid` 或 `DataTable` 展示列信息，并支持复选框选择。
  - [x] 底部操作条仅保留“删除”按钮，风格参考出库采集结果页。
  - [x] 删除成功后展示 `SnackBar`/`Toast` 并自动返回。
- [ ] **测试计划**：
  - [ ] BLoC 单测覆盖：初始化加载、单选/全选、删除成功/取消。
  - [ ] 仓储单测验证缓存更新逻辑与数量回滚。
  - [ ] Widget 测试验证复选框交互与删除提示。

## 依赖与参考
- 原始逻辑：`aswhInventorytaskCollectDetail.nvue` 删除流程。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventorytaskCollectDetail.nvue†L143-L198】
- Flutter 参考：`lib/modules/outbound/collection_task/pages/outbound_collection_result_page.dart`（如存在）或同类结果页实现。
