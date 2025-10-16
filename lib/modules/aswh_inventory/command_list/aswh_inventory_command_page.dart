import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import 'bloc/aswh_inventory_command_bloc.dart';
import 'bloc/aswh_inventory_command_event.dart';
import 'bloc/aswh_inventory_command_state.dart';
import 'config/aswh_inventory_command_grid_config.dart';
import 'models/inventory_command_models.dart';

class AswhInventoryCommandPage extends StatefulWidget {
  const AswhInventoryCommandPage({super.key});

  @override
  State<AswhInventoryCommandPage> createState() =>
      _AswhInventoryCommandPageState();
}

class _AswhInventoryCommandPageState extends State<AswhInventoryCommandPage> {
  late final AswhInventoryCommandBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhInventoryCommandBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Modular.args.data as Map<String, dynamic>? ?? {};
      final taskComment = args['taskComment']?.toString() ?? '';
      final taskId = args['taskId']?.toString();
      final taskNo = args['taskNo']?.toString();
      final taskType = args['taskType']?.toString();
      final categoryParam = args['category']?.toString();
      final category = categoryParam == 'checkOrder'
          ? InventoryCommandCategory.checkOrder
          : InventoryCommandCategory.inventory;

      if (taskComment.isNotEmpty) {
        _bloc.add(
          AswhInventoryCommandStarted(
            taskComment: taskComment,
            taskId: taskId,
            taskNo: taskNo,
            taskType: taskType,
            category: category,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AswhInventoryCommandBloc, AswhInventoryCommandState>(
      listener: (context, state) {
        if (state.status == AswhInventoryCommandStatus.loading ||
            state.status == AswhInventoryCommandStatus.actionInProgress) {
          LoadingDialogManager.instance.showLoadingDialog(
            context,
            text: state.status == AswhInventoryCommandStatus.loading
                ? '正在加载指令...'
                : '正在撤销指令...',
          );
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.status == AswhInventoryCommandStatus.failure &&
            state.message != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.message!,
          );
        } else if (state.message != null && state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.select(
            (AswhInventoryCommandBloc bloc) => bloc.state.title,
          ),
          onBackPressed: () => Modular.to.pop(),
        ).appBar,
        body: Column(
          children: [
            Expanded(child: _buildDataGrid()),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildDataGrid() {
    return BlocBuilder<AswhInventoryCommandBloc, AswhInventoryCommandState>(
      builder: (context, state) {
        return CommonDataGrid<InventoryWcsCommand>(
          columns: AswhInventoryCommandGridConfig.columns(),
          datas: state.commands,
          currentPage: 1,
          totalPages: 1,
          allowPager: false,
          allowSelect: true,
          selectedRows: state.selectedRows,
          onSelectionChanged: (rows) {
            _bloc.add(AswhInventoryCommandSelectionChanged(rows));
          },
          onLoadData: (index) async {},
        );
      },
    );
  }

  Widget _buildActions() {
    return BlocBuilder<AswhInventoryCommandBloc, AswhInventoryCommandState>(
      builder: (context, state) {
        final disableActions =
            state.status == AswhInventoryCommandStatus.loading ||
                state.status == AswhInventoryCommandStatus.actionInProgress;
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, -2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: disableActions
                      ? null
                      : () => _confirmAndDispatch(
                            context,
                            InventoryCommandAction.revokeBack,
                            '撤销回指令',
                          ),
                  child: const Text('撤销回指令'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: disableActions
                      ? null
                      : () => _confirmAndDispatch(
                            context,
                            InventoryCommandAction.revokeOutbound,
                            '撤销出库指令',
                          ),
                  child: const Text('撤销出库指令'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: disableActions
                      ? null
                      : () =>
                          _bloc.add(const AswhInventoryCommandRefreshRequested()),
                  child: const Text('刷新'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmAndDispatch(
    BuildContext context,
    InventoryCommandAction action,
    String label,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('指令确认'),
          content: Text('是否确认$label?'),
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
    );

    if (confirmed == true) {
      _bloc.add(AswhInventoryCommandActionRequested(action));
    }
  }
}
