import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/goods_up_task_item.dart';

class GoodsUpTaskDetailGridConfig {
  static List<GridColumnConfig<GoodsUpTaskItem>> columns() {
    return [
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'storeSiteNo',
        headerText: '库位',
        valueGetter: (item) => item.storeSiteNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'quantity',
        headerText: '任务数量',
        width: 100,
        valueGetter: (item) => item.quantity,
        textAlign: TextAlign.center,
      ),

      GridColumnConfig<GoodsUpTaskItem>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (item) => item.batchNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'serialNumber',
        headerText: '序列',
        valueGetter: (item) => item.serialNumber ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        width: 100,
        valueGetter: (item) => item.subInventoryCode ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'storeRoomNo',
        headerText: '库房',
        width: 100,
        valueGetter: (item) => item.storeRoomNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (item) => item.materialName ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        valueGetter: (item) => item.inboundOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'oldMaterialCode',
        headerText: '物料旧编码',
        valueGetter: (item) => item.oldMaterialCode ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'taskComment',
        headerText: '凭证号',
        valueGetter: (item) => item.taskComment ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'inTaskNo',
        headerText: '任务号',
        valueGetter: (item) => item.inTaskNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<GoodsUpTaskItem>(
        name: 'inTaskId',
        headerText: '任务ID',
        valueGetter: (item) => item.inTaskId,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
