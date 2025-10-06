# 消息中心模块重构 TODO

## UniApp 现状
- 页面结构：
  - 消息列表：`pages/msg/msg.nvue`
  - 消息详情：`pages/msg/msgdetail.nvue`
  - 首页入口脚本：`pages/msg/index.js`
- API 依赖：沿用 `api/system/goodsUp.js` 中的公告接口（`getLatestNotice`、`getMorNotice`、`getNoticeDetail`）。

## Flutter 重构策略
- **模块结构**：创建 `message_center_module`，包含列表页与详情页；如需消息订阅/推送设置，可扩展设置页。
- **逻辑复用**：
  - 列表展示可使用 `CommonDataGrid` 或 `ListView` + 下拉刷新，结合分页加载和已读状态管理。【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L49-L161】
  - 状态管理使用简单的 `Cubit` 或 BLoC，负责加载消息列表、标记已读、跳转详情。
- **UI 设计**：
  - 列表项展示标题、来源、时间、已读标记，支持搜索与筛选。
  - 详情页显示消息正文、附件链接、关联任务跳转按钮。

## 待办清单
1. 新建 `lib/modules/message_center` 模块与路由。
2. 实现 `MessageService`：
   - `getLatestNotice`（轮播/首页提醒）、`getMorNotice`（分页列表）、`getNoticeDetail`。
   - 如需推送配置，扩展订阅状态接口。
3. 定义数据模型：消息实体（标题、内容摘要、时间、已读状态、关联任务等）。
4. 构建列表页：
   - 支持下拉刷新、分页加载、搜索过滤。
   - 已读状态实时更新并缓存。
5. 构建详情页：
   - 展示正文、附件、关联任务按钮。
   - 支持收藏/分享（可选）。
6. 与首页整合：
   - 在首页模块注册消息入口，显示未读数。
7. 测试：
   - Service Mock 验证接口调用、错误处理。
   - BLoC/Cubit 测试覆盖加载、分页、标记已读、错误分支。
8. 文档：
   - 更新消息中心使用说明、未读策略、通知来源列表。
