# 金风 WMS Flutter 客户端

Flutter 版本的仓储管理系统应用，替换原有 UniApp 平库作业。项目已实现平库下架与上架两个核心模块，并支持扫码、表格分页、Hive 缓存等仓储业务能力。

## 模块导航
- `/outbound`：平库下架（任务列表、采集、接收、异常处理）。
- `/goods-up`：平库上架（任务列表、明细、采集、接收）。
  - `/goods-up/receive`：上架接收任务列表。
  - `/goods-up/receive/detail/:inTaskId`：接收任务明细，支持多选批量接收。
- `/mtl-senter`：拉式发料采集（库位/物料扫码、数量采集、批量提交）。

首页功能卡片会跳转到上述模块；在上架任务列表页面的右上角「接收」入口会直达接收任务列表。

## 开发与测试
1. 安装依赖：
   ```bash
   flutter pub get
   ```
2. 生成代码（如需）：
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. 运行单元测试：
   ```bash
   flutter test
   ```

本仓库在 `test/modules/goods_up` 与 `test/modules/mtl_senter` 下提供服务与采集流程的测试用例，可在本地验证 API 参数映射与状态流转。

## 相关文档
- `docs/goods_up_todo.md`：平库上架重构任务清单及完成标记。
- `api.md`：接口字段与调用说明。
