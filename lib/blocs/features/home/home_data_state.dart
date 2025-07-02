


part of 'home_data_bloc.dart';


enum HomeDataStatus { initial, loading, success, failure }

class HomeDataState extends Equatable {
  const HomeDataState({
    this.status = HomeDataStatus.initial,
    required this.filterSelection,
    this.tempGaugeData,
    this.humidityGaugeData,
    this.tempChartData,
    this.humidityChartData,
    this.tableData,
    this.areaItems = const [],
    this.deviceItems = const [],
    this.timeCountItems = const [],
    this.errorMessage = '',
  });

  final HomeDataStatus status;
  final FilterSelection filterSelection;
  final GaugeValueModel? tempGaugeData;
  final GaugeValueModel? humidityGaugeData;
  final ChartDataModel? tempChartData;
  final ChartDataModel? humidityChartData;
  final TableDataModel? tableData;
  final List<String> areaItems;
  final List<String> deviceItems;
  final List<String> timeCountItems;
  final String errorMessage;

  factory HomeDataState.initial() {
    final areaNames = Titik.areaNames;
    final initialRoom = areaNames.isNotEmpty ? areaNames.first : '';
    final deviceItems = Titik.getDeviceItemsForArea(initialRoom);
    final initialFilter = FilterSelection(
      selectedRoom: initialRoom,
      selectedSensor: deviceItems.isNotEmpty ? deviceItems.first : '',
      selectedCount: FilterConstants.timeCountItems.first,
      selectedDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
    );
    return HomeDataState(
      status: HomeDataStatus.initial,
      filterSelection: initialFilter,
      areaItems: areaNames,
      deviceItems: deviceItems,
      timeCountItems: FilterConstants.timeCountItems,
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
    List<String>? areaItems,
    List<String>? deviceItems,
    List<String>? timeCountItems,
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
      areaItems: areaItems ?? this.areaItems,
      deviceItems: deviceItems ?? this.deviceItems,
      timeCountItems: timeCountItems ?? this.timeCountItems,
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
        areaItems,
        deviceItems,
        timeCountItems,
        errorMessage,
      ];
}