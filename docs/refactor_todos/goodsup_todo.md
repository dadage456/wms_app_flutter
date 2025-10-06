# 平库上架模块重构 TODO

## UniApp 现状
- 页面结构：
  - 列表页：`pages/goodsup/goodsUp.nvue`
  - 明细页：`pages/goodsup/goodsUpDetail.nvue`
  - 任务接收：`pages/goodsup/task_receive/goodsUpReceive.nvue`、`goodsUpReceiveDetail.nvue`
  - 采集流程：`pages/goodsup/task_collect/goodsUpTaskItem.nvue`、`goodsUpCollectDetail.nvue`
- API 依赖：`api/system/goodsUp.js`，提供入库任务列表、明细、库位/库存校验、上架提交、接收撤销、托盘管理等接口。

## Flutter 重构策略
- **模块组织**：复制 `outbound_module` 的结构创建 `inbound_module`（或 `goods_up_module`），分层到 `task_list`、`task_details`、`task_receive`、`collection_task`、`pallet` 等目录。
- **列表/明细逻辑**：
  - 列表页参照 `OutboundTaskBloc` 管理分页、扫码检索，调整查询参数为入库相关字段。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】
  - 明细页复用 detail BLoC 模式，支持扫码过滤、批量接收/撤销、刷新等操作。【F:lib/modules/outbound/task_details/outbound_task_detail_page.dart†L1-L200】
- **采集流程**：
  - 利用 `CollectionBloc` 的扫描与缓存机制，扩展为上架所需字段（目标库位、托盘号、批次/序列等）。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - `CollectionService` 风格封装入库相关接口，确保库位校验、库存查询、提交等操作在 service 层完成。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 复用**：
  - 统一使用 `CustomAppBar` + `ScannerWidget` 处理扫描、筛选。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 表格展示通过 `CommonDataGrid`，列配置单独维护，支持托盘/库位状态标识。
  - 采集页沿用“任务信息 + 扫码输入 + 明细卡片/表格 + 提交按钮”的布局，同时增加托盘绑定区域。
- **扩展点**：
  - 结合 `goodsUp.js` 的托盘接口，新增托盘查询/绑定子页面或弹窗。
  - 提供 WCS 指令提交入口（如需要可复用出库模块的异常提交流程）。

## 待办清单
1. 新建 `lib/modules/goods_up` 目录与 module、route、binders。
2. 实现 `GoodsUpService`，覆盖以下方法：
   - 任务列表/明细：`getIntaskList`、`getIntaskitemList`。
   - 库位校验与库存查询：`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNo`、`getLSMtlRepertoryByStoresiteNo`、`getMtlQtyByMtlCode`、`GetRepertoryBySiteNoMatCode`。
   - 上架提交：`CommitUpShelves`、`CommitRCInTaskItem`。
   - 托盘接口：`getInTaskPalletNo`、`getInTaskPalletNoByUserID`、`CommitRCInTaskPalletNo`。
   - 公告接口：`getLatestNotice`、`getMorNotice`、`getNoticeDetail`（用于消息中心复用或模块内公告）。
3. 建模：
   - 入库任务、明细、托盘、库存查询结果、采集提交请求。
4. 列表页：
   - 复制列表页面结构，替换列字段，增加筛选条件（库房、到货单号、托盘状态等）。
   - 添加“任务接收”“采集上架”导航入口。
5. 明细页：
   - 支持扫码定位明细、批量接收/撤销、刷新。
   - 展示库位/托盘绑定信息，提供快速跳转到托盘详情。
6. 接收页：
   - 任务接收、接收明细页面按出库模块模式实现，调用 `CommitRCInTaskItem` 更新状态。
7. 采集页：
   - 扩展 `CollectionBloc` 事件以支持托盘扫描、库位扫描、物料扫码的顺序控制。
   - 接入库存查询接口校验数量、批次限制。
   - 完成提交成功/失败后的提示与缓存更新。
8. 托盘管理：
   - 依据接口实现托盘选择/绑定弹窗或页面，支持任务级托盘跟踪。
9. 路由集成：
   - 在模块入口注册 `/goods-up/list`、`/goods-up/detail/:id`、`/goods-up/collect/:taskNo`、`/goods-up/pallet` 等路由。
10. 测试与文档：
    - BLoC 单元测试覆盖列表加载、扫码过滤、采集提交流程。
    - Service 层 mock 测试确保请求参数正确。
    - 更新开发文档说明与平库出库模块的差异点（如托盘处理、公告）。
