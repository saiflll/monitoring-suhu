// lib/models/gauge_value_model.dart

import 'package:equatable/equatable.dart';

class GaugeValueModel extends Equatable {
  final double value;
  final String title;
  final String unit;
  final double low;
  final double high;
  final double last;

  const GaugeValueModel({
    required this.value,
    required this.title,
    this.unit = '',
    required this.low,
    required this.high,
    required this.last,
  });

  @override
  List<Object> get props => [value, title, unit, low, high, last];
}