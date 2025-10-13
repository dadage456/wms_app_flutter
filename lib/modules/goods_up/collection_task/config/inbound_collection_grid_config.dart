import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';

class InboundCollectionGridConfig {
  static List<GridColumnConfig<InboundCollectTaskItem>> taskColumns() {
    return [
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode ?? '',
        width: 160,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'storesite',
        headerText: '库位',
        valueGetter: (item) => item.storeSiteNo ?? '',
        width: 150,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'qty',
        headerText: '任务数量',
        valueGetter: (item) => item.planQty,
        width: 110,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'collectedqty',
        headerText: '采集数量',
        valueGetter: (item) => item.collectedQty,
        width: 110,
        cellTextStyle: const TextStyle(color: Color(0xFF1976D2)),
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (item) => item.batchNo ?? '',
        width: 200,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (item) => item.serialNumber ?? '',
        width: 200,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'subinventory',
        headerText: '子库',
        valueGetter: (item) => item.subInventoryCode ?? '',
        width: 120,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'storeroom',
        headerText: '库房',
        valueGetter: (item) => item.storeRoomNo ?? '',
        width: 120,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'matname',
        headerText: '物料名称',
        valueGetter: (item) => item.materialName ?? '',
        width: 220,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'orderno',
        headerText: '入库单号',
        valueGetter: (item) => item.inboundOrderNo ?? '',
        width: 220,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'innercode',
        headerText: '物料旧编码',
        valueGetter: (item) => item.oldMaterialCode ?? '',
        width: 200,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'taskcomment',
        headerText: '凭证号',
        valueGetter: (item) => item.taskComment ?? '',
        width: 220,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'intaskno',
        headerText: '任务号',
        valueGetter: (item) => item.inTaskNo ?? '',
        width: 180,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'intaskitemid',
        headerText: '任务明细ID',
        valueGetter: (item) => item.inTaskItemId,
        width: 120,
      ),
    ];
  }

  static List<GridColumnConfig<InboundCollectionStock>> resultColumns() {
    return [
      GridColumnConfig<InboundCollectionStock>(
        name: 'storesite',
        headerText: '库位',
        valueGetter: (item) => item.storeSite,
        width: 150,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode,
        width: 160,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'taskqty',
        headerText: '任务数量',
        valueGetter: (item) => item.planQty,
        width: 110,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'collectqty',
        headerText: '采集数量',
        valueGetter: (item) => item.collectQty,
        width: 110,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (item) => item.batchNo,
        width: 200,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (item) => item.serialNumber,
        width: 200,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'storeroom',
        headerText: '库房',
        valueGetter: (item) => item.storeRoom,
        width: 120,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'taskno',
        headerText: '任务号',
        valueGetter: (item) => item.taskNo ?? '',
        width: 160,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'stockid',
        headerText: '采集ID',
        valueGetter: (item) => item.stockId,
        width: 160,
      ),
    ];
  }
}
