# 自动化仓库下架采集 TODO 清单

- [x] **恢复批次/库位采集后的结余强制流程**
  - 背景：UniApp 在完成批次或该库位任务采集后，会把 `checkFlg` 置为 `Y`，强制输入数字结余并把占位提示切换为“请输入该物料在当前库位的结余数量”，未输入数字时禁止继续扫描【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L579-L626】
  - 差异：Flutter 版在 `_collectOutboundQuantity` 完成后直接把占位符重置为“请扫描库位”，没有标记强制结余，`_handleQuantityScan` 也只按模式决定是否走库存核对，导致可以继续采集下一条【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L232-L267】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L358-L365】
  - 实现要点：
    - 在 `OnlinePickCollectionState` / 缓存快照中新增 `requireInventoryCheck` 等布尔字段，并确保序列化与恢复时同步。
    - `_collectOutboundQuantity` 在批次管控或当前库位物料任务量耗尽时，设置该标记、保留当前条码数据、占位文案切换为结余提示，并切换到库存核对页签。
    - `_handleQuantityScan` 在标记为真时无视当前模式直接调用 `_collectInventoryRecord`，拒绝非数字输入；库存核对成功后清除标记并恢复到库位扫描占位。
    - `_collectInventoryRecord` 成功后重置占位/步骤，同时把标记持久化到缓存。
  - 验收标准：
    - 批次物料或同库位任务完成后，界面必须要求先录入结余才能继续扫描。
    - 录入有效结余后自动回到库位扫描步骤，且缓存恢复时不会丢失该强制状态。

- [x] **提交前校验每个采集物料都录入结余**
  - 背景：UniApp 在提交前逐一检查采集清单，每个物料必须在结余列表中找到对应记录，否则阻止提交【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L1187-L1215】
  - 差异：Flutter 版 `_onSubmitCollection` 仅判断结余列表是否为空，未验证是否覆盖全部采集物料组合【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L883-L946】
  - 实现要点：
    - 在 BLoC 内新增辅助方法，按物料编码 + 托盘 + 库位（必要时批次/序列）匹配 `inventoryCheckRecords`。
    - `_onSubmitCollection` 在构造请求前调用该方法，缺失时返回错误状态并提示具体物料。
    - 为匹配逻辑添加单元测试，覆盖托盘/库位/批次等多种组合。
  - 验收标准：
    - 若任意采集物料未录入结余，提交按钮会弹出错误提示并阻止调用后端接口。
    - 所有采集物料完成结余后才能提交成功。

- [x] **提交弹窗补充未完成任务提示**
  - 背景：UniApp 会在提交确认弹窗内提示当前托盘仍有多少任务未完成，帮助操作员确认【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L1121-L1165】
  - 差异：Flutter 弹窗只展示“确认提交当前的 N 条采集记录吗？”，缺少剩余任务量信息【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L627-L671】
  - 实现要点：
    - 在 BLoC 或页面侧封装汇总逻辑，根据 `currentTrayCode` 对 `pendingCheckItems` 统计剩余数量。
    - `_confirmSubmit` 根据统计结果动态生成弹窗正文；若无剩余任务则沿用现有文案。
    - 需要时为汇总函数编写单元或 widget 测试，确保多物料、多库位场景展示正确。
  - 验收标准：
    - 当托盘仍有未完成任务时，弹窗必须准确列出物料、库位及剩余数量。
    - 托盘任务完成时弹窗文案保持原有简洁格式。

- [x] **托盘扫码自动回填库位并刷新任务**
  - 背景：UniApp 在托盘扫码后会回填任务明细中的库位编码，并按托盘刷新正在采集列表；找不到托盘时给出明确错误【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L403-L460】
  - 差异：Flutter 版 `_handleTrayScan` 仅更新托盘号和任务列表，未同步 `currentStoreSite`，导致后续流程缺少库位上下文【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L199-L229】
  - 实现要点：
    - 在 `_handleTrayScan` 中按托盘号回查 `taskItems` 的库位并写入 `currentStoreSite`，找不到时返回与旧系统一致的错误提示。
    - 托盘与库位联动后，更新 `pendingCheckItems` / `currentTrayItems` 与缓存快照，确保页面刷新后仍保持联动。
  - 验收标准：
    - 扫描托盘后界面即时展示对应库位，且下一步扫描不再提示“请先扫描库位”。
    - 托盘不存在于任务明细时弹出一致的错误文案。

- [x] **任务行匹配遵循 site/batch 强制策略**
  - 背景：UniApp 根据 `siteFlag`、`batchFlag` 等配置推导 `mtlCheckMode`，先按物料+批次+库位精确匹配，失败后按既定顺序回退，仍找不到则报错，并校验 ERP 子库一致性【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L640-L879】
  - 差异：Flutter 版 `_matchTaskItems` 仅做直接筛选，没有 `mtlCheckMode`、`siteFlag`、`batchFlag` 等状态，也缺少逐级回退与强制校验【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L470-L548】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L549-L606】
  - 实现要点：
    - 初始化任务时解析 `task.forceSite`、`task.forceBatch` 等字段，写入新的状态位并持久化到缓存。
    - 将 `_matchTaskItems` 拆分为带回退策略的方法，结合 `mtlCheckMode` 对托盘/库位/批次/序列进行分层匹配，并与 `_resolveErpRoom` 一致地校验 ERP 子库。
    - 匹配失败时抛出与 UniApp 相同的错误文案，方便操作员定位问题。
    - 为不同组合编写单元测试，确保强制与非强制模式均能得到正确匹配。
  - 验收标准：
    - 在强制库位/批次模式下，只有满足任务明细的组合才能采集成功。
    - 匹配失败时错误提示包含物料、批次、库位等关键信息。

- [x] **扫码输入框按步骤更新占位提示与键盘类型**
  - 背景：UniApp 输入框绑定 `placeholder.text` 并强制数字键盘，随着步骤切换到数量/结余时提供明确提示并阻止非数字输入【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L8-L37】
  - 差异：Flutter 页面固定 `ScannerConfig`，始终展示“请扫描条码”且使用文本键盘，无法随步骤更新提示或限制输入类型【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L149-L166】
  - 实现要点：
    - 根据 bloc 状态的 `placeholder` 与 `step` 构造 `ScannerConfig`，在数量/结余步骤切换数字键盘，其余步骤保持条码键盘。
    - 继续复用现有扫码控制器以保持自动聚焦与清空行为。
  - 验收标准：
    - 当进入数量或结余步骤时，占位提示与键盘类型同步更新为数字输入，其他步骤恢复条码提示。
    - 输入框提示与 UniApp 占位文案保持一致。

- [x] **信息卡补充当前物料与库存概览**
  - 背景：UniApp 顶部卡片实时展示库存、托盘、库位、物料编码/名称、采集数量与结余数量，便于操作员核对【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L19-L48】
  - 差异：Flutter 信息卡仅显示任务、库房、工位等基础信息，缺少当前库位、可用库存及条码相关采集/结余统计【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L169-L230】
  - 实现要点：
    - 在信息卡中补充当前库位与可用库存 chips，并新增“当前物料信息”段落，聚合条码对应的批次/序列、已采集数量和结余数量【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L169-L230】【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L780-L858】
    - 当尚未扫描条码时展示“-”占位符，避免误导。
  - 验收标准：
    - 扫描物料后，信息卡同步显示该物料的批次/序列、累计采集量与已录入结余量。
    - 未有条码上下文时，卡片保持灰色占位符。

- [x] **全部托盘默认数量与 UniApp 对齐**
  - 背景：UniApp 的 `palletnum.calling_num` 默认值为 10，全部托盘指令弹窗也以 10 作为默认数量【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L420-L448】
  - 差异：Flutter 弹窗默认值为 1，且取消后未恢复默认，导致与旧版行为不一致【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L38-L40】【F:lib/modules/aswh_down/collection_task/pages/online_pick_collection_page.dart†L620-L652】
  - 实现要点：
    - 初始化托盘数量输入框为 10，弹窗打开时在无选中行的情况下使用 10 作为默认值，并在取消后重置回 10。
    - 提交时若用户输入为空或非法，回退到默认数量。
  - 验收标准：
    - 未选择任务行时直接点击“全部托盘”会以下发数量 10 触发事件。
    - 取消或关闭弹窗后默认值保持为 10。
