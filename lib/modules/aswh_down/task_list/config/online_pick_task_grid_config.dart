import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

typedef OnlinePickTaskOperation = void Function(
  OnlinePickTask task,
  int actionIndex,
);

class OnlinePickTaskGridConfig {
  static List<GridColumnConfig<OnlinePickTask>> columns(
    OnlinePickTaskOperation? operation,
  ) {
    return [
      GridColumnConfig<OnlinePickTask>(
        name: 'actions',
        headerText: '操作',
        width: 180,
        valueGetter: (_) => '',
        cellBuilder: (task, column, value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => operation?.call(task, 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('采集', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => operation?.call(task, 1),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E88E5),
                    side: const BorderSide(color: Color(0xFF1E88E5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('明细'),
                ),
              ),
            ],
          );
        },
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'taskComment',
        headerText: '凭证号',
        width: 160,
        valueGetter: (task) => task.taskComment,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 120,
        valueGetter: (task) => task.storeRoomNo,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'outTaskNo',
        headerText: '任务号',
        width: 180,
        valueGetter: (task) => task.outTaskNo,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'orderNo',
        headerText: '出库单号',
        width: 180,
        valueGetter: (task) => task.orderNo,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'poNumber',
        headerText: '来源单号',
        width: 180,
        valueGetter: (task) => task.poNumber,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'workStation',
        headerText: '工位',
        width: 120,
        valueGetter: (task) => task.workStation,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'urgentFlag',
        headerText: '紧急补单',
        width: 100,
        valueGetter: (task) => task.urgentFlag,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'scheduleGroupName',
        headerText: '班组',
        width: 140,
        valueGetter: (task) => task.scheduleGroupName,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        valueGetter: (task) => task.taskQty,
        cellBuilder: (task, column, value) {
          return Align(
            alignment: Alignment.centerRight,
            child: Text('${task.taskQty}'),
          );
        },
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'finishQty',
        headerText: '完成数量',
        width: 110,
        valueGetter: (task) => task.finishQty,
        cellBuilder: (task, column, value) {
          return Align(
            alignment: Alignment.centerRight,
            child: Text('${task.finishQty}'),
          );
        },
      ),
    ];
  }
}
