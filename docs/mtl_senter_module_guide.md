# Flutter 拉式发料模块使用说明

本指南概述 `lib/modules/mtl_senter` 下拉式发料功能的架构、依赖与自测流程，便于后续维护人员快速上手。

## 模块概览
- **入口路由**：`/mtl-senter`，在 `AppModule` 中注册，并由首页卡片进入。
- **核心页面**：`MtlSenterCollectionPage`，覆盖库位扫码、物料扫码、数量输入、明细列表、删除与提交。
- **状态管理**：`MtlSenterCollectionBloc` 负责扫码顺序控制、库存校验、提交工作流。
- **服务层**：`MtlSenterService` 对接接口
  - `getPmMaterialInfoByQR`
  - `getLSMtlRepertoryByStoresiteNo`
  - `getMtlQtyByMtlCode`
  - `commitMtlSender`
- **数据模型**：`mtl_senter_models.dart` 基于 `freezed` 生成不可变实体和 JSON 序列化代码。

## 依赖与命令
- 依赖：`bloc`、`flutter_bloc`、`dio`、`freezed_annotation`、`json_serializable`、`uuid`。
- 代码生成：
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- 单元测试：
  ```bash
  flutter test test/modules/mtl_senter
  ```
- 分析工具：
  ```bash
  flutter analyze
  ```

## 自测清单
1. 执行 `flutter analyze`，关注新增告警或格式问题。
2. 运行 `flutter test test/modules/mtl_senter`，确保 BLoC 和 Service 测试通过。
3. 如调整模型或 DTO，需要重新执行 `build_runner` 并提交生成文件。
4. 手动验证扫码流程：库位 → 物料 → 数量，确认库存超限时的错误提示。
5. 提交成功后返回首页或继续采集，确认状态已清空。

## 常见问题
- **数量超限提示**：检查 `availableQty` 来源，必要时调用 `fetchInventoryByLocation` 重新同步库存。
- **接口错误信息**：`MtlSenterService.commitSender` 会抛出后端返回的 `msg`，UI 层需弹出 `SnackBar` 或对话框提示。
- **焦点丢失**：使用 `MtlSenterResetStatus` 与 `MtlSenterFocusConsumed` 事件控制输入框焦点，避免扫码后无法继续输入。

## 相关文档
- `docs/refactor_todos/mtlsenter_todo.md`：重构任务清单与进度标记。
- `api.md`：接口字段及示例。
- UniApp 参考：`GlodWind-Wms-App/pages/mtlsenter/mtlSenterTaskItem.nvue`。
