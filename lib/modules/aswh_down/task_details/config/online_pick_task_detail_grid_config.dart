import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

class OnlinePickTaskDetailGridConfig {
  static List<GridColumnConfig<OnlinePickTaskItem>> columns() {
    return [
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 150,
        valueGetter: (item) => item.materialCode,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'materialName',
        headerText: '物料名称',
        width: 220,
        valueGetter: (item) => item.materialName,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'storeSiteNo',
        headerText: '库位',
        width: 140,
        valueGetter: (item) => item.storeSiteNo,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'storeRoomNo',
        headerText: '库房',
        width: 120,
        valueGetter: (item) => item.storeRoomNo,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        width: 140,
        valueGetter: (item) => item.subInventoryCode,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'palletNo',
        headerText: '托盘号',
        width: 140,
        valueGetter: (item) => item.palletNo,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'hintBatchNo',
        headerText: '任务批次',
        width: 160,
        valueGetter: (item) => item.hintBatchNo,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'batchNo',
        headerText: '采集批次',
        width: 160,
        valueGetter: (item) => item.batchNo,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'serialNumber',
        headerText: '序列号',
        width: 180,
        valueGetter: (item) => item.serialNumber,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        valueGetter: (item) => item.taskQty,
        cellBuilder: (item, column, value) => Align(
          alignment: Alignment.centerRight,
          child: Text('${item.taskQty}'),
        ),
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'collectedQty',
        headerText: '采集数量',
        width: 110,
        valueGetter: (item) => item.collectedQty,
        cellBuilder: (item, column, value) => Align(
          alignment: Alignment.centerRight,
          child: Text('${item.collectedQty}'),
        ),
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'repositoryQty',
        headerText: '库存数量',
        width: 110,
        valueGetter: (item) => item.repositoryQty,
        cellBuilder: (item, column, value) => Align(
          alignment: Alignment.centerRight,
          child: Text('${item.repositoryQty}'),
        ),
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'orderNo',
        headerText: '出库单号',
        width: 180,
        valueGetter: (item) => item.orderNo,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'wcsState',
        headerText: 'WCS 状态',
        width: 140,
        valueGetter: (item) => item.wcsState,
      ),
    ];
  }
}
