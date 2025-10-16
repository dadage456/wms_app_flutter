# 到货签收采集结果页重构 TODO（原 `pages/arrive_sign/task_collect/collect_detail.nvue`）

## 目标
- 显示并管理采集过程中生成的明细记录，可批量删除并回写任务列表缓存。
- 对接 Flutter 采集页缓存/状态管理，延续出库模块的交互体验。

## 待办清单
### 路由与依赖
- [x] 在 `arrival_sign_module.dart` 中注册 `/arrival-sign/collect/result` 路由，接收或读取共享的采集缓存。
- [ ] Bloc 可与 `ArrivalCollectBloc` 共享，或单独创建 `ArrivalCollectResultCubit` 管理选中状态。

### 数据模型
- [x] 复用 `ArrivalCollectSummary`（含 stockId、matcode、batchno、sn、collectQty、taskQty、pdate、vdays、collectFlg 等字段）。
- [ ] 若单独缓存，需要 `ArrivalCollectResultState`（列表、已选ID集合、loading、error）。

### 数据来源
- [x] 优先通过依赖注入共享 Bloc 状态；若通过持久化缓存（Hive），进入页面时加载 `stocks` 与 `detailListView` 缓存。
- [x] 确保进入页面前先同步最新缓存，以便删除后正确刷新主采集页。

-### UI 实现
- [x] 使用 `Scaffold` + `CustomAppBar` 标题“到货签收采集结果”。
- [x] 主体使用 `CommonDataGrid` 或 `DataTable` 展示列：物料编码/批次/序列/采集数量/任务数量/生产日期/有效天数/匹配情况。
- [x] 支持复选：
  - 使用 `CommonDataGrid` 的多选能力或 `CheckboxListTile` 自定义。
  - `全选/反选` 功能需映射到 Bloc 状态。
- [x] 底部操作栏提供“删除”按钮（样式参考 uni-app 蓝底按钮）。

-### 删除逻辑
- [ ] 删除前校验是否勾选记录，否则弹出 `LoadingDialogManager.showErrorDialog('请至少选择一行记录')`。
- [x] 弹窗确认删除。
- [x] 删除后：
  - 从缓存/Bloc 状态中移除对应记录。
  - 回写任务列表中 `goodqty`（减去删除的采集数量，最小 0）。
  - 更新 `updateFlag`，以便主采集页刷新。
  - 将最新数据重新持久化（Hive 或 Bloc 内存）。

### 导航
- [x] 删除完成后仍停留在页面；点击 AppBar 返回或系统返回键需通知主采集页刷新（可通过 `Navigator.pop(context, CollectResultPopData)` 返回布尔值）。

### 校验 & 提示
- [x] 提供空态提示（如“暂无采集记录”）。
- [ ] 异常捕获后弹出错误提示。

### 测试
- [ ] Bloc/状态测试：全选、单选、删除回写逻辑。
- [ ] Widget 测试：列渲染、空态展示。
