# 接收明细页重构 TODO（原 `pages/arrive_sign/task_receive/receive_detail.nvue`）

## 目标
- 展示待接收到货单的明细列表，并支持扫码物料二维码过滤。
- 与接收到货任务列表联动，保持 Flutter 架构风格。

## 待办清单
### 路由与依赖
- [x] 在 `arrival_sign_module.dart` 中注册 `/arrival-sign/receive/detail` 路由，接收 `arrivalsBillId`。
- [x] 通过依赖注入获取 `ArrivalSignService` 与 `ScannerController`。

### 数据模型
- [x] 复用 `ArrivalSignDetail` 与 `ArrivalSignDetailQuery` 模型（与明细页共享）。
- [ ] 若过滤条件不同，可扩展 `ArrivalSignDetailQuery` 增加 `mode` 或 `isReceiveMode` 标记。

### 状态管理
- [x] 可复用 `ArrivalSignDetailBloc`，或创建 `ArrivalReceiveDetailCubit`：
  - 事件：加载明细、分页切换、扫码过滤、清除过滤。
  - 状态：包含 `List<ArrivalSignDetail>`、`currentPage`、`totalPages`、`loading`、`error`、`scanFilter`。
- [x] 处理扫码逻辑：
  - 接收 `ScannerWidget` 回调。
  - 若扫码内容包含 `MC`，调用 `getMaterialInfoByQr` 获取物料编码并作为 `searchKey`。
  - 无效扫码时弹窗提示。

### UI 实现
- [x] `CustomAppBar` 标题“到货任务接收明细”，左上角返回按钮返回接收列表。
- [x] 顶部加入 `ScannerWidget`/输入框（placeholder“请扫描单号/物料二维码”），成功后触发过滤。
- [x] 使用 `CommonDataGrid` 渲染列（与 detail 页一致）。
- [x] 支持分页。

### 提示 & 校验
- [x] 扫码错误/空值提示沿用 `LoadingDialogManager`。
- [x] 数据为空时显示 Toast/空态提示。

### 导航
- [x] 返回时清理扫码监听、重置 bloc 状态（必要时）。

### 测试
- [ ] Bloc 测试：扫码成功 -> 过滤列表、扫码失败 -> 错误状态。
- [ ] Widget 测试：表格渲染、分页交互。
