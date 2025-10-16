import 'package:flutter/material.dart';

import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/aswh_up_task_detail_item.dart';

class AswhUpTaskDetailGridConfig {
  static List<GridColumnConfig<AswhUpTaskDetailItem>> columns() {
    return [
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode ?? '-',
        textAlign: TextAlign.center,
      ),
      // GridColumnConfig<AswhUpTaskDetailItem>(
      //   name: 'storeSiteNo',
      //   headerText: '库位',
      //   valueGetter: (item) => item.storeSiteNo ?? '-',
      //   textAlign: TextAlign.center,
      // ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'quantity',
        headerText: '任务数量',
        width: 100,
        valueGetter: (item) => item.planQty,
        textAlign: TextAlign.center,
      ),

      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (item) => item.batchNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'serialNumber',
        headerText: '序列',
        valueGetter: (item) => item.serialNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        width: 100,
        valueGetter: (item) => item.subInventoryCode ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'storeRoomNo',
        headerText: '库房',
        width: 100,
        valueGetter: (item) => item.storeRoomNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (item) => item.materialName ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inboundOrderNo',
        headerText: '入库单号',
        valueGetter: (item) => item.inboundOrderNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'oldMaterialCode',
        headerText: '物料旧编码',
        valueGetter: (item) => item.oldMaterialCode ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'taskComment',
        headerText: '凭证号',
        valueGetter: (item) => item.taskComment ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inTaskNo',
        headerText: '任务号',
        valueGetter: (item) => item.inTaskNo ?? '-',
        textAlign: TextAlign.center,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inTaskId',
        headerText: '任务ID',
        valueGetter: (item) => item.inTaskId,
        textAlign: TextAlign.center,
      ),
    ];
  }
}
