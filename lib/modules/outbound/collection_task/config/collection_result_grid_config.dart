import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';

/// 采集结果列表 表格列配置（对齐 goodsDownCollectDetail.nvue 的 column1）
class CollectionResultGridConfig {
  static List<GridColumnConfig<CollectionStock>> getColumns() {
    return [
      GridColumnConfig<CollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (r) => r.storeSite,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (r) => r.matcode,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (r) => r.taskQty,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (r) => r.collectQty,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (r) => r.batchno,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (r) => r.sn,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'erpStore',
        headerText: '子库',
        valueGetter: (r) => r.erpStore,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (r) => r.storeRoom,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'taskid',
        headerText: '任务id',
        valueGetter: (r) => r.taskid,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'outtaskitemid',
        headerText: '出库任务明细id',
        valueGetter: (r) => r.outtaskitemid,
      ),
      GridColumnConfig<CollectionStock>(
        name: 'stockid',
        headerText: '采集数据id',
        valueGetter: (r) => r.stockid,
      ),
    ];
  }
}
