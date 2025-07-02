import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/features/home/home_data_bloc.dart';
import '../common/app_containers.dart';
import '../../config/color.dart';
import '../common/custom_dropdown.dart';
import '../common/date_range_picker_button.dart';
import '../../utils/excel_exporter.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.bgblu, width: 6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Kiri (Gauge)
          Expanded(
            flex: 4,
            child: Column(
              children: [
                _buildGaugeFilters(context, state),
                const SizedBox(height: 8),
                DoubleGaugeDisplay(
                  gaugeData1: state.tempGaugeData!,
                  gaugeData2: state.humidityGaugeData!,
                ),
              ],
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

  Widget _buildGaugeFilters(BuildContext context, HomeDataState state) {
    final homeBloc = context.read<HomeDataBloc>();
    final filterSelection = state.filterSelection;

    // Helper untuk styling container filter yang konsisten
    Widget buildFilterContainer(Widget child) {
      return Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      color: AppColors.bgblu, // Memberi background putih untuk spasi antar item
      child: Column(
        children: [
          // Baris 1: Judul, Area, Device
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  'Average',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 80),
              Expanded(
                flex: 1,
                child: buildFilterContainer(
                  CustomDropdown(
                    value: filterSelection.selectedRoom,
                    items: state.areaItems,
                    onChanged: (value) {
                      if (value != null) {
                        homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedRoom: value)));
                      }
                    },
                    backgroundColor: Colors.transparent, // Transparan agar warna container terlihat
                    borderRadius: BorderRadius.zero, // Biarkan container yang mengatur radius
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: buildFilterContainer(
                  CustomDropdown(
                    value: filterSelection.selectedSensor,
                    items: state.deviceItems,
                    onChanged: (value) {
                      if (value != null) {
                        homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedSensor: value)));
                      }
                    },
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Baris 2: Tanggal, Export
          Row(
            children: [
              Expanded(
                flex: 1,
                child: buildFilterContainer(
                  CustomDropdown(
                    value: filterSelection.selectedCount,
                    items: state.timeCountItems,
                    onChanged: (value) {
                      if (value != null) {
                        homeBloc.add(HomeDataFilterChanged(
                            filterSelection.copyWith(selectedCount: value)));
                      }
                    },
                    
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.zero,
                  ),
                  
                ),
                
              ),
              const SizedBox(width: 600),
              Expanded(
                flex: 1,
                child: buildFilterContainer(
                  DateRangePickerButton(
                    initialDateRange: filterSelection.selectedDateRange,
                    onDateRangeChanged: (newRange) {
                      homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedDateRange: newRange)));
                    },
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: buildFilterContainer(
                  InkWell(
                    onTap: () => ExcelExporter.exportDataToExcel(context, dateRange: filterSelection.selectedDateRange),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download, size: 18),
                        SizedBox(width: 8),
                        Text('Export'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
