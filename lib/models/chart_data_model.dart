// lib/models/chart_data_model.dart

import 'package:equatable/equatable.dart';

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
}