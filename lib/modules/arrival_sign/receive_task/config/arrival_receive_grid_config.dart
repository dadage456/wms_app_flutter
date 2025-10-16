import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/models/arrival_receive_task.dart';

typedef ArrivalReceiveOperation = void Function(
  ArrivalReceiveTask task,
  ArrivalReceiveAction action,
);

enum ArrivalReceiveAction { receive, detail }

class ArrivalReceiveGridConfig {
  static List<GridColumnConfig<ArrivalReceiveTask>> buildColumns(
    ArrivalReceiveOperation onAction,
  ) {
    return [
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'actions',
        headerText: '操作',
        width: 180,
        valueGetter: (task) => null,
        cellBuilder: (task, columnName, cellValue) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => onAction(task, ArrivalReceiveAction.receive),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF43A047),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('接收'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => onAction(task, ArrivalReceiveAction.detail),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E88E5),
                    side: const BorderSide(color: Color(0xFF1E88E5)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('明细'),
                ),
              ),
            ],
          );
        },
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'arrivalsBillNo',
        headerText: '到货单号',
        width: 160,
        valueGetter: (task) => task.arrivalsBillNo,
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'orderNo',
        headerText: '采购单号',
        width: 150,
        valueGetter: (task) => task.orderNo,
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'poNumber',
        headerText: '采购订单',
        width: 150,
        valueGetter: (task) => task.poNumber,
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'createDate',
        headerText: '到货日期',
        width: 140,
        valueGetter: (task) => task.createDate,
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'plant',
        headerText: '工厂',
        width: 100,
        valueGetter: (task) => task.plant,
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'supplierName',
        headerText: '供应商',
        width: 160,
        valueGetter: (task) => task.supplierName,
      ),
      GridColumnConfig<ArrivalReceiveTask>(
        name: 'arrivalsBillId',
        headerText: '到货单ID',
        width: 140,
        valueGetter: (task) => task.arrivalsBillId,
      ),
    ];
  }
}
