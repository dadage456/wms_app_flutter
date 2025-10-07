import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../../task_list/models/goods_up_task.dart';

typedef InboundReceiveTaskOperation = void Function(GoodsUpTask task);

class InboundReceiveTaskGridConfig {
  static List<GridColumnConfig<GoodsUpTask>> columns(
    InboundReceiveTaskOperation? onDetail,
  ) {
    return [
      GridColumnConfig<GoodsUpTask>(
        name: 'actions',
        headerText: '操作',
        width: 90,
        valueGetter: (task) => '',
        cellBuilder: (task, column, value) {
          return Center(
            child: SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () => onDetail?.call(task),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('明细'),
              ),
            ),
          );
        },
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 120,
        valueGetter: (task) => task.storeRoomNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'inTaskNo',
        headerText: '任务号',
        width: 150,
        valueGetter: (task) => task.inTaskNo,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        width: 170,
        valueGetter: (task) => task.inboundOrderNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
        width: 170,
        valueGetter: (task) => task.sourceOrderNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'workStation',
        headerText: '工位',
        width: 120,
        valueGetter: (task) => task.workStation ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'partnerName',
        headerText: '供应商',
        width: 200,
        valueGetter: (task) => task.partnerName ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'taskComment',
        headerText: '凭证号',
        width: 160,
        valueGetter: (task) => task.taskComment ?? '-',
      ),
    ];
  }
}
