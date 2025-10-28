import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/collection_columns.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/services/user_manager.dart';

class OnlinePickCollectionPage extends StatefulWidget {
  final OnlinePickTask task;
  final Map<String, dynamic> initialArgs;

  const OnlinePickCollectionPage({
    super.key,
    required this.task,
    this.initialArgs = const {},
  });

  @override
  State<OnlinePickCollectionPage> createState() =>
      _OnlinePickCollectionPageState();
}

class _OnlinePickCollectionPageState extends State<OnlinePickCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late OnlinePickCollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();
  final TextEditingController _trayCountController = TextEditingController(
    text: '10',
  );

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickCollectionBloc>(context);
    _tabController = TabController(length: 3, vsync: this);

    final userInfo = Modular.get<UserManager>().userInfo;
    _bloc.add(
      InitializeCollectionEvent(
        task: widget.task,
        userId: userInfo?.userId ?? 0,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _trayCountController.dispose();
    super.dispose();
  }

  bool _canPop(OnlinePickCollectionState state) {
    return state.collectedStocks.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlinePickCollectionBloc, OnlinePickCollectionState>(
      listener: _listenState,
      builder: (context, state) {
        return PopScope(
          canPop: _canPop(state),
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            _handleBackPress(state);
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: _buildAppBar(state),
            body: Column(
              children: [
                _buildScanInput(state),
                _buildInfoCard(state),
                _buildTabs(state),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTaskGrid(state, state.taskItems),
                      _buildTaskGrid(state, state.currentTrayItems),
                      _buildInventoryCheckList(state),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomBar(state),
          ),
        );
      },
    );
  }

  void _listenState(BuildContext context, OnlinePickCollectionState state) {
    if (state.status.isLoading) {
      LoadingDialogManager.instance.showLoadingDialog(context);
    } else {
      LoadingDialogManager.instance.hideLoadingDialog(context);
    }

    if (state.status.isError) {
      _showMessage(state.status.message ?? '处理失败', Colors.red);
      _bloc.add(const ResetCollectionStatusEvent());
    } else if (state.status.isSuccess && state.status.message != null) {
      _showMessage(state.status.message!, Colors.green);
      _bloc.add(const ResetCollectionStatusEvent());
    }

    if (state.currentTab != _tabController.index) {
      _tabController.index = state.currentTab;
    }

    if (state.focus) {
      _scannerController.requestFocus();
      _bloc.add(const SetCollectionFocusEvent(false));
    }

    _scannerController.clear();
  }

  PreferredSizeWidget _buildAppBar(OnlinePickCollectionState state) {
    return AppBar(
      title: const Text('自动化仓库下架采集'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => _handleBackPress(state),
      ),
      actions: [
        TextButton(
          onPressed: () => _showMoreOptions(state),
          child: const Text('更多', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildScanInput(OnlinePickCollectionState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ScannerWidget(
        controller: _scannerController,
        config: ScannerConfig(
          placeholder: state.placeholder,
          keyboardType:
              state.step == OnlinePickCollectionStep.quantity
                  ? TextInputType.number
                  : TextInputType.text,
        ),
        onScanResult: (value) {
          _bloc.add(PerformScanEvent(value));
        },
      ),
    );
  }

  Widget _buildInfoCard(OnlinePickCollectionState state) {
    final task = state.task ?? widget.task;
    final modeLabel = _modeLabel(state);
    final availableInventoryText = state.availableInventory <= 0 &&
            (state.currentBarcode == null ||
                (state.currentBarcode?.materialCode ?? '').isEmpty)
        ? '-'
        : _formatQuantityDisplay(state.availableInventory);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '任务号：${task.outTaskNo}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildInfoChip('库房', task.storeRoomNo ?? '-'),
              _buildInfoChip('工位', task.workStation ?? '-'),
              _buildInfoChip(
                '拣选口',
                state.selectedLocation.isEmpty
                    ? (task.taskComment ?? '-')
                    : state.selectedLocation,
              ),
              _buildInfoChip(
                '托盘',
                state.currentTrayCode.isEmpty ? '-' : state.currentTrayCode,
              ),
              _buildInfoChip(
                '库位',
                state.currentStoreSite.isEmpty ? '-' : state.currentStoreSite,
              ),
              _buildInfoChip(
                '可用库存',
                availableInventoryText,
              ),
              _buildInfoChip('模式', modeLabel),
              _buildInfoChip('任务行数', state.taskItems.length.toString()),
            ],
          ),
          const SizedBox(height: 12),
          _buildCurrentMaterialSummary(state),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('$label：$value'),
    );
  }

  Widget _buildTabs(OnlinePickCollectionState state) {
    return Container(
      height: 44,
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        dividerHeight: 0,
        labelColor: const Color(0xFF1976D2),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF1976D2),
        indicatorWeight: 3,
        tabs: const [
          Tab(text: '任务列表'),
          Tab(text: '当前托盘'),
          Tab(text: '库存核对'),
        ],
        onTap: (index) {
          _bloc.add(ChangeCollectionTabEvent(index));
        },
      ),
    );
  }

  Widget _buildTaskGrid(
    OnlinePickCollectionState state,
    List<OnlinePickTaskItem> items,
  ) {
    final selectedIndices = _selectedIndicesFor(items, state.selectedItemIds);
    return CommonDataGrid<OnlinePickTaskItem>(
      columns: buildTaskItemColumns(),
      datas: items,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: selectedIndices,
      onSelectionChanged: (indices) {
        final selectedIds = indices
            .where((index) => index >= 0 && index < items.length)
            .map((index) => items[index].outTaskItemId)
            .toList();
        _bloc.add(UpdateSelectionEvent(selectedIds));
      },
    );
  }

  Widget _buildInventoryCheckList(OnlinePickCollectionState state) {
    final records = state.inventoryCheckRecords;
    if (records.isEmpty) {
      return _buildEmptyPlaceholder('暂无库存核对记录');
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: records.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final record = records[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '物料：${record.materialCode}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildInfoChip(
                    '托盘',
                    record.trayNo.isEmpty ? '-' : record.trayNo,
                  ),
                  _buildInfoChip(
                    '库位',
                    record.storeSite.isEmpty ? '-' : record.storeSite,
                  ),
                  _buildInfoChip(
                    '结余数量',
                    record.quantity.toString(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyPlaceholder(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildBottomBar(OnlinePickCollectionState state) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: _outlinedActionStyle(),
                onPressed: () => _openPickLocationSelector(state),
                child: const Text('拣选位置'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: _outlinedActionStyle(),
                onPressed: () => _openResultPage(state),
                child: const Text('采集结果'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: _primaryActionStyle(),
                onPressed: state.collectedStocks.isEmpty ||
                        state.inventoryCheckRecords.isEmpty
                    ? null
                    : () => _confirmSubmit(state),
                child: const Text('提交采集'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                style: _outlinedActionStyle(),
                onPressed: () => _showMoreOptions(state),
                child: const Text('更多'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openResultPage(OnlinePickCollectionState state) async {
    final deletedIds = await Modular.to.pushNamed<List<String>>(
      '/aswh-down/collect/result',
      arguments: {'bloc': _bloc},
    );

    if (deletedIds != null && deletedIds.isNotEmpty) {
      _bloc.add(DeleteCollectedStocksEvent(deletedIds));
    }
  }

  void _handleBackPress(OnlinePickCollectionState state) {
    if (_canPop(state)) {
      Modular.to.pop();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('存在未提交的采集记录，确认返回将丢失这些数据，是否继续？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Modular.to.pop();
            },
            child: const Text('继续'),
          ),
        ],
      ),
    );
  }

  void _openPickLocationSelector(OnlinePickCollectionState state) {
    if (state.loadingLocations) {
      _showMessage('拣选口加载中，请稍后再试', Colors.orange);
      return;
    }

    if (state.locationOptions.isEmpty) {
      _bloc.add(const LoadPickLocationsEvent());
      _showMessage('正在加载拣选口，请稍后重试', Colors.orange);
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '选择拣选口',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...state.locationOptions.map(
                (option) => ListTile(
                  title: Text(option),
                  trailing: option == state.selectedLocation
                      ? const Icon(Icons.check, color: Color(0xFF1976D2))
                      : null,
                  onTap: () {
                    Navigator.of(context).pop();
                    _bloc.add(SelectPickLocationEvent(option));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmSubmit(OnlinePickCollectionState state) {
    final message = _buildSubmitConfirmMessage(state);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交确认'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _bloc.add(const SubmitCollectionEvent());
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(OnlinePickCollectionState state) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.tune),
                title: const Text('采集模式'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showModeSelector(state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.article_outlined),
                title: const Text('查询指令'),
                onTap: () {
                  Navigator.of(context).pop();
                  _openWcsPage(state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.outbox),
                title: const Text('空盘出库'),
                onTap: () {
                  Navigator.of(context).pop();
                  _bloc.add(const RequestEmptyTrayOutEvent());
                },
              ),
              ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: const Text('空盘入库'),
                onTap: () {
                  Navigator.of(context).pop();
                  _bloc.add(const RequestEmptyTrayInEvent());
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_shipping_outlined),
                title: const Text('单个托盘'),
                onTap: () {
                  Navigator.of(context).pop();
                  _bloc.add(const RequestSingleTrayEvent());
                },
              ),
              ListTile(
                leading: const Icon(Icons.reply_all_outlined),
                title: const Text('托盘回库'),
                onTap: () {
                  Navigator.of(context).pop();
                  _bloc.add(const RequestReturnTrayEvent());
                },
              ),
              ListTile(
                leading: const Icon(Icons.all_inbox),
                title: const Text('全部托盘'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showAllTrayDialog(state);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showModeSelector(OnlinePickCollectionState state) async {
    final selected = await showModalBottomSheet<OnlinePickCollectionModeType>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: state.availableModes
                .map(
                  (mode) => ListTile(
                    title: Text(mode.label),
                    trailing: mode.type == state.mode
                        ? const Icon(Icons.check, color: Color(0xFF1976D2))
                        : null,
                    onTap: () => Navigator.of(context).pop(mode.type),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (selected != null) {
      _bloc.add(ChangeCollectionModeEvent(selected));
    }
  }

  Future<void> _showAllTrayDialog(OnlinePickCollectionState state) async {
    _trayCountController.text = state.selectedItemIds.isNotEmpty
        ? state.selectedItemIds.length.toString()
        : '10';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('获取托盘数量'),
        content: TextField(
          controller: _trayCountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: '请输入需要下发的托盘数量'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final defaultCount =
          state.selectedItemIds.isNotEmpty ? state.selectedItemIds.length : 10;
      final parsed = int.tryParse(_trayCountController.text.trim());
      final count = parsed != null && parsed > 0 ? parsed : defaultCount;
      _bloc.add(RequestAllTrayEvent(count));
    } else {
      _trayCountController.text = '10';
    }
  }

  Future<void> _openWcsPage(OnlinePickCollectionState state) async {
    final task = state.task ?? widget.task;
    await Modular.to.pushNamed(
      '/aswh-down/wcs',
      arguments: {
        'taskComment': task.taskComment ?? '',
        'taskId': task.outTaskId,
        'taskNo': task.outTaskNo,
      },
    );
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  List<int> _selectedIndicesFor(
    List<OnlinePickTaskItem> items,
    List<int> selectedIds,
  ) {
    final ids = selectedIds.toSet();
    final indices = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (ids.contains(items[i].outTaskItemId)) {
        indices.add(i);
      }
    }
    return indices;
  }

  ButtonStyle _outlinedActionStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1976D2),
      side: const BorderSide(color: Color(0xFF1976D2)),
      padding: const EdgeInsets.symmetric(vertical: 14),
    );
  }

  ButtonStyle _primaryActionStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
    );
  }

  String _modeLabel(OnlinePickCollectionState state) {
    for (final mode in state.availableModes) {
      if (mode.type == state.mode) {
        return mode.label;
      }
    }
    return state.mode.name;
  }

  String _buildSubmitConfirmMessage(OnlinePickCollectionState state) {
    final base = '确认提交当前的 ${state.collectedStocks.length} 条采集记录吗？';
    final pendingLines = _pendingSummaryLines(state);
    if (pendingLines.isEmpty) {
      return base;
    }

    final buffer = StringBuffer(base)
      ..writeln()
      ..writeln('当前托盘仍有未完成任务：');
    for (final line in pendingLines) {
      buffer.writeln(line);
    }
    return buffer.toString();
  }

  List<String> _pendingSummaryLines(OnlinePickCollectionState state) {
    final tray = state.currentTrayCode.toUpperCase();
    if (tray.isEmpty) {
      return const [];
    }

    final summary = <String, double>{};
    for (final item in state.pendingCheckItems) {
      if ((item.palletNo ?? '').toUpperCase() != tray) {
        continue;
      }
      final remaining = (item.taskQty - item.collectedQty).toDouble();
      if (remaining <= 1e-6) {
        continue;
      }
      final material = (item.materialCode ?? '').toUpperCase();
      final site = (item.storeSiteNo ?? '').toUpperCase();
      final label = '物料【$material】库位【$site】';
      summary[label] = (summary[label] ?? 0) + remaining;
    }

    final entries = summary.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return entries
        .map(
          (entry) => '${entry.key}剩余${entry.value.toStringAsFixed(3)}',
        )
        .toList();
  }

  Widget _buildCurrentMaterialSummary(OnlinePickCollectionState state) {
    final barcode = state.currentBarcode;
    final hasBarcode = barcode != null && (barcode.materialCode ?? '').isNotEmpty;
    final materialCode = hasBarcode ? (barcode!.materialCode ?? '-') : '-';
    final materialName = hasBarcode ? (barcode!.materialName ?? '-') : '-';
    final batchNo = hasBarcode ? (barcode!.batchNo ?? '') : '';
    final serialNo = hasBarcode ? (barcode!.serialNumber ?? '') : '';

    final tray = state.currentTrayCode.toUpperCase();
    final storeSite = state.currentStoreSite.toUpperCase();
    final batchKey = batchNo.toUpperCase();
    final serialKey = serialNo.toUpperCase();

    double collectedQty = 0;
    double inventoryQty = 0;

    if (hasBarcode) {
      for (final stock in state.collectedStocks) {
        if ((stock.materialCode).toUpperCase() != materialCode.toUpperCase()) {
          continue;
        }
        if (tray.isNotEmpty && (stock.trayNo ?? '').toUpperCase() != tray) {
          continue;
        }
        if (storeSite.isNotEmpty &&
            (stock.storeSite ?? '').toUpperCase() != storeSite) {
          continue;
        }
        if (serialKey.isNotEmpty) {
          if ((stock.serialNumber ?? '').toUpperCase() != serialKey) {
            continue;
          }
        } else if (batchKey.isNotEmpty) {
          if ((stock.batchNo ?? '').toUpperCase() != batchKey) {
            continue;
          }
        }
        collectedQty += stock.collectQty.toDouble();
      }

      for (final record in state.inventoryCheckRecords) {
        if (record.materialCode.toUpperCase() != materialCode.toUpperCase()) {
          continue;
        }
        if (tray.isNotEmpty && record.trayNo.toUpperCase() != tray) {
          continue;
        }
        if (storeSite.isNotEmpty && record.storeSite.toUpperCase() != storeSite) {
          continue;
        }
        inventoryQty += record.quantity.toDouble();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '当前物料信息',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            _buildInfoChip('物料编码', materialCode.isEmpty ? '-' : materialCode),
            _buildInfoChip('物料名称', materialName.isEmpty ? '-' : materialName),
            _buildInfoChip(
              '批次',
              batchNo.isEmpty ? '-' : batchNo,
            ),
            _buildInfoChip(
              '序列号',
              serialNo.isEmpty ? '-' : serialNo,
            ),
            _buildInfoChip(
              '已采集数量',
              hasBarcode ? _formatQuantityDisplay(collectedQty) : '-',
            ),
            _buildInfoChip(
              '结余数量',
              hasBarcode ? _formatQuantityDisplay(inventoryQty) : '-',
            ),
          ],
        ),
      ],
    );
  }

  String _formatQuantityDisplay(num value) {
    final number = value.toDouble();
    if (number == 0) {
      return '0';
    }
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }
    return number.toStringAsFixed(3);
  }
}
