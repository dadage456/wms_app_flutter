import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

List<GridColumnConfig<OnlinePickTaskItem>> buildTaskItemColumns() {
  return [
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'materialCode',
      headerText: '物料编码',
      width: 140,
      enableSelectableText: true,
      valueGetter: (row) => row.materialCode ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'palletNo',
      headerText: '托盘号',
      width: 120,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.palletNo ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'taskQty',
      headerText: '任务数量',
      width: 110,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.taskQty,
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'collectedQty',
      headerText: '采集数量',
      width: 110,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.collectedQty,
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'repositoryQty',
      headerText: '库存',
      width: 110,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.repositoryQty,
      textStyle: const TextStyle(color: Color(0xFF1976D2)),
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'batchNo',
      headerText: '批次',
      width: 160,
      enableSelectableText: true,
      valueGetter: (row) => row.batchNo ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'serialNumber',
      headerText: '序列',
      width: 160,
      enableSelectableText: true,
      valueGetter: (row) => row.serialNumber ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'storeRoomNo',
      headerText: '库房',
      width: 100,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.storeRoomNo ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'storeSiteNo',
      headerText: '库位',
      width: 120,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.storeSiteNo ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'subinventoryCode',
      headerText: '子库',
      width: 100,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.subInventoryCode ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'orderNo',
      headerText: '出库单号',
      width: 140,
      enableSelectableText: true,
      valueGetter: (row) => row.orderNo ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'materialName',
      headerText: '物料名称',
      width: 180,
      enableSelectableText: true,
      valueGetter: (row) => row.materialName ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'materialInnerCode',
      headerText: '物料旧编码',
      width: 140,
      enableSelectableText: true,
      valueGetter: (row) => row.oldMaterialCode ?? '-',
    ),
    GridColumnConfig<OnlinePickTaskItem>(
      name: 'outTaskItemId',
      headerText: '任务id',
      width: 90,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.outTaskItemId,
    ),
  ];
}

List<GridColumnConfig<OnlinePickCollectionStock>>
buildCollectionStockColumns() {
  return [
    GridColumnConfig<OnlinePickCollectionStock>(
      name: 'stockId',
      headerText: '库存ID',
      width: 120,
      enableSelectableText: true,
      valueGetter: (row) => row.stockId,
    ),
    GridColumnConfig<OnlinePickCollectionStock>(
      name: 'materialCode',
      headerText: '物料编码',
      width: 140,
      enableSelectableText: true,
      valueGetter: (row) => row.materialCode,
    ),
    GridColumnConfig<OnlinePickCollectionStock>(
      name: 'batchNo',
      headerText: '批次',
      width: 120,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.batchNo ?? '-',
    ),
    GridColumnConfig<OnlinePickCollectionStock>(
      name: 'serialNumber',
      headerText: '序列号',
      width: 140,
      enableSelectableText: true,
      valueGetter: (row) => row.serialNumber ?? '-',
    ),
    GridColumnConfig<OnlinePickCollectionStock>(
      name: 'collectQty',
      headerText: '采集数量',
      width: 110,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.collectQty,
    ),
    GridColumnConfig<OnlinePickCollectionStock>(
      name: 'trayNo',
      headerText: '托盘',
      width: 110,
      textAlign: TextAlign.center,
      valueGetter: (row) => row.trayNo ?? '-',
    ),
  ];
}
