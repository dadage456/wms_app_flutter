import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../bloc/inventory_query_bloc.dart';
import '../bloc/inventory_query_event.dart';
import '../bloc/inventory_query_state.dart';
import '../models/inventory_barcode_material.dart';
import '../models/inventory_query_request.dart';
import '../models/inventory_record.dart';
import '../models/inventory_summary.dart';

class InventoryQueryPage extends StatefulWidget {
  const InventoryQueryPage({super.key});

  @override
  State<InventoryQueryPage> createState() => _InventoryQueryPageState();
}

class _InventoryQueryPageState extends State<InventoryQueryPage> {
  final ScannerController _scannerController = ScannerController();
  int _lastFocusTick = 0;

  static final List<GridColumnConfig<InventoryRecord>> _columns = [
    GridColumnConfig<InventoryRecord>(
      name: 'matcode',
      headerText: '物料编码',
      valueGetter: (row) => row.matcode,
      enableSelectableText: true,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'matname',
      headerText: '物料名称',
      valueGetter: (row) => row.matname,
      enableSelectableText: true,
      width: 200,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'repqty',
      headerText: '库存数量',
      valueGetter: (row) => row.repqty,
      textAlign: TextAlign.right,
      formatter: (value, row) => _formatQuantity(row.repqty),
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'batchno',
      headerText: '批次号',
      valueGetter: (row) => row.batchno,
      enableSelectableText: true,
      width: 160,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'sn',
      headerText: '序列号',
      valueGetter: (row) => row.sn,
      enableSelectableText: true,
      width: 160,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'storesiteno',
      headerText: '库位',
      valueGetter: (row) => row.storesiteno,
      enableSelectableText: true,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'erpStoreroom',
      headerText: 'ERP子库',
      valueGetter: (row) => row.erpStoreroom,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'storeroomno',
      headerText: '库房编码',
      valueGetter: (row) => row.storeroomno,
    ),
    GridColumnConfig<InventoryRecord>(
      name: 'storeroomname',
      headerText: '库房名称',
      valueGetter: (row) => row.storeroomname,
      enableSelectableText: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<InventoryQueryBloc>().add(
        const InventoryQueryEvent.initialized(),
      );
    });
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '库存查询',
        onBackPressed: () => Modular.to.pop(),
      ).appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_scannerController.isAttached) {
            _scannerController.requestFocus();
          }
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
      body: BlocConsumer<InventoryQueryBloc, InventoryQueryState>(
        listener: (context, state) {
          if (_lastFocusTick != state.focusTick) {
            _lastFocusTick = state.focusTick;
            if (_scannerController.isAttached) {
              _scannerController.requestFocus();
            }
          }

          if (state.status == PageStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildModeSelector(state),
                    const SizedBox(height: 12),
                    _buildScanner(context, state),
                    const SizedBox(height: 16),
                    InventorySummaryCard(
                      summary: state.summary,
                      material: state.barcodeMaterial,
                      onReset: () => context.read<InventoryQueryBloc>().add(
                        const InventoryQueryEvent.resetRequested(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(child: _buildDataSection(state)),
                  ],
                ),
              ),
              if (state.status == PageStatus.loading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModeSelector(InventoryQueryState state) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: InventoryQueryMode.values
          .map(
            (mode) => ChoiceChip(
              label: Text(mode.displayName),
              selected: state.selectedMode == mode,
              onSelected: (_) => context.read<InventoryQueryBloc>().add(
                InventoryQueryEvent.modeChanged(mode),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildScanner(BuildContext context, InventoryQueryState state) {
    return ScannerWidget(
      controller: _scannerController,
      config: const ScannerConfig(placeholder: '请扫描或输入条码', autoFocus: true),
      onScanResult: (code) {
        context.read<InventoryQueryBloc>().add(
          InventoryQueryEvent.barcodeScanned(code),
        );
      },
      onError: (message) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
      suffix: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: ElevatedButton.icon(
          onPressed: () {
            final input = _scannerController.text.trim();
            context.read<InventoryQueryBloc>().add(
              InventoryQueryEvent.manualSubmitted(input: input),
            );
          },
          icon: const Icon(Icons.search),
          label: const Text('查询'),
        ),
      ),
    );
  }

  Widget _buildDataSection(InventoryQueryState state) {
    if (state.status == PageStatus.initial) {
      return const Center(child: Text('请扫描物料、库位或托盘条码开始查询'));
    }

    if (state.status == PageStatus.failure && state.records.isEmpty) {
      return const Center(child: Text('暂无数据'));
    }

    if (state.records.isEmpty) {
      return const Center(child: Text('未查询到相关库存'));
    }

    return CommonDataGrid<InventoryRecord>(
      columns: _columns,
      datas: state.records,
      currentPage: state.currentPage,
      totalPages: state.totalPages,
      onLoadData: (pageIndex) async {
        context.read<InventoryQueryBloc>().add(
          InventoryQueryEvent.pageChanged(pageIndex),
        );
      },
      allowPager: true,
    );
  }

  static String _formatQuantity(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(3);
  }
}

class InventorySummaryCard extends StatelessWidget {
  const InventorySummaryCard({
    super.key,
    required this.summary,
    this.material,
    this.onReset,
  });

  final InventorySummary summary;
  final InventoryBarcodeMaterial? material;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    label: '库存数量',
                    value: _InventoryQueryPageState._formatQuantity(
                      summary.totalQuantity,
                    ),
                    valueStyle: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onReset != null)
                  IconButton(
                    onPressed: onReset,
                    icon: const Icon(Icons.refresh),
                    tooltip: '重置',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _SummaryTile(
                  label: '物料编码',
                  value: _resolveText(summary.materialCode, material?.matcode),
                ),
                _SummaryTile(
                  label: '物料名称',
                  value: _resolveText(summary.materialName, material?.matname),
                  maxLines: 2,
                ),
                _SummaryTile(label: '库位', value: summary.storeSite),
                _SummaryTile(label: '托盘号', value: summary.trayNo),
                _SummaryTile(label: '批次号', value: material?.batchno ?? ''),
                _SummaryTile(label: '序列号', value: material?.sn ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _resolveText(String primary, String? fallback) {
    if (primary.isNotEmpty) return primary;
    if (fallback == null || fallback.isEmpty) return '-';
    return fallback;
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    this.maxLines = 1,
    this.valueStyle,
  });

  final String label;
  final String value;
  final int maxLines;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '-' : value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: valueStyle ?? theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
