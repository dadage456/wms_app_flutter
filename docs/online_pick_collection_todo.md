# Flutter 在线拣选采集修复 TODO

> 对比 UniApp 版本 `GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue` 与 Flutter 模块 `lib/modules/aswh_down/collection_task` 后整理的修复任务。每项完成后请将复选框标记为已完成。

- [x] **统一扫描步骤判断逻辑**
  Flutter 端当前按 `$KW$ → $TP$ → 数量 → 物料` 的顺序解析，并且数量必须以 `$` 结尾，导致托盘开场扫描、纯数字数量输入无法通过判定。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L171-L244】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L775-L819】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L714-L743】
  - 调整 `_detectCodeType` 与占位提示，支持 UniApp 相同的“托盘→二维码→数量”节奏，并接受纯数字数量。
  - 在托盘扫描时自动回填库位，而不是强制额外扫描 `$KW$`。
  - ✅ 已切换默认步骤为托盘扫描，托盘解析会回填库位并在未匹配托盘时给出 UniApp 同款错误提示；数量解析接受纯数字输入并保持提示语一致。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L178-L242】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart†L22-L28】

- [x] **补齐托盘与库位合法性校验**
  UniApp 会校验托盘是否存在于任务、并据托盘反查库位；Flutter 端仅记录原始字符串，缺少任何合法性验证。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L252-L308】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L1348-L1386】
  - 引入 `taskItems` 数据校验托盘是否存在，并填充/验证库位。
  - 失败时沿用 UniApp 的明确错误提示（如“任务明细中不存在托盘号…”）。
  - ✅ 托盘与库位扫描均通过任务明细反查合法性；扫描库位时若与现有托盘不匹配会提示“托盘所属库位...请核对”，扫描托盘时若与已选库位不一致会提示“托盘应在库位...”；均在成功后自动回填库位并持久化快照。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L183-L243】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L796-L822】

- [x] **串号与批次重复采集防护**
  UniApp 通过 `dicSeq` 与遍历 `stocks` 阻止同一物料串号重复采集；Flutter 仅在聚合时记录 `serialMap`，并未在入库前判重。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L262-L319】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L714-L798】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L780-L820】
  - 在 `_finalizeCollection` 之前检查新串号/批次是否已存在，保持与 UniApp 相同的错误文案。
  - ✅ 新增 `_duplicateCollectionError` 复用任务缓存和历史采集记录判重；重复串号分别返回“序列号不允许重复采集，请确认”与“库位已经采集,不允许重复采集”提示，批次重复则提示“批次…已经采集，不允许重复”，完成后阻断采集流程并维持扫码焦点。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L286-L318】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L734-L793】

- [x] **补充库存/ERP 子库一致性校验**
  UniApp 扫描托盘与二维码后会调用多种 `getMtlRepertory*` 接口，对库存数量、ERP 子库一致性、批次存在性做校验；Flutter 当前未调用对应 `AswhDownCollectionService` 方法，导致缺乏关键业务约束。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L243-L306】【F:lib/modules/aswh_down/services/aswh_down_collection_service.dart†L41-L118】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L1387-L1508】
  - 根据物料控制模式调用相应接口校验库存、批次及子库。
  - 校验失败时抛出与 UniApp 一致的详细提示，阻止继续采集。
  - ✅ `_performInventoryValidation` 针对序列号/批次分别调用库存接口，复用“当前物料明细指定子库…”等错误文案，并将校验结果写回采集记录的 ERP 子库。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L391-L487】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L891-L1035】【F:lib/modules/aswh_down/services/aswh_down_collection_service.dart†L72-L123】

- [x] **数量校验与配额分摊**
  UniApp 在录入数量时会校验 >0、不得超过剩余库存与任务剩余额、并按任务明细拆分累计；Flutter 直接累加数量，无任何上限控制。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L246-L305】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L1581-L1718】
  - 复刻“可采集数量/库存余量”双重校验与提示语。
  - 维护任务明细的累计采集量，以支持与服务端的 `mtlQty` 结构保持一致。
  - ✅ `_quantityValidationError` 在批次/库位粒度累计已采集数量、扣除结余录入并提示“本次采集数量…大于剩余可采集数量”等中文文案；同时 `_finalizeCollection` 在校验失败时恢复扫码焦点，保持 UniApp 行为。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L441-L519】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L1038-L1116】

- [x] **库存核对数据结构对齐**
  UniApp 将核对结果写入 `detailListViewCheck`，并在提交前逐条校验是否缺少结余；Flutter 仅以 `inventoryQtyMap` 记录，缺少对应物料/托盘展示与“物料没有采集结余库存”类提示。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L400-L447】【F:lib/modules/aswh_down/collection_task/online_pick_collection_page.dart†L262-L354】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L2124-L2162】
  - 参照 UniApp 构建核对明细列表，并补充缺失提示。
  - ✅ `OnlinePickCollectionState` 引入 `inventoryCheckDetails`，Hive 快照和 `_inventoryCheckDetailMap` 保留核对条目，提交前校验“物料…没有采集结余库存”，并在核对弹窗中展示与编辑结余明细。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart†L20-L72】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L118-L232】【F:lib/modules/aswh_down/collection_task/online_pick_collection_page.dart†L86-L223】

- [x] **错误提示一致性梳理**
  Flutter 端大量使用通用“操作失败”或“提交失败”提示，缺乏 UniApp 对应的业务语句（如“物料…不在任务明细中，请核实”）。【F:lib/modules/aswh_down/collection_task/online_pick_collection_page.dart†L60-L86】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L563-L602】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L721-L1705】
  - 收集 UniApp 中的关键错误提示并在对应校验失败时复用。
  - 统一 LoadingDialog/SnackBar 的提示语，避免与原系统不一致。
  - ✅ 托盘、拣选口、库存校验均改用 UniApp 原文提示（如“物料【】在库位【】没有采集结余库存，请采集后提交！”、“拣选口位置不能为空”、“采集数据未提交,不允许查看指令！”），并针对 WCS 指令动作输出成功/失败语句，与 LoadingDialog 行为保持一致。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L708-L900】【F:lib/modules/aswh_down/collection_task/online_pick_collection_page.dart†L354-L430】

- [x] **采集模式与功能按钮缺失补齐**
  UniApp 底部菜单包含“采集模式、查询指令、空盘出/入库、托盘确认、回库、全部托盘”等操作；Flutter 仅保留“采集结果 / 库存核对 / 提交”，其余功能缺失。【F:lib/modules/aswh_down/collection_task/online_pick_collection_page.dart†L107-L190】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L248-L320】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L2060-L2196】
  - 评估并迁移缺失的功能入口或提供替代交互，保持流程完整。
  - ✅ 底栏新增“更多”菜单，包含拣选口选择、查询指令及空盘/来料/回库指令，BLoC 实现 `commitEmptyTrayWmsToWcs`、`commitDownWmsToWcs`、`commitResetWmsToWcs` 调度及托盘数量输入逻辑，补齐 UniApp 菜单功能。【F:lib/modules/aswh_down/collection_task/online_pick_collection_page.dart†L318-L444】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L232-L400】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart†L49-L99】

- [x] **缓存快照结构扩展**
  UniApp 会将采集任务、库存核对、序列映射等多项数据持久化；Flutter `OnlinePickCollectionCacheSnapshot` 未保存 `inventoryQtyMap` 之外的核对详情与任务列表修改标记，恢复场景可能丢信息。【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L86-L174】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L500-L540】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L632-L704】【F:GlodWind-Wms-App/pages/aswhdown/task_collect/aswhDownTaskItem.nvue†L2098-L2148】
  - 扩展快照模型以保存核对清单、更新标记等信息，并在恢复时完整还原。
  - ✅ `OnlinePickCollectionCacheSnapshot` 新增 `inventoryChecks` 与 `destination` 字段，Hive 适配器/Freezed 模型、`_restoreSnapshot` 和 `_persistSnapshot` 同步更新，保证结余核对与拣选口在恢复后完整还原。【F:lib/modules/aswh_down/models/online_pick_collection_models.dart†L137-L213】【F:lib/modules/aswh_down/models/online_pick_collection_models.g.dart†L138-L207】【F:lib/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart†L108-L218】


- [x] **WCS 指令流程测试补齐**
  针对空盘出入库、批量托盘指令新增 Bloc 单元测试，覆盖成功/失败分支，确保状态与错误提示与 UniApp 一致。
  - ✅ `online_pick_collection_bloc_wcs_test.dart` 模拟 Hive 快照与服务响应，校验 `_onEmptyTray*Requested` 及 `_onAllTrayRequested` 事件的状态输出与请求参数。【F:test/modules/aswh_down/collection_task/online_pick_collection_bloc_wcs_test.dart†L1-L208】

- [x] **采集页面交互测试补齐**
  为“更多”操作栏与库存核对弹窗添加 Widget 测试，验证缺失功能入口与结余记录渲染逻辑。
  - ✅ `online_pick_collection_page_more_test.dart` 覆盖操作栏指令触发与库存核对弹窗的数据回填、保存事件。【F:test/modules/aswh_down/collection_task/online_pick_collection_page_more_test.dart†L1-L173】
