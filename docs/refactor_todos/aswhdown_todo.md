# 在线拣选（立库出库）模块重构 TODO

## UniApp 现状
- 页面结构：
  - 列表页：`pages/aswhdown/aswhDown.nvue`
  - 明细页：`pages/aswhdown/aswhDownDetail.nvue`
  - 任务接收：`pages/aswhdown/task_receive/aswhDownReceive.nvue`、`aswhDownReceiveDetail.nvue`
  - 采集/指令：`pages/aswhdown/task_collect/aswhDownTaskItem.nvue`、`aswhDownCollectDetail.nvue`、`aswhDownWmsToWcs.nvue`
- API 依赖：主要来自 `api/system/goodsDown.js`（如 `commitASWHDownShelves`、`commitDownWmsToWcs`、`getOutTaskCollitemList` 等）。

## Flutter 重构策略
- **模块结构**：新建 `aswh_down_module`，包含列表、明细、接收、采集、WCS 指令查询五个子域，保持与 UniApp 页面一一对应。
- **业务基线**：
  - 列表与明细：完全沿用 `OutboundTaskBloc` 与 detail 页模式，实现扫码、筛选、批量操作。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】【F:lib/modules/outbound/task_details/outbound_task_detail_page.dart†L1-L200】
  - 采集：在 `CollectionBloc` 基础上扩展自动化仓库特有字段（托盘、巷道、WCS 地址、重量等），并通过事件驱动与 Hive 缓存维持状态。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 层：仿照 `CollectionService` 将自动化仓库接口封装，区分 WMS 与 WCS 请求，确保重用 `ApiResponseHandler`。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 设计**：
  - 列表/明细沿用 `CustomAppBar` + `ScannerWidget` + `CommonDataGrid` 的组合，增加 WCS 状态展示与跳转按钮。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 采集页需提供多标签页或折叠面板展示：任务信息、扫码输入、自动化参数、异常处理、WCS 指令记录。
  - 指令查询页面以 `CommonDataGrid` 呈现指令列表，支持按任务号过滤、状态颜色标记。
- **集成要点**：
  - 引入 WCS 提交流程：提交采集后调用 `commitASWHDownShelves` 与 `commitDownWmsToWcs`，必要时提供失败重试与日志记录。
  - 将托盘库位查询 `getPalletStoreSite` 逻辑复用到自动化场景，确保托盘到站校验。

## 待办清单
1. 创建 `lib/modules/aswh_down` 模块骨架及路由映射。
2. 实现 `AswhDownService`：
   - 任务列表/明细：`getOutaskList`、`getOutTaskitemList`、`getOutTaskCollitemList`。
   - 库位/库存：`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNoSn`、`getMtlRepertoryByStoresiteNoErp`。
   - 采集提交：`commitASWHDownShelves`、`commitDownShelves`（通用接口复用）。
   - WCS 相关：`commitDownWmsToWcs`、`commitInvDownWmsToWcs`、`getPalletStoreSite`。
3. 建模：
   - 自动化出库任务、明细、采集提交、WCS 指令记录。
4. 列表页：
   - 配置列展示托盘、巷道、WCS 状态，提供筛选（完成状态、库房、巷道等）。
   - 添加导航至采集、指令查询、任务接收。
5. 明细页：
   - 支持扫码定位、批量撤销、刷新，展示指令状态与托盘信息。
6. 接收页：
   - 复用平库模式，实现接收/撤销与明细列表刷新。
7. 采集页：
   - 定义扫描顺序（托盘 → 库位 → 物料 → 数量），接入库存/WCS 校验。
   - 支持异常下架（调用 `commitExceptionShelves`）与现场确认流程。
   - 完成 Hive 缓存、离线恢复、成功提示。
8. 指令查询页：
   - 基于 `CommonDataGrid` 构建指令列表，支持状态筛选、重发指令操作。
9. 路由与依赖：
   - 在模块中配置 `/aswh-down/list`、`/aswh-down/detail/:id`、`/aswh-down/collect/:taskNo`、`/aswh-down/wcs` 等路径。
10. 测试计划：
    - BLoC 测试覆盖列表加载、采集流程（正常/异常）、WCS 提交失败重试。
    - Service 层测试确认参数映射与错误处理。
11. 文档：补充自动化仓库专有配置（巷道、WCS 地址、托盘绑定）说明。
