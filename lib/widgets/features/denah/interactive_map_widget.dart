import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/features/denah/titik_cubit.dart';
import '../../../config/data/models/titik_model.dart';

class InteractiveMapWidget extends StatelessWidget {
  final bool isRotated;

  const InteractiveMapWidget({super.key, this.isRotated = false});
  static const double mapDesignWidth = 3010.0; // GANTI DENGAN LEBAR ASLI GAMBAR DENAH ANDA
  static const double mapDesignHeight = 1777.0; // GANTI DENGAN TINGGI ASLI GAMBAR DENAH ANDA

  // Di aplikasi nyata, ini mungkin dikonfigurasi di tempat lain
  static final backgroundStages = [
    'assets/denah/bg_stage0.png',
    'assets/denah/bg_stage1.png', // Pastikan file ini ada dan terdaftar di pubspec.yaml
    //'assets/bg_stage2.png', // Placeholder, ganti jika perlu
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'warning':
        return Colors.amber;
      case 'danger':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitikCubit, TitikState>(
      builder: (context, state) {
        // Gunakan ClipRRect untuk memberi efek rounded corner pada InteractiveViewer
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: InteractiveViewer(
            // Menonaktifkan zoom dengan menyamakan minScale dan maxScale
            minScale: 1.0,
            maxScale: 1.0,
            // Menonaktifkan pan/geser agar denah tidak bisa digerakkan
            panEnabled: false,
            boundaryMargin: EdgeInsets.zero,
            // Gunakan FittedBox untuk memastikan konten awal selalu pas di dalam InteractiveViewer
            // sebelum pengguna melakukan zoom/pan.
            child: FittedBox(
              fit: BoxFit.contain,
              child: RotatedBox(
                quarterTurns: isRotated ? 1 : 0, // Putar 90 derajat jika true
                child: SizedBox(
                  width: mapDesignWidth,
                  height: mapDesignHeight,
                  child: Stack(
                    children: [
                      // Gambar Latar
                      Positioned.fill(
                        child: Image.asset(
                          backgroundStages[state.stage],
                          fit: BoxFit.fill, // Memastikan gambar mengisi seluruh SizedBox
                        ),
                      ),
                      // Titik-titik
                      ...titikList
                          .where((t) => t.backgroundStage == state.stage)
                          .map(
                            (t) => Positioned(
                              left: t.x,
                              top: t.y,
                              child: GestureDetector(
                                onTap: () =>
                                    context.read<TitikCubit>().pilihTitik(t),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: _statusColor(t.status),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: state.selected?.id == t.id
                                            ? Colors.blueAccent
                                            : Colors.white,
                                        width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}