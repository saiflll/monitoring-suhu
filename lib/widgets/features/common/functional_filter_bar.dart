import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import 'package:testv1/models/filter_selection_model.dart';
import 'package:testv1/utils/excel_exporter.dart';
import 'package:testv1/widgets/common/custom_dropdown.dart';
import 'package:testv1/widgets/common/date_range_picker_button.dart';
import 'package:testv1/widgets/common/app_containers.dart';

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

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeDataBloc>();

    return CardContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 24),
            // Area Filter
            Expanded(
              flex: 2,
              child: CustomDropdown(
                value: filterSelection.selectedRoom,
                items: areaItems,
                onChanged: (value) {
                  if (value != null) {
                    homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedRoom: value)));
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            // Device Filter
            Expanded(
              flex: 2,
              child: CustomDropdown(
                value: filterSelection.selectedSensor,
                items: deviceItems,
                onChanged: (value) {
                  if (value != null) {
                    homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedSensor: value)));
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            // Time Count Filter
            Expanded(
              flex: 1,
              child: CustomDropdown(
                value: filterSelection.selectedCount,
                items: timeCountItems,
                onChanged: (value) {
                  if (value != null) {
                    homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedCount: value)));
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            // Date Range Filter
            Expanded(
              flex: 2,
              child: DateRangePickerButton(
                initialDateRange: filterSelection.selectedDateRange,
                onDateRangeChanged: (newRange) {
                  homeBloc.add(HomeDataFilterChanged(filterSelection.copyWith(selectedDateRange: newRange)));
                },
              ),
            ),
            const SizedBox(width: 12),
            // Export Button
            ElevatedButton.icon(
              onPressed: () => ExcelExporter.exportDataToExcel(context, dateRange: filterSelection.selectedDateRange),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Export'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}