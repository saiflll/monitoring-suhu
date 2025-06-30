// lib/models/table_data_model.dart

import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:testv1/models/filter_selection_model.dart';

class TableRowData extends Equatable {
  final int no;
  final String titikSensor;
  final String area;
  final DateTime timestamp;
  final String status;
  final double temperature;
  final double humidity;

  const TableRowData({
    required this.no,
    required this.titikSensor,
    required this.area,
    required this.timestamp,
    required this.status,
    required this.temperature,
    required this.humidity,
  });

  @override
  List<Object> get props => [no, titikSensor, area, timestamp, status, temperature, humidity];
}

class TableDataModel extends Equatable {
  final List<String> headers;
  final List<TableRowData> rows;

  const TableDataModel({required this.headers, required this.rows});

  @override
  List<Object> get props => [headers, rows];

  // Dummy data 
  static TableDataModel generateDummyData(FilterSelection filter) {
    final random = Random();
    final statuses = ['running', 'offline'];
    final sensors = ['Sensor T/H 01', 'Sensor Pintu 01', 'Sensor Suhu 02', 'Sensor Kelembapan 01'];

    return TableDataModel(
      headers: [
        'No',
        'Titik Sensor',
        'Area',
        'Date',
        'Time',
        'Status',
        'Temperature  (℃)',
        'Humidity  (%)'
      ],
      rows: List.generate(30, (index) {
        return TableRowData(
          no: index + 1,
          titikSensor: sensors[random.nextInt(sensors.length)],
          area: filter.selectedRoom,
          timestamp: DateTime.now().subtract(Duration(hours: index, minutes: random.nextInt(60))),
          status: statuses[random.nextInt(statuses.length)],
          temperature: 20 + random.nextDouble() * 15, 
          humidity: 40 + random.nextDouble() * 30,
        );
      }),
    );
  }
}