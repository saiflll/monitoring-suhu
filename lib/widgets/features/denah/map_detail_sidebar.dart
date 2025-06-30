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
      child: SingleChildScrollView( // 1. Bungkus dengan SingleChildScrollView
        child: BlocBuilder<TitikCubit, TitikState>(
          buildWhen: (prev, current) => prev.selected != current.selected,
          builder: (context, state) {
            if (state.selected == null) {
              // Jika tidak ada titik yang dipilih, tampilkan daftar semua area
              return _buildAllPointsList(context);
            }
            // Jika ada titik yang dipilih, tampilkan detailnya
            return _buildPointDetailView(context, state.selected!);
          },
        ),
      ),
    );
  }

  /// Widget helper untuk membuat subtitle yang berisi status Suhu dan RH.
  Widget _buildStatusSubtitle(BuildContext context, Titik titik) {
    List<String> statuses = [];
    // Tambahkan status suhu
    statuses.add('Suhu: ${titik.suhu}°C');

    // Tambahkan status RH hanya jika ada nilainya
    if (titik.rh.isNotEmpty) {
      statuses.add('RH: ${titik.rh}%');
    }

    // Gabungkan status dengan pemisah '|'
    return Text(statuses.join(' | '));
  }

  /// Widget untuk menampilkan daftar semua titik dalam bentuk Card.
  Widget _buildAllPointsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Area',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        // 2. Hapus Expanded dan gunakan ListView.builder dengan shrinkWrap
        ListView.builder(
          shrinkWrap: true, // Membuat ListView setinggi kontennya
          physics: const NeverScrollableScrollPhysics(), // Mencegah konflik scroll
          itemCount: titikList.length,
          itemBuilder: (context, index) {
            final titik = titikList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                title: Text(titik.deskripsi),
                subtitle: _buildStatusSubtitle(context, titik),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Saat card di-klik, panggil cubit untuk memilih titik ini
                  context.read<TitikCubit>().pilihTitik(titik);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPointDetailView(BuildContext context, Titik titik) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Mencegah Column mengambil tinggi tak terbatas
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail Area Terpilih',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.read<TitikCubit>().reset(),
              tooltip: 'Tutup Detail & Tampilkan Semua',
            )
          ],
        ),
        const Divider(),
        const SizedBox(height: 8),
        // Tampilkan detail dalam bentuk Card yang sama seperti di daftar
        Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: Text(titik.deskripsi, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: _buildStatusSubtitle(context, titik),
          ),
        ),
        
      ],
    );
  }
}