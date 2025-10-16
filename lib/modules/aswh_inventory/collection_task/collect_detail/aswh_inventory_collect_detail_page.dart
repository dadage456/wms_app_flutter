import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../../models/inventory_collect_detail_models.dart';
import '../../models/inventory_collect_models.dart';
import '../bloc/aswh_inventory_collect_detail_bloc.dart';
import '../bloc/aswh_inventory_collect_detail_event.dart';
import '../bloc/aswh_inventory_collect_detail_state.dart';

class AswhInventoryCollectDetailPage extends StatefulWidget {
  const AswhInventoryCollectDetailPage({super.key});

  @override
  State<AswhInventoryCollectDetailPage> createState() =>
      _AswhInventoryCollectDetailPageState();
}

class _AswhInventoryCollectDetailPageState
    extends State<AswhInventoryCollectDetailPage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final args = Modular.args.data;
    if (args is Map) {
      final taskId = (args['taskId'] ?? '').toString();
      final taskComment = (args['taskComment'] ?? '').toString();
      final records = (args['records'] as List?)
              ?.map(
                (e) => InventoryCollectingRecord.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList() ??
          const <InventoryCollectingRecord>[];
      final taskItems = (args['taskItems'] as List?)
              ?.map(
                (e) => InventoryTaskItem.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList() ??
          const <InventoryTaskItem>[];

      final activeTrayNo = args['currentTrayNo'] as String?;
      final activeStoreSiteNo = args['currentSiteNo'] as String?;
      final lastScannedCode = args['lastScannedCode'] as String?;

      context.read<AswhInventoryCollectDetailBloc>().add(
            AswhInventoryCollectDetailStarted(
              taskId: taskId,
              taskComment: taskComment,
              records: records,
              taskItems: taskItems,
              activeTrayNo: activeTrayNo,
              activeStoreSiteNo: activeStoreSiteNo,
              lastScannedCode: lastScannedCode,
            ),
          );
    }

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AswhInventoryCollectDetailBloc,
        AswhInventoryCollectDetailState>(
      listenWhen: (previous, current) =>
          previous.pendingDeletion != current.pendingDeletion ||
          previous.message != current.message ||
          previous.status != current.status,
      listener: (context, state) async {
        final messenger = ScaffoldMessenger.of(context);

        if (state.message != null && state.message!.isNotEmpty) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
        }

        if (state.pendingDeletion) {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('确认删除'),
                content: Text('确定删除选中的 ${state.selectedIds.length} 条记录吗？'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('取消'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('删除'),
                  ),
                ],
              );
            },
          );

          if (confirmed == true) {
            context
                .read<AswhInventoryCollectDetailBloc>()
                .add(const AswhInventoryCollectDetailDeletionConfirmed());
          } else {
            context
                .read<AswhInventoryCollectDetailBloc>()
                .add(const AswhInventoryCollectDetailDeletionCancelled());
          }
        }

        if (state.status == AswhInventoryCollectDetailStatus.success) {
          await Future.delayed(const Duration(milliseconds: 300));
          if (mounted) {
            _finishWithResult(context, state: state);
          }
        }
      },
      builder: (context, state) {
        final selectedIndices = state.items.asMap().entries
            .where((entry) => state.selectedIds.contains(entry.value.stockId))
            .map((entry) => entry.key)
            .toList();

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            _finishWithResult(context, state: state);
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('立库盘点采集结果'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => _finishWithResult(context, state: state),
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: state.items.isEmpty
                          ? const Center(child: Text('暂无采集记录'))
                          : Padding(
                              padding: const EdgeInsets.all(16),
                              child: CommonDataGrid<InventoryCollectedItem>(
                                columns: _resultColumns(),
                                datas: state.items,
                                allowPager: false,
                                allowSelect: true,
                                selectedRows: selectedIndices,
                                onLoadData: (_) async {},
                                onSelectionChanged: (indices) {
                                  final ids = indices
                                      .where((index) =>
                                          index >= 0 &&
                                          index < state.items.length)
                                      .map((index) =>
                                          state.items[index].stockId)
                                      .toSet();
                                  context
                                      .read<AswhInventoryCollectDetailBloc>()
                                      .add(
                                        AswhInventoryCollectDetailSelectionChanged(
                                          ids,
                                        ),
                                      );
                                },
                                currentPage: 1,
                                totalPages: 1,
                              ),
                            ),
                    ),
                    _buildBottomBar(context, state),
                  ],
                ),
                if (state.status == AswhInventoryCollectDetailStatus.updating ||
                    state.status == AswhInventoryCollectDetailStatus.loading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    AswhInventoryCollectDetailState state,
  ) {
    final bloc = context.read<AswhInventoryCollectDetailBloc>();
    final total = state.items.length;
    final selected = state.selectedIds.length;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: total > 0 && state.isAllSelected,
            onChanged: total == 0
                ? null
                : (value) => bloc.add(
                      AswhInventoryCollectDetailSelectAllToggled(value ?? false),
                    ),
          ),
          const Text('全选'),
          const SizedBox(width: 12),
          Text('已选 $selected / $total'),
          const Spacer(),
          FilledButton.icon(
            onPressed: total == 0
                ? null
                : () => bloc.add(
                      const AswhInventoryCollectDetailDeleteRequested(),
                    ),
            icon: const Icon(Icons.delete_outline),
            label: const Text('删除'),
          ),
        ],
      ),
    );
  }

  List<GridColumnConfig<InventoryCollectedItem>> _resultColumns() {
    return [
      GridColumnConfig<InventoryCollectedItem>(
        name: 'trayNo',
        headerText: '托盘号',
        valueGetter: (row) => row.trayNo ?? '-',
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'sourceQty',
        headerText: '采集数量',
        valueGetter: (row) => row.sourceQty.toString(),
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'batchNo',
        headerText: '批次号',
        valueGetter: (row) => row.batchNo ?? '-',
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'serialNo',
        headerText: '序列号',
        valueGetter: (row) => row.serialNo ?? '-',
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoomNo,
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo,
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'invTaskItemId',
        headerText: '任务明细ID',
        valueGetter: (row) => row.invTaskItemId,
      ),
      GridColumnConfig<InventoryCollectedItem>(
        name: 'stockId',
        headerText: '记录ID',
        valueGetter: (row) => row.stockId,
      ),
    ];
  }

  void _finishWithResult(
    BuildContext context, {
    AswhInventoryCollectDetailState? state,
  }) {
    final blocState = state ??
        context.read<AswhInventoryCollectDetailBloc>().state;
    final records = blocState.items
        .map(
          (item) => item
              .toRecord(taskComment: blocState.taskComment ?? '')
              .toJson(),
        )
        .toList();
    final taskItems = blocState.taskItems.map((item) => item.toJson()).toList();

    Modular.to.pop({
      'records': records,
      'taskItems': taskItems,
      'message': blocState.hasChanges ? '采集结果已更新' : null,
    });
  }
}
