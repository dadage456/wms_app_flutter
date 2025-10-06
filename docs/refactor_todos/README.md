# UniApp 模块 Flutter 重构待办指引

## 已完成与剩余范围
- ✅ 平库出库（`pages/goodsdown/*`）已完成 Flutter 重构，可作为后续模块的标准实现。
- ⏳ 仍需重构的 UniApp 模块按业务域划分如下：
  - 账号与认证：`pages/account/*`、`pages/set/*`、`pages/common/*`
  - 首页与导航：`pages/index.nvue`
  - 到货签收：`pages/arrive_sign/*`
  - 平库上架：`pages/goodsup/*`
  - 在线拣选（立库出库）：`pages/aswhdown/*`
  - 立库组盘：`pages/aswhup/*`
  - 平库盘点：`pages/Inventorytask/*`
  - 立库盘点：`pages/aswhInventorytask/*`
  - 平库移库：`pages/transfer/*`
  - 库存查询：`pages/queryrepertory/*`
  - 拉式发料：`pages/mtlsenter/*`
  - 异常任务与接口异常：`pages/exceptTask/*`、`pages/exceptColl/*`
  - 消息中心：`pages/msg/*`

> 上述路径来自 `pages.json` 中的路由配置，覆盖了当前 UniApp 版本上线的功能页面。

## Flutter 参照基线（平库出库模块）
- **列表/查询页模式**：使用 `CommonDataGrid` + 专属 BLoC 协同加载和筛选（如 `OutboundTaskBloc` 与 `CommonDataGridBloc` 的组合）。【F:lib/modules/outbound/task_list/bloc/outbound_task_bloc.dart†L1-L102】【F:lib/modules/outbound/task_list/outbound_task_list_page.dart†L1-L224】
- **明细页模式**：沿用扫描输入 + 表格 + 批量操作的布局结构，借助 detail BLoC 管理搜索、扫码、撤销与刷新逻辑。【F:lib/modules/outbound/task_details/outbound_task_detail_page.dart†L1-L200】
- **采集流程模式**：`CollectionBloc` 负责初始化任务、扫码校验、Hive 缓存恢复和提交，配套 `CollectionService` 封装所有数据接口调用，支持库位/批次控制判定等复杂业务。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **服务层组织**：所有接口封装在 `OutboundTaskService`、`CollectionService` 等 service 中，集中处理 API 调用与响应解析。【F:lib/modules/outbound/services/outbound_task_service.dart†L1-L104】【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】

## 文档使用方式
- 每个业务模块拥有独立的 `*_todo.md` 文档，包含 UniApp 现状概览、Flutter 重构策略与详细待办列表。
- 制定开发计划或拆解任务时，优先查阅对应模块文档，并严格对齐本 README 中定义的参照基线，确保 Flutter 端实现风格一致。
