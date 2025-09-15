import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

typedef OnPageChanged = Future<void> Function(int pageIndex);

/* ------------------ 样式常量（沿用你已有的） ------------------ */
const TextStyle _titleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
const TextStyle _infoStyle = TextStyle(fontSize: 14);

const Color _titleBgColor = Color(0xFFF6F6F6);
const Color _borderColor = Color(0xFFE0E6ED);
const Color _infoBgColor = Color(0xFFF6F6F6);

/* ------------------ 通用表格组件 ------------------ */
typedef CellBuilder<T> =
    Widget? Function(T rowData, String columnName, dynamic cellValue);

typedef HeaderBuilder = Widget? Function(String columnName, String headerText);

class CommonDataGrid<T> extends StatefulWidget {
  /* 列配置 */
  final List<GridColumnConfig<T>> columns;

  /* 行数据 */
  final List<T> datas;

  /* 分页信息 */
  final int currentPage;
  final int totalPages;

  final OnPageChanged onLoadData;

  /* 选中控制 */
  final List<int> selectedRows;
  final ValueChanged<List<int>>? onSelectionChanged;

  /* 显隐控制 */
  final bool allowPager;
  final bool allowSelect;

  /* 外部控制器（可选） */
  final DataGridController? dataGridController;
  final DataPagerController? dataPagerController;

  /* 高度 */
  final double? height;
  final double? headerHeight;
  final double? rowHeight;

  const CommonDataGrid({
    super.key,
    required this.columns,
    required this.datas,
    this.currentPage = 1,
    this.totalPages = 1,
    required this.onLoadData,
    this.selectedRows = const [],
    this.onSelectionChanged,
    this.allowPager = false,
    this.allowSelect = false,
    this.dataGridController,
    this.dataPagerController,
    this.height,
    this.headerHeight,
    this.rowHeight,
  });

  @override
  State<CommonDataGrid<T>> createState() => _CommonDataGridState<T>();
}

class _CommonDataGridState<T> extends State<CommonDataGrid<T>> {
  Map<String, double> columnWidths = {};
  late _CommonDataSource<T> _source;
  late DataGridController _controller;
  late DataPagerController _dataPagerController;
  late ScrollController _verticalScrollController;
  late ScrollController _horizontalScrollController;
  final Set<int> _selectedIndexInPage = {};

  // 生命周期管理标记
  bool _ownGridController = false;
  bool _ownPagerController = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.dataGridController ?? DataGridController();
    _dataPagerController = widget.dataPagerController ?? DataPagerController();
    _verticalScrollController = ScrollController();
    _horizontalScrollController = ScrollController();

    // 生命周期安全化管理
    if (widget.dataGridController != null) {
      _controller = widget.dataGridController!;
    } else {
      _controller = DataGridController();
      _ownGridController = true;
    }

    if (widget.dataPagerController != null) {
      _dataPagerController = widget.dataPagerController!;
    } else {
      _dataPagerController = DataPagerController();
      _ownPagerController = true;
    }

    _source = _CommonDataSource<T>(
      datas: widget.datas,
      columns: widget.columns,
      onPageChanged: _onPageChanged,
    );

    // 加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('---------- init load page index: ${widget.currentPage}');
      widget.onLoadData(widget.currentPage);
    });

    debugPrint('INIT currentPage: ${widget.currentPage}');
  }

  @override
  void didUpdateWidget(covariant CommonDataGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.datas != widget.datas ||
        oldWidget.currentPage != widget.currentPage) {
      _dataPagerController.selectedPageIndex = widget.currentPage - 1;
      _source = _CommonDataSource<T>(
        datas: widget.datas,
        columns: widget.columns,
        onPageChanged: _onPageChanged,
      );
      // _dataPagerController.selectedPageIndex = widget.currentPage;

      _selectedIndexInPage.clear(); // 数据变了就清空
      debugPrint(
        '----- table didUpdateWidget currentPage: ${widget.currentPage}',
      );
    }
  }

  // 页面切换
  Future<void> _onPageChanged(int pageIndex) async {
    _scrollToOrigin();
    await widget.onLoadData.call(pageIndex);
  }

  void _scrollToOrigin() {
    // 确保下一帧渲染完再滚，避免空白
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_horizontalScrollController.hasClients) {
        _horizontalScrollController.jumpTo(0);
      }
      if (_verticalScrollController.hasClients) {
        _verticalScrollController.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    // 仅销毁自己创建的控制器
    if (_ownGridController) {
      _controller.dispose();
    }
    if (_ownPagerController) {
      _dataPagerController.dispose();
    }
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pagerHeight = widget.allowPager ? 64.0 : 0.0;
    final bodyHeight = widget.height != null
        ? widget.height! - pagerHeight
        : double.infinity;

    return LayoutBuilder(
      builder: (_, constraints) {
        final maxHeight = bodyHeight == double.infinity
            ? constraints.maxHeight
            : bodyHeight;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /* 表格 */
            Expanded(
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  gridLineColor: _borderColor,
                  headerColor: _titleBgColor,
                  sortIcon: Builder(
                    builder: (context) {
                      Widget? icon;
                      String columnName = '';
                      context.visitAncestorElements((element) {
                        if (element is GridHeaderCellElement) {
                          columnName = element.column.columnName;
                        }
                        return true;
                      });
                      var column = _source.sortedColumns
                          .where((element) => element.name == columnName)
                          .firstOrNull;
                      if (column != null) {
                        if (column.sortDirection ==
                            DataGridSortDirection.ascending) {
                          icon = const Icon(Icons.arrow_drop_up, size: 16);
                        } else if (column.sortDirection ==
                            DataGridSortDirection.descending) {
                          icon = const Icon(Icons.arrow_drop_down, size: 16);
                        }
                      }
                      // return icon ?? const Icon(Icons.sort_outlined, size: 16);
                      return icon ?? SizedBox();
                    },
                  ),
                ),
                child: SfDataGrid(
                  controller: _controller,
                  verticalScrollController: _verticalScrollController,
                  horizontalScrollController: _horizontalScrollController,
                  source: _source,
                  allowSorting: true,
                  allowColumnsResizing: true,
                  columnWidthMode: ColumnWidthMode.none,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  onSelectionChanged: _handleSelectionChanged,
                  columnResizeMode: ColumnResizeMode.onResize,

                  onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                    setState(() {
                      columnWidths[details.column.columnName] = details.width;
                    });
                    return true;
                  },
                  showCheckboxColumn: widget.allowSelect,
                  selectionMode: widget.allowSelect
                      ? SelectionMode.multiple
                      : SelectionMode.none,
                  checkboxColumnSettings: const DataGridCheckboxColumnSettings(
                    width: 50,
                  ),
                  headerRowHeight: widget.headerHeight ?? 32,
                  rowHeight: widget.rowHeight ?? 32,
                  columns: _buildColumnsWithSpacer(),
                ),
              ),
            ),
            /* 分页 */
            if (widget.allowPager) _buildPager(),
          ],
        );
      },
    );
  }

  Widget _buildPager() {
    return Container(
      height: 64,
      alignment: Alignment.center,
      // width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: SfDataPagerTheme(
        data: SfDataPagerThemeData(
          itemBorderWidth: 0.5,
          itemBorderColor: Colors.grey[200],
          itemBorderRadius: BorderRadius.circular(4),
          selectedItemColor: Colors.blue,
          selectedItemTextStyle: TextStyle(color: Colors.white),
        ),
        child: SfDataPager(
          controller: _dataPagerController,
          delegate: _source,
          pageCount: widget.totalPages.toDouble(),
          visibleItemsCount: 6,
          itemWidth: 40,
          itemHeight: 40,
          navigationItemWidth: 66,
          navigationItemHeight: 40,
          firstPageItemVisible: false,
          lastPageItemVisible: false,
        ),
      ),
    );
  }


  List<GridColumn> _buildColumnsWithSpacer() {
    final columns = widget.columns.map((e) => _buildGridColumn(e)).toList();
    
    // 添加一个隐藏的占位列，为最后一列提供拖拽空间
    columns.add(GridColumn(
      columnName: '_spacer_column',
      width: 50.0, // 提供50px的拖拽空间
      label: Container(), // 空的标题
    ));
    
    return columns;
  }

  GridColumn _buildGridColumn(GridColumnConfig cfg) {
    final effectiveWidth = columnWidths[cfg.name] ?? cfg.width ?? 120.0;

    return GridColumn(
      columnName: cfg.name,
      width: effectiveWidth,
      minimumWidth: cfg.minimumWidth ?? 80.0,
      maximumWidth: cfg.maximumWidth ?? double.infinity,
      autoFitPadding: const EdgeInsets.symmetric(horizontal: 8),
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerLeft,
        child:
            cfg.headerBuilder?.call(cfg.name, cfg.headerText) ??
            Text(cfg.headerText, style: _titleStyle),
      ),
    );
  }

  void _handleSelectionChanged(
    List<DataGridRow> added,
    List<DataGridRow> removed,
  ) {
    // 1. 把 DataGridRow 转成它在当前页里的索引
    void addIndex(DataGridRow r) {
      final idx = _source.rows.indexOf(r);
      if (idx >= 0) _selectedIndexInPage.add(idx);
    }

    void removeIndex(DataGridRow r) {
      final idx = _source.rows.indexOf(r);
      if (idx >= 0) _selectedIndexInPage.remove(idx);
    }

    added.forEach(addIndex);
    removed.forEach(removeIndex);

    debugPrint('selectedIndexInPage: ${_selectedIndexInPage.join(', ')}');

    // 2. 通知外部：把索引集合转 List 并回调
    widget.onSelectionChanged?.call(_selectedIndexInPage.toList());
  }
}

/* ------------------ 数据源 ------------------ */
class _CommonDataSource<T> extends DataGridSource {
  final List<T> datas;
  final List<GridColumnConfig<T>> columns;
  final OnPageChanged onPageChanged;

  // 列配置映射缓存，O(1)查找
  late Map<String, GridColumnConfig<T>> _columnMap;
  late Map<DataGridRow, T> _rowMap;

  _CommonDataSource({
    required this.datas,
    required this.columns,
    required this.onPageChanged,
  }) {
    _columnMap = {for (final col in columns) col.name: col};
    _mapDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void _mapDataGridRows() {
    _dataGridRows = datas.map((item) {
      final cells = <DataGridCell>[];
      for (final col in columns) {
        final value = col.valueGetter(item);
        cells.add(DataGridCell<dynamic>(columnName: col.name, value: value));
      }
      // 为占位列添加空数据单元格
      cells.add(DataGridCell<dynamic>(columnName: '_spacer_column', value: ''));
      return DataGridRow(cells: cells);
    }).toList();

    _rowMap = {
      for (int i = 0; i < _dataGridRows.length; i++) _dataGridRows[i]: datas[i],
    };
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = _rowMap[row];
    final effectiveIndex = effectiveRows.indexOf(row);
    final color = effectiveIndex % 2 == 0 ? Colors.white : _infoBgColor;

    return DataGridRowAdapter(
      color: color,
      cells: row.getCells().map<Widget>((cell) {
        final col = _columnMap[cell.columnName];
        if (col == null) return Container(); // 占位列返回空容器

        final custom = col.cellBuilder?.call(
          item as T,
          cell.columnName,
          cell.value,
        );
        return custom ?? _buildCellContent(cell.value, col, item as T);
      }).toList(),
    );
  }

  // 构建单元格内容
  Widget _buildCellContent(
    dynamic value,
    GridColumnConfig<T> config,
    T rowData,
  ) {
    final text =
        config.formatter?.call(value, rowData) ?? value?.toString() ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: config.enableSelectableText
          ? SelectableText(text, style: config.textStyle ?? _infoStyle)
          : Text(
              text,
              style: config.textStyle ?? _infoStyle,
              maxLines: config.maxLines,
              overflow: config.overflow ?? TextOverflow.ellipsis,
              textAlign: config.textAlign,
            ),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    debugPrint('------------- page change ----------');
    debugPrint('old: $oldPageIndex, new: $newPageIndex');

    if (oldPageIndex != newPageIndex) {
      await onPageChanged(newPageIndex + 1);
      return true;
    }

    // return super.handlePageChange(oldPageIndex, newPageIndex);
    return false;
  }
}

/* ------------------ 列配置对象 ------------------ */
class GridColumnConfig<T> {
  final String name;
  final String headerText;
  final double? width;
  final double? minimumWidth;
  final double? maximumWidth;
  final HeaderBuilder? headerBuilder;
  final CellBuilder<T>? cellBuilder;
  final dynamic Function(T row) valueGetter;
  final bool enableSelectableText; // 是否允许文本选择

  // 新增配置选项
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final String Function(dynamic value, T row)? formatter;

  GridColumnConfig({
    this.enableSelectableText = false,
    required this.name,
    required this.headerText,
    this.width,
    this.minimumWidth,
    this.maximumWidth,
    this.headerBuilder,
    required this.valueGetter,
    this.cellBuilder,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textStyle,
    this.formatter,
  });
}
