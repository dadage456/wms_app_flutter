# 到货签收采集页重构 TODO（原 `pages/arrive_sign/task_collect/index.nvue`）

## 目标
- 实现到货签收的采集作业流程，包含扫码、批次/序列校验、数量录入、列表切换、采集记录提交。
- 参考“平库出库采集”模块（`lib/modules/outbound/collection_task`）和“平库入库采集”模块的架构与交互。

## 待办清单
### 模块与基础设施
- [x] 在 `arrival_sign_module.dart` 中注册 `/arrival-sign/collect` 路由，接收整行任务对象（`ArrivalSignTask`）。
- [x] 新建 `lib/modules/arrival_sign/task_collect/` 子目录（`bloc`、`models`、`widgets`、`services`、`config`），保持与 `outbound/collection_task` 对齐。

### 数据模型（Freezed）
- [x] 定义以下模型：
  - `ArrivalCollectTask`：承载当前任务行字段（matcode、qty、goodqty、batchno、sn、subinventoryCode、matname、matcodecontrol、orderno、arrivalsBillno、arrivalsBillid 等）。
  - `ArrivalCollectProgress`：记录采集中的临时状态（matcode、batchno、sn、collectQty、pdate、vdays、collectFlg 等）。
  - `ArrivalCollectSubmitRequest`：封装提交接口 `/system/terminal/commitSign` 所需 `upShelvesInfos`、`itemListInfos`、`filter` 结构。
  - `ArrivalCollectScanStep` 枚举（materialQRCode、location、quantity）用于描述多步扫码流程。
  - `ArrivalCollectSummary`：用于“正在采集”列表与提交预览。
- [x] 若需要本地缓存，定义 `ArrivalCollectCache` 模型（用于 Hive）。

- [x] `ArrivalSignService` 中补充：
  - `getArrivalSignDetails`（复用 detail 页实现）。
  - `getMaterialInfoByQr(String qr)` -> `/system/terminal/materialInfo`。
  - `commitSignShelves(ArrivalCollectSubmitRequest request)` -> `/system/terminal/commitSign`（POST JSON，content-type 需指定）。
- [x] 若存在草稿保存需求，规划使用 `LocalStorageService`/Hive box（可参考 `OutboundCollectionCacheService`）。

- [x] 创建 `ArrivalCollectBloc`（或按功能拆分多个 bloc）：
  - 事件：初始化任务、切换 Tab、扫码结果（二维码/数量/库位）、手动输入数量、选择采集记录、删除记录、提交、恢复缓存、刷新明细列表。
  - 状态：包含当前扫描步骤、当前输入内容、`taskItems` 列表、`collectingItems` 列表、`selectedCollects`、错误提示、加载状态、提交状态。
- [x] 使用 `freezed` 生成事件/状态类，参考 `OutboundCollectBloc` 的组织方式。
- [x] 整合 `CommonDataGridBloc` 或自定义数据源以呈现“任务列表/正在采集”两个表格。

- [x] 集成 `ScannerWidget`（或 `ScannerTextField`）作为顶部输入，placeholder “请扫描物料二维码”。
- [x] 还原 uni-app 逻辑：
  - 第一阶段识别物料二维码（包含 `MC`） -> 匹配 `detailListView` 中的物料。
  - 校验物料控制属性（序列/批次）、供应商、批号是否匹配。
  - 序列号控制物料需校验序列唯一；批次控制物料需校验批次非空。
  - 第二阶段读取数量（纯数字），支持浮点；数量需 >0，且不得超过任务剩余量。
  - 若有库位扫描需求（Step.Site），对接 `storeRoom` 验证逻辑（确认在 uni-app 中是否启用）。
- [x] 将错误通过 Bloc 状态上报并由 UI 弹窗提示（`LoadingDialogManager.showErrorDialog`）。

- [x] 构建页面布局：
  - 顶部信息卡片展示当前物料/数量/批次/序列/生产日期/有效期。
  - `FUITabs` 对应 Flutter 端使用 `ToggleButtons`/`TabBar`，切换“任务列表”“正在采集”。
  - “任务列表”使用 `CommonDataGrid` 显示 `taskItems`，点击行触发 `SelectTask` 事件并更新顶部信息。
  - “正在采集”使用 `CommonDataGrid` 显示 `collectingItems`，支持复选（删除、提交时使用）。
  - 底部 `BottomNavbar` 对应 Flutter `BottomAppBar` + `PrimaryButton` 实现“采集结果/提交”功能。
  - 弹出菜单（bubble box）可用 `PopupMenuButton` 或自定义 overlay，包含“采集结果”“提交”入口。
- [x] 点击“采集结果”跳转 `/arrival-sign/collect/result`，并将缓存同步。
- [ ] `taskcollAdd` 行为：切换到“正在采集”Tab，并过滤出同物料记录。

- [x] 用 Hive 或本地服务代替 `uni.setStorageSync`：
  - 进入页面时清空 `stocks`、`updateflag`，并在采集有变更时写入缓存。
  - 从结果页返回时根据 `updateflag` 恢复最新列表。
- [x] 提供 `ArrivalCollectCacheRepository` 统一读写缓存，避免直接操作 Hive。

- [x] 在“正在采集”表格中支持多选删除，删除后需要回写 `taskItems` 中对应行的 `goodqty`（类似 uni-app `deleteColl` 逻辑）。
- [x] Bloc 中实现数量计算方法：统计每个物料已采集总量、校验是否超计划、更新 `dicMtlQty`、`dicSeq` 等映射。

- [x] Bloc 处理提交事件：
  - 根据 `collectingItems` 组装 `ArrivalCollectSubmitRequest`（upShelvesInfos/itemListInfos/filter），字段命名与 uni-app 保持一致。
  - 调用 `commitSignShelves`，成功后清空缓存、刷新列表，弹出成功提示并返回列表页。
  - 提交前校验是否存在待提交记录，为零时提示错误。
- [ ] 若提交需要额外字段（用户、仓库等），从 `UserManager` 或任务数据中补齐。

- [x] 覆盖返回按钮行为：若存在未提交采集记录，则弹窗确认“当前采集记录尚未提交，确定退出采集吗？”；确认后清理扫码监听并返回列表。

### 测试
- [ ] Bloc 单元测试：扫码流程（成功/失败）、数量校验、删除/提交。
- [ ] Widget 测试：Tab 切换、表格渲染、底部按钮交互。

- [x] 更新所有 `freezed`/`json_serializable` 模型并运行 `build_runner`。
