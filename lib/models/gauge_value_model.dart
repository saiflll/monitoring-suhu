// lib/models/gauge_value_model.dart

import 'package:equatable/equatable.dart';

class GaugeValueModel extends Equatable {
  final double value;
  final String title;
  final String unit; // e.g., "°C", "%"

  const GaugeValueModel({required this.value, required this.title, this.unit = ''});

  @override
  List<Object> get props => [value, title, unit];
}