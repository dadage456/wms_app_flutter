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
        width: 80,
        valueGetter: (task) => '',
        textAlign: TextAlign.center,
        cellBuilder: (task, _, __) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () => onDetail?.call(task),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF), // Blue background
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Text('明细', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        valueGetter: (task) => task.inboundOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
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
        valueGetter: (task) => task.inTaskNo,
        textAlign: TextAlign.center,
      ),

      GridColumnConfig<GoodsUpTask>(
        name: 'partnerName',
        headerText: '供应商',
        valueGetter: (task) => task.partnerName ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'taskComment',
        headerText: '凭证号',
        valueGetter: (task) => task.taskComment ?? '-',
        textAlign: TextAlign.center,
      ),
    ];
  }
}
