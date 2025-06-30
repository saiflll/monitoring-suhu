import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import 'package:testv1/models/chart_data_model.dart';
import '../common/app_containers.dart';
import '../features/charts/line_chart_widget.dart';

/// A generic section to display a chart.
/// It gets the chart data from the provided [chartDataSelector] function.
class ChartSection extends StatelessWidget {
  final ChartDataModel? Function(HomeDataState) chartDataSelector;

  const ChartSection({
    super.key,
    required this.chartDataSelector,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      buildWhen: (previous, current) => chartDataSelector(previous) != chartDataSelector(current),
      builder: (context, state) {
        final chartData = chartDataSelector(state);

        if (chartData == null) {
          return const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()));
        }

        return SectionContainer(child: SizedBox(height: 400, child: LineChartWidget(chartData: chartData)));
      },
    );
  }
}