import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import '../common/app_containers.dart';
import '../../models/titik_model.dart';
import '../features/tables/data_table_widget.dart';

class TableDetailSection extends StatelessWidget {
  const TableDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      buildWhen: (previous, current) =>
          previous.tableData != current.tableData ||
          previous.filterSelection != current.filterSelection,
      builder: (context, state) {
        if (state.tableData == null || state.filterSelection == null) {
          return const SizedBox(height: 40, child: Center(child: CircularProgressIndicator()));
        }
        final areaItems = Titik.areaNames;
        const deviceItems = ['Device 1', 'Device 2', 'Device 3', 'Device 4'];
        const timeCountItems = ['1h', '2h', '3h'];

        return Column(
          children: [
            const SizedBox(height: 4),
            SectionContainer(
              child: DataTableWidget(
                height: 800, 
                tableData: state.tableData!,
                title: 'Table Detail',
                filterSelection: state.filterSelection!,
                areaItems: areaItems,
                deviceItems: deviceItems,
                timeCountItems: timeCountItems,
              ),
            ),
          ],
        );
      },
    );
  }
}