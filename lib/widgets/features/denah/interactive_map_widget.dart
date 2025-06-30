import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final double _mapWidth = 3010;
  final double _mapHeight = 1777;

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
    final targetX = titik.x + (titik.width / 2);
    final targetY = titik.y + (titik.height / 2);

    final x = -(targetX * scale) + (viewportSize.width / 2);
    final y = -(targetY * scale) + (viewportSize.height / 2);

    final matrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);
    _controller.value = matrix;
  }

  void _resetZoom() {
    _controller.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;

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
                        final diameter = titik.width; 

                        return Positioned(
                          left: titik.x,
                          top: titik.y,
                          width: diameter,
                          height: diameter, 
                          child: GestureDetector(
                            onTap: () => context.read<TitikCubit>().pilihTitik(titik),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _statusColor(titik.status),
                                border: isSelected
                                    ? Border.all(color: Colors.blueAccent, width: 10.0)
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