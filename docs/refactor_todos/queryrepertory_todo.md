# 库存查询模块（Query Repertory）Flutter 重构 TODO

> **输入来源**：UniApp 页面 `GlodWind-Wms-App/pages/queryrepertory/queryRepertory.nvue`
>
> **Flutter 参考**：平库出库模块 `lib/modules/outbound`、平库入库模块 `lib/modules/goods_up`
>
> **接口参考**：`api.md`、现有服务 `lib/modules/goods_up/services/goods_up_task_service.dart`、`lib/modules/outbound/services/outbound_task_service.dart`

## 页面：库存查询首页（queryRepertory.nvue）

### 1. 模块初始化与路由骨架
- [x] 新增 `lib/modules/inventory_query` 模块目录，参照 `lib/modules/outbound` 目录结构划分 `pages/`, `bloc/`, `services/`, `models/`, `widgets/` 等子目录。
- [x] 创建 `inventory_query_module.dart`，实现 `Module` 定义与路由注册（例如 `/inventory/query`），并在 `app_module.dart` 中挂载，保持与 `goods_up_module.dart` 相同的模式。
- [x] 定义 `InventoryQueryRoute`（或 `InventoryQueryPageRoute`）常量，供主导航与其他页面跳转复用。

### 2. Freezed 数据模型定义
- [x] 使用 `freezed` + `json_serializable` 创建查询请求模型：`InventoryQueryRequest`（字段：`queryType`、`barcode`、`storeSite`、`trayNo`、`pageIndex`、`pageSize` 等），对照 UniApp 中 `GetRepertoryByBarCode` 及分页参数。
- [x] 定义库存记录模型：`InventoryRecord`（字段覆盖 `matcode`、`matname`、`repqty`、`batchno`、`sn`、`storesiteno`、`erpStoreroom`、`storeroomno`、`storeroomname` 等），参考 UniApp `detailListView`。
- [x] 定义条码解析结果模型：`InventoryBarcodeMaterial`，对应 `getPmMaterialInfoByQR` 返回的 `BarcodeContent` 字段。
- [x] 定义汇总视图模型：`InventorySummary`（如总库存数量、当前库位、托盘号等），用于顶部卡片展示。
- [x] 为分页响应创建 `InventoryRecordPage`（封装 `rows`, `total`），保持与 `CommonDataGridBloc` 兼容。
- [x] 更新 `pubspec.yaml` 中 `build_runner` 依赖说明（若已有可跳过），并在 TODO 完成后提示运行 `flutter pub run build_runner build --delete-conflicting-outputs`。

### 3. 服务层（Service）封装
- [x] 新建 `InventoryQueryService`，注入 `ApiService`/`DioClient`，参考 `CollectionService` 和 `GoodsUpTaskService` 的实现方式。
- [x] 实现以下方法，并对照 `api.md` 补充接口注释：
  - `Future<InventoryBarcodeMaterial> getMaterialInfoByQr(String barcode)` → 对应 `getPmMaterialInfoByQR`。
  - `Future<InventoryRecordPage> getInventoryByBarcode(String code, String queryType, int pageIndex, int pageSize)` → 对应 `GetRepertoryByBarCode`。
  - 预留库位、托盘、批次等扩展接口（如需与 UniApp 其他入口保持一致）。
- [x] 统一错误处理：使用 `ErrorHandler.handleError` 或类似工具，保持与入库/出库模块一致。

### 4. 状态管理（Bloc/Cubit）
- [x] 参考 `lib/modules/outbound/collection_task/bloc`，创建 `InventoryQueryBloc`，以及独立的 `InventoryQueryEvent`/`InventoryQueryState` 文件。
- [x] 事件设计：
  - `InventoryQueryInitialized`（页面初始化，加载默认分页设置）。
  - `InventoryBarcodeScanned`（扫码内容进入，识别 `MC/$KW$/$TP$` 三种步骤）。
  - `InventoryQuerySubmitted`（手动点击查询按钮）。
  - `InventoryPageChanged`（分页器切换页码）。
  - `InventoryResetRequested`（清空当前查询结果）。
- [x] 状态设计：
  - 使用 `freezed` 定义 `InventoryQueryState`，包含字段：`pageStatus`（`PageStatus`）、`barcodeMaterial`、`records`、`summary`、`queryType`、`currentPage`、`pageSize`、`total`、`errorMessage`、`inputFocus` 等。
  - 根据出入库模块的 `PageStatus` 管理 loading/success/error。
- [x] 在 Bloc 中实现扫码步骤逻辑：
  - 解析扫码字符串，映射到 `queryType` (`M`、`S`、`P`)，并更新 `summary`（库位、托盘、总库存）。
  - 触发服务层查询并写入 `records`，计算合计库存数。
  - 捕获异常并派发错误状态，保证 UI 弹出 `ErrorDialog` 或 `SnackBar`。
- [x] 为 `loadData`/分页切换复用 Bloc 事件，保持与 UniApp `loadData` 方法一致的效果。

### 5. UI 页面实现
- [x] 新建 `pages/inventory_query_page.dart`，使用 `BlocProvider` 注入 `InventoryQueryBloc`。
- [x] AppBar：使用现有 `CustomAppBar`，标题“库存查询”，左侧返回调用 `Navigator.pop` 或重定向到首页。
- [x] 输入区：
  - 引入 `common_widgets/scan/scan_input_field.dart`（如有）或复用 `ScanCode` 组件逻辑，实现扫码触发 `InventoryBarcodeScanned`。
  - 提供手动输入框，支持清除/提交按钮，参照入库/出库模块的表单组件样式。
- [x] 汇总卡片：
  - 参照 `goods_up` 模块顶部信息条，展示库位、库存数量、物料信息、托盘号等，绑定 `InventorySummary`。
- [x] 数据表格：
  - 使用 `CommonDataGrid<InventoryRecord>` 或 `SyncfusionDataGrid`，定义列（物料编码、名称、批次、数量、库位、ERP 子库、库房编码/名称等）。
  - 支持排序、分页、空数据占位，与现有模块风格一致。
- [x] 分页组件：复用 `PaginationFooter` 或构建类似组件，调用 `InventoryPageChanged`。
- [x] 错误与加载状态：
  - 当 `PageStatus.loading` 时展示 `LoadingOverlay`。
  - 当 `PageStatus.error` 时显示错误提示，可参考 `Outbound` 模块的实现。
- [x] 扫码悬浮按钮 / 底部按钮（如 UniApp 使用的 `<scanCode>` 组件），结合现有扫码服务确保在扫码完成后自动聚焦输入框。

### 6. 模块集成
- [x] 在主菜单或工作台入口中新增“库存查询”导航，复用 `HomeNavigationBloc`/`modules/home` 的配置方式。
- [x] 确认用户权限校验逻辑（如需要登陆后才能访问），与入库/出库模块保持一致。
- [ ] 如需缓存最近查询参数，可接入 `SharedPreferences` 或 Hive，保持与其他模块统一（可选）。

### 7. 测试与验证
- [x] 编写 `InventoryQueryService` 的单元测试，模拟成功与失败响应（可使用 `mockito`）。
- [x] 为 `InventoryQueryBloc` 添加事件-状态测试，覆盖扫码解析、分页切换、错误提示。
- [ ] 进行 UI Golden / Widget 测试，验证表单与数据网格渲染（可选）。
- [ ] 手动联调：扫码三种类型（物料 MC、库位 `$KW$`、托盘 `$TP$`）、分页跳转、无数据提示、网络错误。

### 8. 文档与发布
- [ ] 在 `docs` 中新增或更新操作指南，说明 Flutter 版库存查询的使用流程与接口对照。
- [ ] 更新 `CHANGELOG` 或发布说明，记录库存查询模块 Flutter 化的主要变更。
- [x] 运行并记录 `flutter analyze`、`flutter test`、`flutter pub run build_runner build --delete-conflicting-outputs` 的结果，确保模块上线前质量可追溯。
  - `flutter pub run build_runner build --delete-conflicting-outputs` ✅
  - `flutter analyze --no-pub lib test` ⚠️（返回 604 个历史遗留告警，待全局治理）
  - `flutter test` ⚠️（因 `StubGoodsUpTaskService.commitUpShelves` 与 `GoodsUpTaskService` 签名不一致导致的既有失败）

> 完成每一项后，请在 TODO 列表中将对应条目由 `[ ]` 改为 `[x]` 以标记完成。
