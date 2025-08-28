import 'package:flutter/material.dart';
import '../models/outbound_task_item.dart';

/// 出库任务明细项卡片组件
class OutboundTaskItemCard extends StatelessWidget {
  final OutboundTaskItem taskItem;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;

  const OutboundTaskItemCard({
    Key? key,
    required this.taskItem,
    required this.isSelected,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 2,
      child: InkWell(
        onTap: () => onSelectionChanged(!isSelected),
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: isSelected
                ? Border.all(color: Colors.blue, width: 2)
                : null,
            color: isSelected ? Colors.blue.withOpacity(0.05) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头部：选择框和物料编码
              Row(
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (value) => onSelectionChanged(value ?? false),
                    activeColor: Colors.blue,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskItem.matCode,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        if (taskItem.matName.isNotEmpty)
                          Text(
                            taskItem.matName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  // 任务数量
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      '数量: ${taskItem.hintQty}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange[800],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 详细信息网格
              _buildInfoGrid(),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建信息网格
  Widget _buildInfoGrid() {
    final infoItems = [
      _InfoItem('库位', taskItem.storeSiteNo),
      _InfoItem('库房', taskItem.storeRoomNo),
      _InfoItem('子库', taskItem.subInventoryCode),
      _InfoItem('批次', taskItem.hintBatchNo ?? ''),
      _InfoItem('序列号', taskItem.sn ?? ''),
      _InfoItem('出库单号', taskItem.orderNo),
    ];

    // 过滤掉空值
    final validItems = infoItems
        .where((item) => item.value.isNotEmpty)
        .toList();

    if (validItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        for (int i = 0; i < validItems.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(child: _buildInfoItem(validItems[i])),
                if (i + 1 < validItems.length) ...[
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoItem(validItems[i + 1])),
                ] else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }

  /// 构建单个信息项
  Widget _buildInfoItem(_InfoItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            '${item.label}:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            item.value,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// 信息项数据类
class _InfoItem {
  final String label;
  final String value;

  const _InfoItem(this.label, this.value);
}
