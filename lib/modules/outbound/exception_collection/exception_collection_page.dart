import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/modules/outbound/exception_collection/bloc/exception_collection_bloc.dart';
import 'package:wms_app/modules/outbound/exception_collection/bloc/exception_collection_event.dart';
import 'package:wms_app/modules/outbound/exception_collection/bloc/exception_collection_state.dart';
import 'package:wms_app/modules/outbound/exception_collection/models/exception_collection_args.dart';
import 'package:wms_app/modules/outbound/exception_collection/models/exception_collection_models.dart';

class ExceptionCollectionPage extends StatefulWidget {
  final ExceptionCollectionArgs args;

  const ExceptionCollectionPage({super.key, required this.args});

  @override
  State<ExceptionCollectionPage> createState() =>
      _ExceptionCollectionPageState();
}

class _ExceptionCollectionPageState extends State<ExceptionCollectionPage> {
  late ExceptionCollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();

  static const List<ExceptionTypeOption> _exceptionOptions = [
    ExceptionTypeOption(value: '010', label: '小包装发料'),
    ExceptionTypeOption(value: '006', label: '整包装多料'),
    ExceptionTypeOption(value: '007', label: '整包装少料'),
    ExceptionTypeOption(value: '008', label: '混料'),
    ExceptionTypeOption(value: '009', label: '质量问题'),
  ];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ExceptionCollectionBloc>(context);
    _bloc.add(
      InitializeExceptionCollectionEvent(
        task: widget.args.task,
        trayNo: widget.args.trayNo ?? '',
        initialStoreSite: widget.args.storeSite ?? '',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool canPop() {
    final state = _bloc.state;
    return state.stocks.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop(),

      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final canLeave = await _confirmLeaveIfNeeded();
        if (canLeave && mounted) {
          Modular.to.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            '异常采集',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () async {
              final canLeave = await _confirmLeaveIfNeeded();
              if (canLeave && mounted) {
                Modular.to.pop();
              }
            },
          ),
        ),
        body: BlocConsumer<ExceptionCollectionBloc, ExceptionCollectionState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else {
              LoadingDialogManager.instance.hideLoadingDialog(context);
            }

            if (state.error != null) {
              _showErrorDialog(state.error!);
              _bloc.add(const ExceptionClearErrorEvent());
            }

            if (state.successMessage != null) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                state.successMessage!,
                duration: const Duration(milliseconds: 800),
              );
              _bloc.add(const ExceptionClearMessageEvent());
              if (mounted) Modular.to.pop();
            }

            if (state.focus) {
              _scannerController.requestFocus();
            }

            _scannerController.clear();
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildScanInput(state.placeholder),
                _buildInfoCard(state),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildDataGrid(state),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildScanInput(String placeholder) {
    final config = ScannerConfig().copyWith(placeholder: placeholder);

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (code) {
        _bloc.add(ExceptionPerformScanEvent(code));
      },
      onError: (message) {
        _showErrorDialog(message);
      },
    );
  }

  Widget _buildInfoCard(ExceptionCollectionState state) {
    final trayNo = state.trayNo.isEmpty ? '-' : state.trayNo;
    final storeSite = state.storeSite.isEmpty ? '-' : state.storeSite;
    final matCode = state.matCode.isEmpty
        ? (state.barcodeContent?.matcode ?? '')
        : state.matCode;
    final batchNo = state.batchNo.isEmpty
        ? (state.barcodeContent?.batchno ?? '')
        : state.batchNo;
    final sn = state.sn.isEmpty ? (state.barcodeContent?.sn ?? '') : state.sn;
    final qty = state.collectQty == 0 ? '' : state.collectQty.toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildInfoRow('托盘号：', trayNo, '库位编码：', storeSite),
          _buildDottedDivider(),
          _buildInfoRow('物料：', matCode, '库存：', '-'),
          _buildDottedDivider(),
          _buildInfoRow('批次：', batchNo, '序列：', sn),
          _buildDottedDivider(),
          _buildInfoRow('采集数量：', qty, '异常类型：', state.exceptionName),
        ],
      ),
    );
  }

  Widget _buildDataGrid(ExceptionCollectionState state) {
    return CommonDataGrid<ExceptionCollectionItem>(
      columns: _buildColumns(),
      datas: state.items,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: _selectedIndices(state.items, state.selectedIds),
      onSelectionChanged: (indices) {
        _handleSelectionChanged(indices, state.items);
      },
    );
  }

  List<GridColumnConfig<ExceptionCollectionItem>> _buildColumns() {
    return [
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'matCode',
        headerText: '物料编码',
        valueGetter: (row) => row.matCode,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSite,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'exceptionName',
        headerText: '异常类型',
        valueGetter: (row) => row.exceptionName,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'qty',
        headerText: '已采数',
        valueGetter: (row) => row.qty,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'batchNo',
        headerText: '批号',
        valueGetter: (row) => row.batchNo,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'sn',
        headerText: '序列号',
        valueGetter: (row) => row.sn,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoom,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'proType',
        headerText: '类型',
        valueGetter: (row) => row.proType,
      ),
      GridColumnConfig<ExceptionCollectionItem>(
        name: 'taskId',
        headerText: '任务ID',
        valueGetter: (row) => row.taskId,
      ),
    ];
  }

  List<int> _selectedIndices(
    List<ExceptionCollectionItem> items,
    List<String> selectedIds,
  ) {
    final idSet = selectedIds.toSet();
    final indices = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (idSet.contains(items[i].id)) {
        indices.add(i);
      }
    }
    return indices;
  }

  void _handleSelectionChanged(
    List<int> indices,
    List<ExceptionCollectionItem> items,
  ) {
    final ids = indices.map((index) => items[index].id).toList();
    _bloc.add(ExceptionSelectionChangedEvent(ids));
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _showExceptionTypeSelector,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1976D2),
                side: const BorderSide(color: Color(0xFF1976D2)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('异常类型'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () => _bloc.add(const ExceptionDeleteSelectedEvent()),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFE55D52),
                side: const BorderSide(color: Color(0xFFE55D52)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('删除'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _handleCommit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('提交'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showExceptionTypeSelector() async {
    final currentType = _bloc.state.exceptionType;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _exceptionOptions.map((option) {
            final selected = option.value == currentType;
            return ListTile(
              title: Text(option.label),
              trailing: selected
                  ? const Icon(Icons.check, color: Color(0xFF1976D2))
                  : null,
              onTap: () {
                _bloc.add(
                  ExceptionTypeChangedEvent(
                    type: option.value,
                    name: option.label,
                  ),
                );
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _handleCommit() async {
    final state = _bloc.state;
    if (state.stocks.isEmpty) {
      _showErrorDialog('本次采集明细，请确认！');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交确认'),
        content: const Text('请确认是否提交？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确认'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _bloc.add(const ExceptionCommitRequestedEvent());
    }
  }

  Future<bool> _confirmLeaveIfNeeded() async {
    final state = _bloc.state;
    if (state.stocks.isEmpty) {
      return true;
    }

    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('当前采集记录尚未提交 确定退出采集吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('确认'),
          ),
        ],
      ),
    );

    return shouldLeave ?? false;
  }

  Widget _buildInfoRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    const infoStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 10,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(label1, style: infoStyle),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    value1,
                    style: infoStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 10,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(label2, style: infoStyle),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    value2,
                    style: infoStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF0067FC)),
              ),
            );
          }),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    LoadingDialogManager.instance.showErrorDialog(context, message);
  }
}
