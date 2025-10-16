import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';

typedef ArrivalSignTaskOperation = void Function(
  ArrivalSignTask task,
  ArrivalSignTaskAction action,
);

enum ArrivalSignTaskAction { collect, detail, cancel }

class ArrivalSignTaskGridConfig {
  static List<GridColumnConfig<ArrivalSignTask>> buildColumns(
    ArrivalSignTaskOperation onAction,
  ) {
    return [
      GridColumnConfig<ArrivalSignTask>(
        name: 'actions',
        headerText: '操作',
        width: 220,
        valueGetter: (task) => null,
        cellBuilder: (task, columnName, cellValue) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => onAction(task, ArrivalSignTaskAction.collect),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('采集'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => onAction(task, ArrivalSignTaskAction.detail),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1E88E5),
                    side: const BorderSide(color: Color(0xFF1E88E5)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('明细'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
                child: OutlinedButton(
                  onPressed: () => onAction(task, ArrivalSignTaskAction.cancel),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD84315),
                    side: const BorderSide(color: Color(0xFFD84315)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('撤销'),
                ),
              ),
            ],
          );
        },
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'arrivalsBillNo',
        headerText: '到货单号',
        width: 160,
        valueGetter: (task) => task.arrivalsBillNo,
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'orderNo',
        headerText: '采购单号',
        width: 150,
        valueGetter: (task) => task.orderNo,
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'poNumber',
        headerText: '采购订单',
        width: 150,
        valueGetter: (task) => task.poNumber,
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'createDate',
        headerText: '到货日期',
        width: 140,
        valueGetter: (task) => task.createDate,
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'plant',
        headerText: '工厂',
        width: 100,
        valueGetter: (task) => task.plant,
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'supplierName',
        headerText: '供应商',
        width: 160,
        valueGetter: (task) => task.supplierName,
      ),
      GridColumnConfig<ArrivalSignTask>(
        name: 'arrivalsBillId',
        headerText: '到货单ID',
        width: 140,
        valueGetter: (task) => task.arrivalsBillId,
      ),
    ];
  }
}
