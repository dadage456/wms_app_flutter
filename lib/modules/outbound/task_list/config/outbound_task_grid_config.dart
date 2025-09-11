import 'package:flutter/material.dart';
import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/outbound_task.dart';

/// 出库任务表格列配置
class OutboundTaskGridConfig {
  static List<GridColumnConfig<OutboundTask>> getColumns() {
    return [
      // 任务ID
      GridColumnConfig<OutboundTask>(
        name: 'outTaskId',
        headerText: '任务ID',
        width: 120,
        valueGetter: (task) => task.outTaskId,
      ),
      
      // 任务号
      GridColumnConfig<OutboundTask>(
        name: 'outTaskNo',
        headerText: '任务号',
        width: 150,
        valueGetter: (task) => task.outTaskNo,
      ),
      
      // 出库单号
      GridColumnConfig<OutboundTask>(
        name: 'orderNo',
        headerText: '出库单号',
        width: 150,
        valueGetter: (task) => task.orderNo,
      ),
      
      // 来源单号
      GridColumnConfig<OutboundTask>(
        name: 'poNumber',
        headerText: '来源单号',
        width: 150,
        valueGetter: (task) => task.poNumber,
      ),
      
      // 库房号
      GridColumnConfig<OutboundTask>(
        name: 'storeRoomNo',
        headerText: '库房号',
        width: 120,
        valueGetter: (task) => task.storeRoomNo,
      ),
      
      // 工位
      GridColumnConfig<OutboundTask>(
        name: 'workStation',
        headerText: '工位',
        width: 100,
        valueGetter: (task) => task.workStation,
      ),
      
      // 任务数量
      GridColumnConfig<OutboundTask>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 100,
        valueGetter: (task) => task.taskQty,
        cellBuilder: (task, columnName, cellValue) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerRight,
            child: Text(
              cellValue?.toString() ?? '0',
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
      
      // 完成数量
      GridColumnConfig<OutboundTask>(
        name: 'finishQty',
        headerText: '完成数量',
        width: 100,
        valueGetter: (task) => task.finishQty,
        cellBuilder: (task, columnName, cellValue) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerRight,
            child: Text(
              cellValue?.toString() ?? '0',
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
      
      // 班组
      GridColumnConfig<OutboundTask>(
        name: 'scheduleGroupName',
        headerText: '班组',
        width: 120,
        valueGetter: (task) => task.scheduleGroupName,
      ),
      
      // 状态
      GridColumnConfig<OutboundTask>(
        name: 'status',
        headerText: '状态',
        width: 100,
        valueGetter: (task) => task.status,
        cellBuilder: (task, columnName, cellValue) {
          final status = cellValue?.toString() ?? '';
          final isFinished = status.contains('完成') || status.contains('已完成');
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isFinished ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isFinished ? Colors.green : Colors.orange,
                  width: 1,
                ),
              ),
              child: Text(
                status.isEmpty ? '进行中' : status,
                style: TextStyle(
                  fontSize: 12,
                  color: isFinished ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
      
      // 创建时间
      GridColumnConfig<OutboundTask>(
        name: 'createTime',
        headerText: '创建时间',
        width: 150,
        valueGetter: (task) => task.createTime,
        cellBuilder: (task, columnName, cellValue) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              cellValue?.toString().substring(0, 16) ?? '',
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
      
      // 操作列
      GridColumnConfig<OutboundTask>(
        name: 'actions',
        headerText: '操作',
        width: 150,
        valueGetter: (task) => '',
        cellBuilder: (task, columnName, cellValue) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: 导航到采集页面
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: const Text(
                    '采集',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    // TODO: 导航到明细页面
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: const Text(
                    '明细',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ];
  }
}