import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/color.dart';
import '../../blocs/features/home/home_data_bloc.dart';
import '../common/app_containers.dart';
import 'package:testv1/widgets/features/gauge/double_gauge_display.dart';
import 'package:testv1/widgets/home_sections/filter_section.dart';

class GaugeAlertSection extends StatelessWidget {
  const GaugeAlertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      // Builder ini hanya akan membangun ulang layout utama saat data pertama kali dimuat atau saat terjadi error.
      // Ini mencegah seluruh bagian menghilang saat filter diubah.
      buildWhen: (previous, current) =>
          (previous.status == HomeDataStatus.initial && current.status != HomeDataStatus.initial) ||
          current.status == HomeDataStatus.failure,
      builder: (context, state) {
        // Tampilkan loading indicator hanya untuk pemuatan awal.
        if (state.filterSelection == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Failure state
        if (state.status == HomeDataStatus.failure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        // Success state
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeDataState state) {
    return SectionContainer(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Section
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgblu,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Wrap FilterSection in its own BlocBuilder to keep its UI in sync
                  BlocBuilder<HomeDataBloc, HomeDataState>(
                    buildWhen: (previous, current) => previous.filterSelection != current.filterSelection,
                    builder: (context, filterState) {
                      return CardContainer(
                        padding: EdgeInsets.zero,
                        child: FilterSection(
                          initialFilter: filterState.filterSelection!,
                          onFilterChanged: (newFilter) {
                            context.read<HomeDataBloc>().add(HomeDataFilterChanged(newFilter));
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  // BlocBuilder ini *hanya* untuk gauge.
                  // Ia akan mengabaikan status 'loading' dan hanya membangun ulang saat data gauge benar-benar berubah.
                  // Ini membuat gauge lama tetap terlihat sampai data baru siap.
                  BlocBuilder<HomeDataBloc, HomeDataState>(
                    buildWhen: (previous, current) =>
                        previous.tempGaugeData != current.tempGaugeData ||
                        previous.humidityGaugeData != current.humidityGaugeData,
                    builder: (context, gaugeState) {
                      if (gaugeState.tempGaugeData != null && gaugeState.humidityGaugeData != null) {
                        return DoubleGaugeDisplay(
                          gaugeData1: gaugeState.tempGaugeData!,
                          gaugeData2: gaugeState.humidityGaugeData!,
                        );
                      }
                      return const SizedBox(height: 200, child: Center(child: Text('No gauge data')));
                    },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Right Section
          Expanded(
            flex: 3,
            child: Container(
              height: 680,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.bgblu,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('alrt_dis'), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
