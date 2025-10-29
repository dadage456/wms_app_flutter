import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/online_pick_collection_grid_config.dart';
import 'package:wms_app/modules/aswh_down/collection_task/widgets/online_pick_collection_info_card.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

class OnlinePickCollectionPage extends StatefulWidget {
  const OnlinePickCollectionPage({
    super.key,
    required this.task,
    this.initialArgs = const {},
  });

  final OnlinePickTask task;
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

  static const List<Map<String, String>> _exceptionTypeOptions = [
    {'value': '010', 'label': '小包装发料'},
    {'value': '006', 'label': '整包装多料'},
    {'value': '007', 'label': '整包装少料'},
    {'value': '008', 'label': '混料'},
    {'value': '009', 'label': '质量问题'},
  ];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickCollectionBloc>(context);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _canPop() {
    return _bloc.state.collectedStocks.isEmpty;
  }

  Future<void> _handleBackPress() async {
    if (_canPop()) {
      Modular.to.pop();
      return;
    }
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('返回确认'),
            content: const Text('返回将丢失未提交的采集记录，是否继续？'),
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
          ),
        ) ??
        false;
    if (confirmed) {
      Modular.to.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop(),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _handleBackPress,
          ),
          title: const Text(
            'AS/RS 下架采集',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _bloc.add(const OnlinePickCollectionCacheCleared());
              },
              icon: const Icon(Icons.cleaning_services_outlined,
                  color: Colors.white),
              tooltip: '清空缓存',
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF6F6F6),
        body:
            BlocConsumer<OnlinePickCollectionBloc, OnlinePickCollectionState>(
          listener: (context, state) {
            LoadingDialogManager.instance.hideLoadingDialog(context);

            if (state.status.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else if (state.status.isError) {
              LoadingDialogManager.instance.showErrorDialog(
                context,
                state.status.message ?? '操作失败',
              );
              _bloc.add(const OnlinePickCollectionResetStatus());
            } else if (state.status.isSuccess &&
                state.status.message?.isNotEmpty == true) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                state.status.message!,
                duration: const Duration(milliseconds: 900),
              );
              _bloc.add(const OnlinePickCollectionResetStatus());
            }

            if (state.currentTab != _tabController.index) {
              _tabController.index = state.currentTab;
            }

            if (state.focus) {
              _scannerController.requestFocus();
              _bloc.add(const OnlinePickCollectionFocusRequested(false));
            }

            _scannerController.clear();
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildScanner(state),
                OnlinePickCollectionInfoCard(state: state),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 44,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF1976D2),
                    unselectedLabelColor: const Color(0xFF78909C),
                    indicatorColor: const Color(0xFF1976D2),
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: '任务列表'),
                      Tab(text: '正在采集'),
                    ],
                    onTap: (index) {
                      _bloc.add(OnlinePickCollectionChangeTab(index));
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTaskGrid(state.detailList, state.selectedDetailIds),
                      _buildCollectingGrid(state.collectingList),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar:
            BlocBuilder<OnlinePickCollectionBloc, OnlinePickCollectionState>(
          buildWhen: (previous, current) =>
              previous.collectedStocks != current.collectedStocks ||
              previous.mode != current.mode ||
              previous.selectedLocation != current.selectedLocation ||
              previous.locationOptions != current.locationOptions ||
              previous.status != current.status,
          builder: (context, state) {
            return _buildBottomBar(state);
          },
        ),
      ),
    );
  }

  Widget _buildScanner(OnlinePickCollectionState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: ScannerWidget(
        controller: _scannerController,
        autofocus: true,
        config: ScannerConfig(
          showKeyboardToggle: true,
          placeholder: state.placeholder,
        ),
        onBarcodeScanned: (value) {
          _bloc.add(OnlinePickCollectionScanPerformed(value));
        },
      ),
    );
  }

  Widget _buildTaskGrid(
    List<OnlinePickTaskItem> items,
    List<int> selectedIds,
  ) {
    final selectedRows = _selectedIndicesFor(items, selectedIds);
    return CommonDataGrid<OnlinePickTaskItem>(
      columns: OnlinePickCollectionGridConfig.taskColumns(),
      datas: items,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      selectedRows: selectedRows,
      onLoadData: (_) async {},
      onSelectionChanged: (indices) {
        final selectedItems = indices
            .where((index) => index >= 0 && index < items.length)
            .map((index) => items[index])
            .toList();
        _bloc.add(OnlinePickCollectionSelectionChanged(selectedItems));
      },
    );
  }

  Widget _buildCollectingGrid(List<OnlinePickTaskItem> items) {
    return CommonDataGrid<OnlinePickTaskItem>(
      columns: OnlinePickCollectionGridConfig.taskColumns(),
      datas: items,
      allowPager: false,
      allowSelect: false,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: const [],
    );
  }

  Future<void> _openExceptionDialog(OnlinePickCollectionState state) async {
    final formKey = GlobalKey<FormState>();
    final currentItem = state.currentItem;
    final barcode = state.barcodeContent;

    final materialCodeController = TextEditingController(
      text: barcode?.materialCode ?? currentItem?.materialCode ?? '',
    );
    final materialNameController = TextEditingController(
      text: barcode?.materialName ?? currentItem?.materialName ?? '',
    );
    final batchController = TextEditingController(
      text: barcode?.batchNo ?? currentItem?.batchNo ?? currentItem?.hintBatchNo ?? '',
    );
    final serialController = TextEditingController(
      text: barcode?.serialNumber ?? currentItem?.serialNumber ?? '',
    );
    final unitController = TextEditingController();
    final descriptionController = TextEditingController();
    final initialQuantity = state.pendingQuantity ?? barcode?.quantity;
    final quantityController = TextEditingController(
      text: initialQuantity == null || initialQuantity == 0
          ? ''
          : initialQuantity.toString(),
    );
    final storeSiteController = TextEditingController(
      text: state.location.isNotEmpty
          ? state.location
          : (currentItem?.storeSiteNo ?? ''),
    );

    final defaultType = _exceptionTypeOptions.first['value']!;
    var selectedType = defaultType;

    final submission = await showDialog<OnlinePickExceptionSubmission>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('异常补录'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: materialCodeController,
                        decoration: const InputDecoration(
                          labelText: '物料编码',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '请输入物料编码';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: materialNameController,
                        decoration: const InputDecoration(
                          labelText: '物料名称',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: quantityController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: '异常数量',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final parsed = num.tryParse(value ?? '');
                          if (parsed == null || parsed <= 0) {
                            return '请输入有效的数量';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: storeSiteController,
                        decoration: const InputDecoration(
                          labelText: '库位',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '请输入库位';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: selectedType,
                        items: _exceptionTypeOptions
                            .map(
                              (option) => DropdownMenuItem<String>(
                                value: option['value'],
                                child: Text(option['label'] ?? option['value']!),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedType = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: '异常类型',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: batchController,
                        decoration: const InputDecoration(
                          labelText: '批次',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: serialController,
                        decoration: const InputDecoration(
                          labelText: '序列号',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: unitController,
                        decoration: const InputDecoration(
                          labelText: '单位',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: '异常描述',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('取消'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final quantity =
                          num.parse(quantityController.text.trim());
                      Navigator.of(context).pop(
                        OnlinePickExceptionSubmission(
                          materialCode: materialCodeController.text.trim(),
                          materialName: materialNameController.text.trim(),
                          quantity: quantity,
                          unit: unitController.text.trim(),
                          storeSite: storeSiteController.text.trim(),
                          batchNo: batchController.text.trim(),
                          serialNumber: serialController.text.trim(),
                          exceptionType: selectedType,
                          description: descriptionController.text.trim(),
                          trayNo: state.trayNo,
                        ),
                      );
                    }
                  },
                  child: const Text('提交'),
                ),
              ],
            );
          },
        );
      },
    );

    materialCodeController.dispose();
    materialNameController.dispose();
    batchController.dispose();
    serialController.dispose();
    unitController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    storeSiteController.dispose();

    if (submission != null) {
      _bloc.add(OnlinePickCollectionExceptionSubmitted(submission));
    }
  }

  Future<void> _confirmEmptyOut(OnlinePickCollectionState state) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('空托盘出库'),
              content: const Text('请确认空托盘出库吗？'),
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
        ) ??
        false;

    if (confirmed) {
      _bloc.add(const OnlinePickCollectionEmptyTrayOutboundRequested());
    }
  }

  Future<void> _confirmTrayReturn(OnlinePickCollectionState state) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            final tray = state.trayNo.isEmpty ? '当前托盘' : state.trayNo;
            return AlertDialog(
              title: const Text('托盘回库'),
              content: Text('确认将托盘【$tray】回库吗？'),
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
        ) ??
        false;

    if (confirmed) {
      _bloc.add(const OnlinePickCollectionTrayReturnRequested());
    }
  }

  Widget _buildMenuItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF546E7A)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  void _handleMoreAction(
    _MoreAction action,
    OnlinePickCollectionState state,
  ) {
    switch (action) {
      case _MoreAction.mode:
        _openModePicker(state);
        break;
      case _MoreAction.wcs:
        Modular.to.pushNamed('/aswh-down/wcs', arguments: {
          'taskId': widget.task.outTaskId,
          'taskNo': widget.task.outTaskNo,
        });
        break;
      case _MoreAction.exception:
        _openExceptionDialog(state);
        break;
      case _MoreAction.allTray:
        _openTrayConfirm(state);
        break;
      case _MoreAction.emptyOut:
        _confirmEmptyOut(state);
        break;
      case _MoreAction.emptyIn:
      case _MoreAction.singleTray:
        _showNotImplemented();
        break;
      case _MoreAction.reset:
        _confirmTrayReturn(state);
        break;
    }
  }

  Future<void> _openLocationPicker(OnlinePickCollectionState state) async {
    final options = state.locationOptions;
    if (options.isEmpty) {
      _showSnack('暂无可用的拣选口配置');
      return;
    }

    final selected = await showModalBottomSheet<OnlinePickLocationOption>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  '选择拣选口',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...options.map((option) {
                final isActive = option.value == state.selectedLocation?.value;
                return ListTile(
                  leading: Icon(
                    isActive ? Icons.check_circle : Icons.circle_outlined,
                    color: isActive
                        ? const Color(0xFF1976D2)
                        : const Color(0xFFB0BEC5),
                  ),
                  title: Text(option.label),
                  onTap: () => Navigator.of(context).pop(option),
                );
              }).toList(),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      _bloc.add(OnlinePickCollectionLocationSelected(selected));
    }
  }

  Future<void> _openModePicker(OnlinePickCollectionState state) async {
    final modes = state.availableModes;
    final selected = await showModalBottomSheet<OnlinePickCollectionMode>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  '切换采集模式',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...modes.map((mode) {
                final isActive = mode.type == state.mode;
                return ListTile(
                  leading: Icon(
                    isActive ? Icons.check_circle : Icons.circle_outlined,
                    color: isActive
                        ? const Color(0xFF1976D2)
                        : const Color(0xFFB0BEC5),
                  ),
                  title: Text(mode.label),
                  subtitle: Text(mode.code),
                  onTap: () => Navigator.of(context).pop(mode),
                );
              }).toList(),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      _bloc.add(OnlinePickCollectionModeChanged(selected));
    }
  }

  Future<void> _openTrayConfirm(OnlinePickCollectionState state) async {
    if (state.selectedLocation == null) {
      _showSnack('请先选择拣选口位置');
      return;
    }

    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController(text: '1');

    final count = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '托盘数量确认',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '下发托盘数量',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed <= 0) {
                      return '请输入有效的托盘数量';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('取消'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          final parsed = int.parse(controller.text);
                          Navigator.of(context).pop(parsed);
                        }
                      },
                      child: const Text('确认'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (count != null) {
      _bloc.add(OnlinePickCollectionPalletsCallRequested(count));
    }
  }

  void _showNotImplemented() {
    _showSnack('功能建设中，敬请期待');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildBottomBar(OnlinePickCollectionState state) {
    final locationLabel = state.selectedLocation?.label ?? '选择拣选口';
    final hasStocks = state.collectedStocks.isNotEmpty;

    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _openLocationPicker(state),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                foregroundColor: const Color(0xFF1976D2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.place_outlined, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      locationLabel,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.expand_more, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _openCollectionResult,
              icon: const Icon(Icons.list_alt_outlined),
              label: const Text('采集结果'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: hasStocks
                  ? () =>
                      _bloc.add(const OnlinePickCollectionSubmitRequested())
                  : null,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('提交采集'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43A047),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFB0BEC5),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PopupMenuButton<_MoreAction>(
              onSelected: (action) => _handleMoreAction(action, state),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: _MoreAction.mode,
                  child: _buildMenuItem(Icons.swap_horiz, '采集模式'),
                ),
                PopupMenuItem(
                  value: _MoreAction.wcs,
                  child: _buildMenuItem(
                    Icons.precision_manufacturing_outlined,
                    '查询指令',
                  ),
                ),
                PopupMenuItem(
                  value: _MoreAction.exception,
                  child: _buildMenuItem(Icons.error_outline, '异常补录'),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: _MoreAction.emptyOut,
                  child: _buildMenuItem(Icons.outbox_outlined, '空盘出库'),
                ),
                PopupMenuItem(
                  value: _MoreAction.emptyIn,
                  enabled: false,
                  child: _buildMenuItem(Icons.move_to_inbox_outlined, '空盘入库'),
                ),
                PopupMenuItem(
                  value: _MoreAction.singleTray,
                  enabled: false,
                  child: _buildMenuItem(Icons.one_k_plus_outlined, '单个托盘'),
                ),
                PopupMenuItem(
                  value: _MoreAction.reset,
                  child: _buildMenuItem(Icons.restart_alt, '回库'),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: _MoreAction.allTray,
                  child: _buildMenuItem(Icons.inventory_2_outlined, '全部托盘'),
                ),
              ],
              position: PopupMenuPosition.over,
              offset: const Offset(0, -4),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFB0BEC5)),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.more_horiz, color: Color(0xFF607D8B)),
                    SizedBox(width: 6),
                    Text(
                      '更多',
                      style: TextStyle(
                        color: Color(0xFF607D8B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openCollectionResult() async {
    final stocks = _bloc.state.collectedStocks;
    final result = await Modular.to.pushNamed<List<OnlinePickCollectionStock>>(
      '/aswh-down/collect/result',
      arguments: {
        'stocks': stocks,
      },
    );
    if (result != null && result.isNotEmpty) {
      _bloc.add(OnlinePickCollectionResultRemoved(result));
    }
    _bloc.add(
      const OnlinePickCollectionDetailsRefreshRequested(
        successMessage: '任务明细已刷新',
      ),
    );
  }

  List<int> _selectedIndicesFor(
    List<OnlinePickTaskItem> items,
    List<int> selectedIds,
  ) {
    if (selectedIds.isEmpty) {
      return const [];
    }
    final idToIndex = <int, int>{};
    for (var i = 0; i < items.length; i++) {
      idToIndex[items[i].outTaskItemId] = i;
    }
    return selectedIds
        .where(idToIndex.containsKey)
        .map((id) => idToIndex[id]!)
        .toList();
  }
}

enum _MoreAction {
  mode,
  wcs,
  exception,
  emptyOut,
  emptyIn,
  singleTray,
  reset,
  allTray,
}
