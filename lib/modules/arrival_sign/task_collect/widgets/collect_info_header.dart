import 'package:flutter/material.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/bloc/arrival_collect_state.dart';

class CollectInfoHeader extends StatelessWidget {
  const CollectInfoHeader({super.key, required this.state});

  final ArrivalCollectState state;

  @override
  Widget build(BuildContext context) {
    final task = state.selectedTask;
    if (task == null) {
      return Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: const Text('请选择需要采集的物料'),
      );
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '物料：${task.materialCode} ${task.materialName ?? ''}',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _infoChip('批次', task.batchNo ?? '-'),
              _infoChip('序列', task.serialNumber ?? '-'),
              _infoChip('剩余数量', task.remainingQuantity.toString()),
              _infoChip('生产日期', task.productionDate ?? '-'),
              _infoChip('有效期', task.validDays ?? '-'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Chip(
      label: Text('$label：$value'),
      backgroundColor: const Color(0xFFEFF3F9),
    );
  }
}
