# 平库移库模块 Flutter 重构 TODO（TransferCollectionPage）

> 源码参考：`GlodWind-Wms-App/pages/transfer/transfer.nvue`
>
> Flutter 参考模块：
> - 平库出库模块 `lib/modules/outbound`
> - 平库入库模块 `lib/modules/goods_up`
>
> 接口参考：`api.md` 及 `lib/modules/goods_up/services/goods_up_task_service.dart`

## 1. 模块与路由初始化
- [x] 在 `lib/modules` 下新增 `transfer` 目录，按照 `goods_up` 模块结构创建 `transfer_module.dart`，注册路由与依赖（`TransferModule`, `TransferRouteGuard` 如有需要）。
- [x] 在全局模块或路由配置中挂载平库移库入口（菜单、Home 快捷入口、路由路径）。
- [x] 复用或封装 `GoodsUpTaskService` 中的移库接口，确保依赖注入后供 Bloc 调用。

## 2. 数据模型（Freezed）
- [x] 使用 `freezed` + `json_serializable` 定义以下模型并补充注释：
  - `TransferScanStep`（枚举 + 扩展：描述扫描流程 来源库位/目标库位/物料码/数量）。
  - `TransferScanContext`：记录当前扫描状态、操作模式（移入/移出）、库房、子库、占位提示、focus 等信息。
  - `TransferCollectedItem`：对应 `detailListView` 采集明细，字段包含来源/目标库位、物料、批次/序列、数量、供应商、子库、项目号。
  - `TransferInventoryRow`：对应库存查询 tab (`taskDataGrid`) 行数据。
  - `TransferSubmitPayload`：提交 `/system/terminal/commitTransfer` 时的请求体（含 `transferInfos`、`filter`）。
  - `TransferUiMessage`（可选）：统一封装页面提示/弹窗内容。
- [x] 在模型文件顶部注明执行 `flutter pub run build_runner build --delete-conflicting-outputs` 生成代码。

- [x] 在 `lib/modules/transfer/collection_task/bloc/` 下创建 `transfer_collection_event.dart`、`transfer_collection_state.dart`、`transfer_collection_bloc.dart`。
- [x] 事件规划：
  - `TransferStarted` / `TransferResetRequested`：页面初始化与重置。
  - `ScanInputSubmitted`：处理扫码/手输输入，推进步骤。
  - `QuantityConfirmed`：数量输入完成。
  - `TransferModeToggled`：移入/移出模式切换。
  - `InventoryQueryRequested`：触发库存查询。
  - `CollectedItemChecked` / `CollectedItemsDeleted`：勾选与删除采集行。
  - `TransferSubmitRequested`：提交移库任务。
- [x] 状态内容：
  - 当前扫描上下文与下一步提示文案。
  - 采集明细列表、选中行、库存列表、当前 Tab。
  - 加载/提交状态、错误或成功提示。
- [x] Bloc 逻辑要点：
  - 库位校验、库房一致性检查（`getStoreSiteByRoom`）。
  - 物料条码解析（`getPmMaterialInfoByQR`）及控制模式判断（序列/批次）。
  - 库存校验：`GetRepertoryByStoresiteNoTransfer`、`GetRepertoryBySiteNoMatCode`、`getMtlQtyByMtlCode`。
  - 采集数量累加/去重校验（原逻辑中的 `dicMtlQty`、`dicSeq`）。
  - 提交前的 filter 拼接并调用 `commitTransfer`。
  - 异常捕获统一映射为 `TransferUiMessage`。

## 4. 服务层适配
- [x] 在 `lib/modules/transfer/services/transfer_task_service.dart` 中封装移库相关接口，内部可组合 `GoodsUpTaskService`。
- [x] 将 Promise 形式的调用改写为 `Future<T>`，并结合 `ApiResponseHandler` 处理后端响应。
- [x] 为库存/提交接口提供明确的返回模型（使用第 2 节定义的 Freezed 数据结构）。

- [x] 在 `lib/modules/transfer/collection_task/transfer_collection_page.dart` 构建页面，使用 `BlocProvider` + `BlocBuilder`/`BlocListener`。
- [x] 头部导航与返回拦截：复用现有 `AppBar`/`WillPopScope` 组件，实现“未提交记录提醒”。
- [x] 扫码输入：使用公共扫码输入组件，支持 `FocusNode` 管理、占位提示动态展示。
- [x] 信息概览卡片：参照入库/出库模块的卡片组件展示库房、子库、来源库位、目标库位、物料、批次/序列、数量、项目号、模式。
- [x] Tab 切换：使用通用 Tab 组件，Tab1=采集列表、Tab2=库存查询，状态与 Bloc 同步。
- [x] 采集列表：
  - 使用 Syncfusion DataGrid 或现有网格封装。
  - 支持多选、排序、数量高亮显示。
  - 提供勾选交互并反馈给 Bloc。
- [x] 库存查询：按列（物料编码、数量、批次、项目号、货位、子库、托盘、序列、库房）渲染，支持行点击回填项目号/子库。
- [x] 底部操作条：
  - “操作模式” -> 弹出选择框触发 `TransferModeToggled`。
  - “删除” -> 弹确认后派发删除事件。
  - “提交” -> 显示确认框后派发提交事件，并在成功后显示提示、重置状态。
- [x] Loading、错误与成功提示：统一使用项目现有对话框或 SnackBar 组件。

- [x] 根据模式（移入/移出）在初始化与切换时执行 `updateCheck` 逻辑，自动设置来源/目标库位。
- [x] 校验库位是否被冻结、是否与当前库房一致，不通过时重置并提示。
- [x] 物料控制模式：
  - 序列控制时数量默认 1，禁止重复采集同序列（维护序列集合）。
  - 批次/弱管控时校验批次、项目号等字段。
- [x] 库存数量校验：确保采集数量不超过可用库存，支持项目号维度判断。
- [x] 扫描流程提示（`getPlaceMsg`）：根据步骤动态更新占位文案。
- [x] 提交后清空上下文、重置选中项与提示。

- [x] 在模块入口添加路由跳转（例如 Home 菜单按钮），确保可访问。
- [x] 编写 Bloc 与服务层测试（使用 mock service），覆盖成功/失败、异常分支。
  - 已新增 `transfer_task_service_test.dart` 与 `transfer_collection_bloc_test.dart`，覆盖库位校验、物料解析、数量校验与提交分支。
- [ ] 页面级 Widget 测试：验证 Tab 切换、删除、提交等关键交互。
- [x] 更新或新增文档（如 README/业务说明）描述移库流程与使用方式。
  - 新增 `docs/transfer_collection_usage.md` 汇总移库流程、提示与测试覆盖。

---

完成每项后请将对应复选框标记为 `[x]`，并可在相应章节补充子任务。
