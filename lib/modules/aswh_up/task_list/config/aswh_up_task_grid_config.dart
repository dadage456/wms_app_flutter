import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../../models/aswh_up_task.dart';

typedef AswhUpTaskOperation = void Function(AswhUpTask task, int type);

class AswhUpTaskGridConfig {
  static List<GridColumnConfig<AswhUpTask>> columns(
    AswhUpTaskOperation? onOperation,
  ) {
    return [
      GridColumnConfig<AswhUpTask>(
        name: 'actions',
        headerText: '操作',
        width: 160,
        textAlign: TextAlign.center,
        valueGetter: (task) => '',
        cellBuilder: (task, columnName, cellValue) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () => onOperation?.call(task, 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF007AFF,
                      ), // Blue background
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: Text('采集', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () => onOperation?.call(task, 1),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E88E5),
                      side: const BorderSide(color: Color(0xFF1E88E5)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text('明细'),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      GridColumnConfig<AswhUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        // width: 180,
        valueGetter: (task) => task.inboundOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
        // width: 160,
        valueGetter: (task) => task.sourceOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 100,
        valueGetter: (task) => task.storeRoomNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'workStation',
        headerText: '工位',
        width: 100,
        valueGetter: (task) => task.workStation ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'inTaskNo',
        headerText: '任务号',
        // width: 160,
        valueGetter: (task) => task.inTaskNo,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'partnerName',
        headerText: '供应商',
        // width: 220,
        valueGetter: (task) => task.partnerName ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        textAlign: TextAlign.center,
        name: 'taskComment',
        headerText: '凭证号',
        // width: 200,
        valueGetter: (task) => task.taskComment ?? '-',
      ),
    ];
  }
}
