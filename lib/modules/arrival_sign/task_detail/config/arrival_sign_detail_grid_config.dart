import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';

class ArrivalSignDetailGridConfig {
  static List<GridColumnConfig<ArrivalSignDetail>> buildColumns() {
    return [
      GridColumnConfig<ArrivalSignDetail>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 140,
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'materialName',
        headerText: '物料名称',
        width: 200,
        valueGetter: (row) => row.materialName,
        maxLines: 2,
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'supplierName',
        headerText: '供应商',
        width: 160,
        valueGetter: (row) => row.supplierName ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'quantity',
        headerText: '数量',
        width: 100,
        valueGetter: (row) => row.quantity,
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'goodQuantity',
        headerText: '合格数量',
        width: 110,
        valueGetter: (row) => row.goodQuantity,
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'batchNo',
        headerText: '批次',
        width: 120,
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'serialNumber',
        headerText: '序列号',
        width: 140,
        valueGetter: (row) => row.serialNumber ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'subInventory',
        headerText: '子库',
        width: 120,
        valueGetter: (row) => row.subInventoryCode ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'orderNo',
        headerText: '采购单号',
        width: 160,
        valueGetter: (row) => row.orderNo ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'arrivalsBillNo',
        headerText: '到货单号',
        width: 160,
        valueGetter: (row) => row.arrivalsBillNo ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'productionDate',
        headerText: '生产日期',
        width: 140,
        valueGetter: (row) => row.productionDate ?? '',
      ),
      GridColumnConfig<ArrivalSignDetail>(
        name: 'validDays',
        headerText: '有效期',
        width: 120,
        valueGetter: (row) => row.validDays ?? '',
      ),
    ];
  }
}
