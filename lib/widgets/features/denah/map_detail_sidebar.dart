import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/config/color.dart';
import '../../../blocs/features/denah/titik_cubit.dart';

class MapDetailSidebar extends StatelessWidget {
  const MapDetailSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Sesuaikan dengan tinggi dari HomePage
      decoration: BoxDecoration(
        color: AppColors.bgblu,
        border: Border.all(color: const Color.fromARGB(25, 0, 0, 0)),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<TitikCubit, TitikState>(
        builder: (context, state) {
          if (state.selected == null) {
            return const Center(
              child: Text(
                'Klik titik pada denah untuk info area',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }
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
                'ID Area: ${state.selected!.id}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Text('Status: ${state.selected!.status.toUpperCase()}'),
              const SizedBox(height: 10),
              const Text('Deskripsi:'),
              Text(state.selected!.deskripsi),
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
        },
      ),
    );
  }
}