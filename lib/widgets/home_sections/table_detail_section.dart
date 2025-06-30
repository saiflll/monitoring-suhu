import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/blocs/features/home/home_data_bloc.dart';
import '../common/app_containers.dart';
import '../features/tables/data_table_widget.dart';

class TableDetailSection extends StatelessWidget {
  const TableDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      buildWhen: (previous, current) => previous.tableData != current.tableData,
      builder: (context, state) {
        if (state.tableData == null) {
          return const SizedBox(height: 40, child: Center(child: CircularProgressIndicator()));
        }

        return SectionContainer(
          child: CardContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Table Detail', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                DataTableWidget(height: 800, tableData: state.tableData!),
              ],
            ),
          ),
        );
      },
    );
  }
}