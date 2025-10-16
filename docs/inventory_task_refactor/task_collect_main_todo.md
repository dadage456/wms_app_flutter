# 平库盘点采集页重构 TODO

## 页面现状回顾
- 采集页包含扫码输入、任务信息卡片、任务列表与“正在采集”双标签页，以及底部“采集结果 / 提交”操作栏。【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskaskItem.nvue†L3-L210】【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskaskItem.nvue†L360-L368】
- 页面在 `onLoad` 中解析任务参数并调用 `getInventoryTaskItem` 获取盘点明细，同时注册扫码监听；离开页面或返回时需要校验是否存在未提交的采集记录。【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskaskItem.nvue†L272-L321】
- 采集数据支持本地缓存（`uni.setStorage`）与任务明细同步；扫描流程需按库位→物料二维码→数量顺序执行，内含大量校验和差异累计逻辑，并最终通过 `commitInventoryInfos` 提交盘点结果。【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskaskItem.nvue†L236-L450】【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskaskItem.nvue†L882-L954】【F:GlodWind-Wms-App/api/system/goodsDown.js†L246-L268】

## Flutter 重构参考
- UI 与交互可参考平库入库采集页的 Tab 切换、扫码聚焦、表格选择与底部操作栏模式，并复用 `ScannerWidget` 与 `CommonDataGrid`。【F:lib/modules/goods_up/collection_task/goods_up_collection_page.dart†L33-L188】
- 采集结果弹窗/删除逻辑可对标入库模块的采集结果页，结合 `Navigator` 返回值更新主页面状态。【F:lib/modules/goods_up/collection_task/goods_up_collection_result_page.dart†L30-L188】
- 数据模型建议使用 Freezed 定义：
  - `InventoryCollectTaskItem`（盘点任务明细）
  - `InventoryCollectStock`（采集结果项）
  - `InventoryBarcodeContent`（二维码解析结果）
  并参考出库/入库模块的 Freezed 模型定义和 JSON 映射方式。【F:lib/modules/outbound/task_list/models/outbound_task.dart†L7-L195】

## TODO 列表
- [x] 建立 `lib/modules/inventory_task/collection_task` 目录，拆分为页面、BLoC、状态/事件、模型、服务五个子目录，保持与入库模块一致结构。【F:lib/modules/goods_up/collection_task/goods_up_collection_page.dart†L11-L188】
- [x] 编写 `InventoryCollectService`：封装 `getInventoryTaskItem`、`commitInventoryInfos`、库位校验及条码解析接口，并提供离线缓存同步（Hive/本地存储）。【F:GlodWind-Wms-App/api/system/goodsDown.js†L246-L268】
- [x] 定义 Freezed 数据模型及序列化：任务明细、采集记录、提交请求、扫码内容等；确保字段覆盖 UniApp 中的物料编码、批次、序列号、库位等信息。【F:GlodWind-Wms-App/pages/Inventorytask/task_collect/InventorytaskaskItem.nvue†L236-L450】
- [x] 构建 `InventoryCollectBloc` 状态机：
  - 维护当前步骤（库位/物料/数量）与占位提示。
  - 管理双标签数据集（待采集、正在采集）及选中行。
  - 处理扫码事件、手动输入、数量累加、异常提示、离线缓存刷新。
  - 支持从结果页返回后同步最新缓存。
- [x] 实现 `InventoryCollectPage` UI：
  - 顶部信息区域展示库房、库位、物料、数量等实时反馈。
  - Tab 切换时刷新对应数据源，表格支持多选与选中回调。
  - 底部按钮：进入采集结果页、提交采集数据（弹出确认对话框）。
  - 监听返回事件，存在未提交数据时提示确认。
- [x] 结果页交互：通过 `Navigator.push` 打开结果页面，支持删除采集记录并返回删除列表，由 BLoC 处理同步更新。
- [x] 使用 `ScannerWidget` 控制焦点与清空输入，扫描异常时调用 `LoadingDialogManager` 弹出错误提示。【F:lib/modules/goods_up/collection_task/goods_up_collection_page.dart†L97-L188】
- [x] 集成提交流程：
  - 组装 `commitInventoryInfos` 请求体（任务备注、物料编码、批次、数量等）。
  - 成功后清理缓存、重置状态并返回任务列表页。
  - 失败时展示错误提示并保持当前采集数据。
- [ ] 编写单元/集成测试：覆盖扫码流程、数量累加、提交成功/失败、离线缓存恢复及结果页回传删除等场景。
