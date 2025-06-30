import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/config/color.dart';
import '../../../blocs/features/denah/titik_cubit.dart';
import '../../../models/titik_model.dart';

class MapDetailSidebar extends StatelessWidget {
  const MapDetailSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // Tinggi sekarang diatur oleh parent (_MapSection)
      decoration: BoxDecoration(
        color: AppColors.bgblu,
        border: Border.all(color: const Color.fromARGB(25, 0, 0, 0)),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<TitikCubit, TitikState>(
        buildWhen: (prev, current) => prev.selected != current.selected,
        builder: (context, state) {
          if (state.selected == null) {
            return const Center(
              child: Text(
                'Klik titik pada denah untuk info area atau reset zoom',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }
          return _buildPointDetailView(context, state.selected!);
        },
      ),
    );
  }

  Widget _buildPointDetailView(BuildContext context, Titik titik) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail Area',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.read<TitikCubit>().reset(),
              tooltip: 'Reset Pilihan',
            )
          ],
        ),
        const Divider(),
        const SizedBox(height: 10),
        Text(
          'ID Area: ${titik.id}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Text('Status: ${titik.status.toUpperCase()}'),
        const SizedBox(height: 10),
        const Text('Deskripsi:'),
        Text(titik.deskripsi),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () { /* TODO: Implementasi navigasi ke halaman detail */ },
            child: const Text('Lihat Detail Lengkap'),
          ),
        ),
      ],
    );
  }
}