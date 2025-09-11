import 'package:flutter/material.dart';

import '../models/outbound_collect_models.dart';
import '../models/outbound_task.dart';

/// 出库采集任务信息组件
class OutboundCollectTaskInfo extends StatelessWidget {
  final OutboundTask? outTask;
  final List<CollectRecord> collectRecords;

  const OutboundCollectTaskInfo({
    Key? key,
    this.outTask,
    required this.collectRecords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (outTask == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '任务编号: ${outTask!.outTaskNo}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '库房: ${outTask!.storeRoomNo}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(outTask!.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(outTask!.status),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  '计划数量',
                  '${outTask!.taskQty}',
                  Icons.list_alt,
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  '完成数量',
                  '${outTask!.finishQty}',
                  Icons.check_circle,
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  '已采集',
                  '${collectRecords.length}',
                  Icons.qr_code_scanner,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.blue,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case '0':
        return Colors.orange; // 待处理
      case '1':
        return Colors.blue; // 进行中
      case '2':
        return Colors.green; // 已完成
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case '0':
        return '待处理';
      case '1':
        return '进行中';
      case '2':
        return '已完成';
      default:
        return '未知';
    }
  }
}