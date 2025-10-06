# 平库盘点模块重构 TODO

## UniApp 现状
- 页面结构：
  - 任务列表：`pages/Inventorytask/InventoryTask.nvue`
  - 接收流程：`pages/Inventorytask/task_receive/InventorytaskReceive.nvue`
  - 采集流程：`pages/Inventorytask/task_collect/InventorytaskaskItem.nvue`、`InventorytaskCollectDetail.nvue`
- API 依赖：位于 `api/system/goodsDown.js`，包含 `getInventoryTask`、`commitInventoryTask`、`getInventoryTaskItem`、`commitInventoryInfos` 等接口。

## Flutter 重构策略
- **模块结构**：创建 `inventory_task_module`，下设 `task_list`、`task_receive`、`collection_task` 三个子目录。
- **逻辑复用**：
  - 列表页使用 `OutboundTaskBloc` 模式管理查询和筛选（参数替换为盘点任务字段）。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】
  - 明细/采集借鉴 `CollectionBloc` 的缓存、扫码与提交逻辑，将盘点差异处理纳入状态机。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 封装参考 `CollectionService`，负责盘点任务获取、差异提交、库位校验等。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 要求**：
  - 列表页：`CustomAppBar` + `ScannerWidget` + `CommonDataGrid`，支持库房、任务状态筛选。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 采集页：展示盘点对象、库位信息、差异数量输入框，提供差异提交与复盘功能。
  - 结果页：沿用 `CommonDataGrid` 展示差异明细，可导出/打印。

## 待办清单
1. 新建 `lib/modules/inventory_task` 模块框架与路由。
2. 实现 `InventoryTaskService`：
   - `getInventoryTask`、`commitInventoryTask` 用于任务接收/撤销。
   - `getInventoryTaskItem`、`commitInventoryInfos` 处理明细获取与差异提交。
   - 复用库存/库位查询接口（必要时调用 `getStoreSite`、`getRepertoryByStoreSiteNo`）。
3. 定义数据模型：
   - 盘点任务（任务号、库房、范围、状态）。
   - 盘点明细（物料、账面数、实际数、差异原因）。
   - 盘点提交请求（差异列表、操作人信息）。
4. 列表页：
   - 构建任务表格、筛选面板、扫码查询。
   - 接入任务接收入口。
5. 接收页：
   - 展示待接收任务，支持批量接收/撤销，更新列表状态。
6. 采集/差异页：
   - 设计扫码流程（库位→物料→数量），并支持人工输入。
   - 管理离线缓存，支持暂存和继续盘点。
   - 差异提交后刷新列表和结果页。
7. 结果页/统计：
   - 若需要，提供差异统计视图和导出功能。
8. 路由配置：
   - `/inventory/list`、`/inventory/receive`、`/inventory/collect/:taskNo`、`/inventory/result/:taskNo`。
9. 测试：
   - BLoC 测试覆盖任务加载、扫码校验、差异提交。
   - Service 层测试验证接口调用与错误处理。
10. 文档：
   - 更新业务规则说明（差异判定、重复盘点、批次校验等），并记录 Flutter 模块的缓存策略。
