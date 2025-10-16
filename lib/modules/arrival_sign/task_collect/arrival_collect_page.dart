import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/bloc/arrival_collect_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/bloc/arrival_collect_event.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/bloc/arrival_collect_state.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/config/arrival_collect_grid_config.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/models/arrival_collect_progress.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/models/arrival_collect_task.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/widgets/collect_info_header.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';

class ArrivalCollectPage extends StatefulWidget {
  const ArrivalCollectPage({super.key, required this.task});

  final ArrivalSignTask task;

  @override
  State<ArrivalCollectPage> createState() => _ArrivalCollectPageState();
}

class _ArrivalCollectPageState extends State<ArrivalCollectPage>
    with SingleTickerProviderStateMixin {
  late final ArrivalCollectBloc _bloc;
  late final TabController _tabController;
  final ScannerController _scannerController = ScannerController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArrivalCollectBloc>(context);
    _bloc.add(ArrivalCollectEvent.initialized(widget.task));
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _bloc.add(ArrivalCollectEvent.switchTab(_tabController.index));
    });
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _tabController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArrivalCollectBloc, ArrivalCollectState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage ||
          previous.isSubmitting != current.isSubmitting,
      listener: (context, state) {
        if (state.isSubmitting) {
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

        if (state.successMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: CustomAppBar(
          title: '到货签收采集',
          onBackPressed: () async {
            if (mounted) {
              final shouldExit = await _confirmLeave(context);
              if (shouldExit == true && mounted) {
                Navigator.of(context).pop();
              }
            }
          },
        ).appBar,
        body: SafeArea(
          child: BlocBuilder<ArrivalCollectBloc, ArrivalCollectState>(
            builder: (context, state) {
              return Column(
                children: [
                  _buildScanner(state),
                  CollectInfoHeader(state: state),
                  _buildTabs(state),
                  _buildTabContent(state),
                  _buildBottomBar(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildScanner(ArrivalCollectState state) {
    final config = ScannerConfig().copyWith(
      placeholder: state.currentStep == ArrivalCollectScanStep.quantity
          ? '请输入采集数量'
          : '请扫描物料二维码',
      clearOnSubmit: true,
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          if (state.currentStep == ArrivalCollectScanStep.quantity) {
            final quantity = double.tryParse(value);
            if (quantity != null) {
              _bloc.add(ArrivalCollectEvent.quantitySubmitted(quantity));
              return;
            }
          }
          _bloc.add(ArrivalCollectEvent.scanSubmitted(value));
        },
        onError: (message) {
          LoadingDialogManager.instance.showErrorDialog(context, message);
        },
        suffix: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () =>
              _bloc.add(const ArrivalCollectEvent.refreshDetails()),
        ),
      ),
    );
  }

  Widget _buildTabs(ArrivalCollectState state) {
    if (_tabController.index != state.activeTabIndex) {
      _tabController.index = state.activeTabIndex;
    }
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black54,
        tabs: const [
          Tab(text: '任务列表'),
          Tab(text: '正在采集'),
        ],
      ),
    );
  }

  Widget _buildTabContent(ArrivalCollectState state) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [_buildTaskGrid(state), _buildCollectingGrid(state)],
      ),
    );
  }

  Widget _buildTaskGrid(ArrivalCollectState state) {
    if (state.isLoading && state.taskItems.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.taskItems.isEmpty) {
      return const Center(child: Text('暂无任务行'));
    }

    return CommonDataGrid<ArrivalCollectTask>(
      columns: ArrivalCollectGridConfig.taskColumns(
        onSelect: (task) => _bloc.add(ArrivalCollectEvent.selectTask(task)),
      ),
      datas: state.taskItems,
      allowPager: false,
      allowSelect: false,
      onLoadData: (index) async {},
      currentPage: 1,
      totalPages: 1,
    );
  }

  Widget _buildCollectingGrid(ArrivalCollectState state) {
    if (state.progresses.isEmpty) {
      return const Center(child: Text('暂无采集记录'));
    }

    return CommonDataGrid<ArrivalCollectProgress>(
      columns: ArrivalCollectGridConfig.collectingColumns(
        selectedIds: state.selectedProgressIds,
        onSelect: (id, selected) {
          _bloc.add(ArrivalCollectEvent.toggleCollectSelection(id));
        },
      ),
      datas: state.progresses,
      allowPager: false,
      allowSelect: false,
      onLoadData: (index) async {},
      currentPage: 1,
      totalPages: 1,
    );
  }

  Widget _buildBottomBar(ArrivalCollectState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: '手动输入数量',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    final qty = double.tryParse(value);
                    if (qty != null) {
                      _bloc.add(ArrivalCollectEvent.quantitySubmitted(qty));
                      _quantityController.clear();
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  final qty = double.tryParse(_quantityController.text);
                  if (qty != null) {
                    _bloc.add(ArrivalCollectEvent.quantitySubmitted(qty));
                    _quantityController.clear();
                  }
                },
                child: const Text('添加'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: state.progresses.isEmpty
                      ? null
                      : () => _navigateToResult(state),
                  child: const Text('采集结果'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: state.selectedProgressIds.isEmpty
                      ? null
                      : () => _bloc.add(
                          const ArrivalCollectEvent.deleteSelected(),
                        ),
                  child: const Text('删除'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: state.progresses.isEmpty || state.isSubmitting
                      ? null
                      : () => _bloc.add(const ArrivalCollectEvent.submit()),
                  child: const Text('提交'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToResult(ArrivalCollectState state) async {
    final result = await Modular.to.pushNamed<List<Map<String, dynamic>>>(
      '/arrival-sign/collect/result',
      arguments: {
        'progresses': state.progresses
            .map((progress) => progress.toJson())
            .toList(),
      },
    );
    if (result != null) {
      final progresses = result
          .map(ArrivalCollectProgress.fromJson)
          .toList(growable: false);
      _bloc.add(ArrivalCollectEvent.resultPageClosed(progresses));
    }
  }

  Future<bool?> _confirmLeave(BuildContext context) async {
    final state = _bloc.state;
    if (state.progresses.isEmpty) {
      return true;
    }

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('退出确认'),
          content: const Text('当前采集记录尚未提交，确定退出采集吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}
