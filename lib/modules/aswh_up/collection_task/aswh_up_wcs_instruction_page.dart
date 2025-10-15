import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../models/aswh_up_wcs_instruction.dart';
import 'bloc/aswh_up_wcs_instruction_cubit.dart';

class AswhUpWcsInstructionPage extends StatefulWidget {
  const AswhUpWcsInstructionPage({super.key});

  @override
  State<AswhUpWcsInstructionPage> createState() =>
      _AswhUpWcsInstructionPageState();
}

class _AswhUpWcsInstructionPageState
    extends State<AswhUpWcsInstructionPage> {
  late final AswhUpWcsInstructionCubit _cubit;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<AswhUpWcsInstructionCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.load();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AswhUpWcsInstructionCubit, AswhUpWcsInstructionState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingDialogManager.instance.showLoadingDialog(context);
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.errorMessage != null) {
          LoadingDialogManager.instance
              .showErrorDialog(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: CustomAppBar(
            title: 'WMS→WCS 指令',
            onBackPressed: () => Modular.to.pop(),
          ).appBar,
          body: Column(
            children: [
              _buildToolbar(state),
              Expanded(child: _buildGrid(state)),
              _buildBottomBar(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToolbar(AswhUpWcsInstructionState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '输入关键字过滤',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: (value) => _cubit.load(queryStr: value.trim()),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: state.isLoading
                ? null
                : () => _cubit.load(queryStr: _searchController.text.trim()),
            icon: const Icon(Icons.refresh_outlined),
            tooltip: '刷新',
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(AswhUpWcsInstructionState state) {
    if (state.instructions.isEmpty && !state.isLoading) {
      return const Center(child: Text('暂无指令记录'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonDataGrid<AswhUpWcsInstruction>(
        columns: _columns,
        datas: state.instructions,
        allowPager: false,
        allowSelect: false,
        selectedRows: const [],
        onLoadData: (_) async {},
        rowHeight: 48,
        headerHeight: 44,
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.08)),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showPendingDialog('撤销回指令'),
                child: const Text('撤销回指令'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showPendingDialog('撤销出库指令'),
                child: const Text('撤销出库指令'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () => _cubit.load(
                  queryStr: _searchController.text.trim(),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('刷新'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPendingDialog(String featureName) {
    LoadingDialogManager.instance.showErrorDialog(
      context,
      '$featureName 接口暂未对接，请联系管理员确认',
    );
  }

  List<GridColumnConfig<AswhUpWcsInstruction>> get _columns {
    return [
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'trayNo',
        headerText: '托盘号',
        valueGetter: (item) => item.trayNo ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'startAddress',
        headerText: '起始地址',
        valueGetter: (item) => item.startAddress ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'destinationAddress',
        headerText: '目标地址',
        valueGetter: (item) => item.destinationAddress ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'stackerNo',
        headerText: '堆垛机号',
        valueGetter: (item) => item.stackerNo ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'sendTime',
        headerText: '发送时间',
        valueGetter: (item) => item.sendTime ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'stateLabel',
        headerText: '状态',
        valueGetter: (item) => item.stateLabel ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'weightGrade',
        headerText: '重量等级',
        valueGetter: (item) => item.weightGrade ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'heightGrade',
        headerText: '高度等级',
        valueGetter: (item) => item.heightGrade ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'taskNo',
        headerText: '任务号',
        valueGetter: (item) => item.taskNo ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'voucherNo',
        headerText: '凭证号',
        valueGetter: (item) => item.voucherNo ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'taskTypeLabel',
        headerText: '任务类型',
        valueGetter: (item) => item.taskTypeLabel ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'changeTypeLabel',
        headerText: '更改类型',
        valueGetter: (item) => item.changeTypeLabel ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'inOutTypeLabel',
        headerText: '出入库',
        valueGetter: (item) => item.inOutTypeLabel ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'wcsErrorMessage',
        headerText: 'WCS错误',
        valueGetter: (item) => item.wcsErrorMessage ?? '-',
        width: 200,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'taskId',
        headerText: '任务ID',
        valueGetter: (item) => item.taskId ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'voucherId',
        headerText: '凭证ID',
        valueGetter: (item) => item.voucherId ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpWcsInstruction>(
        name: 'instructionId',
        headerText: '指令ID',
        valueGetter: (item) => item.instructionId ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
