import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_up/task_details/models/aswh_up_task_detail_item.dart';

class CollectionResultGridConfig {
  static List<GridColumnConfig<AswhUpTaskDetailItem>> getColumns() {
    return [
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'storesiteno',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'qty',
        headerText: '任务数量',
        valueGetter: (row) => row.planQty,
        width: 100,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'collectedqty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectedQty,
        width: 100,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'subinventoryCode',
        headerText: '子库',
        valueGetter: (row) => row.subInventoryCode ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoomNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName ?? '',
        width: 150,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'orderno',
        headerText: '凭证号',
        valueGetter: (row) => row.inboundOrderNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'intaskno',
        headerText: '任务号',
        valueGetter: (row) => row.inTaskNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inTaskItemId',
        headerText: '任务id',
        valueGetter: (row) => row.inTaskItemId ?? '',
      ),
    ];
  }
}
