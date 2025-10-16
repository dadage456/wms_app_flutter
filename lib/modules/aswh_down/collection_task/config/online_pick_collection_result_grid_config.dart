import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

/// 在线拣选采集结果表格列配置。
class OnlinePickCollectionResultGridConfig {
  static List<GridColumnConfig<OnlinePickCollectionStock>> columns() {
    return [
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'trayNo',
        headerText: '托盘号',
        width: 140,
        valueGetter: (stock) => stock.trayNo ?? '',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        width: 140,
        valueGetter: (stock) => stock.storeSite ?? '',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'erpStore',
        headerText: '子库',
        width: 120,
        valueGetter: (stock) => stock.erpStore ?? '',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 160,
        enableSelectableText: true,
        valueGetter: (stock) => stock.materialCode,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'batchNo',
        headerText: '批次',
        width: 160,
        valueGetter: (stock) => stock.batchNo ?? '',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'serialNumber',
        headerText: '序列号',
        width: 180,
        valueGetter: (stock) => stock.serialNumber ?? '',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (stock) => stock.taskQty,
        formatter: (value, _) => value == null ? '' : '$value',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (stock) => stock.collectQty,
        formatter: (value, _) => value == null ? '' : '$value',
      ),
    ];
  }
}
