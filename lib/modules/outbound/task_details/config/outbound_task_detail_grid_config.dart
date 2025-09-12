import 'package:flutter/material.dart';
import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/outbound_task_item.dart';

/// 出库任务明细表格列配置
class OutboundTaskDetailGridConfig {
  static List<GridColumnConfig<OutboundTaskItem>> getColumns() {
    return [
      // 物料编码
      GridColumnConfig<OutboundTaskItem>(
        name: 'matCode',
        headerText: '物料编码',
        width: 150,
        valueGetter: (item) => item.matCode,
      ),

      // 物料名称
      GridColumnConfig<OutboundTaskItem>(
        name: 'matName',
        headerText: '物料名称',
        width: 200,
        valueGetter: (item) => item.matName,
      ),

      // 库位编号
      GridColumnConfig<OutboundTaskItem>(
        name: 'storeSiteNo',
        headerText: '库位编号',
        width: 120,
        valueGetter: (item) => item.storeSiteNo,
      ),

      // 库房编号
      GridColumnConfig<OutboundTaskItem>(
        name: 'storeRoomNo',
        headerText: '库房编号',
        width: 120,
        valueGetter: (item) => item.storeRoomNo,
      ),

      // 子库编码
      GridColumnConfig<OutboundTaskItem>(
        name: 'subInventoryCode',
        headerText: '子库编码',
        width: 120,
        valueGetter: (item) => item.subInventoryCode,
      ),

      // 批次号
      GridColumnConfig<OutboundTaskItem>(
        name: 'hintBatchNo',
        headerText: '批次号',
        width: 130,
        valueGetter: (item) => item.hintBatchNo ?? '',
      ),

      // 序列号
      GridColumnConfig<OutboundTaskItem>(
        name: 'sn',
        headerText: '序列号',
        width: 130,
        valueGetter: (item) => item.sn ?? '',
      ),

      // 任务数量
      GridColumnConfig<OutboundTaskItem>(
        name: 'hintQty',
        headerText: '任务数量',
        width: 100,
        valueGetter: (item) => item.hintQty,
        cellBuilder: (item, columnName, cellValue) {
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

      // 出库单号
      GridColumnConfig<OutboundTaskItem>(
        name: 'orderNo',
        headerText: '出库单号',
        width: 150,
        valueGetter: (item) => item.orderNo,
      ),
    ];
  }
}