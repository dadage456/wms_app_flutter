# 平库盘点采集结果页重构 TODO

## 页面现状回顾
- 结果页通过本地缓存加载采集记录，使用表格支持多选删除，并在底部导航栏提供删除操作按钮。【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskCollectDetail.nvue†L3-L125】
- 删除逻辑需要同步更新缓存中的采集结果与任务明细、回写 `collectdataqty` 数量，并维护 `checkedIds` 多选状态。【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskCollectDetail.nvue†L127-L200】

## Flutter 重构参考
- 参考平库入库采集结果页的 `CommonDataGrid` + 底部删除栏模式，支持 PopScope 返回时回传删除数据。【F:lib/modules/goods_up/collection_task/goods_up_collection_result_page.dart†L30-L188】
- 通过 Freezed 定义采集记录模型，便于与主采集页共享不可变数据与序列化能力。【F:lib/modules/outbound/task_list/models/outbound_task.dart†L7-L195】

## TODO 列表
- [x] 在 `collection_task` 模块内实现 `InventoryCollectResultPage`，接收初始采集记录与任务明细，使用 `CommonDataGrid` 展示并支持多选。
- [x] 设计结果页状态（可使用 `StatefulWidget` 或配合 BLoC）以维护选中项、已删除缓存，并在用户确认时返回删除列表给主采集页处理。
- [x] 删除流程：
  - 根据选中记录更新 `collectdataqty`，同步主任务明细中的数量减少逻辑。
  - 更新本地缓存（Hive/本地存储）中的采集结果与任务明细副本。
  - 删除后刷新表格并清空选中状态。
- [x] 提供无记录提示与空状态处理，防止在空列表时仍显示删除按钮。
- [ ] 编写单元测试：验证删除操作更新数量、缓存同步与返回值传递逻辑。
