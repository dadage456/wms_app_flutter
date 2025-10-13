import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/goods_up_collection_bloc.dart';
import 'widgets/goods_up_task_summary_card.dart';

class GoodsUpCollectionPage extends StatelessWidget {
  const GoodsUpCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('入库上架采集')),
      body: BlocBuilder<GoodsUpCollectionBloc, GoodsUpCollectionState>(
        builder: (context, state) {
          if (state is GoodsUpCollectionInitial) {
            context.read<GoodsUpCollectionBloc>().loadTasks();
            return const _LoadingIndicator();
          }
          if (state is GoodsUpCollectionLoadInProgress) {
            return const _LoadingIndicator();
          }
          if (state is GoodsUpCollectionLoadSuccess) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text('暂无待处理的上架任务'));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return GoodsUpTaskSummaryCard(task: task);
              },
            );
          }
          if (state is GoodsUpCollectionLoadFailure) {
            return Center(child: Text('加载失败：${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
