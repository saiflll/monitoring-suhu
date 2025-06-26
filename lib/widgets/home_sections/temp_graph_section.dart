import 'package:flutter/material.dart';
import '../common/app_containers.dart';
import '../features/charts/line_chart_widget.dart'; // Import the new chart widget
import '../../models/chart_data_model.dart'; // Import the chart data model

class TempGraphSection extends StatelessWidget {
  const TempGraphSection({super.key});

  @override
  Widget build(BuildContext context) {

    final List<ChartPoint> tempDataPoints = [
      for (int i = 0; i < 10; i++) ChartPoint(DateTime.now().add(Duration(hours: i)), 25.0 + i * 0.5),
    ];
    final ChartDataModel tempChartData = ChartDataModel(
      title: 'Temperature Trend',
      yAxisLabel: 'Temperature',
      unit: '°C',
      data: tempDataPoints,
    );

    return SectionContainer(
      child: Column(
        children: [
          SizedBox(
            height: 400, // Tinggi tetap untuk grafik
            child: LineChartWidget(chartData: tempChartData),
          ),
        ],
      ),
    );
  }
}