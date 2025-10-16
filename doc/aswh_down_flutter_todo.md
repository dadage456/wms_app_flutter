# 在线拣选模块 Flutter 重构 TODO

> 目标：基于 UniApp 在线拣选模块（`GlodWind-Wms-App/pages/aswhdown`）整体迁移至 Flutter，复用现有“平库出库”（`lib/modules/outbound`）与“平库入库”（`lib/modules/goods_up`）的架构与组件，确保与 `api.md`、`GlodWind-Wms-App/api/system` 下接口保持一致；所有新建数据模型统一使用 Freezed。

## 全局 / 基础工作
- [ ] **源头**： `task_collect/aswhDownTaskItem.nvue`
- [x] **模块骨架**：在 `lib/modules` 下新建 `aswh_down/`，复制 `outbound/` 与 `goods_up/` 的目录结构（`task_list/`、`task_details/`、`collection_task/`、`task_receive/`、`wcs/`、`services/`、`models/`、`widgets/`）。
- [x] **路由接入**：编写 `lib/modules/aswh_down/aswh_down_module.dart`，通过 `flutter_modular` 注册列表、明细、采集、接收、指令等子路由，并在 `lib/app_module.dart` 中新增 `/aswh-down` 模块引用。
- [x] **服务封装**：实现 `AswhDownService`/`AswhDownCollectionService` 等类，分别封装 `goodsDown.js` 与 `aswhUp.js` 中使用的接口（如 `/system/terminal/outList`、`/getOutTaskItem`、`/commitASWHDownShelves`、`/commitDownWmsToWcs`、`/getWmsToWcsByTaskID` 等），统一走 `ApiResponseHandler`。
- [x] **数据模型**：使用 Freezed + json_serializable + Hive（如需缓存）定义以下核心模型：`OnlinePickTask`、`OnlinePickTaskQuery`、`OnlinePickTaskItem`、`OnlinePickTaskItemQuery`、`OnlinePickCollectionStock`、`OnlinePickBarcodeContent`、`OnlinePickWcsCommand`、`OnlinePickLocationOption` 等。
- [ ] **Hive 适配器**：为需要本地缓存的模型（采集过程、WCS 指令草稿等）注册 `HiveType`，在应用初始化时（参考 `CollectionBloc`）进行 `Hive.registerAdapter`。
- [ ] **共享组件**：复用 `ScannerWidget`、`CommonDataGrid`、`SelectionActionBar` 等通用组件；如需新增控件（如多标签统计、托盘确认弹窗），放置于 `lib/modules/aswh_down/widgets/`。
- [x] **依赖注入**：在模块 `binds` 中注册所有 BLoC、Service，并注入 `UserManager`、`DioClient`；确保 BLoC 生命周期与其它模块一致。
- [ ] **命名规范**：统一使用 `online_pick_*.dart` 前缀，避免与现有出库/入库命名冲突，方便 `build_runner` 生成代码。
- [x] **构建脚本**：在新增 Freezed 文件后，执行并记录 `flutter pub run build_runner build --delete-conflicting-outputs`。
- [ ] **测试基线**：规划 BLoC 与 Service 层的单元测试，复用 `mocktail`/`dio_mock_adapter` 等现有测试工具，确保关键路径（采集提交流程、WCS 指令、撤销/接收）均有覆盖。

## 页面：在线拣选任务列表（`aswhDown.nvue`）
- [x] **数据 & 接口**：实现 `OnlinePickTaskQuery` -> `/system/terminal/outList` 参数映射（含 `finshFlg`、`roomTag='1'`、`PageIndex` 等），确认扫码内容写入 `searchKey` 后追加刷新逻辑。
- [x] **BLoC 实现**：新增 `OnlinePickTaskBloc`（可继承/组合 `CommonDataGridBloc`），处理搜索、分页、状态过滤（“采集中”“全部”）、扫码、导航事件。
- [x] **UI 布局**：基于 `CommonDataGrid` + `ScannerWidget` 构建列表页，复刻操作列按钮（“采集”“明细”）和底部筛选弹窗（单选“所有单据/采集中单据”）。
- [x] **扫码接入**：替换 `uni.$on('scancodedate')` 为 `ScannerController`；扫码成功时触发 `Search` 事件并自动聚焦输入框。
- [x] **导航逻辑**：绑定按钮跳转至 `/collect`, `/detail`, `/receive` 路由，传递任务实体、工作站、完成标记等必要参数。
- [x] **空态与反馈**：在无数据时显示与现有出库模块一致的空态提示；加载、错误提示统一使用 `PageStatus`。
- [ ] **测试**：为 Bloc 编写测试，覆盖默认加载、扫码搜索、过滤切换与分页行为。

## 页面：在线拣选任务明细（`aswhDownDetail.nvue`）
- [x] **数据 & 接口**：实现 `OnlinePickTaskItemQuery` 映射（含 `roleoRuserId`、`workstation`、`PageIndex` 等），调用 `/system/terminal/outTaskitemList`。
- [x] **BLoC 实现**：创建 `OnlinePickTaskDetailBloc`，支持初始化加载、扫码过滤、行选择、批量撤销 (`CommitRCOutTaskItem` with `isCanel='true'`)。
- [x] **UI 布局**：沿用 `ReceiveTaskDetailPage` 的 `CommonDataGrid` 模式，展示与 UniApp 相同列配置（托盘、数量、库位、批次、序列等），支持多选勾选框。
- [x] **操作栏**：提供底部操作条按钮（“全选/取消全选”“撤销”），触发 Bloc 事件并在完成后刷新列表。
- [x] **扫码逻辑**：复用任务列表的扫码组件，支持解析 `MC` 二维码与 `$KW$` 库位码后自动触发查询。
- [x] **反馈机制**：撤销成功/失败弹窗复用 `showConfirm`/`showSnackBar` 方案，并处理接口错误码。
- [ ] **测试**：添加 Bloc 单测覆盖扫码、批量撤销、错误场景；补充参数映射测试。

## 页面：在线拣选采集（`task_collect/aswhDownTaskItem.nvue`）
- [x] **数据模型**：使用 Freezed 定义采集页所需状态对象（任务行 `OnlinePickTaskItem`、扫码内容 `OnlinePickBarcodeContent`、采集缓存 `OnlinePickCollectionStock`、拣选模式枚举、扫描步骤枚举、托盘确认数据等）。
- [x] **BLoC 架构**：实现 `OnlinePickCollectionBloc`，参考 `CollectionBloc`，扩展自动化仓库字段与事件：初始化任务、扫码步骤（托盘→库位→物料→数量）、库存校验、模式切换、WCS 指令提交、缓存恢复、异常处理。
- [x] **缓存策略**：借助 Hive 存储任务行、采集记录、序列集合、数量字典（对应 UniApp 的 `dicSeq`、`dicMtlQty` 等），支持恢复与手动清理。
- [x] **接口调用**：封装并串联以下接口：`getOutTaskCollitemList`、`GetRoomMatControl`、`GetMatControl`、`getMtlRepertoryByStoresiteNo*`、`CommitASWHDownShelves`、`CommitDownShelves`、`CommitDownWmsToWcs`、`CommitEmptyTrayWmsToWcs`、`CommitResetWmsToWcs`、`GetInOutLocation`、`CommitExceptShelves`、`commitFinishOutTaskItem`、`commitTrayDownShelves` 等。
- [x] **扫码步骤逻辑**：实现与 UniApp 一致的解析规则（`MC` 二维码→物料、`$TP$`→托盘、数字→数量），并在 Bloc 中维护当前步骤提示与错误处理（含重复序列校验、库存不足、子库不一致等）。
- [x] **UI 组件**：构建顶部信息卡片（库存、拣选位置、模式、托盘、库位、物料、采集/结余数）、`TabBar` 三视图（任务列表/正在采集/库存核对）、底部导航（拣选位置、采集结果、提交、更多）、弹窗（托盘数量确认、模式选择）、气泡菜单（采集模式、空盘出入库、回库等）。
- [x] **指令操作**：在 Bloc 中实现子菜单对应事件：
  - 空盘出入库：调用 `CommitEmptyTrayWmsToWcs`/`commitInvDownWmsToWcs`。
  - 单个托盘/全部托盘出库：控制 `singleFlag`，复用 `CommitDownWmsToWcs`。
  - 回库/重置：调用 `CommitResetWmsToWcs`/`CommitInvResetWmsToWcs`。
  - 查询指令：跳转至 WCS 页面或弹窗展示。
- [x] **导航互通**：实现跳转到采集结果页、WCS 指令页并回传更新（例如删除采集记录后同步刷新）。
- [x] **无障碍 & 键盘**：在扫码/手输模式下维持焦点、控制软键盘显隐，确保 `ScannerWidget` 与 `TextField` 共存。
- [ ] **测试**：编写 Bloc 测试覆盖扫码顺序、库存校验、提交成功/失败、缓存恢复、指令调用（可用假数据/Mock Service）。

## 页面：采集结果（`task_collect/aswhDownCollectDetail.nvue`）
- [x] **数据绑定**：从 Bloc 或导航参数接收 `OnlinePickCollectionStock` 列表，支持本地删除并回写缓存。
- [ ] **UI 展示**：使用 `CommonDataGrid` 呈现托盘、物料、任务/采集数量、批次、序列等列，并提供多选框。
- [ ] **删除逻辑**：实现批量删除操作，同步更新主采集 Bloc 状态（减少采集数量、移除序列缓存），保持与 UniApp 逻辑一致。
- [ ] **反馈**：删除成功提示，支持空列表展示。
- [ ] **测试**：添加 Bloc/Service 测试验证删除后状态同步正确。

## 页面：WMS ↔ WCS 指令查询（`task_collect/aswhDownWmsToWcs.nvue`）
- [x] **数据模型**：定义 `OnlinePickWcsCommand`（托盘号、起始/目标地址、堆垛机、状态、任务类型、错误信息等字段）。
- [x] **接口调用**：封装 `/system/terminal/getWmsToWcsByTaskID` 查询，支持传入 `taskComment`、`taskId`、`TaskType='03'`、`queryStr`。
- [x] **UI & 操作**：通过 `CommonDataGrid` 呈现指令列表；底部操作栏支持“撤销回指令”“撤销出库指令”“刷新”按钮，分别调用 `CommitResetWmsToWcs`、`CommitDownWmsToWcs`（或对接后台同义接口）并刷新列表。
- [x] **状态标识**：根据 `state2`/`typ2` 等字段增加颜色或标签提示（进行中/完成/异常）。
- [x] **测试**：为 Service/BLoC 编写测试，验证参数映射与刷新逻辑。

## 页面：在线拣选接收列表（`task_receive/aswhDownReceive.nvue`）
- [x] **数据 & 接口**：重用 `OnlinePickTaskQuery`，但根据 UniApp 传入 `userId='ALL'`、`roleoRuserId=当前用户`，请求 `/system/terminal/outList`。
- [x] **BLoC 实现**：创建 `OnlinePickReceiveBloc`，支持扫码过滤、分页加载、跳转至明细。
- [x] **UI 布局**：复刻平库出库的 `ReceiveTaskPage`，展示操作按钮“明细”，保留输入框、表格与分页。
- [x] **扫码逻辑**：与任务列表保持一致，扫码即触发搜索。
- [x] **测试**：添加 Bloc 测试覆盖加载、扫码过滤、空数据提示。

## 页面：在线拣选接收明细（`task_receive/aswhDownReceiveDetail.nvue`）
- [x] **数据 & 接口**：沿用 `OnlinePickTaskItemQuery`，请求 `/system/terminal/outTaskitemList`，注意 `userId='ALL'`、`roomTag='1'`。
- [x] **BLoC 实现**：实现 `OnlinePickReceiveDetailBloc`，提供全选、批量接收 (`CommitRCOutTaskItem` with `isCanel='false'`)、扫码过滤功能。
- [x] **UI 布局**：使用 `CommonDataGrid` + 底部操作栏（“全选/取消全选”“接收”），实时显示选中数量。
- [x] **反馈**：完成接收后提示并刷新列表；错误信息透出后端 `msg`。
- [x] **测试**：覆盖批量接收成功/失败、扫码过滤、分页场景。

## 交互 & 共享逻辑补充
- [x] **扫码解析工具**：提取 `MC`/`$KW$`/`$TP$`/数字的解析、校验逻辑为独立工具类（如 `online_pick_scanner_parser.dart`），供多个页面复用并单元测试。
- [ ] **权限与用户信息**：确保所有请求从 `UserManager` 拉取 `userId`、`roleOrUserId`，与 UniApp 中 `this.$store.state.userid` 对齐。
- [ ] **异常处理**：统一错误弹窗/Toast 方案（使用 `ErrorHandler.handleError` + `ScaffoldMessenger`），替换 `uni.showModal/Toast`。
- [ ] **日志与调试**：必要处添加 `log()`（或 `debugPrint`）记录关键参数、接口响应，便于后续排查。
- [ ] **文档更新**：在 `docs/` 或 `doc/` 下追加模块说明（路由、模型、接口对照、扫码流程图），便于后续维护。
