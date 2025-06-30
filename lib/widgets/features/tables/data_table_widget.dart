import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';
import 'package:testv1/models/table_data_model.dart';
import 'package:testv1/config/color.dart';

class DataTableWidget extends StatefulWidget {
  final TableDataModel tableData;
  final double? height;

  const DataTableWidget({
    super.key,
    required this.tableData,
    this.height,
  });

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  late _EventDataGridSource _dataSource;
  final double _dataPagerHeight = 80.0;

  @override
  void initState() {
    super.initState();
    _dataSource = _EventDataGridSource(eventData: widget.tableData.rows);
  }

  @override
  void didUpdateWidget(covariant DataTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tableData.rows != oldWidget.tableData.rows) {
      _dataSource.updateDataGridSource(newData: widget.tableData.rows);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0), 
      child: SizedBox(
        height: widget.height,
        child: SfDataGridTheme(
          data: SfDataGridThemeData(
            headerColor: AppColors.blul,
            headerHoverColor: AppColors.bgblu.withOpacity(0.5),
            sortIconColor: AppColors.white,
            gridLineColor: AppColors.blul,
          ),
          child: Column(
            children: [
              Expanded(
                child: SfDataGrid(
                  source: _dataSource,
                  allowSorting: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'no',
                      width: 60,
                      label: Container(
                        padding: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'titikSensor',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[1], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'area',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[2], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'date',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[3], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'time',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[4], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'status',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[5], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'temperature',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[6], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                    GridColumn(
                      columnName: 'humidity',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(widget.tableData.headers[7], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              Container( //nav tabel
                height: _dataPagerHeight,
                alignment: Alignment.topRight, 
                width: 350,
                //color: AppColors.pri,
                child: SfDataPager(
                  
                  delegate: _dataSource,
                  pageCount: (widget.tableData.rows.length / 10).ceil().toDouble(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDataGridSource extends DataGridSource {
  _EventDataGridSource({required List<TableRowData> eventData}) {
    _fullEventData = eventData;
    _paginatedRows = _fullEventData.getRange(0, min(_rowsPerPage, _fullEventData.length)).toList();
    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];
  List<TableRowData> _fullEventData = [];
  List<TableRowData> _paginatedRows = [];
  final int _rowsPerPage = 10;

  void _buildDataGridRows() {
    _dataGridRows = _paginatedRows.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'no', value: dataGridRow.no),
        DataGridCell<String>(columnName: 'titikSensor', value: dataGridRow.titikSensor),
        DataGridCell<String>(columnName: 'area', value: dataGridRow.area),
        DataGridCell<DateTime>(columnName: 'date', value: dataGridRow.timestamp),
        DataGridCell<DateTime>(columnName: 'time', value: dataGridRow.timestamp),
        DataGridCell<String>(columnName: 'status', value: dataGridRow.status),
        DataGridCell<double>(columnName: 'temperature', value: dataGridRow.temperature),
        DataGridCell<double>(columnName: 'humidity', value: dataGridRow.humidity),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  // ⚡️ BuildRow dengan warna per sel khusus status
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        String text;

        // Atur warna khusus untuk sel status
        Color cellColor = Colors.transparent;
        if (dataGridCell.columnName == 'status') {
          final statusValue = dataGridCell.value.toString().toLowerCase();
          switch (statusValue) {
            case 'running':
              cellColor = Colors.transparent;
              
              break;
            case 'offline':
              cellColor = Colors.transparent;
              break;
            default:
              cellColor = Colors.transparent;
              break;
          }
        }

        // Atur format text sesuai kolom
        switch (dataGridCell.columnName) {
          case 'date':
            text = DateFormat('dd/MM/yyyy').format(dataGridCell.value);
            break;
          case 'time':
            text = DateFormat('HH:mm:ss').format(dataGridCell.value);
            break;
          case 'temperature':
          case 'humidity':
            text = (dataGridCell.value as double).toStringAsFixed(1);
            break;
          default:
            text = dataGridCell.value.toString();
        }

        return Container(
          color: cellColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4.0),
          child: Text(text),
        );
      }).toList(),
    );
  }

  void updateDataGridSource({required List<TableRowData> newData}) {
    _fullEventData = newData;
    _paginatedRows = _fullEventData.getRange(0, min(_rowsPerPage, _fullEventData.length)).toList();
    _buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    final int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;

    if (endIndex > _fullEventData.length) {
      endIndex = _fullEventData.length;
    }

    _paginatedRows = _fullEventData.getRange(startIndex, endIndex).toList();
    _buildDataGridRows();
    notifyListeners();
    return true;
  }

  @override
  Future<void> sort() async {
    final SortColumnDetails? sortedColumn = sortedColumns.isNotEmpty ? sortedColumns.first : null;
    if (sortedColumn != null) {
      _fullEventData.sort((a, b) {
        final aValue = _getCellValue(a, sortedColumn.name);
        final bValue = _getCellValue(b, sortedColumn.name);
        int comparison = 0;

        if (aValue is Comparable && bValue is Comparable) {
          comparison = aValue.compareTo(bValue);
        }
        return sortedColumn.sortDirection == DataGridSortDirection.ascending ? comparison : -comparison;
      });
      _paginatedRows = _fullEventData.getRange(0, min(_rowsPerPage, _fullEventData.length)).toList();
      _buildDataGridRows();
      notifyListeners();
    }
  }

  dynamic _getCellValue(TableRowData row, String columnName) {
    switch (columnName) {
      case 'no':
        return row.no;
      case 'titikSensor':
        return row.titikSensor;
      case 'area':
        return row.area;
      case 'date':
      case 'time':
        return row.timestamp;
      case 'status':
        return row.status;
      case 'temperature':
        return row.temperature;
      case 'humidity':
        return row.humidity;
      default:
        return '';
    }
  }
}
