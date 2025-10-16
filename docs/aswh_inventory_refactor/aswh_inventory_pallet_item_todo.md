# 托盘明细页（task_collect/aswhInventoryPalletItem.nvue）重构 TODO

## 背景概述
- 页面基于 `getPalletItemByTaskID` 查询单个托盘下的物料明细，使用折叠面板展示托盘、物料、批次、序列、数量等信息，顶部提供搜索栏以关键字过滤。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventoryPalletItem.nvue†L1-L127】
- 当前仅实现简单 toast 搜索，无实际过滤逻辑，需要在 Flutter 中补齐。
- 页面引用多个混入/组件（浮动球、抽屉、列表），Flutter 版本需简化并与统一设计系统对齐。

## 实施目标
- 构建可复用的托盘明细组件/页面，供采集页跳转查看。
- 支持列表过滤、折叠卡片展示、数据加载指示和错误处理。
- 使用 Freezed 定义 `InventoryPalletItem` 数据模型。

- [x] **路由与入口**：
  - [x] 注册 `/aswh-inventory/pallet/:trayNo`，从采集页“更多→单个托盘”跳转。
  - [x] 接收 `trayNo` 参数并在返回时告知采集页是否继续下发指令。
- [x] **数据模型与服务**：
  - [x] 定义 `InventoryPalletItem`（palletNo、matCode、matName、itemBatch、itemSn、itemQty、proofNo 等）。
  - [x] 在 `AswhInventoryCommandService` 或独立 `AswhInventoryPalletService` 中实现 `getPalletItemByTaskID` 调用。
- [x] **BLoC/状态管理**：
  - [x] 事件：`PalletDetailStarted`、`KeywordChanged`、`RefreshRequested`。
  - [x] 状态：`items`、`filteredItems`、`status`（loading/success/failure）、`keyword`、`message`。
  - [x] 搜索事件实时过滤 `filteredItems`，空关键词恢复原列表。
- [x] **UI 实现**：
  - [x] 顶部搜索栏（可使用 `SearchBar` 组件），支持输入与扫码。
  - [x] 列表项采用 `ExpansionPanelList`/`Card` 展示明细，兼容移动端滚动。
  - [x] 底部提示“已经到底了”可替换为 `ListFooter` 组件。
  - [x] 错误/空状态提示（`EmptyView`）。
- [x] **交互增强**：
  - [x] 支持下拉刷新与加载动画。
  - [x] 如需浮动操作按钮，结合设计规范决定是否保留，避免额外复杂性。
- [ ] **测试计划**：
  - [ ] BLoC 单测覆盖：加载成功、失败、关键词过滤。
  - [ ] Widget 测试：展开/收起面板、空状态展示。

## 依赖与参考
- API：`getPalletItemByTaskID`。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventoryPalletItem.nvue†L74-L77】
- Flutter 参考：可借鉴 `lib/modules/outbound/task_details/widgets/outbound_task_detail_panel.dart` 等折叠面板实现。
