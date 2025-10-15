import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/aswh_up_task_detail_item.dart';

class AswhUpTaskDetailGridConfig {
  static List<GridColumnConfig<AswhUpTaskDetailItem>> columns() {
    return [
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'planQty',
        headerText: '任务数量',
        valueGetter: (item) => item.planQty,
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (item) => item.batchNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'serialNo',
        headerText: '序列',
        valueGetter: (item) => item.serialNo ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        valueGetter: (item) => item.subInventoryCode ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'storeRoomNo',
        headerText: '库房',
        valueGetter: (item) => item.storeRoomNo ?? '-',
        width: 120,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (item) => item.materialName ?? '-',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        valueGetter: (item) => item.inboundOrderNo ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'oldMaterialCode',
        headerText: '物料旧编码',
        valueGetter: (item) => item.oldMaterialCode ?? '-',
        width: 150,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'taskComment',
        headerText: '凭证号',
        valueGetter: (item) => item.taskComment ?? '-',
        width: 160,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inTaskNo',
        headerText: '任务号',
        valueGetter: (item) => item.inTaskNo ?? '-',
        width: 140,
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inTaskItemId',
        headerText: '任务ID',
        valueGetter: (item) => item.inTaskItemId,
        width: 120,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
