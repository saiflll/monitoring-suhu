import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testv1/models/titik_model.dart';
import '../../../blocs/features/denah/titik_cubit.dart';

class InteractiveMapWidget extends StatefulWidget {
  final bool isRotated;
  const InteractiveMapWidget({super.key, this.isRotated = false});

  @override
  State<InteractiveMapWidget> createState() => _InteractiveMapWidgetState();
}

class _InteractiveMapWidgetState extends State<InteractiveMapWidget> {
  final TransformationController _controller = TransformationController();
  final double _mapWidth = 301;
  final double _mapHeight = 177;
  Matrix4? _initialMatrix;
  static const double dotDiameter = 5.0; // Ukuran titik yang konsisten

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'warning':
        return Colors.amber.withOpacity(0.5);
      case 'danger':
        return Colors.red.withOpacity(0.5);
      default:
        return Colors.green.withOpacity(0.5);
    }
  }

  void _zoomToTitik(Titik titik, Size viewportSize) {
    const double scale = 4.0;
    final targetX = titik.x * _mapWidth; // Hitung posisi absolut dari relatif
    final targetY = titik.y * _mapHeight; // Hitung posisi absolut dari relatif

    final x = -(targetX * scale) + (viewportSize.width / 2);
    final y = -(targetY * scale) + (viewportSize.height / 2);

    final matrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);
    _controller.value = matrix;
  }

  void _resetZoom() {
    // Kembali ke tampilan awal yang sudah dihitung, bukan ke skala 1:1.
    if (_initialMatrix != null) {
      _controller.value = _initialMatrix!;
    }
  }

  /// Menghitung dan mengatur matriks transformasi awal agar denah pas di layar.
  void _setupInitialMatrix(Size viewportSize) {
    // Hanya atur sekali saja untuk efisiensi.
    if (_initialMatrix != null || viewportSize.isEmpty) return;

    final scaleX = viewportSize.width / _mapWidth;
    final scaleY = viewportSize.height / _mapHeight;
    // Gunakan `min` untuk memastikan seluruh denah terlihat (seperti BoxFit.contain).
    final scale = min(scaleX, scaleY);

    // Hitung offset untuk memusatkan denah di dalam viewport.
    final dx = (viewportSize.width - _mapWidth * scale) / 2;
    final dy = (viewportSize.height - _mapHeight * scale) / 2;

    _initialMatrix = Matrix4.identity()
      ..translate(dx, dy)
      ..scale(scale);

    // Terapkan matriks awal ke controller.
    _controller.value = _initialMatrix!;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;
        // Panggil fungsi setup setiap kali layout berubah (misal: rotasi layar).
        _setupInitialMatrix(viewportSize);

        return BlocConsumer<TitikCubit, TitikState>(
          // Listener untuk memicu animasi zoom
          listener: (context, state) {
            if (state.selected != null) {
              _zoomToTitik(state.selected!, viewportSize);
            } else {
              _resetZoom();
            }
          },
     
      builder: (context, state) {
            final mapContent = InteractiveViewer(
              transformationController: _controller,
              minScale: 0.1,
    
              boundaryMargin: const EdgeInsets.all(double.infinity),
      
              panEnabled: false,
              scaleEnabled: false,
     
              child: GestureDetector(
                onTap: () {
              
                  context.read<TitikCubit>().reset();
                },
                child: SizedBox(
                  width: _mapWidth,
                  height: _mapHeight,
                  child: Stack(
                    children: [
                
                      SvgPicture.asset(
                        'assets/denah/denah.svg', 
                        width: _mapWidth,
                        height: _mapHeight,
                        fit: BoxFit.fill,
                      ),
                   
                      ...titikList.map((titik) {
                        final isSelected = state.selected?.id == titik.id;
                        
                        final left = (titik.x * _mapWidth) - (dotDiameter / 2);
                        final top = (titik.y * _mapHeight) - (dotDiameter / 2);

                        return Positioned(
                          left: left,
                          top: top,
                          width: dotDiameter,
                          height: dotDiameter, 
                          child: GestureDetector(
                            onTap: () => context.read<TitikCubit>().pilihTitik(titik),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _statusColor(titik.status),
                                border: isSelected
                                    ? Border.all(color: Colors.blueAccent, width: 4.0) // Border lebih tipis
                                    : null,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );

            if (widget.isRotated) {
              return RotatedBox(quarterTurns: 1, child: mapContent);
            }
            return mapContent;
          },
        );
      }
    );
  }
}