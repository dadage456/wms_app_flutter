import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';

class OnlinePickWcsGridConfig {
  static List<GridColumnConfig<OnlinePickWcsCommand>> columns() {
    return [
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'palletNo',
        headerText: '托盘号',
        width: 140,
        valueGetter: (item) => item.palletNo ?? '',
        enableSelectableText: true,
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'startAddress',
        headerText: '起始地址',
        width: 120,
        valueGetter: (item) => item.startAddress ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'destinationAddress',
        headerText: '目标地址',
        width: 120,
        valueGetter: (item) => item.destinationAddress ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'stackerNo',
        headerText: '堆垛机号',
        width: 100,
        valueGetter: (item) => item.stackerNo ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'sendTime',
        headerText: '发送时间',
        width: 160,
        valueGetter: (item) => item.sendTime ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'state',
        headerText: '状态',
        width: 110,
        valueGetter: (item) => item.state ?? '',
        cellBuilder: (item, _, __) => _buildStatusTag(item),
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'weightGrade',
        headerText: '重量等级',
        width: 110,
        valueGetter: (item) => item.weightGrade ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'heightGrade',
        headerText: '高度等级',
        width: 110,
        valueGetter: (item) => item.heightGrade ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'taskNo',
        headerText: '任务号',
        width: 160,
        valueGetter: (item) => item.taskNo ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'proofNo',
        headerText: '凭证号',
        width: 180,
        valueGetter: (item) => item.proofNo ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'taskType',
        headerText: '任务类型',
        width: 120,
        valueGetter: (item) => item.taskType ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'changeType',
        headerText: '更改类型',
        width: 120,
        valueGetter: (item) => item.changeType ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'ioType',
        headerText: '出入库',
        width: 110,
        valueGetter: (item) => item.ioType ?? '',
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'errorMessage',
        headerText: 'WCS 错误',
        width: 220,
        valueGetter: (item) => item.errorMessage ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      GridColumnConfig<OnlinePickWcsCommand>(
        name: 'commandId',
        headerText: '指令ID',
        width: 160,
        valueGetter: (item) => item.commandId ?? '',
        enableSelectableText: true,
      ),
    ];
  }

  static Widget _buildStatusTag(OnlinePickWcsCommand command) {
    final state = (command.state ?? '').trim();
    final color = _statusColor(state);
    final label = state.isEmpty ? '未知' : state;

    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  static Color _statusColor(String status) {
    switch (status) {
      case '新建':
      case '待执行':
      case '0':
        return Colors.orange;
      case '执行中':
      case '1':
        return Colors.blue;
      case '完成':
      case '2':
        return Colors.green;
      case '异常':
      case '失败':
      case 'E':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
