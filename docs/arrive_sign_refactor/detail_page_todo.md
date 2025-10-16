# 到货任务明细页重构 TODO（原 `pages/arrive_sign/detail.nvue`）

## 目标
- 基于 Flutter 页面展示到货单明细，沿用 `CommonDataGrid` 表格体验。
- 支持分页、扫码刷新、从列表页带参跳转、返回列表。

## 待办清单
### 路由与依赖
- [x] 在 `arrival_sign_module.dart` 中注册 `/arrival-sign/detail` 路由，接收 `arrivalsBillId` 参数，保持与出库明细页路由风格一致。
- [x] 提前在模块注入 `ArrivalSignService` 供 bloc 使用。

### 数据模型（Freezed）
- [x] 使用 `freezed` 定义 `ArrivalSignDetail` 模型，字段覆盖原始列（matcode、qty、goodqty、batchno、sn、subinventoryCode、posnr、matname、parname、matcodecontrol、orderno、arrivalsBillno、pdate、vdays 等）。
- [x] 定义 `ArrivalSignDetailQuery`（含分页参数）与 `ArrivalSignDetailPage`（total/rows）。

### 服务层
- [x] 在 `ArrivalSignService` 内新增 `getArrivalSignDetails(ArrivalSignDetailQuery)` 调用 `/system/terminal/arriveSignDetailList`。
- [x] 支持可选 `searchKey` 用于扫码过滤。

### 状态管理
- [x] 创建 `ArrivalSignDetailBloc`（或使用 `CommonDataGridBloc<ArrivalSignDetail>` 包装），事件包括：初始化加载、分页切换、刷新。
- [x] 使用 `freezed` 定义事件与状态，状态需保存 `currentPage`、`totalPages`、`loading`、`errorMessage`、`details`。

### UI 实现
- [x] 构建 `ArrivalSignDetailPage`，包含：
  - `CustomAppBar` 标题“到货任务明细”，返回按钮 `Navigator.pop`。
  - `CommonDataGrid` 渲染列头，与 uni-app 顺序保持一致。
  - 底部分页器（可使用 `CommonDataGrid` 自带分页功能或手动 `PaginationFooter`）。
- [x] 如果需要扫码过滤，复用 `ScannerWidget`（可隐藏在 AppBar actions 或顶部输入框）。
- [x] Loading/空态/错误使用 `LoadingDialogManager` 与 `CommonDataGrid` 状态统一处理。

### 导航交互
- [x] 确保从列表页传入的 `arrivalsBillId` 正确注入到 bloc query，首屏自动加载。
- [x] 返回时无需额外确认；保留页面 pop 即可。

### 校验
- [x] 数据为空时提示“当前任务列表没有待处理任务！”（可用 `SnackBar` 或空态组件）。
- [x] 捕获服务异常并弹出错误提示。

### 测试
- [ ] Bloc 单元测试：校验初始加载成功/失败、分页切换逻辑。
- [ ] Widget 测试：验证表头渲染、空态展示。
