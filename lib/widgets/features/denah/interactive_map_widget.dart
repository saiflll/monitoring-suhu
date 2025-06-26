import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/models/titik_model.dart';
import '../../../blocs/features/denah/titik_cubit.dart';

class InteractiveMapWidget extends StatelessWidget {
  final bool isRotated;

  const InteractiveMapWidget({super.key, this.isRotated = false});
  static const double mapDesignWidth = 3010.0; 
  static const double mapDesignHeight = 1777.0; 

  static final backgroundStages = [
    'assets/denah/bg_stage0.png',
    'assets/denah/bg_stage1.png', 
    
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
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: 1.0,
            panEnabled: false,
            boundaryMargin: EdgeInsets.zero,
            child: FittedBox(
              fit: BoxFit.contain,
              child: RotatedBox(
                quarterTurns: isRotated ? 1 : 0, // Putar 90 
                child: SizedBox(
                  width: mapDesignWidth,
                  height: mapDesignHeight,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            backgroundStages[state.stage],
                            fit: BoxFit.fill,
                          ),
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
                                  width: 30,
                                  height:30,
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
                                        // ignore: deprecated_member_use
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