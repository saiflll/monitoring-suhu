import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/chart_data_model.dart';
import '../../../models/filter_selection_model.dart';
import '../../../models/gauge_value_model.dart';
import '../../../models/table_data_model.dart';
import '../../../models/titik_model.dart';
import '../../../config/filter_constants.dart';

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
      final data = _generateDummyData(state.filterSelection);
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
    var newFilter = event.newFilter;
    List<String> newDeviceItems = state.deviceItems;

    // Cek apakah ruangan berubah.
    if (newFilter.selectedRoom != state.filterSelection.selectedRoom) {
      // Jika ya, perbarui daftar device yang tersedia untuk ruangan baru.
      newDeviceItems = Titik.getDeviceItemsForArea(newFilter.selectedRoom);
      
      // Cek apakah sensor yang datang dari event valid untuk area baru.
      // Ini penting agar klik dari peta (yang mengirim area & sensor) tidak di-reset.
      final isSensorValidForNewRoom = newDeviceItems.contains(newFilter.selectedSensor);

      // Jika sensor TIDAK valid (misalnya, saat user ganti area via dropdown),
      // reset sensor ke item pertama dari daftar device yang baru.
      if (!isSensorValidForNewRoom) {
        final newSelectedSensor = newDeviceItems.isNotEmpty ? newDeviceItems.first : '';
        newFilter = newFilter.copyWith(selectedSensor: newSelectedSensor);
      }
    }

    emit(state.copyWith(
      status: HomeDataStatus.loading,
      filterSelection: newFilter,
      deviceItems: newDeviceItems, // Kirim daftar device yang sudah diperbarui
    ));

    try {
      // Simulate network delay for fetching new data
      await Future.delayed(const Duration(milliseconds: 300));
      final data = _generateDummyData(newFilter); // Gunakan filter yang sudah diperbarui
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
    
    return {
      'tempGauge': GaugeValueModel.generateDummyData(type: 'temperature', random: random),
      'humidityGauge': GaugeValueModel.generateDummyData(type: 'humidity', random: random),
      'tempChart': ChartDataModel.generateDummyData(
        type: 'temperature',
        filter: filter,
        random: random,
      ),
      'humidityChart': ChartDataModel.generateDummyData(
        type: 'humidity',
        filter: filter,
        random: random,
      ),
      'table': TableDataModel.generateDummyData(filter),
    };
  }
}