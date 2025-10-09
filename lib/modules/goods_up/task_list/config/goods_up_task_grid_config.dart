import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/goods_up_task.dart';

typedef GoodsUpTaskOperation = void Function(GoodsUpTask task, int type);

class GoodsUpTaskGridConfig {
  static List<GridColumnConfig<GoodsUpTask>> columns(
    GoodsUpTaskOperation? onOperation,
  ) {
    return [
      GridColumnConfig<GoodsUpTask>(
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

      GridColumnConfig<GoodsUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        // width: 180,
        valueGetter: (task) => task.inboundOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
        // width: 160,
        valueGetter: (task) => task.sourceOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 100,
        valueGetter: (task) => task.storeRoomNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'workStation',
        headerText: '工位',
        width: 100,
        valueGetter: (task) => task.workStation ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'inTaskNo',
        headerText: '任务号',
        // width: 160,
        valueGetter: (task) => task.inTaskNo,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'partnerName',
        headerText: '供应商',
        // width: 220,
        valueGetter: (task) => task.partnerName ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        textAlign: TextAlign.center,
        name: 'taskComment',
        headerText: '凭证号',
        // width: 200,
        valueGetter: (task) => task.taskComment ?? '-',
      ),
    ];
  }
}
