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
  static const double dotDiameter = 5.0; // Ukuran titik yang konsisten

  // Controller dan animasi untuk zoom
  late final AnimationController _zoomAnimationController;
  Animation<Matrix4>? _zoomAnimation;

  // Controller dan animasi untuk efek denyut (pulsate)
  late final AnimationController _pulsateAnimationController;
  late final Animation<double> _pulsateAnimation;

  @override
  void initState() {
    super.initState();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
    const double scale = 20.0; // Tingkat zoom
    final targetX = titik.x * _mapWidth; // Hitung posisi absolut dari relatif
    final targetY = titik.y * _mapHeight; // Hitung posisi absolut dari relatif

    final x = -(targetX * scale) + (viewportSize.width / 2);
    final y = -(targetY * scale) + (viewportSize.height / 2);

    final targetMatrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);
    
    _animateTo(targetMatrix);
  }

  void _resetZoom() {
    // Kembali ke tampilan awal yang sudah dihitung, bukan ke skala 1:1.
    if (_initialMatrix != null) {
      _animateTo(_initialMatrix!);
    }
  }

  void _animateTo(Matrix4 target) {
    _zoomAnimation = Matrix4Tween(begin: _controller.value, end: target)
        .animate(CurvedAnimation(parent: _zoomAnimationController, curve: Curves.fastOutSlowIn));
    _zoomAnimationController.forward(from: 0.0);
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
                      // Efek blur/dim saat sebuah titik dipilih
                      AnimatedOpacity(
                        opacity: state.selected != null ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                          child: Container(
                            // Sedikit menggelapkan latar belakang untuk memperkuat efek fokus
                            color: const Color.fromARGB(116, 209, 208, 208).withOpacity(0.2),
                          ),
                        ),
                      ),
                   
                      ...titikList.map((titik) {
                        final isSelected = state.selected?.id == titik.id;
                        final isAlert = titik.status == 'warning' || titik.status == 'danger';
                        
                        // Ukuran maksimum widget (titik + efek denyut)
                        final double maxWidgetSize = dotDiameter + 6.0; // 6.0 adalah nilai 'end' dari Tween pulsasi

                        // Sesuaikan posisi kiri/atas untuk memusatkan widget
                        final left = (titik.x * _mapWidth) - (maxWidgetSize / 2);
                        final top = (titik.y * _mapHeight) - (maxWidgetSize / 2);

                        return Positioned(
                          left: left,
                          top: top,
                          width: maxWidgetSize,
                          height: maxWidgetSize, 
                          child: GestureDetector(
                            onTap: () => context.read<TitikCubit>().pilihTitik(titik),
                            // Mencegah event tap "tembus" ke GestureDetector di belakangnya
                            behavior: HitTestBehavior.opaque,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Efek denyut (hanya untuk status warning/danger)
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
                                // Titik utama
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  width: dotDiameter,
                                  height: dotDiameter,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _statusColor(titik.status).withOpacity(0.9),
                                    border: isSelected
                                        ? Border.all(color: Colors.blueAccent, width: 0.15) // Border saat dipilih
                                        : Border.all(color: Colors.white, width: 0.3), // Border tipis agar menonjol
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