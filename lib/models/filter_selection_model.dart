import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class FilterSelection extends Equatable {
  final String selectedRoom;
  final String selectedSensor;
  final String selectedCount;
  final DateTimeRange selectedDateRange;

  const FilterSelection({
    required this.selectedRoom,
    required this.selectedSensor,
    required this.selectedCount,
    required this.selectedDateRange,
  });

  FilterSelection copyWith({
    String? selectedRoom,
    String? selectedSensor,
    String? selectedCount,
    DateTimeRange? selectedDateRange,
  }) {
    return FilterSelection(
      selectedRoom: selectedRoom ?? this.selectedRoom,
      selectedSensor: selectedSensor ?? this.selectedSensor,
      selectedCount: selectedCount ?? this.selectedCount,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
    );
  }

  @override
  List<Object?> get props => [selectedRoom, selectedSensor, selectedCount, selectedDateRange];
}