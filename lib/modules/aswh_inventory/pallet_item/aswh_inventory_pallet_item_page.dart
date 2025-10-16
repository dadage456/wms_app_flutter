import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import 'bloc/aswh_inventory_pallet_item_bloc.dart';
import 'bloc/aswh_inventory_pallet_item_event.dart';
import 'bloc/aswh_inventory_pallet_item_state.dart';
import 'models/inventory_pallet_item.dart';

class AswhInventoryPalletItemPage extends StatefulWidget {
  const AswhInventoryPalletItemPage({super.key});

  @override
  State<AswhInventoryPalletItemPage> createState() =>
      _AswhInventoryPalletItemPageState();
}

class _AswhInventoryPalletItemPageState
    extends State<AswhInventoryPalletItemPage> {
  late final AswhInventoryPalletItemBloc _bloc;
  final ScannerController _scannerController = ScannerController();
  final Set<int> _expandedIndexes = <int>{};

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhInventoryPalletItemBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Modular.args;
      final params = args.params;
      final data = args.data as Map<String, dynamic>?;
      final trayNoParam = params['trayNo']?.toString();
      final trayNoData = data != null ? data['trayNo']?.toString() : null;
      final trayNo = trayNoParam?.isNotEmpty == true
          ? trayNoParam
          : (trayNoData?.isNotEmpty == true ? trayNoData : null);

      if (trayNo != null && trayNo.isNotEmpty) {
        _bloc.add(AswhInventoryPalletItemStarted(trayNo: trayNo));
      }
    });
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AswhInventoryPalletItemBloc, AswhInventoryPalletItemState>(
      listener: (context, state) {
        if (state.status == AswhInventoryPalletItemStatus.loading) {
          LoadingDialogManager.instance.showLoadingDialog(
            context,
            text: '正在加载托盘明细...',
          );
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.message != null && state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      child: Scaffold(
        appBar: BlocBuilder<AswhInventoryPalletItemBloc,
            AswhInventoryPalletItemState>(
          builder: (context, state) {
            final trayNo = state.trayNo ?? '托盘明细';
            return CustomAppBar(
              title: '托盘明细($trayNo)',
              onBackPressed: () => Modular.to.pop(),
            ).appBar;
          },
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildContent()),
          ],
        ),
        bottomNavigationBar: _buildActionBar(),
      ),
    );
  }

  Widget _buildSearchBar() {
    final config = ScannerConfig().copyWith(
      placeholder: '请输入托盘/物料/批次关键字',
      clearOnSubmit: true,
      autoFocus: false,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(AswhInventoryPalletItemKeywordChanged(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
      suffix: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          _scannerController.requestFocus();
        },
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<AswhInventoryPalletItemBloc, AswhInventoryPalletItemState>(
      builder: (context, state) {
        switch (state.status) {
          case AswhInventoryPalletItemStatus.initial:
          case AswhInventoryPalletItemStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case AswhInventoryPalletItemStatus.failure:
            return _buildRefreshWrapper(
              child: Center(
                child: Text(state.message ?? '托盘明细加载失败'),
              ),
            );
          case AswhInventoryPalletItemStatus.success:
            if (state.filteredItems.isEmpty) {
              return _buildRefreshWrapper(
                child: const Center(child: Text('暂无托盘明细')),
              );
            }
            return _buildRefreshWrapper(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: state.filteredItems.length + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index == state.filteredItems.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          '已经到底了',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  final item = state.filteredItems[index];
                  final isExpanded = _expandedIndexes.contains(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      child: ExpansionTile(
                        key: PageStorageKey('pallet_${item.palletNo}_$index'),
                        initiallyExpanded: isExpanded,
                        title: _buildTileHeader(item),
                        subtitle: _buildTileSubtitle(item),
                        onExpansionChanged: (expanded) {
                          setState(() {
                            if (expanded) {
                              _expandedIndexes.add(index);
                            } else {
                              _expandedIndexes.remove(index);
                            }
                          });
                        },
                        children: [_buildTileDetails(item)],
                      ),
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }

  Widget _buildRefreshWrapper({required Widget child}) {
    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(const AswhInventoryPalletItemRefreshRequested());
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [child],
      ),
    );
  }

  Widget _buildTileHeader(InventoryPalletItem item) {
    return Text(
      '托盘号：${item.palletNo ?? '-'}',
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTileSubtitle(InventoryPalletItem item) {
    final material = item.materialCode ?? '-';
    final qty = item.quantity ?? 0;
    return Text('物料：$material    数量：$qty');
  }

  Widget _buildTileDetails(InventoryPalletItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('物料名称', item.materialName),
          _buildDetailRow('批次', item.batchNo),
          _buildDetailRow('序列', item.serialNo),
          _buildDetailRow('凭证号', item.displayProofNo.isEmpty ? null : item.displayProofNo),
          _buildDetailRow('库位', item.storeSite),
          _buildDetailRow('库房', item.storeRoom),
        ].whereType<Widget>().toList(),
      ),
    );
  }

  Widget? _buildDetailRow(String label, String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return BlocBuilder<AswhInventoryPalletItemBloc,
        AswhInventoryPalletItemState>(
      builder: (context, state) {
        final enabled = state.filteredItems.isNotEmpty;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: ElevatedButton(
              onPressed: enabled
                  ? () => Navigator.of(context).pop(true)
                  : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('获取来料托盘'),
              ),
            ),
          ),
        );
      },
    );
  }
}
