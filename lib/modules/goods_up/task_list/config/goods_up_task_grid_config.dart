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
        width: 180,
        valueGetter: (task) => '',
        cellBuilder: (task, column, value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () => onOperation?.call(task, 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF465CFF),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                  child: const Text('采集'),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 32,
                child: OutlinedButton(
                  onPressed: () => onOperation?.call(task, 1),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF465CFF),
                    side: const BorderSide(color: Color(0xFF465CFF)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                  child: const Text('明细'),
                ),
              ),
            ],
          );
        },
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'inTaskNo',
        headerText: '任务号',
        width: 160,
        valueGetter: (task) => task.inTaskNo,
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        width: 180,
        valueGetter: (task) => task.inboundOrderNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'sourceOrderNo',
        headerText: '来源单号',
        width: 160,
        valueGetter: (task) => task.sourceOrderNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 120,
        valueGetter: (task) => task.storeRoomNo ?? '-',
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
        width: 220,
        valueGetter: (task) => task.partnerName ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'taskComment',
        headerText: '凭证号',
        width: 200,
        valueGetter: (task) => task.taskComment ?? '-',
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 120,
        valueGetter: (task) => task.taskQty,
        cellBuilder: (task, column, value) {
          return Align(
            alignment: Alignment.centerRight,
            child: Text('${value ?? 0}'),
          );
        },
      ),
      GridColumnConfig<GoodsUpTask>(
        name: 'finishQty',
        headerText: '完成数量',
        width: 120,
        valueGetter: (task) => task.finishQty,
        cellBuilder: (task, column, value) {
          return Align(
            alignment: Alignment.centerRight,
            child: Text('${value ?? 0}'),
          );
        },
      ),
    ];
  }
}
