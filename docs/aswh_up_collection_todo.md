# 立库组盘采集整改 TODO

> 参考来源：UniApp `GlodWind-Wms-App/pages/aswhup/task_collect` 与 Flutter 平库上架模块 `lib/modules/goods_up/collection_task`

- [x] **Pass taskType=00 when validating trays**
  - Update `_service.checkBindingTrayByTask` invocation to pass `taskType: '00'` and record rationale.
  - Add regression coverage or manual验证说明。

- [x] **Block “查询提交” when local stocks exist**
  - Guard the navigation in `_showMoreOptions` to prevent entering提交界面 when `_bloc.state.stocks` 非空。
  - 重用旧流程提示文案。

- [x] **Align “查询指令” guard and taskType**
  - Mirror legacy guard for existing采集记录。
  - 调整传参 `taskType: '00'`。

- [x] **Implement “托盘上架” action**
  - 新增BLoC事件调用 `_service.commitUpWmsToWcs` 并反馈执行结果。
  - 将 UI 入口绑定到事件。

- [x] **Extend header card with material snapshot**
  - 在信息卡展示当前物料、批次/序列、数量等。
  - 对齐平库视觉结构。

- [x] **Match AppBar and tab styling to 平库上架**
  - 调整 AppBar、Tab 文案与样式。

- [x] **Restore missing task grid columns**
  - 补齐任务/库存列表必要字段，保证布局与平库一致。

- [ ] **Testing & validation**
  - 记录执行的自动化或手工测试步骤。
  - 当前容器缺少 Flutter SDK（`flutter` 命令不可用），待本地环境验证 `flutter test` 及关键手工场景。

