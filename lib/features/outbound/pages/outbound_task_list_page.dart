import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../bloc/outbound_task_bloc.dart';
import '../bloc/outbound_task_event.dart';
import '../bloc/outbound_task_state.dart';
import '../models/outbound_task.dart';
import '../widgets/outbound_task_list_item.dart';
import '../widgets/outbound_task_filter_dialog.dart';
import '../widgets/outbound_search_bar.dart';

/// 出库任务列表页面
class OutboundTaskListPage extends HookWidget {
  const OutboundTaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final scrollController = useScrollController();
    final refreshIndicatorKey = useMemoized(
      () => GlobalKey<RefreshIndicatorState>(),
    );

    // 当前筛选状态
    final currentFilter = useState<String>('0'); // '0': 采集中, '1': 所有
    final currentPage = useState<int>(1);

    // 获取BLoC实例
    final outboundTaskBloc = Modular.get<OutboundTaskBloc>();

    // 初始化加载数据
    useEffect(() {
      final defaultQuery = outboundTaskBloc.getDefaultQuery();
      if (defaultQuery != null) {
        outboundTaskBloc.add(LoadOutboundTasksEvent(defaultQuery));
      }
      return null;
    }, []);

    // 监听滚动事件，实现分页加载
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          // 接近底部时加载下一页
          final state = outboundTaskBloc.state;
          if (state is OutboundTaskLoaded && !state.hasReachedMax) {
            outboundTaskBloc.add(LoadPageEvent(state.currentPage + 1));
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Container(color: Colors.blue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('平库下架'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 筛选按钮
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () =>
                _showFilterDialog(context, currentFilter, outboundTaskBloc),
          ),
          // 刷新按钮
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                outboundTaskBloc.add(const RefreshOutboundTasksEvent()),
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          OutboundSearchBar(
            controller: searchController,
            onSearch: (searchKey) {
              outboundTaskBloc.add(SearchOutboundTasksEvent(searchKey));
            },
            onScanCode: (code) {
              searchController.text = code;
              outboundTaskBloc.add(SearchOutboundTasksEvent(code));
            },
          ),

          // 任务列表
          Expanded(
            child: BlocBuilder<OutboundTaskBloc, OutboundTaskState>(
              bloc: outboundTaskBloc,
              builder: (context, state) {
                return RefreshIndicator(
                  key: refreshIndicatorKey,
                  onRefresh: () async {
                    outboundTaskBloc.add(const RefreshOutboundTasksEvent());
                    // 等待刷新完成
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: _buildTaskList(
                    context,
                    state,
                    scrollController,
                    outboundTaskBloc,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建任务列表
  Widget _buildTaskList(
    BuildContext context,
    OutboundTaskState state,
    ScrollController scrollController,
    OutboundTaskBloc bloc,
  ) {
    if (state is OutboundTaskLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is OutboundTaskError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('加载失败', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => bloc.add(const RefreshOutboundTasksEvent()),
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (state is OutboundTaskLoaded ||
        state is OutboundTaskRefreshing ||
        state is OutboundTaskPageLoading) {
      List<OutboundTask> tasks = [];
      int total = 0;
      bool isRefreshing = false;
      bool isPageLoading = false;

      if (state is OutboundTaskLoaded) {
        tasks = state.tasks;
        total = state.total;
      } else if (state is OutboundTaskRefreshing) {
        tasks = state.tasks;
        total = state.total;
        isRefreshing = true;
      } else if (state is OutboundTaskPageLoading) {
        tasks = state.tasks;
        total = state.total;
        isPageLoading = true;
      }

      if (tasks.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                '当前任务列表没有待处理任务',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: tasks.length + (isPageLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= tasks.length) {
            // 分页加载指示器
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final task = tasks[index];
          return OutboundTaskListItem(
            task: task,
            onCollectTap: () => _navigateToCollect(context, task),
            onDetailTap: () => _navigateToDetail(context, task),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }

  /// 显示筛选对话框
  void _showFilterDialog(
    BuildContext context,
    ValueNotifier<String> currentFilter,
    OutboundTaskBloc bloc,
  ) {
    showDialog(
      context: context,
      builder: (context) => OutboundTaskFilterDialog(
        currentFilter: currentFilter.value,
        onFilterChanged: (filter) {
          currentFilter.value = filter;
          bloc.add(FilterOutboundTasksEvent(filter));
        },
      ),
    );
  }

  /// 导航到采集页面
  void _navigateToCollect(BuildContext context, OutboundTask task) {
    // TODO: 实现导航到采集页面
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('导航到采集页面: ${task.outTaskNo}')));
  }

  /// 导航到明细页面
  void _navigateToDetail(BuildContext context, OutboundTask task) {
    // TODO: 实现导航到明细页面
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('导航到明细页面: ${task.outTaskNo}')));
  }
}
