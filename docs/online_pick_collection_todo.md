# 在线拣选采集修复 TODO 进度

> 参考 `GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue`

- [x] 允许托盘扫描自动落库位并放开物料前置校验（`online_pick_collection_bloc.dart` 托盘/物料分支，通过 `_resolveLocationByTray` 自动填充 `location`）。
- [x] 引入库位/批次控制信息并严格匹配任务明细（`_onStarted` 预取 `getRoomMatControl`，`_matchTaskItem` 使用托盘/库位/批次匹配）。
- [x] 在提交采集数量前校验任务剩余额度（`_onQuantitySubmitted` 对序列与普通物料做剩余量校验）。
- [x] 补齐结余采集流程并随提交携带 `invCheckInfos`（`pendingInventoryPrompt` + `OnlinePickInventoryCheck` + `_submitCollection`）。
- [x] 补齐单托托盘与空盘入库 WCS 指令（`OnlinePickCollectionSingleTrayRequested`/`EmptyTrayInboundRequested` 分支）。
- [x] 去除重复的 `fetchInOutLocations` 定义（`AswhDownCollectionService` 仅保留单一实现）。

**进度**：6 / 6 已完成。
