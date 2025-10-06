# 平库移库模块重构 TODO

## UniApp 现状
- 页面结构：`pages/transfer/transfer.nvue`，提供移库任务查询、扫码录入和提交功能。
- API 依赖：复用 `api/system/goodsUp.js` 中的 `CommitTransfer`、`getMtlRepertoryByStoresiteNo`、`getStoreSiteByRoom` 等接口。

## Flutter 重构策略
- **模块结构**：构建 `transfer_module`，包含单页（移库操作）与历史记录/结果子页面（如需）
- **逻辑复用**：
  - 使用 `CollectionBloc` 的扫码、校验、缓存模式管理移库流程（库位→物料→数量→目标库位），根据业务自定义事件与状态字段。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 层复用 `CollectionService` 风格封装库位/库存校验与移库提交逻辑。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 要点**：
  - 顶部 `CustomAppBar` + `ScannerWidget`，分步骤展示原库位、物料、数量、目标库位输入，并提供明细列表与删除/修改功能。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 提供待提交清单（`CommonDataGrid` 或卡片列表）和提交成功反馈。

## 待办清单
1. 创建 `lib/modules/transfer` 目录及模块入口。
2. 实现 `TransferService`：
   - 封装 `CommitTransfer`、`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNo` 等接口。
3. 定义模型：
   - 移库记录（原库位、目标库位、物料、数量、批次、托盘等）。
   - 提交请求结构体（移库数组、过滤条件）。
4. 构建移库页面：
   - 设计扫码顺序与输入验证（原库位→物料→数量→目标库位）。
   - 支持手动修改数量、删除待提交记录、批量提交。
   - 复用 Hive 缓存暂存尚未提交的数据。
5. 若需要历史/结果页：
   - 提供提交记录展示、状态筛选、导出功能。
6. 路由注册：
   - `/transfer`（主页面）、`/transfer/history`（可选）。
7. 测试计划：
   - BLoC 测试覆盖正常提交流程、库存不足、库位校验失败、缓存恢复。
   - Service 测试验证接口参数与错误处理。
8. 文档：
   - 更新移库操作说明、扫码顺序、异常处理方式，指导培训与上线。
