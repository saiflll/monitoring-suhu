import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../models/chart_data_model.dart';
import '../../../models/filter_selection_model.dart';
import '../../../models/gauge_value_model.dart';
import '../../../models/table_data_model.dart';
import '../../../models/titik_model.dart';

part 'home_data_event.dart';
part 'home_data_state.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, HomeDataState> {
  HomeDataBloc() : super(HomeDataState.initial()) {
    on<HomeDataFetched>(_onHomeDataFetched);
    on<HomeDataFilterChanged>(_onHomeDataFilterChanged);
  }

  Future<void> _onHomeDataFetched(
    HomeDataFetched event,
    Emitter<HomeDataState> emit,
  ) async {
    emit(state.copyWith(status: HomeDataStatus.loading));
    try {
      // Simulate network delay (dihapus untuk pengembangan)
      // await Future.delayed(const Duration(milliseconds: 500));
      final data = _generateDummyData(state.filterSelection!);
      emit(state.copyWith(
        status: HomeDataStatus.success,
        tempGaugeData: data['tempGauge'],
        humidityGaugeData: data['humidityGauge'],
        tempChartData: data['tempChart'],
        humidityChartData: data['humidityChart'],
        tableData: data['table'],
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeDataStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onHomeDataFilterChanged(
    HomeDataFilterChanged event,
    Emitter<HomeDataState> emit,
  ) async {
    emit(state.copyWith(status: HomeDataStatus.loading, filterSelection: event.newFilter));
    try {
      // Simulate network delay for fetching new data
      await Future.delayed(const Duration(milliseconds: 300));
      final data = _generateDummyData(event.newFilter);
      emit(state.copyWith(
        status: HomeDataStatus.success,
        tempGaugeData: data['tempGauge'],
        humidityGaugeData: data['humidityGauge'],
        tempChartData: data['tempChart'],
        humidityChartData: data['humidityChart'],
        tableData: data['table'],
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeDataStatus.failure, errorMessage: e.toString()));
    }
  }

  // Helper to generate all dummy data based on a filter
  Map<String, dynamic> _generateDummyData(FilterSelection filter) {
    final random = Random();

    // Gauge Data
    final tempValue = 20 + random.nextDouble() * 15;
    final tempGauge = GaugeValueModel(
      value: tempValue,
      title: 'Temperature',
      unit: '°C',
      low: tempValue - (random.nextDouble() * 5),
      high: tempValue + (random.nextDouble() * 10),
      last: tempValue,
    );

    final humidityValue = 40 + random.nextDouble() * 30;
    final humidityGauge = GaugeValueModel(
      value: humidityValue,
      title: 'Humidity',
      unit: '%',
      low: humidityValue - (random.nextDouble() * 10),
      high: humidityValue + (random.nextDouble() * 15),
      last: humidityValue,
    );

    // Chart Data
    final List<ChartPoint> tempDataPoints = [
      for (int i = 0; i < 10; i++)
        ChartPoint(filter.selectedDateRange.start.add(Duration(hours: i)), 25.0 + (random.nextDouble() * 5)),
    ];
    final tempChart = ChartDataModel(
      title: 'Temperature Trend (${filter.selectedSensor})',
      yAxisLabel: 'Temperature',
      unit: '°C',
      data: tempDataPoints,
    );

    final List<ChartPoint> rhDataPoints = [
      for (int i = 0; i < 10; i++)
        ChartPoint(filter.selectedDateRange.start.add(Duration(hours: i)), 60.0 + (random.nextDouble() * 10)),
    ];
    final humidityChart = ChartDataModel(
      title: 'Relative Humidity Trend (${filter.selectedSensor})',
      yAxisLabel: 'Humidity',
      unit: '%',
      data: rhDataPoints,
    );

    // Table Data
    // The logic is now moved to the model for better separation of concerns.
    final table = TableDataModel.generateDummyData(filter);

    return {
      'tempGauge': tempGauge,
      'humidityGauge': humidityGauge,
      'tempChart': tempChart,
      'humidityChart': humidityChart,
      'table': table,
    };
  }
}