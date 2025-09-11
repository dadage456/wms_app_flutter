import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/outbound_task_detail_bloc.dart';
import 'bloc/outbound_task_detail_event.dart';
import 'bloc/outbound_task_detail_state.dart';
import 'models/outbound_task_item.dart';
import 'widgets/outbound_task_item_card.dart';
import 'widgets/outbound_scan_dialog.dart';
import 'widgets/outbound_batch_action_bar.dart';

/// 出库任务明细页面
class OutboundTaskDetailPage extends StatefulWidget {
  final String outTaskId;
  final String workStation;
  final int userId;
  final int roleOrUserId;

  const OutboundTaskDetailPage({
    Key? key,
    required this.outTaskId,
    required this.workStation,
    required this.userId,
    required this.roleOrUserId,
  }) : super(key: key);

  @override
  State<OutboundTaskDetailPage> createState() => _OutboundTaskDetailPageState();
}

class _OutboundTaskDetailPageState extends State<OutboundTaskDetailPage> {
  late OutboundTaskDetailBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OutboundTaskDetailBloc>(context);
    _initializePage();
    _setupScrollListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  /// 初始化页面
  void _initializePage() {
    final query = _bloc.getDefaultQuery(
      widget.outTaskId,
      widget.workStation,
      widget.userId,
      widget.roleOrUserId,
    );
    _bloc.add(OutboundTaskDetailEvent.loadTaskItems(query: query));
  }

  /// 设置滚动监听器
  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (!_isLoadingMore) {
          _loadMoreData();
        }
      }
    });
  }

  /// 加载更多数据
  void _loadMoreData() {
    final state = _bloc.state;
    state.when(
      initial: () {},
      loading: () {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) {
            if (hasMore && !_isLoadingMore) {
              setState(() {
                _isLoadingMore = true;
              });
              _bloc.add(const OutboundTaskDetailEvent.loadMore());
            }
          },
      error: (_, __, ___) {},
      scanning: () {},
      cancelling: (_, __) {},
    );
  }

  /// 处理搜索
  void _handleSearch(String searchKey) {
    final state = _bloc.state;
    state.when(
      initial: () {},
      loading: () {},
      loaded:
          (
            taskItems,
            selectedItemIds,
            hasMore,
            currentPage,
            totalCount,
            currentQuery,
            scannedMaterial,
          ) {
            if (currentQuery != null) {
              final searchQuery = currentQuery.copyWith(
                searchKey: searchKey.isEmpty ? '' : searchKey,
                pageIndex: 1,
              );
              _bloc.add(
                OutboundTaskDetailEvent.searchTaskItems(query: searchQuery),
              );
            }
          },
      error: (_, __, ___) {},
      scanning: () {},
      cancelling: (_, __) {},
    );
  }

  /// 显示扫码对话框
  void _showScanDialog() {
    showDialog(
      context: context,
      builder: (context) => OutboundScanDialog(
        onScanResult: (qrContent) {
          _bloc.add(OutboundTaskDetailEvent.scanQRCode(qrContent: qrContent));
        },
      ),
    );
  }

  /// 处理任务项选择
  void _handleTaskItemSelection(String taskItemId, bool isSelected) {
    _bloc.add(
      OutboundTaskDetailEvent.selectTaskItem(
        taskItemId: taskItemId,
        isSelected: isSelected,
      ),
    );
  }

  /// 处理全选/取消全选
  void _handleSelectAll(bool isSelectAll) {
    _bloc.add(OutboundTaskDetailEvent.selectAll(isSelectAll: isSelectAll));
  }

  /// 处理撤销选中项
  void _handleCancelSelected() {
    _bloc.add(const OutboundTaskDetailEvent.cancelSelectedItems());
  }

  /// 处理清除选择
  void _handleClearSelection() {
    _bloc.add(const OutboundTaskDetailEvent.clearSelection());
  }

  /// 处理刷新
  void _handleRefresh() {
    _bloc.add(const OutboundTaskDetailEvent.refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('平库下架任务明细'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: _showScanDialog,
            tooltip: '扫码搜索',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _handleRefresh,
            tooltip: '刷新',
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(),
          // 任务明细列表
          Expanded(
            child:
                BlocConsumer<OutboundTaskDetailBloc, OutboundTaskDetailState>(
                  listener: (context, state) {
                    state.when(
                      initial: () {},
                      loading: () {
                        setState(() {
                          _isLoadingMore = false;
                        });
                      },
                      loaded:
                          (
                            taskItems,
                            selectedItemIds,
                            hasMore,
                            currentPage,
                            totalCount,
                            currentQuery,
                            scannedMaterial,
                          ) {
                            setState(() {
                              _isLoadingMore = false;
                            });

                            // 如果有扫码结果，显示提示
                            if (scannedMaterial != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '已扫描物料: ${scannedMaterial.matCode}',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                      error: (message, taskItems, selectedItemIds) {
                        setState(() {
                          _isLoadingMore = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      scanning: () {
                        // 扫码状态处理
                      },
                      cancelling: (taskItems, selectedItemIds) {
                        // 撤销状态处理
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(child: Text('初始化中...')),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      loaded:
                          (
                            taskItems,
                            selectedItemIds,
                            hasMore,
                            currentPage,
                            totalCount,
                            currentQuery,
                            scannedMaterial,
                          ) {
                            if (taskItems.isEmpty) {
                              return const Center(child: Text('当前任务列表没有待处理任务'));
                            }

                            return RefreshIndicator(
                              onRefresh: () async {
                                _handleRefresh();
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(8.0),
                                itemCount: taskItems.length + (hasMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == taskItems.length) {
                                    // 加载更多指示器
                                    return const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final taskItem = taskItems[index];
                                  final isSelected = selectedItemIds.contains(
                                    taskItem.outTaskItemId.toString(),
                                  );

                                  return OutboundTaskItemCard(
                                    taskItem: taskItem,
                                    isSelected: isSelected,
                                    onSelectionChanged: (selected) {
                                      _handleTaskItemSelection(
                                        taskItem.outTaskItemId.toString(),
                                        selected,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                      error: (message, taskItems, selectedItemIds) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '加载失败',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              message,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _handleRefresh,
                              child: const Text('重试'),
                            ),
                          ],
                        ),
                      ),
                      scanning: () => const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('正在扫码...'),
                          ],
                        ),
                      ),
                      cancelling: (taskItems, selectedItemIds) => const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('正在撤销...'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      // 底部操作栏
      bottomNavigationBar:
          BlocBuilder<OutboundTaskDetailBloc, OutboundTaskDetailState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                loaded:
                    (
                      taskItems,
                      selectedItemIds,
                      hasMore,
                      currentPage,
                      totalCount,
                      currentQuery,
                      scannedMaterial,
                    ) {
                      return OutboundBatchActionBar(
                        selectedCount: selectedItemIds.length,
                        totalCount: taskItems.length,
                        onSelectAll: () => _handleSelectAll(true),
                        onDeselectAll: () => _handleSelectAll(false),
                        onCancelSelected: _handleCancelSelected,
                        onClearSelection: _handleClearSelection,
                      );
                    },
                error: (_, __, ___) => const SizedBox.shrink(),
                scanning: () => const SizedBox.shrink(),
                cancelling: (_, __) => const SizedBox.shrink(),
              );
            },
          ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '输入物料编码搜索',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
              onSubmitted: _handleSearch,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              _handleSearch(_searchController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
            child: const Text('搜索'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              _handleSearch('');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
            child: const Text('清除'),
          ),
        ],
      ),
    );
  }
}
