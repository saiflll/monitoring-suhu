import 'package:flutter/material.dart';
import '../common/app_containers.dart';
import '../features/charts/line_chart_widget.dart'; // Import the new chart widget
import '../../models/chart_data_model.dart'; // Import the chart data model

class RHGraphSection extends StatelessWidget {
  const RHGraphSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data untuk grafik RH (akan diganti dengan data dari backend)
    final List<ChartPoint> rhDataPoints = [
      for (int i = 0; i < 10; i++) ChartPoint(DateTime.now().add(Duration(hours: i)), 60.0 + i * 2.5),
    ];
    final ChartDataModel rhChartData = ChartDataModel(
      title: 'Relative Humidity Trend',
      yAxisLabel: 'Humidity',
      unit: '%',
      data: rhDataPoints,
    );

    return SectionContainer(
      child: Column(
        children: [
          PlaceholderBox('RH Graph Title'), // Tetap gunakan PlaceholderBox untuk judul
          const SizedBox(height: 8),
          SizedBox(
            height: 400, // Tinggi tetap untuk grafik
            child: LineChartWidget(chartData: rhChartData),
          ),
        ],
      ),
    );
  }
}