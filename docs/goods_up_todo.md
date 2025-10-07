# 平库上架 Flutter 模块重构 TODO

> 注：复用 UniApp `pages/goodsup` 与 Flutter 出库模块 (`lib/modules/outbound`) 的实现方式。完成每一项后请勾选复选框并补充必要的备注或关联提交。

## 1. 模块与导航搭建
- [x] 在 `lib/modules` 下创建 `goods_up` 目录，新增 `GoodsUpModule`，按照出库模块的依赖注入和路由组织注册任务列表、明细、采集、接收等页面所需的服务与 BLoC，提供 `/`, `/list`, `/detail/:inTaskId`, `/collect/:inTaskNo`, `/collect/result`, `/receive`, `/receive/detail/:inTaskId` 等子路由。
- [x] 在 `AppModule` 中通过 `r.module('/goods-up', module: GoodsUpModule())` 注册新模块，并在主页功能格中将“平库入库”卡片跳转到 `/goods-up`；保留“加号”按钮进入接收列表的行为以匹配 UniApp 版本的导航流程。

## 2. 数据模型与持久化
- [x] 依据 UniApp 列表字段（如 `intaskid/intaskno/parname/taskcomment`）定义 `InboundTask`、`InboundTaskQuery`、`InboundTaskListData` 等 Freezed/JSON 模型；结构可参考现有 `OutboundTask` 实现，注意替换字段名与查询参数拼写。
- [x] 为上架明细创建 `InboundTaskItem`、`InboundTaskItemQuery`、列表响应等模型，覆盖 `qty/collectedqty/batchno/sn/subinventoryCode` 等字段和分页参数，用于 BLoC 和网格展示。
- [x] 设计采集场景的 `InboundCollectTaskItem`、`InboundBarcodeContent`、`InboundCollectionStock` 等数据结构，增加保质期 (`vdays`)、生产日期 (`pdate`) 等字段，满足 UniApp 采集页的界面展示与校验。（`lib/modules/goods_up/collection_task/models/inbound_collection_models.dart`）
- [x] 为新的 Hive 实体（采集明细、扫码缓存、采集结果等）分配未占用的 `typeId`，在应用初始化处注册适配器，并沿用 `collection_cache_<taskId>` 风格的本地缓存键名以支持离线续采功能。（typeId=3/4/5 已注册于 `main.dart`）

## 3. 服务层封装
- [x] 新建 `GoodsUpTaskService`，仿照 `OutboundTaskService` 封装 `getInboundTaskList`、`getInboundTaskItemList`、`getMaterialInfoByQR`、`commitInboundTaskItems` 等方法；所有 HTTP 请求应复用 `DioClient`，并通过 `ApiResponseHandler` 统一解析。
- [x] 根据 UniApp `goodsUp.js` 实现额外接口：`getStoreSiteByRoom`、`getMtlRepertoryByStoresiteNo`、`GetRepertoryBySiteNoMatCode`、`CommitUpShelves`、`CommitRCInTaskItem`、`CommitTransfer`、`CommitRCInTaskPalletNo` 等，以便完成库位校验、库存核对、上架提交、接收/撤销、托盘操作等业务流程。（`GoodsUpTaskService` 新增方法）
- [x] 将入库相关 API 文档映射到新服务的方法签名（请求体、查询参数、响应解析），确保 `/system/terminal/inList`、`/system/terminal/commitUpShelves` 等端点的参数与返回值覆盖完整业务需求。（服务层补充文档注释与参数模型）

## 4. 入库任务列表
- [x] 复制 `OutboundTaskBloc` 的模式实现 `InboundTaskBloc`，支持扫码搜索、完成状态切换、分页加载，并通过 `CommonDataGridBloc` 提供表格数据；默认查询需传入上架场景的用户、角色与 `roomTag` 参数。
- [x] 编写 `GoodsUpTaskListPage`，复用 `CustomAppBar`、`ScannerWidget`、`CommonDataGrid`，展示操作列（采集/明细按钮）、任务字段及分页信息；点击采集导航到 `/goods-up/collect/:inTaskNo`，点击明细进入 `/goods-up/detail/:inTaskId`，右上角按钮跳转至接收列表。

## 5. 入库任务明细
- [x] 创建 `InboundTaskDetailBloc`，参照出库明细 BLoC 完成扫码搜索、选中行撤销、刷新等逻辑，并连接新服务的 `getInboundTaskItemList`、`commitInboundTaskItems` 接口。
- [x] 实现 `GoodsUpTaskDetailPage`，沿用 `ScannerWidget` + `CommonDataGrid` + 批量操作栏的布局，呈现 `matcode/storesiteno/qty/batchno/sn` 等列并支持全选、删除、扫码过滤，与 UniApp 明细页行为一致。

## 6. 上架采集工作流
- [x] 新建 `InboundCollectionBloc`，在初始化时加载任务明细、查询物料控制、维护扫描步骤（库位→物料→数量）与校验模式，复用 Hive 缓存与本地状态字典（`dicSeq/dicMtlQty/dicInvMtlQty`）管理采集进度；需要扩展状态以记录有效期、生产日期等附加字段。
- [x] 创建 `GoodsUpCollectionPage`，比照出库采集页构建信息卡、Tab 切换（任务列表/正在采集）、扫码输入框、底部操作按钮（采集结果、提交、异常上报）；在 UI 上展示库存、批次、序列、有效期/生产日期等信息，并为提交按钮调用 `CommitUpShelves`。
- [x] 在提交事件中组装 `upShelvesInfos` 与 `itemListInfos` 数据结构，匹配后台接口字段（任务 ID、库位、数量、批次、序列等），并处理返回结果提示及缓存清理。

## 7. 采集结果与本地缓存
- [x] 参考 UniApp 采集结果页的行为，实现 `GoodsUpCollectionResultPage`：加载 Hive 中的采集快照、支持多选删除、回传被删除条目并更新主界面；复用 `CommonDataGrid` 与删除确认弹窗。
- [x] 在 BLoC 中完成缓存读写（`stocks`、`detailList`、序列映射等），并在返回采集页时根据删除结果更新数量、同步本地缓存，保持与 UniApp 本地存储逻辑一致。

## 8. 入库任务接收
- [x] 依据 `ReceiveTaskBloc`/`ReceiveTaskDetailBloc` 模式开发 `InboundReceiveTaskBloc` 与 `InboundReceiveTaskDetailBloc`，使用新服务的 `getIntaskList`、`getIntaskitemList`、`CommitRCInTaskItem` 接口完成扫码过滤、选中接收与刷新动作。（`lib/modules/goods_up/task_receive/bloc/*`）
- [x] 构建 `GoodsUpReceivePage` 与 `GoodsUpReceiveDetailPage`，复用列表页面的扫描输入、`CommonDataGrid` 和批量操作栏，实现明细全选/取消、批量接收以及扫码过滤，与 UniApp 接收 UI 对齐。（`lib/modules/goods_up/task_receive`）

## 9. 扩展能力与共享逻辑
- [x] 在服务层补充托盘相关接口（如 `getInTaskPalletNoByUserID`、`CommitRCInTaskPalletNo`）和消息通知方法，为后续立库或异常处理场景预留扩展点；若暂未使用，可在模块初始化时按需懒加载。（`GoodsUpTaskService` 新增托盘与公告消息查询接口）
- [x] 评估出入库模块之间可复用的组件（网格列配置、批量操作栏、异常处理弹窗等），在 `common_widgets` 或共享配置目录抽象公共逻辑，减少重复代码。（新增 `SelectionActionBar`，两端共用）

## 10. 测试与文档
- [x] 为新服务编写单元测试（验证参数映射、错误处理、响应解析），并为关键 BLoC（任务列表、采集、接收）添加状态流转用例，覆盖扫码搜索、分页、提交成功/失败等场景。（`test/modules/goods_up/services/goods_up_task_service_test.dart`、`test/modules/goods_up/task_receive/inbound_receive_bloc_test.dart`）
- [x] 更新 README 或内部文档，说明平库上架模块的路由入口、主要工作流、需要执行的代码生成命令（如 `flutter pub run build_runner build`），并在 API 文档中标记 Flutter 端对各接口的实现状态。（README 新增模块导航与测试说明）
