# 立库组盘模块重构 TODO

## UniApp 现状
- 页面结构：
  - 列表页：`pages/aswhup/aswhUp.nvue`
  - 明细页：`pages/aswhup/aswhUpDetail.nvue`
  - 任务接收：`pages/aswhup/task_receive/aswhUpReceive.nvue`、`aswhUpReceiveDetail.nvue`
  - 采集相关：`pages/aswhup/task_collect/aswhUpTaskItem.nvue`、`aswhUpCollectDetail.nvue`、`aswhUpWmsToWcs.nvue`、`aswhUpPalletItem.nvue`
- API 依赖：`api/system/aswhUp.js`（托盘校验、组盘提交、WCS 指令、托盘明细查询等）。

## Flutter 重构策略
- **模块结构**：构建 `aswh_up_module`，细分列表、明细、接收、采集、托盘、WCS 指令查询 6 个子域。
- **逻辑复用**：
  - 列表与明细：继续使用 `OutboundTaskBloc` 模型完成列表/明细交互，根据接口切换为入库任务字段。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】【F:lib/modules/outbound/task_details/outbound_task_detail_page.dart†L1-L200】
  - 采集：在 `CollectionBloc` 的基础上扩展托盘绑定、重量/容积校验、WCS 指令触发逻辑，复用 Hive 缓存能力。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 层：参考 `CollectionService` 与 `OutboundTaskService` 的写法封装组盘接口，包括校验托盘、提交指令、获取托盘明细等。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】【F:lib/modules/outbound/services/outbound_task_service.dart†L1-L104】
- **UI 要点**：
  - 列表/明细沿用统一布局，额外展示托盘/巷道/重量等字段，支持跳转到托盘明细页面。
  - 采集页需包含托盘绑定步骤、物料扫码、WCS 指令提交状态提示及异常处理按钮。
  - 托盘明细及指令查询页面以 `CommonDataGrid` 呈现，并提供导出/刷新功能。

## 待办清单
1. 新建 `lib/modules/aswh_up` 模块骨架及路由。
2. 编写 `AswhUpService`，覆盖以下方法：
   - 任务列表/明细：`getIntaskList`、`getIntaskitemList`。
   - 库位/库存：`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNo`。
   - 托盘校验与提交：`CheckBindingTray`、`CheckBindingTrayByTaskId`、`CommitUpShelves`、`CommitTrayUpShelves`。
   - WCS 指令：`CommitUpWmsToWcs`、`getPalletItemByTaskID`、`getWmsToWcsByTaskID`。
3. 建模：
   - 立库上架任务、托盘、指令记录、采集提交请求及结果。
4. 列表页：
   - 配置列（任务号、托盘数量、巷道、状态等），提供筛选和导航。
5. 明细页：
   - 支持扫码定位、批量撤销、刷新，展示托盘绑定情况。
6. 接收页：
   - 实现接收、撤销功能，确保状态同步列表。
7. 采集页：
   - 定义扫描顺序（托盘 → 库位 → 物料 → 数量 → 指令），串联托盘校验、库存校验、指令提交。
   - 增加重量/容积校验逻辑与告警提示。
   - 记录提交结果并提供异常重试入口。
8. 托盘明细页：
   - 列表展示托盘内物料、数量、状态，支持刷新和筛选。
9. 指令查询页：
   - 展示 WCS 指令列表，提供重发/撤销按钮与执行记录。
10. 路由配置：
    - 注册 `/aswh-up/list`、`/aswh-up/detail/:id`、`/aswh-up/collect/:taskNo`、`/aswh-up/pallet/:trayNo`、`/aswh-up/wcs`。
11. 测试：
    - BLoC 测试覆盖托盘校验失败、指令提交失败、缓存恢复等场景。
    - Service 层 Mock 确认请求参数、异常处理。
12. 文档：整理托盘作业流程、异常处理与 WCS 交互说明，供实施与测试使用。
