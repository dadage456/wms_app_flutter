import '../../../../common_widgets/common_grid/common_data_grid.dart';
import '../models/inventory_command_models.dart';

class AswhInventoryCommandGridConfig {
  static List<GridColumnConfig<InventoryWcsCommand>> columns() {
    return [
      GridColumnConfig<InventoryWcsCommand>(
        name: 'palletNo',
        headerText: '托盘号',
        width: 140,
        valueGetter: (row) => row.palletNo,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'startAddr',
        headerText: '起始地址',
        width: 140,
        valueGetter: (row) => row.startAddr,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'destAddr',
        headerText: '目标地址',
        width: 140,
        valueGetter: (row) => row.destAddr,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'stackerNo',
        headerText: '堆垛机号',
        width: 120,
        valueGetter: (row) => row.stackerNo,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'sendTime',
        headerText: '发送时间',
        width: 180,
        valueGetter: (row) => row.sendTime,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'state',
        headerText: '状态',
        width: 120,
        valueGetter: (row) => row.state,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'weightGrade',
        headerText: '重量等级',
        width: 120,
        valueGetter: (row) => row.weightGrade,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'highGrade',
        headerText: '高度等级',
        width: 120,
        valueGetter: (row) => row.highGrade,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'taskNo',
        headerText: '任务号',
        width: 160,
        valueGetter: (row) => row.taskNo,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'proofNo',
        headerText: '凭证号',
        width: 160,
        valueGetter: (row) => row.proofNo,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'taskType',
        headerText: '任务类型',
        width: 120,
        valueGetter: (row) => row.taskType,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'changeType',
        headerText: '更改类型',
        width: 120,
        valueGetter: (row) => row.changeType,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'ioType',
        headerText: '出入库',
        width: 100,
        valueGetter: (row) => row.ioType,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'wcsError',
        headerText: 'WCS 错误',
        width: 220,
        valueGetter: (row) => row.wcsError,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'taskId',
        headerText: '任务 ID',
        width: 160,
        valueGetter: (row) => row.taskId,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'proofId',
        headerText: '凭证 ID',
        width: 160,
        valueGetter: (row) => row.proofId,
      ),
      GridColumnConfig<InventoryWcsCommand>(
        name: 'interfaceId',
        headerText: '指令 ID',
        width: 180,
        valueGetter: (row) => row.interfaceId,
      ),
    ];
  }
}
