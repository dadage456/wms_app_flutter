# 异常采集任务模块重构 TODO

## UniApp 现状
- 页面结构：单页 `pages/exceptTask/exceptTask.nvue`，提供异常任务列表、扫码定位、异常记录提交等功能。
- API 依赖：借助 `api/system/goodsDown.js` 中的 `commitExceptionShelves`、`commitDownShelves` 等接口处理异常任务提交。

## Flutter 重构策略
- **模块结构**：创建 `exception_task_module`，可拆分为异常任务列表页与异常详情/提交页。
- **逻辑复用**：
  - 列表逻辑沿用 `OutboundTaskBloc` + `CommonDataGrid` 的分页、筛选模式，展示异常任务来源、状态、处理人等。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 异常详情/提交页参考 `CollectionBloc` 的状态流，管理扫码、异常原因选择、附件上传（如需）与提交。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 层模仿 `CollectionService`，封装异常提交与补采接口，统一错误提示。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 设计**：
  - 列表页：带筛选面板（任务类型、状态、日期），支持扫码定位任务。
  - 异常详情页：展示任务基本信息、异常明细表格、扫码输入、异常类型选择、照片上传（调用原生能力）。
  - 提交成功/失败弹窗统一由 `LoadingDialogManager` 控制。

## 待办清单
1. 创建 `lib/modules/exception_task` 目录与路由。
2. 实现 `ExceptionTaskService`：
   - 获取异常任务列表（复用出库/盘点接口或新增 API）。
   - 提交异常记录：`commitExceptionShelves`、`commitDownShelves`（用于补采）。
3. 定义数据模型：
   - 异常任务实体（任务号、来源、类型、状态、关联单据）。
   - 异常记录/提交请求（库位、物料、数量、异常原因、附件）。
4. 列表页：
   - 使用 `CommonDataGrid` 渲染，提供筛选、搜索、排序。
   - 支持跳转到异常详情页。
5. 异常详情/提交页：
   - 定义扫码流程，允许手动录入或选择异常原因。
   - 支持多条异常记录暂存、批量提交。
   - 集成附件上传（可复用 UniApp 的上传策略或 Flutter 插件方案）。
6. 路由注册：`/exception-task/list`、`/exception-task/detail/:id`。
7. 测试：
   - BLoC 测试覆盖列表加载、异常提交、错误处理。
   - Service Mock 确认接口参数与异常提示。
8. 文档：
   - 更新异常采集操作说明、异常分类、附件要求等内容。
