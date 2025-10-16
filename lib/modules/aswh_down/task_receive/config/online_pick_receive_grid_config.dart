import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

typedef OnlinePickReceiveDetailCallback = void Function(OnlinePickTask task);

class OnlinePickReceiveGridConfig {
  static List<GridColumnConfig<OnlinePickTask>> columns(
    OnlinePickReceiveDetailCallback? onDetail,
  ) {
    return [
      GridColumnConfig<OnlinePickTask>(
        name: 'actions',
        headerText: '操作',
        width: 90,
        valueGetter: (task) => '',
        cellBuilder: (task, _, __) => Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () => onDetail?.call(task),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('明细', style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'outTaskNo',
        headerText: '任务号',
        width: 160,
        valueGetter: (task) => task.outTaskNo,
        enableSelectableText: true,
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 110,
        valueGetter: (task) => task.storeRoomNo ?? '',
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'orderNo',
        headerText: '出库单号',
        width: 180,
        valueGetter: (task) => task.orderNo ?? '',
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'taskComment',
        headerText: '凭证号',
        width: 180,
        valueGetter: (task) => task.taskComment ?? '',
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'workStation',
        headerText: '工位',
        width: 120,
        valueGetter: (task) => task.workStation ?? '',
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'scheduleGroupName',
        headerText: '班组',
        width: 160,
        valueGetter: (task) => task.scheduleGroupName ?? '',
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        valueGetter: (task) => task.taskQty,
        cellBuilder: (task, _, __) => Align(
          alignment: Alignment.centerRight,
          child: Text('${task.taskQty}'),
        ),
      ),
      GridColumnConfig<OnlinePickTask>(
        name: 'finishQty',
        headerText: '完成数量',
        width: 110,
        valueGetter: (task) => task.finishQty,
        cellBuilder: (task, _, __) => Align(
          alignment: Alignment.centerRight,
          child: Text('${task.finishQty}'),
        ),
      ),
    ];
  }
}
