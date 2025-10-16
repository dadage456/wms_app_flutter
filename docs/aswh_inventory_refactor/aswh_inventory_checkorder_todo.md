# 立库盘点指令结果页（task_collect/aswhInventoryCheckorder.nvue）重构 TODO

## 背景概述
- 页面展示盘点相关指令执行情况，与在线拣选指令页结构类似，同样基于 `getWmsToWcsByTaskID` 查询，并通过底部按钮提供撤销与刷新功能。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventoryCheckorder.nvue†L1-L95】
- 与采集页的更多菜单联动，用于查看盘点任务已下发指令的状态。

## 实施目标
- 根据业务需要决定与 `在线拣选指令页` 的差异（例如过滤条件/展示字段），可共用同一 Flutter 页面，通过参数控制标题与操作类型。
- 提供刷新、撤销功能，并展示 WCS 返回的详细信息。

## TODO 清单
- [x] **需求澄清**：
  - [x] 与业务确认 `Checkorder` 页与 `WmsToWcs` 页的差异点（是否仅标题不同或过滤不同）。
  - [x] 如差异较小，考虑共享组件，通过 `CommandCategory` 参数驱动。
- [x] **路由策略**：
  - [x] 若独立页面，注册 `/aswh-inventory/commands/checkorder` 并传递任务参数与类别。
  - [x] 若复用通用指令页，定义可选参数控制标题 `立库盘点采集结果`。
- [x] **数据模型与服务**：
  - [x] 重用 `InventoryWcsCommand` 模型，必要时扩展字段。
  - [x] 服务层添加对应过滤逻辑（如任务类型、命令类型）。
- [x] **BLoC 扩展**：
  - [x] 在指令 BLoC 中加入 `CommandCategory` 字段，加载时应用不同过滤；撤销事件根据类别调用不同接口。
  - [x] 确保刷新按钮（底部第三个）触发重新加载。
- [x] **UI 调整**：
  - [x] 根据类别设置 AppBar 标题。
  - [x] 底部按钮与在线拣选页一致，可复用组件。
- [ ] **测试**：
  - [ ] 单测覆盖多类别加载、撤销；
  - [ ] Widget 测试验证标题、按钮行为符合类别要求。

## 依赖与参考
- API：`getWmsToWcsByTaskID`。【F:GlodWind-Wms-App/pages/aswhInventorytask/task_collect/aswhInventoryCheckorder.nvue†L83-L93】
- Flutter 参考：共用 `aswh_inventory_wms_to_wcs_todo.md` 中的服务与 UI 设计。
