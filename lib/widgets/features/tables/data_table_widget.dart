// lib/widgets/features/tables/data_table_widget.dart

import 'package:flutter/material.dart';
import 'package:testv1/models/table_data_model.dart';
import 'package:testv1/config/color.dart';

class DataTableWidget extends StatelessWidget {
  final TableDataModel tableData;

  const DataTableWidget({super.key, required this.tableData});

  @override
  Widget build(BuildContext context) {
    // Placeholder for a real DataTable or data_table_2 widget
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgblu, // Example background for the table area
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Table Placeholder',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                'Headers: ${tableData.headers.join(', ')}\nRows: ${tableData.rows.length}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}