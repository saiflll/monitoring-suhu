import 'package:flutter/material.dart';
import '../../config/color.dart';

class DateRangePickerButton extends StatefulWidget {
  final DateTimeRange initialDateRange;
  final ValueChanged<DateTimeRange> onDateRangeChanged;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  const DateRangePickerButton({
    super.key,
    required this.initialDateRange,
    required this.onDateRangeChanged,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  State<DateRangePickerButton> createState() => _DateRangePickerButtonState();
}

class _DateRangePickerButtonState extends State<DateRangePickerButton> {
  late DateTimeRange _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.initialDateRange;
  }

  @override
  void didUpdateWidget(covariant DateRangePickerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDateRange != oldWidget.initialDateRange) {
      _selectedDateRange = widget.initialDateRange;
    }
  }

  String get _dateRangeText {
    final start = _selectedDateRange.start;
    final end = _selectedDateRange.end;
    final now = DateTime.now();

    bool isSameDate(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    if (isSameDate(start, now) && isSameDate(end, now)) {
      return 'Today';
    }

    final startFormatted = '${start.day}/${start.month}/${start.year}';
    final endFormatted = '${end.day}/${end.month}/${end.year}';

    return isSameDate(start, end) ? startFormatted : '$startFormatted - $endFormatted';
  }

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.subpri,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.subpri),
            ),
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
      widget.onDateRangeChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: _pickDateRange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 18),
            const SizedBox(width: 8),
            Text(
              _dateRangeText,
              style: const TextStyle(color: AppColors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
