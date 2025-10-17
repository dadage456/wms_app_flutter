import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../../../services/user_manager.dart';
import 'bloc/mtl_senter_collection_bloc.dart';
import 'bloc/mtl_senter_collection_event.dart';
import 'bloc/mtl_senter_collection_state.dart';
import 'models/mtl_senter_models.dart';

class MtlSenterCollectionPage extends StatefulWidget {
  const MtlSenterCollectionPage({super.key, this.task});

  final MtlSenterTask? task;

  @override
  State<MtlSenterCollectionPage> createState() =>
      _MtlSenterCollectionPageState();
}

class _MtlSenterCollectionPageState extends State<MtlSenterCollectionPage> {
  late final MtlSenterCollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<MtlSenterCollectionBloc>(context);
    final user = Modular.get<UserManager>().userInfo;
    _bloc.add(
      MtlSenterCollectionStarted(
        task: widget.task,
        operatorId: user != null ? '${user.userId}' : null,
      ),
    );
  }

  bool _canPop() => _bloc.state.stocks.isEmpty;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress(context);
      },
      child: BlocConsumer<MtlSenterCollectionBloc, MtlSenterCollectionState>(
        listener: (context, state) {
          LoadingDialogManager.instance.hideLoadingDialog(context);

          if (state.status.isLoading) {
            LoadingDialogManager.instance.showLoadingDialog(context);
          } else if (state.status.isError) {
            LoadingDialogManager.instance.showErrorDialog(
              context,
              state.status.message ?? '操作失败',
            );
            _bloc.add(const MtlSenterResetStatus());
          } else if (state.status.isSuccess &&
              (state.status.message ?? '').isNotEmpty) {
            LoadingDialogManager.instance.showSnackSuccessMsg(
              context,
              state.status.message!,
              duration: const Duration(milliseconds: 800),
            );
            _bloc.add(const MtlSenterResetStatus());
          }

          if (state.focus) {
            _scannerController.requestFocus();
            _bloc.add(const MtlSenterFocusConsumed());
          }

          _scannerController.clear();
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: AppBar(
              backgroundColor: const Color(0xFF1976D2),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => _handleBackPress(context),
              ),
              title: const Text(
                '拉式发料采集',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Column(
              children: [
                _buildScanner(state),
                _buildInfoCards(state),
                Expanded(child: _buildDataGrid(state)),
              ],
            ),
            bottomNavigationBar: _buildBottomBar(state),
          );
        },
      ),
    );
  }

  Widget _buildScanner(MtlSenterCollectionState state) {
    return ScannerWidget(
      controller: _scannerController,
      config: ScannerConfig(
        placeholder: state.placeholder,
        autoFocus: false,
        height: 64,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      ),
      onScanResult: (value) {
        _bloc.add(MtlSenterBarcodeScanned(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showSnackErrorMsg(
          context,
          message,
        );
      },
    );
  }

  Widget _buildInfoCards(MtlSenterCollectionState state) {
    final TextStyle labelStyle = Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: const Color(0xFF8A8A8A));
    final TextStyle valueStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.w600);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  label: '库位',
                  value: state.currentLocation ?? '--',
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoItem(
                  label: '库存',
                  value: _formatQuantity(state.availableQty),
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  label: '物料编码',
                  value: state.currentMaterial?.materialCode ?? '--',
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoItem(
                  label: '采集数量',
                  value: _formatQuantity(
                    state.collectedQtyMap.values
                        .fold<double>(0, (prev, e) => prev + e),
                  ),
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoItem(
            label: '物料名称',
            value: state.currentMaterial?.materialName ?? '--',
            labelStyle: labelStyle,
            valueStyle: valueStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  label: '最小包装数',
                  value: _formatQuantity(state.minPackageQty),
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoItem(
                  label: '默认配送量',
                  value: _formatQuantity(state.defaultDeliveryQty),
                  labelStyle: labelStyle,
                  valueStyle: valueStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem({
    required String label,
    required String value,
    required TextStyle labelStyle,
    required TextStyle valueStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 4),
        Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildDataGrid(MtlSenterCollectionState state) {
    return CommonDataGrid<MtlSenterCollectItem>(
      columns: _gridColumns(),
      datas: state.stocks,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: _selectedIndices(state),
      onSelectionChanged: (indices) {
        final ids = indices
            .where((index) => index >= 0 && index < state.stocks.length)
            .map((index) => state.stocks[index].id)
            .toSet();
        _bloc.add(MtlSenterSelectionChanged(ids));
      },
    );
  }

  List<int> _selectedIndices(MtlSenterCollectionState state) {
    final selected = <int>[];
    for (var i = 0; i < state.stocks.length; i++) {
      if (state.selectedIds.contains(state.stocks[i].id)) {
        selected.add(i);
      }
    }
    return selected;
  }

  List<GridColumnConfig<MtlSenterCollectItem>> _gridColumns() {
    return [
      GridColumnConfig<MtlSenterCollectItem>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo,
        width: 120,
      ),
      GridColumnConfig<MtlSenterCollectItem>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
        width: 160,
      ),
      GridColumnConfig<MtlSenterCollectItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName ?? '',
        width: 200,
      ),
      GridColumnConfig<MtlSenterCollectItem>(
        name: 'quantity',
        headerText: '数量',
        valueGetter: (row) => _formatQuantity(row.quantity),
        width: 100,
        textStyle: const TextStyle(color: Color(0xFF1976D2)),
      ),
      GridColumnConfig<MtlSenterCollectItem>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
        width: 120,
      ),
      GridColumnConfig<MtlSenterCollectItem>(
        name: 'serialNo',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
        width: 120,
      ),
    ];
  }

  String _formatQuantity(num? value) {
    if (value == null) return '--';
    final doubleValue = value.toDouble();
    if (!doubleValue.isFinite) {
      return '--';
    }
    if (doubleValue % 1 == 0) {
      return doubleValue.toInt().toString();
    }
    var text = doubleValue.toStringAsFixed(3);
    while (text.contains('.') && text.endsWith('0')) {
      text = text.substring(0, text.length - 1);
    }
    if (text.endsWith('.')) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  Widget _buildBottomBar(MtlSenterCollectionState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: state.hasSelection ? _confirmDelete : null,
              icon: const Icon(Icons.delete_outline),
              label: const Text('删除'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: state.canSubmit ? _confirmSubmit : null,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('提交'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('删除确认'),
        content: const Text('确定删除选中的采集记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result == true) {
      _bloc.add(const MtlSenterDeleteSelected());
    }
  }

  Future<void> _confirmSubmit() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('提交确认'),
        content: const Text('请确认是否提交本次采集结果？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result == true) {
      _bloc.add(const MtlSenterSubmitRequested());
    }
  }

  void _handleBackPress(BuildContext context) {
    if (_bloc.state.stocks.isNotEmpty) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('提示'),
          content: const Text('当前采集记录尚未提交，确定退出采集吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}
