import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';

/// 采集结果列表 表格列配置（对齐 goodsDownCollectDetail.nvue 的 column1）
class CollectionResultGridConfig {
  static List<GridColumnConfig<InboundCollectTaskItem>> getColumns() {
    return [
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'storesiteno',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'qty',
        headerText: '任务数量',
        valueGetter: (row) => row.planQty,
        width: 100,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'collectedqty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectedQty,
        width: 100,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'subinventoryCode',
        headerText: '子库',
        valueGetter: (row) => row.subInventoryCode ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoomNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName ?? '',
        width: 150,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'taskcommend',
        headerText: '凭证号',
        valueGetter: (row) => row.taskcommend ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'intaskno',
        headerText: '任务号',
        valueGetter: (row) => row.intaskno ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'inTaskId',
        headerText: '任务id',
        valueGetter: (row) => row.inTaskId ?? '',
      ),
    ];
  }
}
