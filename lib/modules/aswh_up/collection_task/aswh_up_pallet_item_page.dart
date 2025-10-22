import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../models/aswh_up_collection_models.dart';
import 'bloc/aswh_up_pallet_item_cubit.dart';

class AswhUpPalletItemPage extends StatefulWidget {
  const AswhUpPalletItemPage({super.key});

  @override
  State<AswhUpPalletItemPage> createState() => _AswhUpPalletItemPageState();
}

class _AswhUpPalletItemPageState extends State<AswhUpPalletItemPage> {
  late final AswhUpPalletItemCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<AswhUpPalletItemCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AswhUpPalletItemCubit, AswhUpPalletItemState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingDialogManager.instance.showLoadingDialog(context);
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.errorMessage != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: CustomAppBar(
            title: '组盘上架提交结果',
            onBackPressed: () => Modular.to.pop(),
          ).appBar,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(state),
                const SizedBox(height: 16),
                Expanded(child: _buildGrid(state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AswhUpPalletItemState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.inventory_2_outlined, color: Color(0xFF465CFF)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '当前托盘',
                    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.trayNo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh_outlined),
              onPressed: state.isLoading ? null : _cubit.load,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(AswhUpPalletItemState state) {
    if (state.stocks.isEmpty && !state.isLoading) {
      return const Center(child: Text('暂无托盘提交记录'));
    }

    return CommonDataGrid<AswhUpCollectionStock>(
      columns: _columns,
      datas: state.stocks,
      allowPager: false,
      allowSelect: false,
      selectedRows: const [],
      onLoadData: (_) async {},
    );
  }

  List<GridColumnConfig<AswhUpCollectionStock>> get _columns {
    return [
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'trayNo',
        headerText: '托盘号',
        valueGetter: (item) => item.trayNo,
        textAlign: TextAlign.center,
        width: 140,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode,
        textAlign: TextAlign.center,
        width: 140,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (item) => item.taskQty,
        textAlign: TextAlign.center,
        width: 120,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (item) => item.collectQty,
        textAlign: TextAlign.center,
        width: 120,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (item) => item.batchNo ?? '-',
        textAlign: TextAlign.center,
        width: 140,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'serialNo',
        headerText: '序列',
        valueGetter: (item) => item.serialNo ?? '-',
        textAlign: TextAlign.center,
        width: 160,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (item) => item.storeRoom ?? '-',
        textAlign: TextAlign.center,
        width: 120,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (item) => item.storeSite ?? '-',
        textAlign: TextAlign.center,
        width: 140,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'taskItemId',
        headerText: '任务明细ID',
        valueGetter: (item) => item.taskItemId,
        textAlign: TextAlign.center,
        width: 140,
      ),
    ];
  }
}
