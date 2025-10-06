# 库存查询模块重构 TODO

## UniApp 现状
- 页面结构：单页 `pages/queryrepertory/queryRepertory.nvue`，提供按库位、物料、条码等条件查询库存。
- API 依赖：分散在 `api/system/goodsUp.js`、`goodsDown.js` 中（库位库存查询、条码查询、库位对调查询等）。

## Flutter 重构策略
- **模块结构**：创建 `inventory_query_module`，根据需要划分主查询页、条码查询结果页、库位对调查询页。
- **逻辑复用**：
  - 表单与结果展示可借鉴出库模块中 `CommonDataGrid` 的用法，支持分页、筛选、导出。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - Service 层参照 `CollectionService`，封装库存查询相关接口，统一异常处理。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 设计**：
  - 顶部 `CustomAppBar`，中间以表单布局输入库房、库位、物料、批次、条码等条件。
  - 结果区使用 `CommonDataGrid` 或 `DataTable` 展示库存列表，支持导出、复制、筛选。
  - 可添加标签页切换不同查询模式（库存、条码、对调记录）。

## 待办清单
1. 建立 `lib/modules/inventory_query` 目录与路由。
2. 实现 `InventoryQueryService`，封装以下接口：
   - `getMtlRepertoryByStoresiteNo`（含平库/立库版本）、`getMtlRepertoryByStoresiteNosn`、`getMtlRepertoryByStoresiteNoErp`。
   - 条码查询：`GetRepertoryByBarCode`。
   - 库位对调：`GetRepertoryByStoresiteNoTransfer`。
3. 定义数据模型：
   - 库存记录（库位、物料、批次、数量、托盘、ERP 子库等）。
   - 条码查询结果、库位对调结果。
4. 构建查询页面：
   - 设计筛选表单、查询按钮、扫码快捷入口。
   - 查询后使用 `CommonDataGrid` 展示结果，提供分页、排序、导出。
5. 扩展页（可选）：
   - 条码查询详情、库位对调记录页面。
6. 测试：
   - Service 层测试验证参数与响应解析。
   - UI/BLoC 测试覆盖条件输入、查询、空结果、错误提示。
7. 文档：
   - 更新库存查询操作说明，标注不同接口的适用场景（平库/立库、对调查询等）。
