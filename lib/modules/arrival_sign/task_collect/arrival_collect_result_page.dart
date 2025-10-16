import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/config/arrival_collect_grid_config.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/models/arrival_collect_progress.dart';

class ArrivalCollectResultPage extends StatefulWidget {
  const ArrivalCollectResultPage({super.key, required this.progresses});

  final List<ArrivalCollectProgress> progresses;

  @override
  State<ArrivalCollectResultPage> createState() =>
      _ArrivalCollectResultPageState();
}

class _ArrivalCollectResultPageState extends State<ArrivalCollectResultPage> {
  late List<ArrivalCollectProgress> _progresses;
  late List<ArrivalCollectSummary> _summaries;
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _progresses = List.of(widget.progresses);
    _summaries = _progresses.map(ArrivalCollectSummary.fromProgress).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop(_progresses.map((e) => e.toJson()).toList());
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: CustomAppBar(
          title: '到货签收采集结果',
          onBackPressed: () =>
              Modular.to.pop(_progresses.map((e) => e.toJson()).toList()),
        ).appBar,
        body: Column(
          children: [
            Expanded(child: _buildGrid()),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    if (_summaries.isEmpty) {
      return const Center(child: Text('暂无采集记录'));
    }

    return CommonDataGrid<ArrivalCollectSummary>(
      columns: ArrivalCollectGridConfig.summaryColumns(
        selectedIds: _selectedIds,
        onSelect: (id, selected) {
          setState(() {
            if (selected) {
              _selectedIds.add(id);
            } else {
              _selectedIds.remove(id);
            }
          });
        },
      ),
      datas: _summaries,
      allowPager: false,
      allowSelect: false,
      onLoadData: (index) async {},
      currentPage: 1,
      totalPages: 1,
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _selectedIds.isEmpty
                  ? null
                  : () => _confirmDelete(context),
              child: const Text('删除'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除确认'),
          content: const Text('确定删除选中的采集记录吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('删除'),
            ),
          ],
        );
      },
    );

    if (result != true) {
      return;
    }

    setState(() {
      _progresses = _progresses
          .where((p) => !_selectedIds.contains(p.id))
          .toList();
      _summaries = _summaries
          .where((summary) => !_selectedIds.contains(summary.id))
          .toList();
      _selectedIds.clear();
    });

    LoadingDialogManager.instance.showSnackSuccessMsg(context, '删除成功');
  }
}
