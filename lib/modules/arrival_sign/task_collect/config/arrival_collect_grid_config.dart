import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';

import '../models/arrival_collect_progress.dart';
import '../models/arrival_collect_task.dart';

class ArrivalCollectGridConfig {
  static List<GridColumnConfig<ArrivalCollectTask>> taskColumns({
    required void Function(ArrivalCollectTask task) onSelect,
  }) {
    return [
      GridColumnConfig<ArrivalCollectTask>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
        cellBuilder: (row, _, __) => GestureDetector(
          onTap: () => onSelect(row),
          child: Text(row.materialCode),
        ),
      ),
      GridColumnConfig<ArrivalCollectTask>(
        name: 'matname',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName,
      ),
      GridColumnConfig<ArrivalCollectTask>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo,
      ),
      GridColumnConfig<ArrivalCollectTask>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNumber,
      ),
      GridColumnConfig<ArrivalCollectTask>(
        name: 'qty',
        headerText: '任务数量',
        valueGetter: (row) => row.plannedQuantity.toString(),
      ),
      GridColumnConfig<ArrivalCollectTask>(
        name: 'goodqty',
        headerText: '已采集',
        valueGetter: (row) => row.collectedQuantity.toString(),
      ),
    ];
  }

  static List<GridColumnConfig<ArrivalCollectProgress>> collectingColumns({
    required void Function(String id, bool selected) onSelect,
    required Set<String> selectedIds,
  }) {
    return [
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'checkbox',
        headerText: '',
        width: 56,
        valueGetter: (row) => row.id,
        cellBuilder: (row, _, __) {
          final isSelected = selectedIds.contains(row.id);
          return Center(
            child: Checkbox(
              value: isSelected,
              onChanged: (value) => onSelect(row.id, value ?? false),
            ),
          );
        },
      ),
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.task.materialCode,
      ),
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectQty.toString(),
      ),
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? row.task.batchNo,
      ),
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNumber ?? row.task.serialNumber,
      ),
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'pdate',
        headerText: '生产日期',
        valueGetter: (row) => row.productionDate ?? row.task.productionDate,
      ),
      GridColumnConfig<ArrivalCollectProgress>(
        name: 'vdays',
        headerText: '有效期',
        valueGetter: (row) => row.validDays ?? row.task.validDays,
      ),
    ];
  }

  static List<GridColumnConfig<ArrivalCollectSummary>> summaryColumns({
    required void Function(String id, bool selected) onSelect,
    required Set<String> selectedIds,
  }) {
    return [
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'checkbox',
        headerText: '',
        width: 56,
        valueGetter: (row) => row.id,
        cellBuilder: (row, _, __) {
          final isSelected = selectedIds.contains(row.id);
          return Center(
            child: Checkbox(
              value: isSelected,
              onChanged: (value) => onSelect(row.id, value ?? false),
            ),
          );
        },
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectQty?.toString(),
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (row) => row.taskQty?.toString(),
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo,
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNumber,
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'pdate',
        headerText: '生产日期',
        valueGetter: (row) => row.productionDate,
      ),
      GridColumnConfig<ArrivalCollectSummary>(
        name: 'vdays',
        headerText: '有效期',
        valueGetter: (row) => row.validDays,
      ),
    ];
  }
}
