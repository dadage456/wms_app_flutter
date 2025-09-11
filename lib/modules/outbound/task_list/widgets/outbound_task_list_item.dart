import 'package:flutter/material.dart';
import '../models/outbound_task.dart';

/// 出库任务列表项
class OutboundTaskListItem extends StatelessWidget {
  const OutboundTaskListItem({
    super.key,
    required this.task,
    required this.onCollectTap,
    required this.onDetailTap,
  });

  final OutboundTask task;
  final VoidCallback onCollectTap;
  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题行：任务号和状态
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '任务号: ${task.outTaskNo}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusChip(context, task.status ?? ''),
              ],
            ),

            const SizedBox(height: 12),

            // 基本信息网格
            _buildInfoGrid(context),

            const SizedBox(height: 12),

            // 进度信息
            _buildProgressInfo(context),

            const SizedBox(height: 16),

            // 操作按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: onDetailTap, child: const Text('明细')),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: onCollectTap,
                  child: const Text('采集'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建状态标签
  Widget _buildStatusChip(BuildContext context, String status) {
    Color chipColor;
    String statusText;

    // 根据状态设置颜色和文本
    switch (status.toLowerCase()) {
      case 'pending':
      case '待处理':
        chipColor = Colors.orange;
        statusText = '待处理';
        break;
      case 'processing':
      case '处理中':
        chipColor = Colors.blue;
        statusText = '处理中';
        break;
      case 'completed':
      case '已完成':
        chipColor = Colors.green;
        statusText = '已完成';
        break;
      default:
        chipColor = Colors.grey;
        statusText = status;
    }

    return Chip(
      label: Text(
        statusText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  /// 构建信息网格
  Widget _buildInfoGrid(BuildContext context) {
    return Column(
      children: [
        _buildInfoRow('出库单号', task.orderNo),
        const SizedBox(height: 8),
        _buildInfoRow('来源单号', task.poNumber),
        const SizedBox(height: 8),
        _buildInfoRow('库房号', task.storeRoomNo),
        const SizedBox(height: 8),
        _buildInfoRow('工位', task.workStation),
        if (task.scheduleGroupName?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          _buildInfoRow('班组', task.scheduleGroupName ?? ''),
        ],
        if (task.wipSupplementFlag.isNotEmpty &&
            task.wipSupplementFlag != 'N') ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                '紧急补单: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: const Text(
                  '是',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// 构建信息行
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  /// 构建进度信息
  Widget _buildProgressInfo(BuildContext context) {
    final progress = task.taskQty > 0 ? task.finishQty / task.taskQty : 0.0;
    final progressPercent = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '完成进度',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            Text(
              '${task.finishQty}/${task.taskQty} ($progressPercent%)',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            progress >= 1.0 ? Colors.green : Colors.blue,
          ),
        ),
      ],
    );
  }
}
