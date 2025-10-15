# 立库组盘模块 Flutter 重构 TODO

## 0. 模块基础设施
- [x] 在 `lib/modules/` 下新建 `aswh_up` 模块，按照 `goods_up` 现有结构划分 `task_list/`, `task_details/`, `collection_task/`, `task_receive/`, `services/`, `models/`, `config/`, `widgets/` 子目录。
- [x] 新增 `AswhUpModule`，参考 `GoodsUpModule` 完成依赖绑定：
  - [x] 注册 `AswhUpTaskService`，封装 `/system/terminal/aswhInList`、`commitASWHUpShelves`、`CheckBindingTray`、`getWmsToWcsByTaskID` 等接口。
  - [x] 绑定任务列表、任务明细、采集、接收场景对应的 BLoC，并注入 `UserManager`、`DioClient` 等依赖。
- [x] 在 `AppModule.routes` 注册 `/aswh-up` 子路由，并在首页入口增加导航。
- [x] 在 `lib/modules/aswh_up/models/` 中使用 `freezed`+`json_serializable`+`HiveType` 创建数据模型：
  - [x] `AswhUpTask` 及分页封装。
  - [x] `AswhUpTaskItem`。
  - [x] `AswhUpBarcodeContent`、`AswhUpCollectionStock`、`AswhUpDicSeqEntry` 等采集相关模型。
- [x] 为上述模型配置 `build_runner` 生成脚本并更新文档。
- [x] 编写 `AswhUpTaskService`，封装 `aswhInList`、`commitASWHUpShelves`、`getPalletItemByTaskID`、`getWmsToWcsByTaskID`、`CheckBindingTray`、`CheckBindingTrayByTaskId`、`GetMatControl`、`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNo` 等接口调用。

## 1. 任务列表页（`aswhUp.nvue` → `AswhUpTaskListPage`）
- [x] 基于 `GoodsUpTaskListPage` 创建 `AswhUpTaskListPage`，集成 `ScannerWidget` 并在加载时自动查询。
- [x] 配置 `CommonDataGrid` 列，包含操作、入库单号、来源单号、库房号、工位、任务号、供应商、凭证号等，操作按钮支持跳转采集和明细页面，AppBar 右侧提供接收入口。
- [x] 新建 `AswhUpTaskBloc` 管理分页、搜索、刷新，状态包含 `total`、`currentPage` 等分页信息。
- [x] 处理扫码查询逻辑，空结果时提示用户。

## 2. 任务明细页（`aswhUpDetail.nvue` → `AswhUpTaskDetailPage`）
- [x] 创建 `AswhUpTaskDetailPage`，包含顶部扫描、列表、底部操作栏，扫描逻辑识别 `MC` 与 `$KW$`。
- [x] 使用 `CommonDataGridBloc<AswhUpTaskDetailItem>` 管理分页与选中，列字段与 UniApp 一致。
- [x] 底部操作栏实现全选/取消、删除（调用 `CommitRCInTaskItem` 撤销明细）并带确认对话框。
- [x] 通过 `BlocListener` 管理 Loading/Error 提示，并在页面销毁时重置扫描监听。

## 3. 组盘采集页（`aswhUpTaskItem.nvue` → `AswhUpCollectionPage`）
- [x] 还原 UniApp 布局：扫描输入、信息卡片、`TabBar`、两个 `CommonDataGrid`、底部三键导航及气泡菜单，支持返回拦截。
- [x] 构建 `AswhUpCollectionBloc`，管理任务列表、采集记录、托盘信息、二维码状态、选中项、缓存数据等。
- [x] 实现扫码状态机：
  - [x] 托盘扫描 `$TP$`，校验托盘并查询容量，处理绑定逻辑。
  - [x] 物料二维码 `MC`，调用 `getPmMaterialInfoByQR` 与 `GetMatControl` 校验任务、子库、供应商、重复采集。
  - [x] 数量输入，校验任务剩余、托盘容量/重量、一致性，并更新 `stocks`、`dicMtlQty`、`dicSeq`。
- [x] 调用 `getIntaskitemList` 初始化任务明细，根据 `protype` 决定校验规则，读取并写入 Hive 缓存。
- [x] 配置底部按钮：
  - [x] “采集结果” 跳转 `/aswh-up/collect/result`。
  - [x] “组盘提交” 调用 `CommitUpShelves`、`CommitUpWmsToWcs`，成功后清理缓存。
  - [x] “更多” 菜单包含异常处理、查询提交、查询指令、托盘上架逻辑。
- [x] 返回时检测未提交采集记录并确认退出。
- [x] 统一 Loading/SnackBar 提示与扫码异常处理。

## 4. 采集结果页（`aswhUpCollectDetail.nvue` → `AswhUpCollectionResultPage`）
- [x] 展示当前缓存的 `stocks` 列表，支持多选删除，删除同步更新主采集页状态与 Hive 缓存。
- [x] 使用 `CommonDataGrid` 渲染列（托盘号、物料编码、任务数量、采集数量、批次、序列、子库、库房、任务号、任务明细 ID）。
- [x] 删除完成后派发 `AswhUpCollectionBloc` 事件回退数量、清理 `dicSeq` 并写入缓存。

## 5. 组盘提交结果页（`aswhUpPalletItem.nvue` → `AswhUpPalletItemPage`）
- [x] 当 `stocks` 为空后允许访问，根据托盘号查询已提交记录并显示列表。
- [x] 在服务层实现 `getPalletItemByTaskID(trayNo)`，页面加载后请求数据。
- [x] 提供返回上一页功能，无需编辑操作。

## 6. WMS→WCS 指令列表页（`aswhUpWmsToWcs.nvue` → `AswhUpWmsToWcsPage`）
- [x] 构建指令列表界面，列包含托盘号、起始/目标地址、堆垛机号、发送时间、状态、重量/高度等级、任务号、凭证号、任务/指令 ID 等，底部按钮展示撤销/刷新操作。
- [x] 实现 `getWmsToWcsByTaskID(taskComment, taskId, taskType)` 数据加载及刷新。
- [x] 撤销指令按钮当前提示“接口暂未对接”，待后端接口确认后补充实际调用。

## 7. 组盘接收列表页（`aswhUpReceive.nvue` → `AswhUpReceivePage`）
- [x] 参考 `GoodsUpReceivePage` 创建页面，列表展示任务信息，操作列跳转接收明细页，AppBar 返回主界面。
- [x] 建立 `AswhUpReceiveBloc` 管理分页查询，查询参数包含 `userId='ALL'`、当前角色 ID、`roomTag=1`。
- [x] 扫码写入搜索关键字后加载数据，无结果时提示用户。

## 8. 组盘接收明细页（`aswhUpReceiveDetail.nvue` → `AswhUpReceiveDetailPage`）
- [x] 布局包含扫描输入、数据表、底部操作栏（全选/取消 + 接收），扫描支持 `MC` 与 `$KW$` 判断。
- [x] `AswhUpReceiveDetailBloc` 处理明细加载、选中、提交接收，调用 `CommitRCInTaskItem` 完成接收并刷新列表。
- [x] 接收完成后返回上一页并通知接收列表刷新。
- [x] 统一错误提示、Loading 状态和扫码异常弹窗。

## Testing
- [ ] 运行必要的单元测试、集成测试或手动验证，确保模块功能符合预期。
