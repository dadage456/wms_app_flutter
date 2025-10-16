# 接收到货任务列表页重构 TODO（原 `pages/arrive_sign/task_receive/index.nvue`）

## 目标
- 在 Flutter 中实现待接收到货单列表，支持扫码搜索、分页、接收单据、跳转到接收明细。
- 参考“平库出库-任务接收”页面（`lib/modules/outbound/task_receive`）。

## 待办清单
### 模块与路由
- [x] 在 `arrival_sign_module.dart` 中注册 `/arrival-sign/receive` 路由。
- [x] 将页面注入模块依赖的 bloc/service。

### 数据模型（Freezed）
- [x] 定义 `ArrivalReceiveTask` 模型，字段包括：orderno、poNumber、createdate、arrivalsBillno、werks、parname、arrivalsBillid 等。
- [x] 定义 `ArrivalReceiveTaskPage`（total/rows）。

### 服务层
- [x] 在 `ArrivalSignService` 添加 `getArrivalUnSignList(query)`（接口 `/system/terminal/arriveUnSignList`）。
- [x] 添加 `receiveArrivalOrder(String arrivalsBillId)`（接口 `/system/terminal/receArriveSign`）。

### 状态管理
- [x] 创建 `ArrivalReceiveBloc`（可复用 `CommonDataGridBloc`）：
  - 事件：初始化加载、扫码/文本搜索、分页切换、接收单据、刷新。
  - 状态：记录任务列表、分页信息、加载/错误、最近操作结果。
- [x] 接收成功后刷新列表并提示成功。

### UI 实现
- [x] 构建 `ArrivalReceivePage`：
  - `CustomAppBar` 标题“接收到货任务”。
  - 顶部 `ScannerWidget` 供扫码搜索。
  - `CommonDataGrid` 渲染列头，与 uni-app 表格对应。
  - 操作列包含“接收”“明细”两个按钮：
    - 点击“接收” -> 调用 bloc 接收事件（弹出确认？若无则直接调用）。
    - 点击“明细” -> 跳转 `/arrival-sign/receive/detail`。
  - 底部分页控制。
- [x] 页面销毁时释放扫码控制器。

### 导航
- [x] 接收成功后自动回到列表并提示成功。
- [x] 明细按钮通过 `Modular.to.pushNamed('/arrival-sign/receive/detail', arguments: ...)` 跳转。

### 提示 & 校验
- [x] 空数据时显示提示“当前任务列表没有待处理任务！”。
- [x] 接收前可选弹出确认框，避免误触。
- [x] 捕获服务异常并展示错误信息。

### 测试
- [ ] Bloc 测试：加载成功/失败、接收成功。
- [ ] Widget 测试：操作列按钮触发、空态渲染。
