import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/inventory_task.dart';

typedef InventoryTaskOperation = void Function(InventoryTask task, int type);

class InventoryTaskGridConfig {
  static List<GridColumnConfig<InventoryTask>> columns(
    InventoryTaskOperation? operation, {
    bool showCancel = true,
  }) {
    return [
      GridColumnConfig<InventoryTask>(
        name: 'actions',
        headerText: '操作',
        width: 160,
        valueGetter: (task) => '',
        cellBuilder: (task, columnName, cellValue) {
          final buttons = <Widget>[
            SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () => operation?.call(task, 0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF465CFF),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(showCancel ? '采集' : '接收'),
              ),
            ),
          ];
          if (showCancel) {
            buttons.addAll([
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => operation?.call(task, 1),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF465CFF),
                    side: const BorderSide(color: Color(0xFF465CFF)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('撤销'),
                ),
              ),
            ]);
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons,
          );
        },
      ),
      GridColumnConfig<InventoryTask>(
        name: 'taskcomment',
        headerText: '盘库单号',
        width: 180,
        valueGetter: (task) => task.taskComment,
      ),
      GridColumnConfig<InventoryTask>(
        name: 'storeroomno',
        headerText: '库房号',
        width: 120,
        valueGetter: (task) => task.storeRoomNo,
      ),
      GridColumnConfig<InventoryTask>(
        name: 'storeroomname',
        headerText: '库房名称',
        width: 200,
        valueGetter: (task) => task.storeRoomName,
      ),
      GridColumnConfig<InventoryTask>(
        name: 'checktaskno',
        headerText: '任务号',
        width: 200,
        valueGetter: (task) => task.checkTaskNo,
      ),
      GridColumnConfig<InventoryTask>(
        name: 'status',
        headerText: '状态',
        width: 120,
        valueGetter: (task) => task.status ?? '',
      ),
    ];
  }
}
