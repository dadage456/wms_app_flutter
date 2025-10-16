
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../task_list/models/inventory_task.dart';
import 'bloc/aswh_inventory_collect_bloc.dart';
import 'bloc/aswh_inventory_collect_enums.dart';
import 'bloc/aswh_inventory_collect_event.dart';
import 'bloc/aswh_inventory_collect_state.dart';
import 'models/inventory_collect_models.dart';

class AswhInventoryCollectPage extends StatefulWidget {
  const AswhInventoryCollectPage({super.key});

  @override
  State<AswhInventoryCollectPage> createState() =>
      _AswhInventoryCollectPageState();
}

class _AswhInventoryCollectPageState
    extends State<AswhInventoryCollectPage> {
  String? _taskId;
  InventoryTaskSummary? _taskSummary;
  bool _routeBound = false;
  late final TextEditingController _scanController;
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _scanController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _scanController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_routeBound) {
      return;
    }

    final args = Modular.args;
    _taskId = args.params['taskId'];

    final payload = args.data;
    if (payload is Map && payload['task'] is Map) {
      final taskJson = Map<String, dynamic>.from(
        payload['task'] as Map,
      );

      final summary = InventoryTaskSummary.fromJson(taskJson);
      final query = InventoryTaskItemQuery(
        taskComment: summary.taskComment,
        checkTaskNo: summary.checkTaskNo,
        checkTaskId: summary.checkTaskId?.toString(),
      );

      context.read<AswhInventoryCollectBloc>().add(
            AswhInventoryCollectStarted(
              query: query,
              taskKey: summary.checkTaskId?.toString() ?? summary.checkTaskNo,
            ),
          );

      setState(() {
        _taskSummary = summary;
        _routeBound = true;
      });
    } else {
      setState(() {
        _routeBound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AswhInventoryCollectBloc, AswhInventoryCollectState>(
      listenWhen: (previous, current) =>
          previous.message != current.message ||
          previous.popup != current.popup,
      listener: (context, state) {
        final message = state.message;
        if (message != null && message.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            );
        }

        final popup = state.popup;
        if (popup != null) {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(popup.title),
              content: Text(popup.message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context
                        .read<AswhInventoryCollectBloc>()
                        .add(const AswhInventoryCollectPopupClosed());
                  },
                  child: const Text('确定'),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state.isSubmitting;
        final isLoading = state.isLoading && state.taskItems.isEmpty;

        return Scaffold(
          appBar: AppBar(title: const Text('立库盘点采集')),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTaskInfo(context, state),
                        const SizedBox(height: 12),
                        _buildStepIndicator(context, state),
                        const SizedBox(height: 12),
                        _buildScanInput(context, state),
                        if (state.currentStep ==
                            AswhInventoryCollectStep.quantityInput)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: _buildQuantityInput(context, state),
                          ),
                      ],
                    ),
                  ),
                  _buildTabHeader(context, state),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildTabBody(context, state),
                    ),
                  ),
                  _buildBottomBar(context, state),
                ],
              ),
              if (isLoading || isSubmitting)
                Container(
                  color: Colors.black45,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 12),
                        Text(
                          isSubmitting ? '正在提交采集结果' : '数据加载中',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskInfo(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    final summary = _taskSummary;
    if (summary == null) {
      return Text(
        '任务编号: ${_taskId ?? '-'}',
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    final pickLocation = state.selectedPickLocation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '盘库单号: ${summary.taskComment}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text('任务号: ${summary.checkTaskNo}'),
        if (summary.storeRoomName != null)
          Text('库房: ${summary.storeRoomName} (${summary.storeRoomNo})'),
        if (summary.workStation != null && summary.workStation!.isNotEmpty)
          Text('拣选工位: ${summary.workStation}'),
        if (pickLocation != null)
          Text('拣选口: ${pickLocation.displayName ?? pickLocation.code ?? '-'}'),
      ],
    );
  }

  Widget _buildStepIndicator(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    final steps = {
      AswhInventoryCollectStep.trayScan: '扫描托盘',
      AswhInventoryCollectStep.siteScan: '扫描库位',
      AswhInventoryCollectStep.materialScan: '扫描物料',
      AswhInventoryCollectStep.quantityInput: '录入数量',
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: steps.entries
          .map(
            (entry) => Chip(
              label: Text(entry.value),
              backgroundColor: entry.key == state.currentStep
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceVariant,
            ),
          )
          .toList(),
    );
  }

  Widget _buildScanInput(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    final hintText = switch (state.currentStep) {
      AswhInventoryCollectStep.trayScan => '请扫描托盘条码',
      AswhInventoryCollectStep.siteScan => '请扫描库位条码',
      AswhInventoryCollectStep.materialScan => '请扫描物料条码',
      AswhInventoryCollectStep.quantityInput => '请输入采集数量',
    };

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _scanController,
            decoration: InputDecoration(
              labelText: '扫码输入',
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              _scanController.clear();
              context
                  .read<AswhInventoryCollectBloc>()
                  .add(AswhInventoryCollectScanCaptured(value));
            },
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () {
            final value = _scanController.text.trim();
            _scanController.clear();
            if (value.isNotEmpty) {
              context
                  .read<AswhInventoryCollectBloc>()
                  .add(AswhInventoryCollectScanCaptured(value));
            }
          },
          child: const Text('确认'),
        ),
      ],
    );
  }

  Widget _buildQuantityInput(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _quantityController,
            decoration: const InputDecoration(
              labelText: '采集数量',
              hintText: '请输入采集数量',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (value) {
              final qty = double.tryParse(value.trim());
              if (qty != null) {
                _quantityController.clear();
                context
                    .read<AswhInventoryCollectBloc>()
                    .add(AswhInventoryCollectQuantityEntered(qty));
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () {
            final qty = double.tryParse(_quantityController.text.trim());
            if (qty != null) {
              _quantityController.clear();
              context
                  .read<AswhInventoryCollectBloc>()
                  .add(AswhInventoryCollectQuantityEntered(qty));
            }
          },
          child: const Text('录入'),
        ),
      ],
    );
  }

  Widget _buildTabHeader(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('任务列表'),
            selected: state.activeTab == AswhInventoryCollectTab.taskList,
            onSelected: (_) => context
                .read<AswhInventoryCollectBloc>()
                .add(const AswhInventoryCollectSwitchTabRequested(
                    AswhInventoryCollectTab.taskList)),
          ),
          const SizedBox(width: 12),
          ChoiceChip(
            label: const Text('采集中'),
            selected: state.activeTab == AswhInventoryCollectTab.collecting,
            onSelected: (_) => context
                .read<AswhInventoryCollectBloc>()
                .add(const AswhInventoryCollectSwitchTabRequested(
                    AswhInventoryCollectTab.collecting)),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBody(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    if (state.activeTab == AswhInventoryCollectTab.collecting) {
      if (state.collectingItems.isEmpty) {
        return const Center(child: Text('暂无采集中记录'));
      }
      return ListView.separated(
        itemCount: state.collectingItems.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final record = state.collectingItems[index];
          return ListTile(
            title: Text('物料: ${record.materialCode}'),
            subtitle: Text(
              '托盘: ${record.trayNo ?? '-'} / 库位: ${record.storeSiteNo} / 数量: ${record.collectQty}',
            ),
            trailing: Text(
              record.collectedAt != null
                  ? record.collectedAt!.toString()
                  : '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        },
      );
    }

    if (state.taskItems.isEmpty) {
      return const Center(child: Text('暂无待采集任务'));
    }

    final bloc = context.read<AswhInventoryCollectBloc>();
    final selectableIds = state.taskItems
        .map(_itemIdentifier)
        .where((id) => id.isNotEmpty)
        .toSet();
    final allSelected = selectableIds.isNotEmpty &&
        selectableIds.every((id) => state.selectedIds.contains(id));

    return ListView.builder(
      itemCount: state.taskItems.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return CheckboxListTile(
            value: allSelected,
            onChanged: selectableIds.isEmpty
                ? null
                : (value) {
                    final nextSelection = <String>{...state.selectedIds};
                    if (value == true) {
                      nextSelection.addAll(selectableIds);
                    } else {
                      nextSelection
                          .removeWhere((element) => selectableIds.contains(element));
                    }
                    bloc.add(AswhInventoryCollectSelectionChanged(nextSelection));
                  },
            title: const Text('全选任务明细'),
          );
        }

        final item = state.taskItems[index - 1];
        final itemId = _itemIdentifier(item);
        final isChecked =
            itemId.isNotEmpty && state.selectedIds.contains(itemId);
        final isActive = state.activeTask == item;

        return Column(
          children: [
            ListTile(
              selected: isActive,
              leading: Checkbox(
                value: isChecked,
                onChanged: itemId.isEmpty
                    ? null
                    : (value) {
                        final updated = <String>{...state.selectedIds};
                        if (value == true) {
                          updated.add(itemId);
                        } else {
                          updated.remove(itemId);
                        }
                        bloc.add(
                          AswhInventoryCollectSelectionChanged(updated),
                        );
                      },
              ),
              title: Text(item.materialName ?? item.materialCode ?? '-'),
              subtitle: Text(
                '托盘: ${item.palletNo ?? '-'} 库位: ${item.storeSiteNo ?? '-'} 计划: ${item.planQty} 已采集: ${item.collectedQty}',
              ),
              onTap: () => bloc.add(
                AswhInventoryCollectTaskItemSelected(item),
              ),
            ),
            if (index <= state.taskItems.length)
              const Divider(height: 1),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    AswhInventoryCollectState state,
  ) {
    final bloc = context.read<AswhInventoryCollectBloc>();
    final pickLabel = state.selectedPickLocation?.displayName ??
        state.selectedPickLocation?.code ??
        '选择拣选口';

    return _CollectBottomBar(
      pickLocationLabel: pickLabel,
      onPickLocationTap: () => _showPickLocationPicker(context, state),
      onViewResults: () =>
          _navigateToCollectResults(context: context, state: state),
      collectingCount: state.collectingItems.length,
      hasCollecting: state.collectingItems.isNotEmpty,
      onSubmit: state.collectingItems.isEmpty
          ? null
          : () => bloc.add(const AswhInventoryCollectSubmitRequested()),
      onMore: () => _showMoreMenu(context, state),
      isMoreOpen: state.commandMenu.isOpen,
    );
  }

  Future<void> _navigateToCollectResults({
    required BuildContext context,
    required AswhInventoryCollectState state,
  }) async {
    if (state.collectingItems.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('暂无采集记录')),
        );
      return;
    }

    final taskComment = state.taskComment ??
        _taskSummary?.taskComment ??
        _taskSummary?.checkTaskNo ??
        '';
    final taskId = state.taskId ??
        _taskSummary?.checkTaskId?.toString() ??
        _taskSummary?.checkTaskNo ??
        _taskId ??
        '';

    final result = await Modular.to.pushNamed(
      '/aswh-inventory/collect/result',
      arguments: {
        'taskId': taskId,
        'taskComment': taskComment,
        'records': state.collectingItems.map((e) => e.toJson()).toList(),
        'taskItems': state.taskItems.map((e) => e.toJson()).toList(),
        'currentTrayNo': state.currentTrayCode,
        'currentSiteNo': state.currentSiteCode,
        'lastScannedCode': state.lastScannedCode,
      },
    );

    if (result is Map) {
      final recordsJson = result['records'];
      final taskItemsJson = result['taskItems'];
      final message = result['message'] as String?;

      final updatedRecords = recordsJson is List
          ? recordsJson
              .map(
                (e) => InventoryCollectingRecord.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList()
          : null;
      final updatedTaskItems = taskItemsJson is List
          ? taskItemsJson
              .map(
                (e) => InventoryTaskItem.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList()
          : null;

      if (updatedRecords != null && updatedTaskItems != null) {
        context.read<AswhInventoryCollectBloc>().add(
              AswhInventoryCollectResultsPatched(
                records: updatedRecords,
                taskItems: updatedTaskItems,
                message: message,
              ),
            );
      }
    }
  }

  Future<void> _showPickLocationPicker(
    BuildContext context,
    AswhInventoryCollectState state,
  ) async {
    final bloc = context.read<AswhInventoryCollectBloc>();
    if (state.pickLocations.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('暂无可选的拣选口位置')),
        );
      return;
    }

    final selected = await showModalBottomSheet<InventoryPickLocation>(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: state.pickLocations.length,
          itemBuilder: (context, index) {
            final location = state.pickLocations[index];
            final isActive = location == state.selectedPickLocation;
            return ListTile(
              title: Text(location.displayName ?? location.code ?? '-'),
              trailing: isActive ? const Icon(Icons.check) : null,
              onTap: () => Navigator.of(context).pop(location),
            );
          },
        );
      },
    );

    if (selected != null) {
      bloc.add(AswhInventoryCollectPickLocationChanged(selected));
    }
  }

  Future<void> _showMoreMenu(
    BuildContext context,
    AswhInventoryCollectState state,
  ) async {
    final bloc = context.read<AswhInventoryCollectBloc>();
    bloc.add(const AswhInventoryCollectCommandMenuVisibilityChanged(true));

    final action = await showModalBottomSheet<_CollectMoreAction>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('查询指令'),
                onTap: () => Navigator.of(context).pop(_CollectMoreAction.viewCommands),
              ),
              ListTile(
                leading: const Icon(Icons.move_down_outlined),
                title: const Text('单个托盘'),
                onTap: () =>
                    Navigator.of(context).pop(_CollectMoreAction.singleTray),
              ),
              ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: const Text('全部托盘'),
                onTap: () =>
                    Navigator.of(context).pop(_CollectMoreAction.bulkTray),
              ),
              ListTile(
                leading: const Icon(Icons.undo_outlined),
                title: const Text('托盘回库'),
                onTap: () =>
                    Navigator.of(context).pop(_CollectMoreAction.returnTray),
              ),
            ],
          ),
        );
      },
    );

    bloc.add(const AswhInventoryCollectCommandMenuVisibilityChanged(false));

    switch (action) {
      case _CollectMoreAction.viewCommands:
        _navigateToCommands();
        break;
      case _CollectMoreAction.singleTray:
        await _handleSingleTrayDetail(context, state);
        break;
      case _CollectMoreAction.bulkTray:
        final quantity = await _promptBulkTrayQuantity(context, state);
        if (quantity != null) {
          bloc.add(AswhInventoryCollectBulkTrayRequested(quantity));
        }
        break;
      case _CollectMoreAction.returnTray:
        bloc.add(const AswhInventoryCollectReturnTrayRequested());
        break;
      case null:
        break;
    }
  }

  Future<int?> _promptBulkTrayQuantity(
    BuildContext context,
    AswhInventoryCollectState state,
  ) async {
    final maxQuantity = state.taskItems.length;
    return showDialog<int>(
      context: context,
      builder: (context) => _TrayQuantityDialog(maxQuantity: maxQuantity),
    );
  }

  Future<void> _handleSingleTrayDetail(
    BuildContext context,
    AswhInventoryCollectState state,
  ) async {
    final bloc = context.read<AswhInventoryCollectBloc>();
    final pickLocation = state.selectedPickLocation;
    if (pickLocation == null) {
      _showSnackBar(context, '请先选择拣选口位置');
      return;
    }

    if (state.selectedIds.isEmpty) {
      _showSnackBar(context, '请至少勾选一条任务明细');
      return;
    }

    InventoryTaskItem? taskItem;
    for (final item in state.taskItems) {
      if (state.selectedIds.contains(_itemIdentifier(item))) {
        taskItem = item;
        break;
      }
    }

    final trayNo = taskItem?.palletNo;
    if (trayNo == null || trayNo.isEmpty) {
      _showSnackBar(context, '所选任务缺少托盘号，无法查看明细');
      return;
    }

    final shouldDispatch = await Modular.to.pushNamed<bool>(
      '/aswh-inventory/pallet/${Uri.encodeComponent(trayNo)}',
      arguments: {
        'trayNo': trayNo,
      },
    );

    if (shouldDispatch == true) {
      bloc.add(const AswhInventoryCollectSingleTrayRequested());
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateToCommands() {
    final summary = _taskSummary;
    final taskId = summary?.checkTaskId?.toString() ?? summary?.checkTaskNo;
    if (summary == null || taskId == null) {
      return;
    }

    Modular.to.pushNamed(
      '/aswh-inventory/commands/checkorder',
      arguments: {
        'taskComment': summary.taskComment,
        'taskId': taskId,
        'taskType': '03',
        'taskNo': summary.checkTaskNo,
        'category': 'checkOrder',
      },
    );
  }

  String _itemIdentifier(InventoryTaskItem item) {
    return item.checkItemId?.toString() ??
        item.palletNo ??
        item.materialCode ??
        item.checkTaskNo ??
        '';
  }
}

enum _CollectMoreAction { viewCommands, singleTray, bulkTray, returnTray }

class _CollectBottomBar extends StatelessWidget {
  const _CollectBottomBar({
    required this.pickLocationLabel,
    required this.onPickLocationTap,
    required this.onViewResults,
    required this.collectingCount,
    required this.hasCollecting,
    required this.onSubmit,
    required this.onMore,
    required this.isMoreOpen,
  });

  final String pickLocationLabel;
  final VoidCallback onPickLocationTap;
  final VoidCallback onViewResults;
  final int collectingCount;
  final bool hasCollecting;
  final VoidCallback? onSubmit;
  final VoidCallback onMore;
  final bool isMoreOpen;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onPickLocationTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.place_outlined, size: 18),
                  const SizedBox(height: 4),
                  Text(
                    pickLocationLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: hasCollecting ? onViewResults : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 18,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasCollecting
                        ? '采集结果($collectingCount)'
                        : '采集结果',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: onSubmit,
              child: const Text('提交采集'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: onMore,
              style: isMoreOpen
                  ? OutlinedButton.styleFrom(
                      backgroundColor: colorScheme.secondaryContainer,
                    )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.more_horiz,
                    size: 18,
                    color: isMoreOpen
                        ? colorScheme.onSecondaryContainer
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '更多',
                    style: TextStyle(
                      color: isMoreOpen
                          ? colorScheme.onSecondaryContainer
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrayQuantityDialog extends StatefulWidget {
  const _TrayQuantityDialog({required this.maxQuantity});

  final int maxQuantity;

  @override
  State<_TrayQuantityDialog> createState() => _TrayQuantityDialogState();
}

class _TrayQuantityDialogState extends State<_TrayQuantityDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('托盘数量确认'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: '托盘数量',
          helperText: '最多可请求 ${widget.maxQuantity} 个托盘',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () {
            final parsed = int.tryParse(_controller.text.trim());
            if (parsed == null || parsed <= 0) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('请输入合法的托盘数量')),
                );
              return;
            }
            Navigator.of(context).pop(parsed);
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}
