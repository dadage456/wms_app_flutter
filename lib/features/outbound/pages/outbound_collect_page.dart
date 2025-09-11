import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/outbound_collect_bloc.dart';
import '../bloc/outbound_collect_event.dart';
import '../bloc/outbound_collect_state.dart';
import '../models/outbound_collect_models.dart';
import '../models/outbound_task.dart';
import '../widgets/outbound_collect_task_info.dart';
import '../widgets/outbound_collect_record_list.dart';
import '../widgets/outbound_collect_scan_widget.dart';

/// 出库扫描采集页面
class OutboundCollectPage extends StatefulWidget {
  final String outTaskNo;
  final String workStation;
  final int userId;
  final String roleOrUserId;

  const OutboundCollectPage({
    super.key,
    required this.outTaskNo,
    required this.workStation,
    required this.userId,
    required this.roleOrUserId,
  });

  @override
  State<OutboundCollectPage> createState() => _OutboundCollectPageState();
}

class _OutboundCollectPageState extends State<OutboundCollectPage>
    with TickerProviderStateMixin {
  late OutboundCollectBloc _bloc;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<OutboundCollectBloc>();
    _tabController = TabController(length: 2, vsync: this);
    _initializePage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializePage() {
    final task = OutboundTask(
      outTaskId: 0,
      outTaskNo: widget.outTaskNo,
      orderNo: '',
      poNumber: '',
      storeRoomNo: '',
      workStation: widget.workStation,
      taskComment: '',
      scheduleGroupName: null,
      wipSupplementFlag: '',
      createTime: null,
      status: '',
      taskQty: 0,
      finishQty: 0,
    );
    
    _bloc.add(OutboundCollectEvent.initialize(
      task: task,
      workStation: widget.workStation,
      userId: widget.userId.toString(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('出库采集 - ${widget.outTaskNo}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<OutboundCollectBloc, OutboundCollectState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message, _, __, ___, ____, _____, ______, _______, ________, _________, __________) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              // 任务信息区域
              _buildTaskInfo(state),
              
              // Tab栏
              Container(
                color: Colors.grey[100],
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '任务明细'),
                    Tab(text: '采集记录'),
                  ],
                  onTap: (index) {
                    _bloc.add(OutboundCollectEvent.switchTab(tabIndex: index));
                  },
                ),
              ),
              
              // 搜索栏
              _buildSearchBar(state),
              
              // 内容区域
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 任务明细列表
                    _buildTaskItemsList(state),
                    // 采集记录列表
                    _buildCollectRecordsList(state),
                  ],
                ),
              ),
              
              // 扫码区域
              _buildScanWidget(state),
              
              // 底部操作栏
              _buildBottomActions(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTaskInfo(OutboundCollectState state) {
    return state.maybeWhen(
      loaded: (task, taskItems, collectRecords, currentTabIndex, currentScanStep, userId, workStation, currentSiteCode, currentBarcodeContent, currentInventory, isSubmitting, isValidating, errorMessage, successMessage) {
        return OutboundCollectTaskInfo(
          outTask: task,
          collectRecords: collectRecords,
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildSearchBar(OutboundCollectState state) {
    final showSearch = state.maybeWhen(
       loaded: (_, __, ___, currentTabIndex, ____, _____, ______, _______, ________, _________, __________, ___________, ____________, _____________) => currentTabIndex == 0,
       orElse: () => true,
     );

    if (!showSearch) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: '搜索物料编码或名称',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _bloc.add(
                OutboundCollectEvent.searchTaskItems(searchKey: ''),
              );
            },
          ),
        ),
        onChanged: (value) {
          _bloc.add(
            OutboundCollectEvent.searchTaskItems(searchKey: value),
          );
        },
      ),
    );
  }

  Widget _buildTaskItemsList(OutboundCollectState state) {
    return state.maybeWhen(
      loaded: (task, taskItems, collectRecords, currentTabIndex, currentScanStep, userId, workStation, currentSiteCode, currentBarcodeContent, currentInventory, isSubmitting, isValidating, errorMessage, successMessage) {
        if (taskItems.isEmpty) {
          return const Center(
            child: Text('暂无任务明细'),
          );
        }
        
        return ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (context, index) {
            final item = taskItems[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(item.matName ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('物料编码: ${item.matCode}'),
                    Text('库位: ${item.storeSiteNo}'),
                    Text('计划数量: ${item.hintQty}'),
                     Text('批次号: ${item.hintBatchNo ?? '无'}'),
                  ],
                ),
                trailing: const Icon(
                   Icons.radio_button_unchecked,
                   color: Colors.grey,
                 ),
              ),
            );
          },
        );
      },
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCollectRecordsList(OutboundCollectState state) {
    return state.maybeWhen(
      loaded: (task, taskItems, collectRecords, currentTabIndex, currentScanStep, userId, workStation, currentSiteCode, currentBarcodeContent, currentInventory, isSubmitting, isValidating, errorMessage, successMessage) {
        return OutboundCollectRecordList(
          collectRecords: collectRecords,
          onRemoveRecord: (index) {
            _bloc.add(
              OutboundCollectEvent.removeCollectRecord(index: index),
            );
          },
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildScanWidget(OutboundCollectState state) {
    return state.maybeWhen(
      loaded: (task, taskItems, collectRecords, currentTabIndex, currentScanStep, userId, workStation, currentSiteCode, currentBarcodeContent, currentInventory, isSubmitting, isValidating, errorMessage, successMessage) {
        return OutboundCollectScanWidget(
          currentScanStep: currentScanStep,
          currentSiteCode: currentSiteCode,
          currentBarcodeContent: currentBarcodeContent,
          currentInventory: currentInventory?.isNotEmpty == true ? currentInventory!.first : null,
          onScanCode: (code) {
            _bloc.add(
              OutboundCollectEvent.processScanCode(content: code),
            );
          },
          onConfirmQuantity: (quantity) {
            _bloc.add(
              OutboundCollectEvent.confirmQuantity(quantity: quantity),
            );
          },
          onResetScan: () {
            _bloc.add(
              const OutboundCollectEvent.resetScanState(),
            );
          },
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildBottomActions(OutboundCollectState state) {
    return state.maybeWhen(
      loaded: (task, taskItems, collectRecords, currentTabIndex, currentScanStep, userId, workStation, currentSiteCode, currentBarcodeContent, currentInventory, isSubmitting, isValidating, errorMessage, successMessage) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: collectRecords.isNotEmpty && !isSubmitting
                      ? () {
                          _bloc.add(
                            const OutboundCollectEvent.submitCollectData(),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text('提交采集数据 (${collectRecords.length})'),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: collectRecords.isNotEmpty
                    ? () {
                        _bloc.add(
                          const OutboundCollectEvent.clearCollectRecords(),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('清空记录'),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}