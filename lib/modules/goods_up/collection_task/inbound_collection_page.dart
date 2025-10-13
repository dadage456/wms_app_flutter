import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_bloc.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_event.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_state.dart';
import 'package:wms_app/modules/goods_up/collection_task/config/inbound_collection_grid_config.dart';
import 'package:wms_app/modules/goods_up/collection_task/inbound_collection_result_page.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_deleted_payload.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/custom_extension.dart';

class InboundCollectionPage extends StatefulWidget {
  const InboundCollectionPage({super.key, required this.task});

  final GoodsUpTask task;

  @override
  State<InboundCollectionPage> createState() => _InboundCollectionPageState();
}

class _InboundCollectionPageState extends State<InboundCollectionPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final InboundCollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();
  final TextEditingController _productionController = TextEditingController();
  final TextEditingController _expireController = TextEditingController();
  bool _isUpdatingSupplementFields = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InboundCollectionBloc>(context);
    _tabController = TabController(length: 2, vsync: this);

    final userInfo = Modular.get<UserManager>().userInfo;
    if (userInfo != null) {
      _bloc.add(
        InitializeInboundCollectionEvent(task: widget.task, userId: userInfo.userId),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _productionController.dispose();
    _expireController.dispose();
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
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress(context);
      },
      child: Scaffold(
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
            '平库上架采集',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocConsumer<InboundCollectionBloc, InboundCollectionState>(
          listener: (context, state) {
            LoadingDialogManager.instance.hideLoadingDialog(context);

            if (state.status.isError) {
              _showErrorDialog(context, state.status.message ?? '采集异常');
              _bloc.add(const ResetInboundStatusEvent());
            } else if (state.status.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else if (state.status.isSuccess && state.status.message != null) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                state.status.message!,
                duration: const Duration(milliseconds: 800),
              );
              _bloc.add(const ResetInboundStatusEvent());
            }

            if (state.currentTab != _tabController.index) {
              _tabController.index = state.currentTab;
            }

            if (state.focus) {
              _scannerController.requestFocus();
              _bloc.add(const SetInboundFocusEvent(false));
            }

            _isUpdatingSupplementFields = true;
            final barcode = state.currentBarcode;
            if (barcode != null) {
              final production = barcode.productionDate ?? '';
              if (_productionController.text != production) {
                _productionController.value = TextEditingValue(
                  text: production,
                  selection: TextSelection.collapsed(offset: production.length),
                );
              }
              final expire = barcode.expireDays == null
                  ? ''
                  : barcode.expireDays!.toString();
              if (_expireController.text != expire) {
                _expireController.value = TextEditingValue(
                  text: expire,
                  selection: TextSelection.collapsed(offset: expire.length),
                );
              }
            } else {
              if (_productionController.text.isNotEmpty) {
                _productionController.clear();
              }
              if (_expireController.text.isNotEmpty) {
                _expireController.clear();
              }
            }
            _isUpdatingSupplementFields = false;

            _scannerController.clear();
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildScanInput(state),
                _buildInfoCard(state),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 44,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF1976D2),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFF1976D2),
                    indicatorWeight: 3,
                    dividerHeight: 0,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: '任务列表'),
                      Tab(text: '正在采集'),
                    ],
                    onTap: (index) {
                      _bloc.add(ChangeInboundTabEvent(index));
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      CommonDataGrid<InboundCollectTaskItem>(
                        columns: InboundCollectionGridConfig.taskColumns(),
                        datas: state.detailList,
                        allowPager: false,
                        allowSelect: false,
                        currentPage: 1,
                        totalPages: 1,
                        onLoadData: (_) async {},
                        selectedRows: const [],
                      ),
                      CommonDataGrid<InboundCollectTaskItem>(
                        columns: InboundCollectionGridConfig.taskColumns(),
                        datas: state.collectionList,
                        allowPager: false,
                        allowSelect: false,
                        currentPage: 1,
                        totalPages: 1,
                        onLoadData: (_) async {},
                        selectedRows: const [],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: _buildBottomButtons(context),
      ),
    );
  }

  Widget _buildScanInput(InboundCollectionState state) {
    final keyboardType = state.scanStep == InboundScanStep.quantity
        ? TextInputType.number
        : TextInputType.text;

    final config = ScannerConfig().copyWith(
      placeholder: state.placeholder,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      height: 48,
      keyboardType: keyboardType,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (code) {
        _bloc.add(PerformInboundScanEvent(code));
      },
      onError: (message) {
        _showErrorDialog(context, message);
      },
    );
  }

  Widget _buildInfoCard(InboundCollectionState state) {
    final barcode = state.currentBarcode;
    final matCode = barcode?.materialKey ?? '';
    final batchNo = barcode?.batchNo ?? '';
    final sn = barcode?.serialNumber ?? '';
    final matName = barcode?.materialName ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            '库位：',
            state.storeSite,
            '库存：',
            state.repQty.toFormatString(),
          ),
          _buildDottedDivider(),
          _buildInfoRow(
            '物料：',
            matCode,
            '采集数量：',
            state.collectQty == 0 ? '' : state.collectQty.toFormatString(),
          ),
          _buildDottedDivider(),
          _buildInfoRow('名称：', matName, '', ''),
          _buildDottedDivider(),
          if (sn.isNotEmpty)
            _buildInfoRow('序列：', sn, '', '')
          else
            _buildInfoRow('批次：', batchNo, '', ''),
          _buildDottedDivider(),
          _buildSupplementRow(state),
          if (state.requireDangerousSupplement)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 16, color: Color(0xFFE55D52)),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      '危化品物料需补录生产日期和有效期后方可继续采集数量',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE55D52),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    const labelStyle = TextStyle(fontSize: 14, color: Color(0xFF666666));
    const valueStyle = TextStyle(
      fontSize: 14,
      color: Color(0xFF333333),
      fontWeight: FontWeight.w500,
    );

    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(label1, style: labelStyle),
                Expanded(
                  child: Text(
                    value1,
                    style: valueStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (label2.isNotEmpty)
            Expanded(
              child: Row(
                children: [
                  Text(label2, style: labelStyle),
                  Expanded(
                    child: Text(
                      value2,
                      style: valueStyle,
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
        final boxWidth = constraints.maxWidth;
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

  Widget _buildSupplementRow(InboundCollectionState state) {
    final isEnabled = state.currentBarcode != null;

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        isDense: true,
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD9D9D9)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1976D2), width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      );
    }

    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _productionController,
              enabled: isEnabled,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: _buildDecoration('生产日期'),
              onChanged: (value) {
                if (_isUpdatingSupplementFields) return;
                _bloc.add(UpdateInboundProductionDateEvent(value));
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _expireController,
              enabled: isEnabled,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: _buildDecoration('有效期(天)'),
              onChanged: (value) {
                if (_isUpdatingSupplementFields) return;
                _bloc.add(UpdateInboundExpireDaysEvent(value));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: const BoxDecoration(color: Colors.white),
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final stocks = List<InboundCollectionStock>.from(_bloc.state.stocks);
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        InboundCollectionResultPage(initialStocks: stocks),
                  ),
                );
                if (!mounted) return;
                if (result is InboundDeletedStocksPayload &&
                    result.deletedStocks.isNotEmpty) {
                  _bloc.add(UpdateInboundResultEvent(result.deletedStocks));
                  LoadingDialogManager.instance.showSnackSuccessMsg(
                    context,
                    '删除成功',
                    duration: const Duration(milliseconds: 800),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1976D2),
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Color(0xFF1976D2)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text('采集结果'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showCommitConfirmation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
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

  void _showCommitConfirmation(BuildContext context) {
    final state = _bloc.state;
    if (state.stocks.isEmpty) {
      _showErrorDialog(context, '本次无采集明细，请确认！');
      return;
    }

    String message = '请确认是否提交？';
    final pending = state.detailList.where((item) => item.planQty > item.collectedQty);
    if (pending.isNotEmpty) {
      final item = pending.first;
      final remain = (item.planQty - item.collectedQty).toFormatString();
      message =
          '库位【${item.storeSiteNo ?? ''}】物料【${item.materialCode ?? ''}】还剩【$remain】未采集，是否继续提交？';
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('提交确认'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _bloc.add(const CommitInboundCollectionEvent());
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _handleBackPress(BuildContext context) {
    if (_bloc.state.stocks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('提示'),
          content: const Text('当前采集记录尚未提交，确定退出采集吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Modular.to.pop();
              },
              child: const Text('确认'),
            ),
          ],
        ),
      );
    } else {
      Modular.to.pop();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    LoadingDialogManager.instance.showErrorDialog(context, message);
  }
}
