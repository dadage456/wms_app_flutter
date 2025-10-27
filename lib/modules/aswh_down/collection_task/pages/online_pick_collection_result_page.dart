import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/collection_columns.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

class OnlinePickCollectionResultPage extends StatefulWidget {
  const OnlinePickCollectionResultPage({super.key});

  @override
  State<OnlinePickCollectionResultPage> createState() =>
      _OnlinePickCollectionResultPageState();
}

class _OnlinePickCollectionResultPageState
    extends State<OnlinePickCollectionResultPage> {
  final List<int> _selectedRows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('采集结果'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<OnlinePickCollectionBloc, OnlinePickCollectionState>(
        builder: (context, state) {
          final stocks = state.collectedStocks;
          final effectiveSelection = _selectedRows
              .where((index) => index >= 0 && index < stocks.length)
              .toList();

          return Column(
            children: [
              Expanded(
                child: CommonDataGrid<OnlinePickCollectionStock>(
                  columns: buildCollectionStockColumns(),
                  datas: stocks,
                  allowPager: false,
                  allowSelect: true,
                  currentPage: 1,
                  totalPages: 1,
                  onLoadData: (_) async {},
                  selectedRows: effectiveSelection,
                  onSelectionChanged: (indices) {
                    setState(() {
                      _selectedRows
                        ..clear()
                        ..addAll(indices);
                    });
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                  '共 ${stocks.length} 条采集记录，已选 ${effectiveSelection.length} 条',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _selectedRows.isEmpty
                      ? null
                      : () => _handleDeleteSelected(context),
                  child: const Text('删除选中'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('完成'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDeleteSelected(BuildContext context) {
    final bloc = context.read<OnlinePickCollectionBloc>();
    final stocks = bloc.state.collectedStocks;
    final selectedIds = _selectedRows
        .where((index) => index >= 0 && index < stocks.length)
        .map((index) => stocks[index].stockId)
        .toList();

    Navigator.of(context).pop(selectedIds);
  }
}
