part of 'home_data_bloc.dart';

enum HomeDataStatus { initial, loading, success, failure }

class HomeDataState extends Equatable {
  const HomeDataState({
    this.status = HomeDataStatus.initial,
    this.filterSelection,
    this.tempGaugeData,
    this.humidityGaugeData,
    this.tempChartData,
    this.humidityChartData,
    this.tableData,
    this.errorMessage = '',
  });

  final HomeDataStatus status;
  final FilterSelection? filterSelection;
  final GaugeValueModel? tempGaugeData;
  final GaugeValueModel? humidityGaugeData;
  final ChartDataModel? tempChartData;
  final ChartDataModel? humidityChartData;
  final TableDataModel? tableData;
  final String errorMessage;

  factory HomeDataState.initial() {
    final initialFilter = FilterSelection(
      selectedRoom: Titik.areaNames.first, // Gunakan nilai pertama yang valid
      selectedSensor: 'Device 1',
      selectedCount: '1h',
      selectedDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
    );
    return HomeDataState(
      status: HomeDataStatus.initial,
      filterSelection: initialFilter,
    );
  }

  HomeDataState copyWith({
    HomeDataStatus? status,
    FilterSelection? filterSelection,
    GaugeValueModel? tempGaugeData,
    GaugeValueModel? humidityGaugeData,
    ChartDataModel? tempChartData,
    ChartDataModel? humidityChartData,
    TableDataModel? tableData,
    String? errorMessage,
  }) {
    return HomeDataState(
      status: status ?? this.status,
      filterSelection: filterSelection ?? this.filterSelection,
      tempGaugeData: tempGaugeData ?? this.tempGaugeData,
      humidityGaugeData: humidityGaugeData ?? this.humidityGaugeData,
      tempChartData: tempChartData ?? this.tempChartData,
      humidityChartData: humidityChartData ?? this.humidityChartData,
      tableData: tableData ?? this.tableData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        filterSelection,
        tempGaugeData,
        humidityGaugeData,
        tempChartData,
        humidityChartData,
        tableData,
        errorMessage,
      ];
}