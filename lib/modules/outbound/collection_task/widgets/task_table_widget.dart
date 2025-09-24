import 'package:flutter/material.dart';
import '../models/collection_models.dart';

class TaskTableWidget extends StatelessWidget {
  final List<OutTaskItem> items;
  final List<String> checkedIds;
  final Function(String, bool) onItemCheck;
  final Function(bool) onSelectAll;
  final bool showSelection;

  const TaskTableWidget({
    Key? key,
    required this.items,
    required this.checkedIds,
    required this.onItemCheck,
    required this.onSelectAll,
    this.showSelection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: showSelection,
        columns: const [
          DataColumn(label: Text('物料编码')),
          DataColumn(label: Text('库位')),
          DataColumn(label: Text('任务数量')),
          DataColumn(label: Text('采集数量')),
          DataColumn(label: Text('结余库存')),
          DataColumn(label: Text('批次')),
          DataColumn(label: Text('序列')),
          DataColumn(label: Text('库房')),
          DataColumn(label: Text('子库')),
          DataColumn(label: Text('物料名称')),
        ],
        rows: items.map((item) {
          final isSelected = checkedIds.contains(item.outtaskitemid);
          return DataRow(
            selected: isSelected,
            onSelectChanged: showSelection ? (selected) {
              onItemCheck(item.outtaskitemid.toString(), selected ?? false);
            } : null,
            cells: [
              DataCell(Text(item.matcode ?? '')),
              DataCell(Text(item.storesiteno ?? '')),
              DataCell(Text(item.hintqty.toString())),
              DataCell(Text(item.collectedqty.toString())),
              DataCell(Text(item.repqty.toString(),
                style: const TextStyle(color: Colors.blue))),
              DataCell(Text(item.hintbatchno ?? '')),
              DataCell(Text(item.sn ?? '')),
              DataCell(Text(item.storeroomno ?? '')),
              DataCell(Text(item.subinventoryCode ?? '')),
              DataCell(Text(item.matname ?? '')),
            ],
          );
        }).toList(),
      ),
    );
  }
}