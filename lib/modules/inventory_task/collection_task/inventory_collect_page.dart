import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../task_list/models/inventory_task.dart';
import 'bloc/inventory_collect_bloc.dart';
import 'bloc/inventory_collect_enums.dart';
import 'bloc/inventory_collect_event.dart';
import 'bloc/inventory_collect_state.dart';
import 'inventory_collect_result_page.dart';
import 'models/inventory_collect_models.dart';

class InventoryCollectPage extends StatefulWidget {
  const InventoryCollectPage({super.key, required this.task});

  final InventoryTask task;

  @override
  State<InventoryCollectPage> createState() => _InventoryCollectPageState();
}

class _InventoryCollectPageState extends State<InventoryCollectPage>
    with SingleTickerProviderStateMixin {
  late final InventoryCollectBloc _bloc;
  late final TabController _tabController;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InventoryCollectBloc>(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _bloc.add(InventoryCollectEvent.tabChanged(_tabController.index));
    });
    _bloc.add(InventoryCollectEvent.started(widget.task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryCollectBloc, InventoryCollectState>(
        listener: (context, state) {
          if (state.status == InventoryCollectStatus.loading ||
              state.status == InventoryCollectStatus.submitting) {
            LoadingDialogManager.instance.showLoadingDialog(context);
          } else {
            LoadingDialogManager.instance.hideLoadingDialog(context);
          }
          if (state.status == InventoryCollectStatus.failure &&
              state.message != null) {
            LoadingDialogManager.instance.showErrorDialog(
              context,
              state.message!,
            );
          }
          if (state.status == InventoryCollectStatus.success &&
              state.message != null) {
            LoadingDialogManager.instance.showSuccessDialog(
              context,
              state.message!,
            );
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              if (state.hasUnsubmittedData) {
                final result = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('提示'),
                          content: const Text('存在未提交的数据，确认返回吗？'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('取消'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('确认'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
                return result;
              }
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('平库盘点采集'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (state.hasUnsubmittedData) {
                      showDialog<void>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('提示'),
                            content: const Text('存在未提交的数据，确认返回吗？'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('取消'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('确认'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              body: Column(
                children: [
                  _buildScanner(state),
                  _buildInfoSection(state),
                  _buildTabs(state),
                  Expanded(child: _buildTabContent(state)),
                  _buildBottomBar(state),
                ],
              ),
            ),
          );
        },
        );
    }

  Widget _buildScanner(InventoryCollectState state) {
    String placeholder;
    if (state.step == InventoryCollectStep.scanLocation) {
      placeholder = '请扫描库位编码';
    } else if (state.step == InventoryCollectStep.scanMaterial) {
      placeholder = '请扫描物料条码';
    } else {
      placeholder = '请输入采集数量';
    }
    final keyboardType =
        state.step == InventoryCollectStep.inputQuantity ? TextInputType.number : TextInputType.text;

    final config = ScannerConfig().copyWith(
      placeholder: placeholder,
      clearOnSubmit: true,
      keyboardType: keyboardType,
      padding: const EdgeInsets.all(12),
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) => _handleInput(value, state),
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
      suffix: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () => _bloc.add(const InventoryCollectEvent.refreshRequested()),
      ),
    );
  }

  void _handleInput(String value, InventoryCollectState state) {
    if (value.isEmpty) return;
    switch (state.step) {
      case InventoryCollectStep.scanLocation:
        _bloc.add(InventoryCollectEvent.storeSiteScanned(value));
        break;
      case InventoryCollectStep.scanMaterial:
        _bloc.add(InventoryCollectEvent.materialScanned(value));
        break;
      case InventoryCollectStep.inputQuantity:
        final quantity = double.tryParse(value);
        if (quantity == null) {
          LoadingDialogManager.instance.showErrorDialog(context, '请输入有效的数量');
        } else {
          _bloc.add(InventoryCollectEvent.quantitySubmitted(quantity));
        }
        break;
    }
    _scannerController.clear();
  }

  Widget _buildInfoSection(InventoryCollectState state) {
    final task = state.task;
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('库房：${task?.storeRoomName ?? ''}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text('库位：${state.currentStoreSite.isEmpty ? '-' : state.currentStoreSite}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text('物料：${state.barcodeContent?.materialCode ?? '-'}',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text('采集数量：${state.barcodeContent == null ? '-' : ''}',
              style: const TextStyle(fontSize: 16)),
          if (state.barcodeContent?.batchNo != null)
            Text('批次：${state.barcodeContent?.batchNo}', style: const TextStyle(fontSize: 14)),
          if (state.barcodeContent?.serialNo != null)
            Text('序列号：${state.barcodeContent?.serialNo}',
                style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTabs(InventoryCollectState state) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black54,
        tabs: const [
          Tab(text: '任务列表'),
          Tab(text: '正在采集'),
        ],
      ),
    );
  }

  Widget _buildTabContent(InventoryCollectState state) {
    final pending = state.taskItems;
    final collecting = state.collectingRecords;
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTaskList(pending),
        _buildCollectingList(collecting),
      ],
    );
  }

  Widget _buildTaskList(List<InventoryTaskItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('暂无任务明细'));
    }
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text('${item.materialCode}  ${item.materialName ?? ''}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('库位：${item.storeSiteNo}'),
              Text('系统数量：${item.systemQuantity}'),
              Text('已采集：${item.collectedQuantity.toStringAsFixed(2)}'),
              Text('差异：${item.difference.toStringAsFixed(2)}'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollectingList(List<InventoryCollectRecord> records) {
    if (records.isEmpty) {
      return const Center(child: Text('暂无采集记录'));
    }
    return ListView.separated(
      itemCount: records.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final record = records[index];
        return ListTile(
          leading: const Icon(Icons.assignment),
          title: Text('${record.materialCode}  ${record.materialName ?? ''}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('库位：${record.storeSiteNo}'),
              Text('采集数量：${record.actualQuantity}'),
              Text('差异：${record.difference.toStringAsFixed(2)}'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(InventoryCollectState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final removed = await Navigator.of(context).push<List<InventoryCollectRecord>>(
                  MaterialPageRoute(
                    builder: (_) => InventoryCollectResultPage(
                      initialRecords: state.collectingRecords,
                    ),
                  ),
                );
                if (removed != null && removed.isNotEmpty) {
                  _bloc.add(InventoryCollectEvent.recordsRemoved(removed));
                }
              },
              child: const Text('采集结果'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: state.collectingRecords.isEmpty
                  ? null
                  : () => _bloc.add(const InventoryCollectEvent.submitRequested()),
              child: const Text('提交'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
