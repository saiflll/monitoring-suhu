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

  /// Widget helper untuk membangun konten internal dari sebuah kartu area.
  /// Menampilkan nama area, suhu, dan kelembapan.
  Widget _buildAreaCardContent(BuildContext context, Titik titik) {
    return Padding(
      padding: const EdgeInsets.all(12.0), // Padding di dalam kartu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Atas: Nama Area
          Text(
            titik.deskripsi,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 12, ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          //const Divider(),
          const SizedBox(height: 4),
          // Bagian Bawah: Suhu & Kelembapan
          Row(
            children: [
              // Kolom Kiri: Suhu
              Expanded(
                child: _buildInfoColumn(context, 'Suhu', '${titik.suhu}°C'),
              ),
              // Kolom Kanan: Kelembapan
              Expanded(
                child: _buildInfoColumn(context, 'Kelembapan', titik.rh.isNotEmpty ? '${titik.rh}%' : '-'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
        const SizedBox(height: 2),
        Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
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
              color: Colors.white, // Latar belakang kartu menjadi putih
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              clipBehavior: Clip.antiAlias, // Agar efek ripple mengikuti bentuk kartu
              child: InkWell(
                onTap: () => context.read<TitikCubit>().pilihTitik(titik),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildAreaCardContent(context, titik),
                    ),
                    
                  ],
                ),
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
          color: Colors.white, // Latar belakang kartu menjadi putih
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: _buildAreaCardContent(context, titik),
        ),
      ],
    );
  }
}