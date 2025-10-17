# 拉式发料模块重构 TODO

> 目标：将 UniApp `pages/mtlsenter/mtlSenterTaskItem.nvue` 拉式发料采集页重构为 Flutter 模块，保持扫码顺序、库存校验与批量提交逻辑，并与现有平库出入库模块保持一致的架构风格。

## 现状分析
- 页面：单页 `mtlSenterTaskItem.nvue`，包含库位扫码、物料扫码、数量录入、明细列表、删除/提交等功能。【F:GlodWind-Wms-App/pages/mtlsenter/mtlSenterTaskItem.nvue†L1-L208】【F:GlodWind-Wms-App/pages/mtlsenter/mtlSenterTaskItem.nvue†L320-L481】
- 接口：依赖 `CommitMtlSender`、`getMtlQtyByMtlCode`、`getLSMtlRepertoryByStoresiteNo`、`getStoreSiteByRoom` 等 API（参考 `api.md` 与原 UniApp 调用）。【F:GlodWind-Wms-App/pages/mtlsenter/mtlSenterTaskItem.nvue†L72-L110】
- Flutter 参考：平库出库采集页使用 `CollectionBloc` 协调扫码、Tab 切换与明细管理；平库入库模块复用类似模式，可作为 UI、BLoC、Service 的设计模板。【F:lib/modules/outbound/collection_task/outbound_collection_page.dart†L1-L119】

## 通用约束
- 全部数据模型使用 `freezed` + `json_serializable` 生成不可变实体与序列化代码。
- 状态管理沿用 BLoC 架构，事件/状态拆分，遵循 `lib/modules/outbound/goods_up` 既有命名与层次。
- 遵循已有的扫描组件（`ScannerWidget`）、列表组件（`CommonDataGrid`）和 Loading/提示机制。
- Todo 列表完成后请将 `[ ]` 改为 `[x]` 以标记完成。

## 模块结构规划
- 目录建议：`lib/modules/mtl_senter/`
  ```
  mtl_senter_module.dart
  collection_task/
    bloc/
    models/
    services/
    widgets/
    mtl_senter_collection_page.dart
  ```
- 可选拓展：历史记录、异常记录子页面与公共组件。

## 任务清单

### 1. 需求澄清与接口确认
- [x] 对照 `api.md` 中的拉式发料接口与 UniApp 逻辑，确认所有字段、参数命名及成功/失败返回结构。
- [ ] 与后端确认是否需要新增或复用现有 `goods_up`、`outbound` 服务中的认证、头信息、分页参数。

### 2. 模块骨架与路由
- [x] 新建 `lib/modules/mtl_senter/mtl_senter_module.dart`，注册依赖（BLoC、Service）与路由。
- [x] 在主模块中添加入口路由（例如 `/pull-feeding/collection`），接入 `home_page` 的功能入口卡片。
- [x] 参考 `outbound`、`goods_up` 模块的模块化注册方式，配置路由守卫与依赖注入。

### 3. 数据模型（Freezed）
- [x] 定义 `MtlSenterTask`（任务头信息：工单/产线、车间、计划数量、需求时间等）。
- [x] 定义 `MtlSenterMaterial`（库存查询结果：库位、物料编码、现有库存、最小包装、默认配送量等）。
- [x] 定义 `MtlSenterCollectItem`（本次采集记录：库位、物料、批次/序列、数量、唯一标识）。
- [x] 定义 `MtlSenterSubmitRequest` 与 `MtlSenterSubmitResponse`，确保字段与 `CommitMtlSender` 接口契合。
- [x] 定义必要的异常/状态模型（例如 `MtlSenterStatus` 或重用通用状态），生成 `*.freezed.dart`、`*.g.dart` 文件。

### 4. Service 层
- [x] 创建 `MtlSenterService`，封装：
  - [x] `fetchMaterialByQr`（对接 `getPmMaterialInfoByQR`）。
  - [x] `fetchInventoryByLocation`（对接 `getLSMtlRepertoryByStoresiteNo`）。
  - [x] `fetchMtlQty`（对接 `getMtlQtyByMtlCode` 并填充最小包装/默认配送量）。
  - [x] `commitSender`（对接 `CommitMtlSender`，支持批量提交）。
- [x] 统一错误处理、超时与 token 刷新逻辑，复用 `ApiService`/`DioClient`。
- [x] 若接口需要组合请求，编写 DTO 映射（model ↔ API 请求/响应）。

### 5. BLoC 设计
- [x] 定义事件：初始化、扫码（库位/物料/数量）、删除、提交、重置焦点、刷新库存等。
- [x] 定义状态：
  - [x] 当前扫码步骤提示（类似 UniApp `placeholder`）。
  - [x] 当前选择库位/物料/数量与库存信息。
  - [x] `stocks` 列表（待提交记录，含唯一 ID）。
  - [x] 校验/错误信息、加载状态。
- [x] 在 `CollectionBloc` 中实现与 UniApp 一致的工作流：
  - [x] 校验扫码顺序（库位 → 物料 → 数量）。
  - [x] 校验库存是否充足（累计数量 ≤ 库存）。
  - [x] 同物料+库位合并数量，支持再次扫码叠加。
  - [x] 删除选中行时同步更新本地字典与库存校验。
- [ ] 引入 Hive 或本地缓存存储未提交记录（可选需求）。

### 6. UI - `mtlSenterTaskItem` 对应 Flutter 页
- [x] 页面骨架：`Scaffold` + `AppBar`，拦截返回逻辑（未提交数据弹窗确认）。
- [x] 顶部扫码输入区使用 `ScannerWidget`，根据状态动态更新 placeholder 与焦点。【F:lib/modules/outbound/collection_task/outbound_collection_page.dart†L28-L119】
- [x] 显示信息卡片：库位、库存、物料信息、采集数量、最小包装/默认配送量。
- [x] 待提交列表：
  - [x] 使用 `CommonDataGrid` 或 `DataTable` 展示库位、物料、数量，支持勾选删除。
  - [x] 与 BLoC `stocks` 状态绑定，删除后刷新。
- [x] 底部操作条：删除/提交按钮，状态不可时禁用。
- [x] 成功/失败反馈：结合 LoadingDialogManager、SnackBar/Dialog 实现。

### 7. 提交与异常处理
- [x] 实现删除确认弹窗、提交前确认。
- [x] 提交成功后清理状态并返回首页或刷新任务。
- [x] 处理接口异常、扫码异常、库存不足提示，确保与 UniApp 体验一致。

### 8. 集成测试与自测
- [x] 编写 BLoC 单元测试，覆盖：扫码流程、库存不足、重复扫码合并、删除记录、提交成功/失败。（`test/modules/mtl_senter/collection_task/bloc/mtl_senter_collection_bloc_test.dart`）
- [x] 编写 Service 层单元测试或 Mock 测试，验证请求参数与响应处理。（`test/modules/mtl_senter/collection_task/services/mtl_senter_service_test.dart`）
- [ ] 如集成 Hive 缓存，测试缓存读写与恢复流程。

### 9. 文档与交付
- [x] 更新 `docs` 中的业务说明与操作手册，新增 Flutter 拉式发料使用说明。（`docs/mtl_senter_module_guide.md`）
- [x] 在 README 或模块文档中记录模块依赖、运行命令、测试方式。（README 新增拉式发料说明）
- [x] 提交代码前执行 `flutter analyze`、`flutter test`、`flutter pub run build_runner build --delete-conflicting-outputs`。（存在历史告警，已记录输出供后续修复）

> 完成项请在复选框内打勾，确保任务闭环。
