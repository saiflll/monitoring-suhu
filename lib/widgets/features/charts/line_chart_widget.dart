// lib/widgets/features/charts/line_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:testv1/models/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide ChartPoint;
import 'package:intl/intl.dart';
import 'package:testv1/config/color.dart';

class LineChartWidget extends StatelessWidget {
  final ChartDataModel chartData;

  const LineChartWidget({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
        title: ChartTitle(
          text: chartData.title,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          dateFormat: DateFormat.Hm(), // Format for Hour:Minute
          intervalType: DateTimeIntervalType.hours,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}${chartData.unit}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent),
        ),
        series: <LineSeries<ChartPoint, DateTime>>[
          LineSeries<ChartPoint, DateTime>(
            dataSource: chartData.data,
            xValueMapper: (ChartPoint point, _) => point.time,
            yValueMapper: (ChartPoint point, _) => point.value,
            name: chartData.yAxisLabel,
            color: AppColors.subpri, // warna garis
            markerSettings: MarkerSettings(
              isVisible: true,
              width: 10,
              height: 10,
              color: AppColors.white, // warna dot/marker
              borderColor: AppColors.pri, // warna border dot/marker
              borderWidth: 2,
              
            ),
          ),
        ],
       
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: false,
          format: 'point.x : point.y${chartData.unit}',
        ),
        legend: Legend(isVisible: false), // Legend can be enabled if needed
      ),
    );
  }
}