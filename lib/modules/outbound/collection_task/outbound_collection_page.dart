import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_event.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/services/user_manager.dart';
import 'bloc/collection_bloc.dart';
import 'widgets/collection_input_widget.dart';
import 'widgets/collection_info_widget.dart';
import 'widgets/task_table_widget.dart';

class OutboundCollectionPage extends StatefulWidget {
  final OutboundTask task;

  const OutboundCollectionPage({Key? key, required this.task}): super(key: key);

  @override
  State<OutboundCollectionPage> createState() => _OutboundCollectionPageState();
}

class _OutboundCollectionPageState extends State<OutboundCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final userInfo = Modular.get<UserManager>().userInfo;
    BlocProvider.of<CollectionBloc>(context).add(InitializeTaskEvent(widget.task, userInfo!.userId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('平库下架采集'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBackPress(context),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'exception', child: Text('异常采集')),
              const PopupMenuItem(value: 'shortage', child: Text('报缺')),
            ],
          ),
        ],
      ),
      body: BlocConsumer<CollectionBloc, CollectionState>(
        listener: (context, state) {
          if (state.error != null) {
            _showErrorDialog(context, state.error!);
            Modular.get<CollectionBloc>().add(ClearErrorEvent());
          }

          debugPrint('------ state changed-----------');
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // 输入框
              CollectionInputWidget(
                placeholder: state.placeholder,
                focus: state.focus,
                onSubmitted: (value) {
                  Modular.get<CollectionBloc>().add(PerformBarcodeEvent(value));
                },
              ),
              // 信息卡片
              CollectionInfoWidget(
                storeSite: state.storeSite,
                repQty: state.repQty,
                barcodeContent: state.currentBarcode,
                collectQty: state.collectQty,
              ),
              // 标签页
              TabBar(
                controller: _tabController,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: '任务列表'),
                  Tab(text: '正在采集'),
                ],
                onTap: (index) {
                  Modular.get<CollectionBloc>().add(ChangeTabEvent(index));
                },
              ),
              // 表格内容
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 任务列表
                    TaskTableWidget(
                      items: state.detailList,
                      checkedIds: state.checkedIds,
                      onItemCheck: (id, selected) {
                        Modular.get<CollectionBloc>().add(
                          ToggleItemSelectionEvent(id, selected),
                        );
                      },
                      onSelectAll: (selected) {
                        Modular.get<CollectionBloc>().add(
                          ToggleAllSelectionEvent(selected),
                        );
                      },
                    ),
                    // 正在采集
                    TaskTableWidget(
                      items: state.collectionList,
                      checkedIds: state.checkedIds,
                      onItemCheck: (id, selected) {
                        Modular.get<CollectionBloc>().add(
                          ToggleItemSelectionEvent(id, selected),
                        );
                      },
                      onSelectAll: (selected) {
                        Modular.get<CollectionBloc>().add(
                          ToggleAllSelectionEvent(selected),
                        );
                      },
                      showSelection: false,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: '采集结果'),
            BottomNavigationBarItem(icon: Icon(Icons.upload), label: '提交'),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '更多'),
          ],
          onTap: (index) => _handleBottomNavTap(context, index),
        );
      },
    );
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // 采集结果 - 可以导航到采集结果页面
        break;
      case 1:
        _showCommitConfirmation(context);
        break;
      case 2:
        _showMoreOptions(context);
        break;
    }
  }

  void _showCommitConfirmation(BuildContext context) {
    final state = Modular.get<CollectionBloc>().state;

    if (state.stocks.isEmpty) {
      _showErrorDialog(context, '本次无采集明细，请确认！');
      return;
    }

    // 检查未完成任务
    String msg = '';
    for (final item in state.detailList) {
      if (item.hintqty != item.collectedqty) {
        msg =
            '库位【${item.storesiteno}】物料【${item.matcode}】还剩【${item.hintqty - item.collectedqty}】未做，请确认是否提交？';
        break;
      }
    }

    if (msg.isEmpty) {
      msg = '请确认是否提交？';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交确认'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Modular.get<CollectionBloc>().add(CommitCollectionEvent());
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('异常采集'),
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuAction(context, 'exception');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text('报缺'),
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuAction(context, 'shortage');
            },
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'exception':
        // 导航到异常采集页面
        Modular.to.pushNamed('/exception');
        break;
      case 'shortage':
        _handleShortageAction(context);
        break;
    }
  }

  void _handleShortageAction(BuildContext context) {
    final state = Modular.get<CollectionBloc>().state;

    if (state.stocks.isNotEmpty) {
      _showErrorDialog(context, '采集数据未提交,不允许报缺！');
      return;
    }

    if (state.checkedIds.isEmpty) {
      _showErrorDialog(context, '请至少选择一行记录！');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('物料报缺'),
        content: const Text('请确认是否该采集明细物料报缺？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Modular.get<CollectionBloc>().add(ReportShortageEvent());
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _handleBackPress(BuildContext context) {
    final state = Modular.get<CollectionBloc>().state;

    if (state.stocks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: const Text('当前采集记录尚未提交 确定退出采集吗？'),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('平库出库采集异常'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }
}
