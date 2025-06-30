// lib/models/chart_data_model.dart

import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:testv1/models/filter_selection_model.dart';

class ChartPoint extends Equatable {
  final DateTime time;
  final double value;

  const ChartPoint(this.time, this.value);

  @override
  List<Object> get props => [time, value];
}

class ChartDataModel extends Equatable {
  final String title;
  final String yAxisLabel;
  final String unit;
  final List<ChartPoint> data;

  const ChartDataModel({required this.title, required this.yAxisLabel, required this.unit, required this.data});

  @override
  List<Object> get props => [title, yAxisLabel, unit, data];

  /// Generates dummy data for a chart.
  static ChartDataModel generateDummyData({
    required String type,
    required FilterSelection filter,
    required Random random,
  }) {
    if (type == 'temperature') {
      final List<ChartPoint> tempDataPoints = [
        for (int i = 0; i < 10; i++)
          ChartPoint(filter.selectedDateRange.start.add(Duration(hours: i)), 25.0 + (random.nextDouble() * 5)),
      ];
      return ChartDataModel(
        title: 'Temperature Trend (${filter.selectedSensor})',
        yAxisLabel: 'Temperature',
        unit: '°C',
        data: tempDataPoints,
      );
    } else { // humidity
      final List<ChartPoint> rhDataPoints = [
        for (int i = 0; i < 10; i++)
          ChartPoint(filter.selectedDateRange.start.add(Duration(hours: i)), 60.0 + (random.nextDouble() * 10)),
      ];
      return ChartDataModel(
        title: 'Relative Humidity Trend (${filter.selectedSensor})',
        yAxisLabel: 'Humidity',
        unit: '%',
        data: rhDataPoints,
      );
    }
  }
}