import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

class OnlinePickCollectionResultGridConfig {
  static List<GridColumnConfig<OnlinePickCollectionStock>> columns() {
    return [
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (item) => item.storeSite,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode,
        width: 140,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (item) => item.taskQty,
        width: 100,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (item) => item.collectQty,
        width: 100,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (item) => item.batchNo,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'serialNumber',
        headerText: '序列',
        valueGetter: (item) => item.serialNumber,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'erpStore',
        headerText: '子库',
        valueGetter: (item) => item.erpStore,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'trayNo',
        headerText: '托盘',
        valueGetter: (item) => item.trayNo,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'stockId',
        headerText: '采集记录ID',
        valueGetter: (item) => item.stockId,
        width: 160,
      ),
    ];
  }
}
