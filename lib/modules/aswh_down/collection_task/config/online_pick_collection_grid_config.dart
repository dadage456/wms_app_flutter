import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

class OnlinePickCollectionGridConfig {
  static List<GridColumnConfig<OnlinePickTaskItem>> taskColumns() {
    return [
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode ?? '',
        width: 140,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'matname',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName ?? '',
        width: 180,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'storesite',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo ?? '-',
        width: 110,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'tray',
        headerText: '托盘',
        valueGetter: (row) => row.palletNo ?? '-',
        width: 120,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'taskqty',
        headerText: '任务数量',
        valueGetter: (row) => row.taskQty,
        width: 100,
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'collectedqty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectedQty,
        width: 100,
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? row.hintBatchNo ?? '-',
        width: 120,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'sn',
        headerText: '序列号',
        valueGetter: (row) => row.serialNumber ?? '-',
        width: 140,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'subinventory',
        headerText: 'ERP 子库',
        valueGetter: (row) => row.subInventoryCode ?? '-',
        width: 120,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'remark',
        headerText: '备注',
        valueGetter: (row) => row.taskComment ?? '-',
        width: 160,
      ),
    ];
  }

  static List<GridColumnConfig<OnlinePickCollectionStock>> collectedColumns() {
    return [
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
        width: 140,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectQty,
        width: 100,
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (row) => row.taskQty,
        width: 100,
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSite ?? '-',
        width: 110,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'trayNo',
        headerText: '托盘',
        valueGetter: (row) => row.trayNo ?? '-',
        width: 120,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '-',
        width: 120,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'sn',
        headerText: '序列号',
        valueGetter: (row) => row.serialNumber ?? '-',
        width: 140,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'erpStore',
        headerText: 'ERP 子库',
        valueGetter: (row) => row.erpStore ?? '-',
        width: 120,
      ),
    ];
  }
}
