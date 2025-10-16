import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/inventory_task.dart';

typedef InventoryTaskOperation =
    void Function(InventoryTaskSummary task, int type);

class AswhInventoryTaskGridConfig {
  static List<GridColumnConfig<InventoryTaskSummary>> columns(
    InventoryTaskOperation? operation,
  ) {
    return [
      GridColumnConfig<InventoryTaskSummary>(
        name: 'actions',
        headerText: '操作',
        width: 180,
        cellBuilder: (task, columnName, cellValue) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () => operation?.call(task, 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF465CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('采集'),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 32,
                child: OutlinedButton(
                  onPressed: () => operation?.call(task, 1),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF465CFF),
                    side: const BorderSide(color: Color(0xFF465CFF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('撤销'),
                ),
              ),
            ],
          );
        },
      ),
      GridColumnConfig<InventoryTaskSummary>(
        name: 'taskComment',
        headerText: '盘库单号',
        width: 220,
        valueGetter: (task) => task.taskComment,
      ),
      GridColumnConfig<InventoryTaskSummary>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 140,
        valueGetter: (task) => task.storeRoomNo,
      ),
      GridColumnConfig<InventoryTaskSummary>(
        name: 'storeRoomName',
        headerText: '库房名称',
        width: 240,
        valueGetter: (task) => task.storeRoomName,
      ),
      GridColumnConfig<InventoryTaskSummary>(
        name: 'checkTaskNo',
        headerText: '任务号',
        width: 200,
        valueGetter: (task) => task.checkTaskNo,
      ),
      GridColumnConfig<InventoryTaskSummary>(
        name: 'status',
        headerText: '状态',
        width: 160,
        cellBuilder: (task, columnName, cellValue) {
          final status = task.status?.isNotEmpty == true ? task.status! : '待处理';
          final isFinished = status.contains('完成');
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isFinished
                  ? Colors.green.withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isFinished ? Colors.green : Colors.orange,
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isFinished ? Colors.green : Colors.orange,
              ),
            ),
          );
        },
      ),
    ];
  }
}
