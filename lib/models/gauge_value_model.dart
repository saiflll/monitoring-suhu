// lib/models/gauge_value_model.dart

import 'dart:math';
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

  /// Generates dummy data for a gauge.
  static GaugeValueModel generateDummyData({
    required String type,
    required Random random,
  }) {
    if (type == 'temperature') {
      final tempValue = 20 + random.nextDouble() * 15;
      return GaugeValueModel(
        value: tempValue,
        title: 'Temperature',
        unit: '°C',
        low: tempValue - (random.nextDouble() * 5),
        high: tempValue + (random.nextDouble() * 10),
        last: tempValue,
      );
    } else { // humidity
      final humidityValue = 40 + random.nextDouble() * 30;
      return GaugeValueModel(
        value: humidityValue,
        title: 'Humidity',
        unit: '%',
        low: humidityValue - (random.nextDouble() * 10),
        high: humidityValue + (random.nextDouble() * 15),
        last: humidityValue,
      );
    }
  }
}