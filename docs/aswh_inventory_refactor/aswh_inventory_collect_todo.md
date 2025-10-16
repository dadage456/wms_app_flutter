# 立库盘点采集页（task_collect/aswhInventorytaskaskItem.nvue）重构 TODO

## 背景概述
- 页面包含扫码输入、托盘/库位/物料信息展示、任务列表与采集结果双 Tab、托盘数量确认弹框、底部工具栏（拣选位置、采集结果、提交、更多）及气泡菜单等复杂交互。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventorytaskaskItem.nvue†L1-L144】【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventorytaskaskItem.nvue†L229-L358】
- 调用接口涉及任务明细查询、托盘校验、WCS 指令、差异提交等十余个 API，需要在 Flutter 中集中封装服务层。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventorytaskaskItem.nvue†L146-L165】
- 当前逻辑依赖大量全局变量与本地缓存（`uni.$on('scancodedate')`、`uni.setStorageSync`），重构时需引入 BLoC + 仓储缓存方案。
- Flutter 参考：
  - `lib/modules/outbound/collection_task` 的扫码工作流、任务切换、离线缓存实现。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L27-L215】【F:lib/modules/outbound/collection_task/widgets/collection_layout.dart†L18-L210】
  - `lib/modules/goods_up/collection_task` 中的托盘/库位校验逻辑与 UI 结构。

## 实施目标
- 构建 `lib/modules/aswh_inventory/collection_task`，拆分页面、部件、BLoC、服务、仓储。
- 完成托盘→库位→物料→数量四步采集流程，支持批次/序列校验、库存校对、托盘数量确认。
- 管理任务列表与采集中列表、WCS 指令弹窗、更多操作（查询指令、单个托盘、回库、全部托盘）。
- 使用 Freezed 定义各类数据对象（任务明细、采集记录、托盘状态、指令提交参数等）。

## TODO 清单
- [x] **目录与路由**：
  - [x] 在模块中创建 `collection_task` 子目录（`bloc/`, `models/`, `services/`, `widgets/`）。
  - [x] 注册路由 `/aswh-inventory/collect/:taskId`，接收任务 JSON 参数。
- [x] **数据模型（Freezed）**：
  - [x] `InventoryTaskItem`：托盘、库位、数量、盘点类型、任务号等字段。
  - [x] `InventoryCollectingRecord`：托盘、库位、物料、批次、序列、数量、时间戳。
  - [x] `InventoryCollectCommand`：WCS 指令提交参数（托盘号、指令类型、数量、操作人等）。
  - [x] `InventoryCollectStateSnapshot`：缓存的采集状态，便于离线恢复。
  - [x] `InventoryPalletInfo`、`InventoryMatControl`、`InventorySiteInfo` 等辅助模型。
- [x] **服务层实现**：
  - [x] 创建 `AswhInventoryCollectService`，封装以下 API：`getInventoryTaskItem`、`commitInventoryInfos`、`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNo`、`CommitInvDownWmsToWcs`、`CommitInvResetWmsToWcs`、`GetMatControl`、`GetRoomMatControl` 等。
  - [x] 提供统一的错误包装与重试支持（参考 `CollectionService`）。
  - [x] 处理托盘数量确认和 WCS 指令提交的 API 调用链。
- [x] **本地缓存策略**：
  - [x] 使用 `Hive` 或本地数据库存储采集缓存，替换 `uni.setStorageSync('up_stocks')` 等逻辑。
  - [x] 定义 `InventoryCollectCacheRepository`，支持保存/恢复任务项与采集结果。
- [x] **BLoC 设计**：
  - [x] 事件分层：`CollectionStarted`（初始化）、`ScanCaptured`、`TrayConfirmed`、`SiteValidated`、`MaterialDecoded`、`QuantityEntered`、`TaskItemSelected`、`SwitchTabRequested`、`SubmitRequested`、`CommandActionTriggered`、`PopupClosed` 等。
  - [x] 状态结构包含：`currentStep`、`activeTask`、`collectingItems`、`collectedItems`、`selectedIds`、`popup`、`commandMenu`、`message`、`isLoading`。
  - [x] 处理扫码分支：托盘码、库位码、物料码分别解析并驱动状态流。
  - [x] 支持多托盘采集与差异判断，合并/更新 `collectingItems`。
- [x] **业务规则实现**：
  - [x] 校验批次规则（映射 `booCheck`）。
  - [x] 校验供应商规则（映射 `booCheckAagentCode`）。
  - [x] 校验有效期等剩余逻辑。
  - [x] 托盘/库位匹配、ERP 库位一致性判断（`siteFlag`、`erpStoreSite`）。
  - [x] 数量校验（空托盘、整盘、盘盈盘亏等）。
  - [x] “更多”菜单包含：
    - [x] 查询指令 → 跳转指令页并传递任务参数。
    - [x] 单个托盘/全部托盘 → 调用 WCS 接口并展示弹框确认。
    - [x] 回库 → 调用回库接口，更新列表。
- [x] **UI 组件拆分**：
  - [x] 顶部信息区组件（托盘、库位、库存、拣选位置、物料信息）。
  - [x] Tab 面板：`TaskListTab`、`CollectingTab`，分别绑定 BLoC 状态。
  - [x] 底部工具栏组件，支持主按钮与更多菜单。
  - [x] 托盘数量确认弹窗组件。
  - [x] 集成扫码监听与输入框焦点控制。
- [x] **交互细节**：
  - [x] 初始化时加载任务列表与拣选位选项（`getInOutdt`）。
  - [x] `SwitchTab` 时同步选中项、更新选择状态。
  - [x] 列表选择支持全选/单选，对应 BLoC 中的集合操作。
  - [x] 提交成功后清理缓存并刷新任务列表。
- [ ] **测试计划**：
  - [ ] BLoC 单测覆盖扫码流程（托盘→库位→物料→数量）、提交成功/失败、指令操作。
  - [ ] Service 单测使用 Mock 校验多接口组合调用。
  - [ ] Widget 测试验证 Tab 切换、弹窗展示、更多菜单交互。

## 依赖与参考
- API：详见 `GlodWind-Wms-App/api/system/goodsDown.js` 中盘点相关接口。【F:GlodWind-Wms-App/api/system/goodsDown.js†L224-L380】
- Flutter 参考模块：`lib/modules/outbound/collection_task`、`lib/modules/goods_up/collection_task`。
