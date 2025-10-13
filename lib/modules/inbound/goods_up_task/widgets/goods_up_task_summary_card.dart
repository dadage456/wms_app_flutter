import 'package:flutter/material.dart';

import '../models/goods_up_collection_task.dart';

class GoodsUpTaskSummaryCard extends StatelessWidget {
  const GoodsUpTaskSummaryCard({super.key, required this.task});

  final GoodsUpCollectionTask task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.taskNo),
        subtitle: Text(task.materialCode),
        trailing: Text(task.quantity.toStringAsFixed(2)),
      ),
    );
  }
}
