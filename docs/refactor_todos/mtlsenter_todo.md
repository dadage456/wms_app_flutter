# 拉式发料模块重构 TODO

## UniApp 现状
- 页面结构：单页 `pages/mtlsenter/mtlSenterTaskItem.nvue`，提供按工单/产线拉式发料的扫码提交功能。
- API 依赖：使用 `api/system/goodsUp.js` 中的 `CommitMtlSender`、`getMtlQtyByMtlCode` 等接口获取库存与提交发料信息。

## Flutter 重构策略
- **模块结构**：创建 `mtl_senter_module`，包含主采集页与历史记录（可选）。
- **逻辑复用**：
  - 采集流程可直接复用 `CollectionBloc` 的扫码、数量校验、缓存与提交机制，针对发料业务调整事件与请求结构。【F:lib/modules/outbound/collection_task/bloc/collection_bloc.dart†L1-L200】
  - Service 层参考 `CollectionService`，封装 `CommitMtlSender`、`getMtlQtyByMtlCode` 等调用，并统一错误处理。【F:lib/modules/outbound/collection_task/services/collection_service.dart†L1-L193】
- **UI 设计**：
  - 页面顶部 `CustomAppBar`，主体区域包含工单/产线选择、库位/物料扫码、数量录入、待提交列表。
  - 提供待提交明细卡片，可编辑数量/批次，支持批量提交与清空。

## 待办清单
1. 新建 `lib/modules/mtl_senter` 目录与模块入口。
2. 实现 `MtlSenterService`：
   - `CommitMtlSender`、`getMtlQtyByMtlCode`、`getStoreSiteByRoom` 等辅助接口。
3. 定义数据模型：
   - 发料任务头（工单、产线、需求时间等）。
   - 发料明细（物料、批次、需求量、实发量、库位）。
   - 提交请求结构（明细数组、过滤条件）。
4. 构建采集页：
   - 设计扫码顺序（库位→物料→数量），支持批次选择、数量验证。
   - 待提交列表支持修改/删除，提交成功后清空或保留。
   - 采用 Hive 缓存暂存未提交数据。
5. 可选：发料历史或异常记录页面。
6. 路由注册：`/mtl-senter`、`/mtl-senter/history`（可选）。
7. 测试：
   - BLoC 测试覆盖正常提交、库存不足、重复扫码、缓存恢复。
   - Service 测试验证接口参数与异常处理。
8. 文档：
   - 更新拉式发料业务说明、扫码顺序、库存校验逻辑、异常处理方案。
