import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import 'package:testv1/config/color.dart';
import 'package:testv1/models/filter_selection_model.dart';
import 'package:testv1/utils/excel_exporter.dart';
import 'package:testv1/widgets/common/custom_dropdown.dart';
import 'package:testv1/widgets/common/date_range_picker_button.dart';

class FunctionalFilterBar extends StatelessWidget {
  final String title;
  final FilterSelection filterSelection;
  final List<String> areaItems;
  final List<String> deviceItems;
  final List<String> timeCountItems;

  const FunctionalFilterBar({
    super.key,
    required this.title,
    required this.filterSelection,
    required this.areaItems,
    required this.deviceItems,
    required this.timeCountItems,
  });

  Widget _buildFilterContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeDataBloc>();

    return Container(
      color: const Color(0xFFEAF6FF),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Atas
          Container(
            height: 40, // Batasan tinggi
            margin: const EdgeInsets.only(bottom: 8), // Margin bawah
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(), // Menambahkan Spacer untuk mendorong item ke kanan
                Row(
                  children: [
                    _buildFilterContainer(
                      child: CustomDropdown(
                        value: filterSelection.selectedRoom,
                        items: areaItems,
                        onChanged: (value) {
                          if (value != null) {
                            homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedRoom: value)));
                          }
                        },
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildFilterContainer(
                      child: CustomDropdown(
                        value: filterSelection.selectedSensor,
                        items: deviceItems,
                        onChanged: (value) {
                          if (value != null) {
                            homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedSensor: value)));
                          }
                        },
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Baris Bawah
          SizedBox(
            height: 40, // Batasan tinggi
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
              children: [
                _buildFilterContainer(
                  child: CustomDropdown(
                    value: filterSelection.selectedCount,
                    items: timeCountItems,
                    onChanged: (value) {
                      if (value != null) {
                        homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedCount: value)));
                      }
                    },
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                ),
                const Spacer(), // Menambahkan Spacer untuk mendorong item ke kanan
                Row(
                  children: [
                    _buildFilterContainer(
                      child: DateRangePickerButton(
                        initialDateRange: filterSelection.selectedDateRange,
                        onDateRangeChanged: (newRange) {
                          homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedDateRange: newRange)));
                        },
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () => ExcelExporter.exportDataToExcel(
                        context,
                        dateRange: filterSelection.selectedDateRange,
                      ),
                      child: _buildFilterContainer(
                        child: const Row(
                          children: [
                            Icon(Icons.download, size: 16),
                            SizedBox(width: 8),
                            Text('Export'),
                            SizedBox(width: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}