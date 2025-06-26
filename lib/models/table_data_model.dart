// lib/models/table_data_model.dart

import 'package:equatable/equatable.dart';

class TableRowData extends Equatable {
  final String id;
  final String event;
  final String timestamp;
  final String status;

  const TableRowData({required this.id, required this.event, required this.timestamp, required this.status});

  @override
  List<Object> get props => [id, event, timestamp, status];
}

class TableDataModel extends Equatable {
  final List<String> headers;
  final List<TableRowData> rows;

  const TableDataModel({required this.headers, required this.rows});

  @override
  List<Object> get props => [headers, rows];
}