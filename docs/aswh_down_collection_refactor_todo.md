# ASWH 下架采集页面重构 TODO

> 目标：基于 `GlodWind-Wms-App/pages/aswhdown/task_collect` 的 UniApp 页面，将自动化仓库下架采集流程完整迁移到 Flutter 模块 `lib/modules/aswh_down/collection_task/` 中，保持与现有出库/入库模块一致的交互体验与架构。

## 架构与基础
- [x] 新建 `collection_task/` 目录，按 BLoC / config / widgets / pages 拆分结构。
- [x] 接入模块路由 `/aswh-down/collect`、`/aswh-down/collect/result`，支持任务参数传递与结果回写。
- [x] 创建 `OnlinePickCollectionBloc`，实现初始化、扫码解析、缓存恢复、采集结果同步等核心状态管理。
- [x] 引入 Hive 缓存快照 `OnlinePickCollectionCacheSnapshot`，落库库位/托盘/采集记录。
- [x] 为提交成功后清理缓存、恢复任务等流程编写集成测试用例。（`test/modules/aswh_down/collection_task/online_pick_collection_bloc_submit_test.dart` 验证提交成功后清空缓存、重载任务明细与 WCS 指令。）

## 页面实现
- [x] 采集主页面 `OnlinePickCollectionPage`
  - [x] 扫码输入框与焦点控制
  - [x] 信息卡片展示任务、库位、托盘、物料、数量
  - [x] `TabBar`+`CommonDataGrid` 显示任务列表/正在采集
  - [x] 底部操作区（采集结果、提交采集、跳转 WCS 指令）
- [x] 采集结果页 `OnlinePickCollectionResultPage`，支持选中批量删除并回传删除清单。
- [x] 采集结果页返回后，联动主页面刷新 WCS 指令状态和任务待采集数量。（返回时触发 BLoC 刷新任务明细与 WCS 指令，并依据本地缓存重算采集数量）
- [x] 补充托盘数量确认、模式切换等弹窗交互。

## 业务逻辑
- [x] 托盘/库位/物料/数量扫码解析，按步骤切换占位提示。
- [x] 采集数量入栈后更新序列缓存、物料数量字典、库位库存映射。
- [x] 提交采集调用 `commitASWHDownShelves`，构建下架/明细入参。
- [x] 支持根据任务类型调用 `commitDownShelves`、`commitTrayDownShelves` 等分支接口。
- [x] 对接库存校验接口（`getRepertoryByStoresiteNo*`）并在数量录入前校验子库、批次、库存余量。（`OnlinePickCollectionBloc` 库位校验调用库存接口并新增 `online_pick_collection_bloc_inventory_test.dart` 覆盖库存不足/成功场景。）
- [x] 完成异常流程（异常补录、空盘出库、回库）事件与弹窗。

## 质量与迭代
- [ ] 编写 BLoC 单测：扫码流程、缓存恢复、提交失败场景。
- [ ] 编写服务层集成测试（Mock Dio）验证参数映射。
- [ ] 完善错误提示与日志记录，统一使用 `ErrorHandler`。
- [ ] 与 WCS 页面交互的数据刷新、回调协议。

> 更新说明：完成的条目已打勾；后续新增任务请在此文档追加并标记状态，方便跨端团队协作追踪。
