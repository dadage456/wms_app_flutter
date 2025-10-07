import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/goods_up_task_item.dart';

class GoodsUpTaskDetailGridConfig {
  static List<GridColumnConfig<GoodsUpTaskItem>> columns() {
    return [
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 160,
        valueGetter: (item) => item.materialCode ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'storeSiteNo',
        headerText: '库位',
        width: 140,
        valueGetter: (item) => item.storeSiteNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'quantity',
        headerText: '任务数量',
        width: 120,
        valueGetter: (item) => item.quantity,
        cellBuilder: (item, column, value) => Align(
          alignment: Alignment.centerRight,
          child: Text('${value ?? 0}'),
        ),
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'collectedQuantity',
        headerText: '已采集',
        width: 120,
        valueGetter: (item) => item.collectedQuantity,
        cellBuilder: (item, column, value) => Align(
          alignment: Alignment.centerRight,
          child: Text('${value ?? 0}'),
        ),
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'batchNo',
        headerText: '批次',
        width: 180,
        valueGetter: (item) => item.batchNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'serialNumber',
        headerText: '序列',
        width: 200,
        valueGetter: (item) => item.serialNumber ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        width: 120,
        valueGetter: (item) => item.subInventoryCode ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'storeRoomNo',
        headerText: '库房',
        width: 120,
        valueGetter: (item) => item.storeRoomNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'materialName',
        headerText: '物料名称',
        width: 220,
        valueGetter: (item) => item.materialName ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        width: 160,
        valueGetter: (item) => item.inboundOrderNo ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'oldMaterialCode',
        headerText: '物料旧编码',
        width: 160,
        valueGetter: (item) => item.oldMaterialCode ?? '-',
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'taskComment',
        headerText: '凭证号',
        width: 200,
        valueGetter: (item) => item.taskComment ?? '-',
      ),
    ];
  }
}
