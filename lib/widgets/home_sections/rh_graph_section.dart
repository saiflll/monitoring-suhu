import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import '../common/app_containers.dart'; // Tetap dibutuhkan untuk SectionContainer
import '../../models/titik_model.dart';
import '../features/common/functional_filter_bar.dart';
import '../features/charts/line_chart_widget.dart'; // Import the new chart widget

class RHGraphSection extends StatelessWidget {
  const RHGraphSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      buildWhen: (previous, current) =>
          previous.humidityChartData != current.humidityChartData ||
          previous.filterSelection != current.filterSelection,
      builder: (context, state) {
        if (state.humidityChartData == null || state.filterSelection == null) {
          return const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()));
        }

        final areaItems = Titik.areaNames;
        const deviceItems = ['Device 1', 'Device 2', 'Device 3', 'Device 4'];
        const timeCountItems = ['1h', '2h', '3h'];

        return SectionContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FunctionalFilterBar(
                title: 'Humidity Chart',
                filterSelection: state.filterSelection!,
                areaItems: areaItems,
                deviceItems: deviceItems,
                timeCountItems: timeCountItems,
              ),
              SizedBox(
                height: 400, // Tinggi tetap untuk grafik
                child: LineChartWidget(chartData: state.humidityChartData!),
              ),
            ],
          ),
        );
      },
    );
  }
}