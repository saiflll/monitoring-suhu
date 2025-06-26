import 'package:flutter/material.dart';
import '../common/app_containers.dart';
import '../features/tables/data_table_widget.dart'; // Import the new table widget
import '../../models/table_data_model.dart'; // Import the table data model

class TableDetailSection extends StatelessWidget {
  const TableDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data untuk tabel (akan diganti dengan data dari backend)
    final TableDataModel tableData = TableDataModel(
      headers: ['ID', 'Event', 'Timestamp', 'Status'],
      rows: const [
        TableRowData(id: 'EV001', event: 'Sensor A Anomaly', timestamp: '2023-10-26 10:00:00', status: 'Warning'),
        TableRowData(id: 'EV002', event: 'Door Opened', timestamp: '2023-10-26 09:30:00', status: 'Normal'),
        TableRowData(id: 'EV003', event: 'Temperature Spike', timestamp: '2023-10-26 08:45:00', status: 'Critical'),
      ],
    );

    return SectionContainer(
      child: Column(
        children: [
          SizedBox(height: 400, child: DataTableWidget(tableData: tableData)),
        ],
      ),
    );
  }
}