import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
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

class _InteractiveMapWidgetState extends State<InteractiveMapWidget> with TickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  final double _mapWidth = 301;
  final double _mapHeight = 177;
  Matrix4? _initialMatrix;
  static const double dotDiameter = 2.0; 
  late final AnimationController _zoomAnimationController;
  Animation<Matrix4>? _zoomAnimation;
  late final AnimationController _pulsateAnimationController;
  late final Animation<double> _pulsateAnimation;

  @override
  void initState() {
    super.initState();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        if (_zoomAnimation != null) {
          _controller.value = _zoomAnimation!.value;
        }
      });

    _pulsateAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _pulsateAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _pulsateAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _zoomAnimationController.dispose();
    _pulsateAnimationController.dispose();
    super.dispose();
  }

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

  void _zoomToTitik(Titik titik, Size viewportSize) {
    const double scale = 20.0; 
    final targetX = titik.x * _mapWidth; 
    final targetY = titik.y * _mapHeight; 

    final x = -(targetX * scale) + (viewportSize.width / 2);
    final y = -(targetY * scale) + (viewportSize.height / 2);

    final targetMatrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);
    
    _animateTo(targetMatrix);
  }

  void _resetZoom() {
    
    if (_initialMatrix != null) {
      _animateTo(_initialMatrix!);
    }
  }

  void _animateTo(Matrix4 target) {
    _zoomAnimation = Matrix4Tween(begin: _controller.value, end: target)
        .animate(CurvedAnimation(parent: _zoomAnimationController, curve: Curves.fastOutSlowIn));
    _zoomAnimationController.forward(from: 0.0);
  }

  void _setupInitialMatrix(Size viewportSize) {
    if (_initialMatrix != null || viewportSize.isEmpty) return;

    final scaleX = viewportSize.width / _mapWidth;
    final scaleY = viewportSize.height / _mapHeight;
    final scale = min(scaleX, scaleY);
    final dx = (viewportSize.width - _mapWidth * scale) / 2;
    final dy = (viewportSize.height - _mapHeight * scale) / 2;

    _initialMatrix = Matrix4.identity()
      ..translate(dx, dy)
      ..scale(scale);
    _controller.value = _initialMatrix!;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;
        _setupInitialMatrix(viewportSize);

        return BlocConsumer<TitikCubit, TitikState>(
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
                    
                      AnimatedOpacity(
                        opacity: state.selected != null ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 250),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                          child: Container(
                            color: const Color.fromARGB(78, 209, 208, 208).withOpacity(0.2),
                          ),
                        ),
                      ),
                   
                      ...titikList.map((titik) {
                        final isSelected = state.selected?.id == titik.id;
                        final isAlert = titik.status == 'warning' || titik.status == 'danger';
                        final double maxWidgetSize = dotDiameter + 6.0; 
                        final left = (titik.x * _mapWidth) - (maxWidgetSize / 2);
                        final top = (titik.y * _mapHeight) - (maxWidgetSize / 2);
                        return Positioned(
                          left: left,
                          top: top,
                          width: maxWidgetSize,
                          height: maxWidgetSize, 
                          child: GestureDetector(
                            onTap: () => context.read<TitikCubit>().pilihTitik(titik),
                            behavior: HitTestBehavior.opaque,
                            child: Stack(
                              alignment: Alignment.center,
                                children: [
                                if (isAlert)
                                  AnimatedBuilder(
                                  animation: _pulsateAnimation,
                                  builder: (context, child) {
                                    return Container(
                                    width: dotDiameter + _pulsateAnimation.value,
                                    height: dotDiameter + _pulsateAnimation.value,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _statusColor(titik.status).withOpacity(0.4),
                                    ),
                                    );
                                  },
                                  ),
                                // Titik utama dengan animasi ukuran saat diklik
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  width: isSelected ? dotDiameter + 6.0 : dotDiameter,
                                  height: isSelected ? dotDiameter + 6.0 : dotDiameter,
                                  decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _statusColor(titik.status).withOpacity(0.9),
                                  border: isSelected
                                    ? Border.all(color: const Color.fromARGB(255, 252, 165, 93), width: 0.35)
                                    : Border.all(color: const Color.fromARGB(255, 9, 9, 9), width: 0.1),
                                  ),
                                ),
                                ],
                              
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