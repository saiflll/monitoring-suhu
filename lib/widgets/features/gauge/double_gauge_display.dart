import 'package:flutter/material.dart';
import 'package:testv1/config/color.dart';
import 'package:testv1/widgets/common/app_containers.dart';
import 'package:testv1/models/gauge_value_model.dart';
import 'package:testv1/widgets/features/gauge/gauge.dart';

class DoubleGaugeDisplay extends StatelessWidget {
  final GaugeValueModel gaugeData1;
  final GaugeValueModel gaugeData2;

  const DoubleGaugeDisplay({
    super.key,
    required this.gaugeData1,
    required this.gaugeData2,
  });

  Widget _buildGaugeCard(GaugeValueModel data) {
    return CardContainer(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadialGaugeDisplay(gaugeData: data),
          const SizedBox(height: 8),
          Column(
            children: [
              _buildStatisticRow(
                'Last ${data.title} (${data.unit}):',
                data.last.toStringAsFixed(2),
                isBold: true,
              ),
              const SizedBox(height: 4),
              _buildStatisticRow(
                  'Low ${data.title} (${data.unit}):', data.low.toStringAsFixed(2)),
              const SizedBox(height: 4),
              _buildStatisticRow('High ${data.title} (${data.unit}):',
                  data.high.toStringAsFixed(2)),
            ],
          
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
  
  Widget _buildStatisticRow(String label, String value, {bool isBold = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          // Label
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.bgblu,
                border: Border.all(color: AppColors.bgblu, width: 4),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          //  Nilai
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.bgblu, width: 4),
              ),
              child: Text(value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                      color: AppColors.black)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildGaugeCard(gaugeData1)),
        const SizedBox(width: 8),
        Expanded(child: _buildGaugeCard(gaugeData2)),
        const SizedBox(width: 14),
      ],
    );
  }
}
