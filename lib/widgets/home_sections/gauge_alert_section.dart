import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/features/home/home_data_bloc.dart';
import '../common/app_containers.dart';
import 'package:testv1/widgets/features/gauge/double_gauge_display.dart';

class GaugeAlertSection extends StatelessWidget {
  const GaugeAlertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      buildWhen: (previous, current) =>
          previous.tempGaugeData != current.tempGaugeData ||
          previous.humidityGaugeData != current.humidityGaugeData ||
          previous.status != current.status,
      builder: (context, state) {
        if (state.status == HomeDataStatus.failure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        if (state.tempGaugeData == null || state.humidityGaugeData == null) {
          return const SizedBox(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }

        // Success state
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeDataState state) {
    return SectionContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Kiri (Gauge)
          Expanded(
            flex: 4,
            child: DoubleGaugeDisplay(
              gaugeData1: state.tempGaugeData!,
              gaugeData2: state.humidityGaugeData!,
            ),
          ),
          const SizedBox(width: 8),

          // Bagian Kanan (Alert)
          Expanded(
            flex: 3,
            child: CardContainer(
              height: 680,
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'Alert Display',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
