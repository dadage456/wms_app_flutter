import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_event.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/bloc/arrival_sign_detail_state.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/config/arrival_sign_detail_grid_config.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';

class ArrivalSignDetailPage extends StatefulWidget {
  const ArrivalSignDetailPage({
    super.key,
    required this.arrivalsBillId,
  });

  final String arrivalsBillId;

  @override
  State<ArrivalSignDetailPage> createState() => _ArrivalSignDetailPageState();
}

class _ArrivalSignDetailPageState extends State<ArrivalSignDetailPage> {
  late final ArrivalSignDetailBloc _bloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArrivalSignDetailBloc>(context);
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
        title: '到货任务明细',
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
      placeholder: '扫描或输入物料编码',
      clearOnSubmit: true,
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          _bloc.add(ArrivalSignDetailEvent.search(value));
        },
        onError: (message) {
          LoadingDialogManager.instance.showErrorDialog(context, message);
        },
      ),
    );
  }
}
