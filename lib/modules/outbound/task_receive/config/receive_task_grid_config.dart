import 'package:flutter/material.dart';
import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../../task_list/models/outbound_task.dart';

typedef ReceiveTaskOperation = void Function(OutboundTask task);

class ReceiveTaskGridConfig {
  static List<GridColumnConfig<OutboundTask>> columns(
    ReceiveTaskOperation? onDetail,
  ) {
    return [
      GridColumnConfig<OutboundTask>(
        name: 'actions',
        headerText: '操作',
        width: 80,
        valueGetter: (task) => '',
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
      GridColumnConfig<OutboundTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 110,
        valueGetter: (task) => task.storeRoomNo,
      ),
      GridColumnConfig<OutboundTask>(
        name: 'orderNo',
        headerText: '出库单号',
        width: 180,
        valueGetter: (task) => task.orderNo,
      ),
      GridColumnConfig<OutboundTask>(
        name: 'poNumber',
        headerText: '来源单号',
        width: 180,
        valueGetter: (task) => task.poNumber,
      ),
      GridColumnConfig<OutboundTask>(
        name: 'workStation',
        headerText: '工位',
        width: 120,
        valueGetter: (task) => task.workStation,
      ),
      GridColumnConfig<OutboundTask>(
        name: 'outTaskNo',
        headerText: '任务号',
        width: 150,
        valueGetter: (task) => task.outTaskNo,
      ),
      GridColumnConfig<OutboundTask>(
        name: 'wipSupplementFlag',
        headerText: '紧急补单',
        width: 100,
        valueGetter: (task) => task.wipSupplementFlag,
      ),
      GridColumnConfig<OutboundTask>(
        name: 'scheduleGroupName',
        headerText: '班组',
        width: 160,
        valueGetter: (task) => task.scheduleGroupName ?? '',
      ),
      GridColumnConfig<OutboundTask>(
        name: 'taskComment',
        headerText: '凭证号',
        width: 160,
        valueGetter: (task) => task.taskComment,
      ),
    ];
  }
}
