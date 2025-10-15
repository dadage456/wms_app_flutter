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
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => onOperation?.call(task, 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    '采集',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => onOperation?.call(task, 1),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E88E5),
                    side: const BorderSide(color: Color(0xFF1E88E5)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('明细', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          );
        },
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        valueGetter: (task) => task.inboundOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
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
        valueGetter: (task) => task.inTaskNo,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'partnerName',
        headerText: '供应商',
        valueGetter: (task) => task.partnerName ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'taskComment',
        headerText: '凭证号',
        valueGetter: (task) => task.taskComment ?? '-',
        textAlign: TextAlign.center,
      ),
    ];
  }
}
