import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../../task_list/models/inventory_task.dart';

typedef InventoryReceiveOperation = void Function(InventoryTaskSummary task);

class AswhInventoryReceiveGridConfig {
  static List<GridColumnConfig<InventoryTaskSummary>> columns(
    InventoryReceiveOperation? onReceive,
  ) {
    return [
      GridColumnConfig<InventoryTaskSummary>(
        name: 'actions',
        headerText: '操作',
        width: 160,
        cellBuilder: (task, columnName, cellValue) {
          return Center(
            child: SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () => onReceive?.call(task),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF465CFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('接收'),
              ),
            ),
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
    ];
  }
}
