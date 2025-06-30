import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../models/titik_model.dart';
import '../../models/filter_selection_model.dart';
import '../common/custom_dropdown.dart';
import '../common/date_range_picker_button.dart';
import '../../utils/excel_exporter.dart';

class FilterSection extends StatefulWidget {
  final FilterSelection initialFilter;
  final ValueChanged<FilterSelection> onFilterChanged;

  const FilterSection({
    super.key,
    required this.initialFilter,
    required this.onFilterChanged,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  late String _selectedRoom;
  late String _selectedSensor;
  late String _selectedCount;
  late DateTimeRange _selectedDateRange;

  final List<String> _roomItems = Titik.areaNames;
  final List<String> _sensorItems = ['Device 1', 'Device 2', 'Device 3', 'Device 4'];
  final List<String> _countItems = ['1h', '2h', '3h'];

  @override
  void initState() {
    super.initState();
    _selectedRoom = widget.initialFilter.selectedRoom;
    _selectedSensor = widget.initialFilter.selectedSensor;
    _selectedCount = widget.initialFilter.selectedCount;
    _selectedDateRange = widget.initialFilter.selectedDateRange;
  }

  @override
  void didUpdateWidget(covariant FilterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFilter != oldWidget.initialFilter) {
      _selectedRoom = widget.initialFilter.selectedRoom;
      _selectedSensor = widget.initialFilter.selectedSensor;
      _selectedCount = widget.initialFilter.selectedCount;
      _selectedDateRange = widget.initialFilter.selectedDateRange;
    }
  }

  void _updateFilterAndNotify() {
    final newFilter = FilterSelection(
      selectedRoom: _selectedRoom,
      selectedSensor: _selectedSensor,
      selectedCount: _selectedCount,
      selectedDateRange: _selectedDateRange,
    );
    widget.onFilterChanged(newFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Baris 1
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgblu,
            border: const Border(
              bottom: BorderSide(
                width: 4,
                color: AppColors.white,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Average',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropdown(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    borderRadius: BorderRadius.circular(15),
                    value: _selectedRoom,
                    items: _roomItems,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedRoom = value);
                        _updateFilterAndNotify();
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomDropdown(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    borderRadius: BorderRadius.circular(15),
                    value: _selectedSensor,
                    items: _sensorItems,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedSensor = value);
                        _updateFilterAndNotify();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // Baris 2
        Container(
          color: AppColors.bgblu,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDropdown(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                borderRadius: BorderRadius.circular(15),
                value: _selectedCount,
                items: _countItems,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCount = value);
                    _updateFilterAndNotify();
                  }
                },
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DateRangePickerButton(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    borderRadius: BorderRadius.circular(15),
                    initialDateRange: _selectedDateRange,
                    onDateRangeChanged: (newRange) {
                      setState(() {
                        _selectedDateRange = newRange;
                      });
                      _updateFilterAndNotify();
                    },
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () => ExcelExporter.exportDataToExcel(
                        context,
                        dateRange: _selectedDateRange,
                        // Pass other filter values if needed for actual export
                        // room: _selectedRoom,
                        // sensor: _selectedSensor,
                        // count: _selectedCount,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_download_outlined, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Export',
                            style: TextStyle(color: AppColors.black, fontSize: 14),
                          ),
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
    );
  }
}