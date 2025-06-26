// lib/widgets/features/charts/line_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:testv1/models/chart_data_model.dart';
import 'package:testv1/config/color.dart';

class LineChartWidget extends StatelessWidget {
  final ChartDataModel chartData;

  const LineChartWidget({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgblu, 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Chart Placeholder: ${chartData.title}\n(Data points: ${chartData.data.length})',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.black54),
        ),
      ),
    );
  }
}