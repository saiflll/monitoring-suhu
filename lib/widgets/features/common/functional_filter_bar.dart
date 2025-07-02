import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import 'package:testv1/models/filter_selection_model.dart';
import 'package:testv1/utils/excel_exporter.dart';
import 'package:testv1/widgets/common/custom_dropdown.dart';
import 'package:testv1/widgets/common/date_range_picker_button.dart';
import 'package:testv1/widgets/common/app_containers.dart';

class FunctionalFilterBar extends StatelessWidget {
  final String? title;
  final FilterSelection? filterSelection;
  final List<String>? areaItems;
  final List<String>? deviceItems;
  final List<String>? timeCountItems;
  final bool showDateRangePicker;
  final bool showExportButton;

  const FunctionalFilterBar({
    super.key,
    this.title,
    this.filterSelection,
    this.areaItems,
    this.deviceItems,
    this.timeCountItems,
    this.showDateRangePicker = false,
    this.showExportButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeDataBloc>();

    final List<Widget> filterWidgets = [];

    // Area Filter
    if (areaItems != null && filterSelection != null) {
      filterWidgets.add(
        SizedBox(
          width: 220,
          child: CustomDropdown(
            value: filterSelection!.selectedRoom,
            items: areaItems!,
            onChanged: (value) {
              if (value != null) {
                homeBloc.add(HomeDataFilterChanged(filterSelection!.copyWith(selectedRoom: value)));
              }
            },
          ),
        ),
      );
    }

    // Device Filter
    if (deviceItems != null && filterSelection != null) {
      filterWidgets.add(
        SizedBox(
          width: 220,
          child: CustomDropdown(
            value: filterSelection!.selectedSensor,
            items: deviceItems!,
            onChanged: (value) {
              if (value != null) {
                homeBloc.add(HomeDataFilterChanged(filterSelection!.copyWith(selectedSensor: value)));
              }
            },
          ),
        ),
      );
    }

    // Time Count Filter
    if (timeCountItems != null && filterSelection != null) {
      filterWidgets.add(
        SizedBox(
          width: 120,
          child: CustomDropdown(
            value: filterSelection!.selectedCount,
            items: timeCountItems!,
            onChanged: (value) {
              if (value != null) {
                homeBloc.add(HomeDataFilterChanged(filterSelection!.copyWith(selectedCount: value)));
              }
            },
          ),
        ),
      );
    }

    // Date Range Filter
    if (showDateRangePicker && filterSelection != null) {
      filterWidgets.add(
        SizedBox(
          width: 220,
          child: DateRangePickerButton(
            initialDateRange: filterSelection!.selectedDateRange,
            onDateRangeChanged: (newRange) {
              homeBloc.add(HomeDataFilterChanged(filterSelection!.copyWith(selectedDateRange: newRange)));
            },
          ),
        ),
      );
    }

    // Export Button
    if (showExportButton && filterSelection != null) {
      filterWidgets.add(
        ElevatedButton.icon(
          onPressed: () => ExcelExporter.exportDataToExcel(context, dateRange: filterSelection!.selectedDateRange),
          icon: const Icon(Icons.download, size: 18),
          label: const Text('Export'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(120, 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      );
    }
    if (title == null && filterWidgets.isEmpty) {
      return const SizedBox.shrink();
    }
    final List<Widget> spacedFilterWidgets = [];
    for (int i = 0; i < filterWidgets.length; i++) {
      spacedFilterWidgets.add(filterWidgets[i]);
      if (i < filterWidgets.length - 1) {
        spacedFilterWidgets.add(const SizedBox(width: 12));
      }
    }

    return CardContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          const Spacer(),
          ...spacedFilterWidgets,
        ],
      ),
    );
  }
}