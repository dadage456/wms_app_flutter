# 立库盘点模块重构 TODO

## UniApp 现状
- 页面结构：
  - 任务列表：`pages/aswhInventorytask/aswhInventorytask.nvue`
  - 接收/采集：`pages/aswhInventorytask/task_receive/*`、`task_collect/aswhInventorytaskaskItem.nvue`、`aswhInventoryCollectDetail.nvue`、`aswhInventoryCheckorder.nvue`
- API 依赖：主要复用 `api/system/goodsDown.js` 中与盘点相关的接口，并扩展使用自动化仓库指令查询接口。

## Flutter 重构策略
- **模块结构**：建立 `aswh_inventory_module`，包含列表、接收、采集、指令查询四个子域。
- **逻辑复用**：
  - 列表页使用 `OutboundTaskBloc` 模板，替换查询与筛选参数。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】
  - 采集流程沿用 `CollectionBloc`，在状态中增加自动化盘点特有字段（托盘、巷道、WCS 指令、复盘标识）。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 层参照 `CollectionService`，补充自动化盘点接口封装（如 `commitInvDownWmsToWcs`、`getWmsToWcsByTaskID`）。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 设计**：
  - 列表/明细：统一 `CustomAppBar` + `ScannerWidget` + `CommonDataGrid`，展示托盘、巷道、差异状态等。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 采集页：提供任务信息、扫码区域、托盘校验、差异记录与 WCS 指令面板。
  - 指令查询：复用 `CommonDataGrid`，支持状态过滤、指令重发。

## 待办清单
1. 创建 `lib/modules/aswh_inventory` 模块及路由。
2. 实现 `AswhInventoryService`：
   - 任务接口：`getInventoryTask`、`commitInventoryTask`、`getInventoryTaskItem`。
   - 自动化接口：`commitInventoryInfos`、`commitInvDownWmsToWcs`、`getWmsToWcsByTaskID`、`getPalletStoreSite`。
3. 定义数据模型：
   - 立库盘点任务、盘点明细、指令记录、采集提交对象。
4. 列表页：
   - 配置列与筛选（库房、巷道、差异状态），支持扫码查询。
5. 接收页：
   - 实现批量接收/撤销，刷新任务列表。
6. 采集页：
   - 设计扫描流程（托盘→库位→物料→数量），引入托盘校验及 WCS 指令提交。
   - 记录差异信息，支持离线缓存与恢复。
   - 提供托盘指令查询入口。
7. 指令查询页：
   - 展示托盘指令列表与执行状态，允许重发/撤销。
8. 路由注册：
   - `/aswh-inventory/list`、`/aswh-inventory/receive`、`/aswh-inventory/collect/:taskNo`、`/aswh-inventory/wcs`。
9. 测试：
   - BLoC 覆盖加载、扫码、提交、指令失败重试。
   - Service Mock 验证接口调用与异常处理。
10. 文档：
   - 记录自动化盘点与平库盘点差异、指令流程、安全要求等信息，供培训与运维使用。
