# 到货签收模块重构 TODO

## UniApp 现状
- 页面结构：
  - 列表页：`pages/arrive_sign/index.nvue`
  - 明细页：`pages/arrive_sign/detail.nvue`
  - 任务接收：`pages/arrive_sign/task_receive/index.nvue`、`receive_detail.nvue`
  - 采集流程：`pages/arrive_sign/task_collect/index.nvue`、`collect_detail.nvue`
- API 依赖：集中在 `api/system/arriveSign.js`，覆盖列表查询、接收/撤销、采集提交、扫码解析等接口。

## Flutter 重构策略
- **模块拆分**：仿照平库出库的 `outbound_module`，创建 `arrive_sign_module`，下设 `task_list`、`task_details`、`task_receive`、`collection_task` 四个子目录，分别负责列表、明细、接收、采集。
- **状态管理**：
  - 列表页沿用 `OutboundTaskBloc + CommonDataGridBloc` 双层模型，负责分页、筛选、扫码查询。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L1-L224】
  - 明细页延续 `OutboundTaskDetailBloc` 的交互（扫码、刷新、批量撤销）。【F:lib/modules/outbound/task_details/outbound_task_detail_page.dart†L1-L200】
  - 采集流程复用 `CollectionBloc` 的初始化、扫码校验、Hive 缓存管理与提交逻辑，将到货签收的字段和接口映射到自定义模型中。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
- **UI 约束**：
  - 顶部使用 `CustomAppBar` + `ScannerWidget` 作为统一交互入口。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 列表、明细页表格均由 `CommonDataGrid` 渲染，列配置分离到 `config/` 目录。
  - 采集页采用“任务头信息 + 扫码输入 + 可滚动表格 + 提交按钮”布局，与 `outbound_collection_page` 对齐。
- **服务层**：建立 `ArriveSignService`，方法对应 `arriveSign.js` 中的 API，复用 `ApiResponseHandler` 解析。参考 `OutboundTaskService` 与 `CollectionService` 的封装方式。【F:lib/modules/outbound/services/outbound_task_service.dart†L1-L104】【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **数据模型**：使用 `freezed`/`json_serializable` 定义 `ArriveSignTask`、`ArriveSignDetail`、`ArriveSignCollectRequest` 等模型，字段来源于现有接口响应。

## 待办清单
1. 在 `lib/modules` 下建立 `arrive_sign` 模块骨架（module、routes、DI 注册）。
2. 定义 `ArriveSignService` 并实现以下方法：
   - `getArriveSignList`、`getArriveUnSignList`、`receArriveSign`、`cancleArriveSign`、`getArriveSignDetailList`、`commitSignShelves`、`getPmMaterialInfoByQR`。
3. 建模：
   - 任务列表实体（含单号、状态、供应商、到货时间等字段）。
   - 明细行实体（物料、数量、批次、库位要求等）。
   - 采集提交结构体（上架信息数组、明细映射、过滤条件）。
4. 列表页：
   - 复制 `OutboundTaskBloc` 模板并调整查询参数、筛选项。
   - 设计列配置、搜索/筛选条件、接收入口导航。
5. 明细页：
   - 创建 detail BLoC，支持扫码过滤、批量撤销、刷新。
   - 复用 `CommonDataGrid` + 批量操作条，定制列字段和状态展示。
6. 接收页：
   - 构建列表 + 明细页面，提供接收/撤销按钮，状态更新后回写列表。
7. 采集页：
   - 复用 `CollectionBloc` 结构，接入到货签收接口及物料校验逻辑。
   - 完成 Hive 缓存 key 定义、扫码流程提示、异常弹窗。
8. 路由与导航：
   - 在 `AppModule`/`arrive_sign_module.dart` 注册路径，确保从首页入口跳转。
9. 集成测试：
   - 编写 BLoC 单元测试覆盖列表加载、扫码过滤、采集成功/失败分支。
   - 补充 service 层 mock 测试，验证请求参数与响应映射。
10. 文档更新：补充 README 或业务说明，说明到货签收的 Flutter 流程差异。
