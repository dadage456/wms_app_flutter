import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/arrival_sign/services/arrival_sign_service.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_event.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_state.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/config/arrival_sign_detail_grid_config.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';

class ArrivalReceiveDetailPage extends StatefulWidget {
  const ArrivalReceiveDetailPage({
    super.key,
    required this.arrivalsBillId,
  });

  final String arrivalsBillId;

  @override
  State<ArrivalReceiveDetailPage> createState() => _ArrivalReceiveDetailPageState();
}

class _ArrivalReceiveDetailPageState extends State<ArrivalReceiveDetailPage> {
  late final ArrivalSignDetailBloc _bloc;
  late final ArrivalSignService _service;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArrivalSignDetailBloc>(context);
    _service = Modular.get<ArrivalSignService>();
    _bloc.add(ArrivalSignDetailEvent.initialized(widget.arrivalsBillId));
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '到货任务接收明细',
        onBackPressed: () => Navigator.of(context).pop(),
      ).appBar,
      body: BlocConsumer<ArrivalSignDetailBloc, ArrivalSignDetailState>(
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
          if (state.details.isEmpty && state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.details.isEmpty && state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          return Column(
            children: [
              _buildScanner(),
              Expanded(
                child: state.details.isEmpty
                    ? const Center(child: Text('当前任务列表没有待处理任务！'))
                    : CommonDataGrid<ArrivalSignDetail>(
                        columns: ArrivalSignDetailGridConfig.buildColumns(),
                        datas: state.details,
                        currentPage: state.currentPage,
                        totalPages: state.totalPages,
                        onLoadData: (pageIndex) async {
                          _bloc.add(
                            ArrivalSignDetailEvent.pageChanged(pageIndex),
                          );
                        },
                        allowPager: true,
                        allowSelect: false,
                        headerHeight: 44,
                        rowHeight: 48,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描单号/物料二维码',
      clearOnSubmit: true,
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          _handleScan(value);
        },
        onError: (message) {
          LoadingDialogManager.instance.showErrorDialog(context, message);
        },
      ),
    );
  }

  Future<void> _handleScan(String value) async {
    final keyword = value.trim();
    if (keyword.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '请输入或扫描有效内容');
      return;
    }

    try {
      String searchKey = keyword;
      if (keyword.contains('MC')) {
        searchKey = await _service.getMaterialCodeByQr(keyword);
      }
      _bloc.add(ArrivalSignDetailEvent.search(searchKey));
    } catch (error) {
      LoadingDialogManager.instance.showErrorDialog(
        context,
        error.toString(),
      );
    }
  }
}
