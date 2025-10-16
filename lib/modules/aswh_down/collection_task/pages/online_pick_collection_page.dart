import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/aswh_down/utils/online_pick_scanner_parser.dart';

import '../bloc/online_pick_collection_bloc.dart';
import '../bloc/online_pick_collection_event.dart';
import '../bloc/online_pick_collection_state.dart';
import '../../models/online_pick_collection_models.dart';

class OnlinePickCollectionPage extends StatefulWidget {
  const OnlinePickCollectionPage({
    super.key,
    required this.initialArgs,
  });

  final Map<String, dynamic> initialArgs;

  @override
  State<OnlinePickCollectionPage> createState() =>
      _OnlinePickCollectionPageState();
}

class _OnlinePickCollectionPageState extends State<OnlinePickCollectionPage>
    with SingleTickerProviderStateMixin {
  late final OnlinePickCollectionBloc _bloc;
  late final TabController _tabController;
  final ScannerController _scannerController = ScannerController();
  final TextEditingController _manualController = TextEditingController();
  final FocusNode _manualFocusNode = FocusNode();
  int _lastFocusSequence = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickCollectionBloc>(context);
    _tabController = TabController(length: 3, vsync: this);
    _bloc.add(OnlinePickCollectionStarted(widget.initialArgs));
  }

  @override
  void dispose() {
    _manualController.dispose();
    _manualFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('在线拣选采集'),
        actions: [
          PopupMenuButton<OnlinePickCollectionModeType>(
            tooltip: '切换模式',
            icon: const Icon(Icons.tune),
            onSelected: (mode) =>
                _bloc.add(OnlinePickCollectionModeChanged(mode)),
            itemBuilder: (context) => OnlinePickCollectionModeType.values
                .map(
                  (mode) => PopupMenuItem(
                    value: mode,
                    child: Text(_modeLabel(mode)),
                  ),
                )
                .toList(),
          ),
          IconButton(
            tooltip: '清空缓存',
            onPressed: () => _bloc.add(const OnlinePickCollectionCacheCleared()),
            icon: const Icon(Icons.delete_outline),
          ),
          IconButton(
            tooltip: '重置采集步骤',
            onPressed: () => _bloc.add(const OnlinePickCollectionStepResetRequested()),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: '提交采集结果',
            onPressed: () => _bloc.add(const OnlinePickCollectionSubmitPressed()),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: BlocConsumer<OnlinePickCollectionBloc, OnlinePickCollectionState>(
        listener: (context, state) {
          _handleFocus(state);
          _handleStatusFeedback(context, state);
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.status.isLoading)
                const LinearProgressIndicator(minHeight: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: _buildScanInput(state),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  state.currentStepLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildInfoCards(state),
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildTabs(state)),
              _buildBottomActions(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScanInput(OnlinePickCollectionState state) {
    final config = ScannerConfig().copyWith(
      placeholder: state.scannerPlaceholder,
      clearOnSubmit: true,
      autoFocus: false,
    );

    Widget? suffix;
    if (state.locationOptions.isNotEmpty) {
      suffix = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: '手动输入',
            icon: const Icon(Icons.keyboard_outlined),
            onPressed: _showManualInputDialog,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.place_outlined),
            tooltip: '选择库位',
            onSelected: (value) {
              _bloc.add(OnlinePickCollectionLocationSelected(value));
            },
            itemBuilder: (context) {
              return state.locationOptions
                  .map(
                    (option) => PopupMenuItem<String>(
                      value: option.value,
                      child: Text(option.label),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      );
    } else {
      suffix = IconButton(
        tooltip: '手动输入',
        icon: const Icon(Icons.keyboard_outlined),
        onPressed: _showManualInputDialog,
      );
    }

    return ScannerWidget(
      controller: _scannerController,
      config: config,
      onScanResult: (value) {
        if (value.trim().isEmpty) return;
        _bloc.add(OnlinePickCollectionScanSubmitted(value));
      },
      onError: (message) {
        _showSnackBar(
          context,
          message,
          Colors.red.shade600,
        );
      },
      suffix: suffix,
    );
  }

  Widget _buildInfoCards(OnlinePickCollectionState state) {
    final textTheme = Theme.of(context).textTheme;

    Widget buildTile(String label, String value, {IconData? icon}) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 12, bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Icon(icon, size: 18, color: const Color(0xFF1E88E5)),
                  if (icon != null) const SizedBox(width: 4),
                  Text(
                    label,
                    style: textTheme.bodySmall
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                value.isEmpty ? '-' : value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final materialName =
        state.barcodeContent?.materialName ?? state.barcodeContent?.materialCode ?? '';
    final qrBatch = state.barcodeContent?.batchNo ?? state.barcodeContent?.serialNumber ?? '';

    return Column(
      children: [
        Row(
          children: [
            buildTile(
              '模式',
              _modeLabel(state.currentMode),
              icon: Icons.tune,
            ),
            buildTile(
              '库位',
              state.currentLocation ?? '',
              icon: Icons.location_on_outlined,
            ),
          ],
        ),
        Row(
          children: [
            buildTile(
              '托盘',
              state.currentTrayNo ?? '',
              icon: Icons.inventory_2_outlined,
            ),
            buildTile(
              '预计子库',
              state.expectedErpStore,
              icon: Icons.warehouse_outlined,
            ),
          ],
        ),
        Row(
          children: [
            buildTile(
              '物料',
              materialName,
              icon: Icons.qr_code_scanner,
            ),
            buildTile(
              '批次/序列',
              qrBatch,
              icon: Icons.tag,
            ),
          ],
        ),
        Row(
          children: [
            buildTile(
              '采集数量',
              state.pendingQuantity?.toString() ?? '',
              icon: Icons.calculate_outlined,
            ),
            buildTile(
              '下一步',
              _nextStepDescription(state.nextExpectedScanType),
              icon: Icons.directions_walk,
            ),
          ],
        ),
      ],
    );
  }

  String _modeLabel(OnlinePickCollectionModeType mode) {
    if (mode == OnlinePickCollectionModeType.inventory) {
      return '库存核对';
    }
    if (mode == OnlinePickCollectionModeType.exception) {
      return '异常采集';
    }
    return '出库采集';
  }

  Widget _buildTabs(OnlinePickCollectionState state) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF1E88E5),
            unselectedLabelColor: Colors.grey.shade600,
            indicatorColor: const Color(0xFF1E88E5),
            indicatorWeight: 3,
            tabs: const [
              Tab(text: '任务明细'),
              Tab(text: '采集中'),
              Tab(text: '库存核对'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              _CollectionPlaceholder(title: 'TODO: 任务列表'),
              _CollectionPlaceholder(title: 'TODO: 正在采集明细'),
              _CollectionPlaceholder(title: 'TODO: 库存核对'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(OnlinePickCollectionState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _navigateToCollectionResult(state),
              icon: const Icon(Icons.list_alt_outlined),
              label: const Text('采集结果'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _navigateToWcs(state),
              icon: const Icon(Icons.send_outlined),
              label: const Text('指令查询'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToCollectionResult(
    OnlinePickCollectionState state,
  ) async {
    final stocks = state.collectedStocks
        .map((stock) => stock.toJson())
        .toList(growable: false);

    final result = await Modular.to.pushNamed(
      '/aswh-down/collect/result',
      arguments: {
        'stocks': stocks,
        'task': state.task?.toJson(),
        'trayNo': state.currentTrayNo,
        'location': state.currentLocation,
      },
    );

    if (result is Map) {
      final stocksPayload = result['stocks'];
      if (stocksPayload is List) {
        final parsed = stocksPayload
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(
                  item.map(
                    (key, value) => MapEntry(key.toString(), value),
                  ),
                ))
            .toList();
        _bloc.add(OnlinePickCollectionStocksSynced(parsed));
      } else if (result['refresh'] == true) {
        _bloc.add(const OnlinePickCollectionReloadRequested());
      }
    }
  }

  void _showManualInputDialog() {
    _manualController.clear();
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('手动输入条码'),
          content: TextField(
            controller: _manualController,
            focusNode: _manualFocusNode,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: '请输入条码或数量',
            ),
            onSubmitted: (value) => _submitManualInput(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _manualController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => _submitManualInput(context),
              child: const Text('确定'),
            ),
          ],
        );
      },
    ).then((_) {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      _scannerController.requestFocus();
    });
  }

  void _submitManualInput(BuildContext dialogContext) {
    final value = _manualController.text.trim();
    if (value.isEmpty) {
      return;
    }
    Navigator.of(dialogContext).pop();
    _bloc.add(OnlinePickCollectionScanSubmitted(value));
  }

  Future<void> _navigateToWcs(OnlinePickCollectionState state) async {
    final result = await Modular.to.pushNamed(
      '/aswh-down/wcs',
      arguments: {
        'taskId': state.task?.outTaskId,
        'taskNo': state.task?.outTaskNo,
        'taskComment': state.task?.taskComment,
        'trayNo': state.currentTrayNo,
        'workStation': state.task?.workStation,
      },
    );

    if (result is Map && result['refresh'] == true) {
      _bloc.add(const OnlinePickCollectionReloadRequested());
    }
  }

  void _handleFocus(OnlinePickCollectionState state) {
    if (state.focusSequence != _lastFocusSequence) {
      _lastFocusSequence = state.focusSequence;
      _scannerController.clear();
      _scannerController.requestFocus();
    }
  }

  void _handleStatusFeedback(
    BuildContext context,
    OnlinePickCollectionState state,
  ) {
    final status = state.status;
    final message = status.message;
    if (message == null || message.isEmpty) {
      return;
    }

    if (status.isError) {
      _showSnackBar(context, message, Colors.red.shade600);
    } else if (status.isSuccess) {
      _showSnackBar(context, message, Colors.green.shade600);
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }

  String _nextStepDescription(OnlinePickScanType type) {
    switch (type) {
      case OnlinePickScanType.location:
        return '等待扫描库位';
      case OnlinePickScanType.tray:
        return '等待扫描托盘';
      case OnlinePickScanType.material:
        return '等待扫描物料二维码';
      case OnlinePickScanType.quantity:
        return '等待录入数量';
    }
  }
}

class _CollectionPlaceholder extends StatelessWidget {
  const _CollectionPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
