# 自动化仓库下架采集重构 TODO

- [x] 建立 `lib/modules/aswh_down/collection_task/` 目录结构（`bloc/`, `config/`, `models/`, `pages/`, `services/`, `widgets/`），并在模块初始化中注册所需依赖，沿用出库采集模块的分层模式。
- [x] 配置 `/aswh-down/collect` 与 `/aswh-down/collect/result` 路由，确保任务列表点击采集时进入新的 Flutter 页面，并在需要时从采集结果页返回删除载荷。
- [x] 复用并补充在线拣选采集模型，确保包含条码、任务行、托盘、缓存快照等实体，必要时扩展字段以支持托盘/拣选位信息。
- [x] 梳理并封装采集相关 API，调用 `AswhDownCollectionService` 中的任务明细、条码解析、库存校验、提交、WCS 指令等接口；若缺少字段，扩展服务层请求参数或新增方法。
- [x] 实现 `OnlinePickCollectionBloc`（事件、状态、处理逻辑），对标 `CollectionBloc` 的初始化、缓存恢复、扫码步骤、提交与报缺流程，并替换为自动化仓库字段与业务规则。
- [x] 迁移 `PerformingBarcode` 扫码流程，支持托盘 (`$TP$`)、库位（`$KW$`）、二维码（`MC`）、数量输入的顺序控制，并结合后端物料校验、库存检查、采集模式选择等逻辑。
- [x] 构建采集主页面：顶部信息卡片、三页签任务表格（任务列表 / 当前托盘 / 待校验）、扫描输入条、自定义提示样式，参考平库采集的布局并适配自动化仓库字段。
- [x] 还原底部操作条与二级菜单：拣选口选择、采集结果入口、提交按钮、更多弹出的采集模式/指令/托盘操作，确保与原 NVUE 行为一致并调用 Bloc/WCS 流程。
- [x] 实现托盘/指令相关操作：提交采集、托盘获取、空盘出入库、回库、WCS 指令查询等流程，调用服务层 `commitASWHDownShelves`、`commitDownWmsToWcs`、`commitEmptyTrayWmsToWcs`、`commitResetWmsToWcs` 等接口，并适配现有 WCS Bloc 页面。
- [x] 搭建 `AswhDownCollectionResultPage`，复刻 NVUE 采集结果列表（含多选删除、统计提示），并与主页面通过 `Navigator` 传递、回收删除记录。
- [x] 设计采集缓存持久化：替换 NVUE 中的 `uni.setStorageSync` 方案，使用 Hive 存储 `OnlinePickCollectionCacheSnapshot`，支持离线恢复与退出提醒。

- [x] 补齐扫码物料校验流程：串联管控标识、库位与 ERP 子库库存校验，防止无效条码进入数量录入。
- [x] 优化数量采集：按任务剩余量与库存上限分摊采集数量，并同步多行任务的计划/采集映射。
- [x] 恢复库存核对模式：记录结余数据至库存核对列表，随提交一起上传并在界面单独展示。
