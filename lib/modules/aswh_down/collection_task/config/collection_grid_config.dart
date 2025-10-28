import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';

class OnlinePickCollectionGridConfig {
  static List<GridColumnConfig<OnlinePickTaskItem>> taskColumns() {
    return [
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'storeSiteNo',
        headerText: '库位',
        valueGetter: (item) => item.storeSiteNo,
        width: 120,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'materialCode',
        headerText: '物料编码',
        valueGetter: (item) => item.materialCode,
        width: 140,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'materialName',
        headerText: '物料名称',
        valueGetter: (item) => item.materialName,
        width: 160,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (item) => item.taskQty,
        width: 100,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'collectedQty',
        headerText: '已采集',
        valueGetter: (item) => item.collectedQty,
        width: 100,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'repositoryQty',
        headerText: '库存',
        valueGetter: (item) => item.repositoryQty,
        width: 100,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'batchNo',
        headerText: '批次',
        valueGetter: (item) => item.batchNo ?? item.hintBatchNo,
        width: 120,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'serialNumber',
        headerText: '序列',
        valueGetter: (item) => item.serialNumber,
        width: 140,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'palletNo',
        headerText: '托盘',
        valueGetter: (item) => item.palletNo,
        width: 120,
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        valueGetter: (item) => item.subInventoryCode,
        width: 120,
      ),
    ];
  }
}
