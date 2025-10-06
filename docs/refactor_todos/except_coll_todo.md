# 接口/采集异常监控模块重构 TODO

## UniApp 现状
- 页面结构：
  - 接口异常：`pages/exceptColl/sapInteExcept.nvue`
  - PDA 采集异常：`pages/exceptColl/pdacollExcept.nvue`、`pdacollExceptDetail.nvue`
  - 异常消息列表：`pages/exceptColl/taskMessage.nvue`
  - 消息详情：`pages/exceptColl/msgdetail.nvue`
- API 依赖：依托后台异常接口（需确认具体 API 文件），用于查询异常记录、异常消息、处理状态。

## Flutter 重构策略
- **模块结构**：新建 `exception_monitor_module`，划分为接口异常列表、采集异常列表、消息中心三大功能区。
- **逻辑复用**：
  - 列表渲染继续使用 `CommonDataGrid`，配合筛选、分页、导出能力。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 如果需要处理/重试操作，可借鉴 `OutboundTaskDetailPage` 的批量操作栏设计。【F:lib/modules/outbound/task_details/outbound_task_detail_page.dart†L1-L200】
  - 状态管理采用 BLoC，将查询条件、分页信息、处理状态统一维护。
- **UI 设计**：
  - 顶部筛选（时间、状态、业务类型）、列表显示、详情侧边栏/弹窗。
  - 消息详情页面展示异常描述、处理建议、关联任务，并提供一键跳转。

## 待办清单
1. 调研并整理接口：确认异常查询、处理、消息接口（若未在现有 JS 文件中需补充后端文档）。
2. 新建 `lib/modules/exception_monitor` 模块及路由。
3. 定义服务层 `ExceptionMonitorService`，封装：
   - 接口异常列表、详情接口。
   - 采集异常列表、详情接口。
   - 异常消息列表、详情接口。
   - 处理/重试操作接口（如有）。
4. 建模：
   - 异常记录（类型、描述、时间、状态、关联任务）。
   - 异常消息（标题、内容、关联任务、已读状态）。
5. 构建页面：
   - 接口异常列表 + 详情弹窗/页。
   - 采集异常列表 + 详情（含操作按钮）。
   - 异常消息列表 + 详情。
6. 路由注册：`/exception-monitor/interface`、`/exception-monitor/pda`、`/exception-monitor/messages`。
7. 测试：
   - BLoC 测试覆盖查询、筛选、处理动作。
   - Service Mock 验证接口参数与错误处理。
8. 文档：
   - 汇总异常类型、处理流程、通知机制，形成运维手册。
