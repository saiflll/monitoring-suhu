import 'package:flutter/material.dart';
import 'package:testv1/widgets/common/app_containers.dart';
import 'package:testv1/models/gauge_value_model.dart';
import 'package:testv1/widgets/features/gauge/gauge.dart';

class DoubleGaugeDisplay extends StatelessWidget {
  final GaugeValueModel gaugeData1;
  final GaugeValueModel gaugeData2;

  const DoubleGaugeDisplay({super.key, required this.gaugeData1, required this.gaugeData2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CardContainer(
            padding: const EdgeInsets.all(8),
            child: RadialGaugeDisplay(gaugeData: gaugeData1),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CardContainer(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadialGaugeDisplay(gaugeData: gaugeData2),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.bgblu,
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'Low: ${gaugeData2.low.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14, color: AppColors.black),
                      ),
                    ),
                    Container(
                      color: AppColors.bgblu,
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'High: ${gaugeData2.high.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14, color: AppColors.black),
                      ),
                    ),
                    Container(
                      color: AppColors.bgblu,
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        'Last: ${gaugeData2.last.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black),
                      ),
                    ),
                   
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}