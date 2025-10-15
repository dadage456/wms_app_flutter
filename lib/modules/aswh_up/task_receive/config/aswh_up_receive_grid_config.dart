import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../../models/aswh_up_task.dart';

typedef AswhUpReceiveOperation = void Function(AswhUpTask task);

class AswhUpReceiveGridConfig {
  static List<GridColumnConfig<AswhUpTask>> columns(
    AswhUpReceiveOperation onDetail,
  ) {
    return [
      GridColumnConfig<AswhUpTask>(
        name: 'actions',
        headerText: '操作',
        width: 120,
        textAlign: TextAlign.center,
        valueGetter: (task) => '',
        cellBuilder: (task, _, __) {
          return Center(
            child: SizedBox(
              height: 32,
              child: OutlinedButton(
                onPressed: () => onDetail(task),
                child: const Text('明细', style: TextStyle(fontSize: 12)),
              ),
            ),
          );
        },
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        valueGetter: (task) => task.inboundOrderNo ?? '-',
        width: 180,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
        valueGetter: (task) => task.sourceOrderNo ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        valueGetter: (task) => task.storeRoomNo ?? '-',
        width: 100,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'workStation',
        headerText: '工位',
        valueGetter: (task) => task.workStation ?? '-',
        width: 100,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'inTaskNo',
        headerText: '任务号',
        valueGetter: (task) => task.inTaskNo,
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'partnerName',
        headerText: '供应商',
        valueGetter: (task) => task.partnerName ?? '-',
        width: 200,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTask>(
        name: 'taskComment',
        headerText: '凭证号',
        valueGetter: (task) => task.taskComment ?? '-',
        width: 180,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
