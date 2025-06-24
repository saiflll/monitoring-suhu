import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testv1/widgets/layouts/responsive_layout.dart';
import '../config/color.dart';
import '../blocs/features/denah/titik_cubit.dart';
import '../widgets/features/denah/interactive_map_widget.dart';
import '../widgets/features/denah/map_detail_sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sediakan TitikCubit untuk HomePage dan turunannya.
    return BlocProvider(
      create: (context) => TitikCubit(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop =
              constraints.maxWidth >= ResponsiveLayout.desktopBreakpointMin;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _build6aAnd6bLayout(isDesktop),
                const SizedBox(height: 8),
                _buildSubLayout6c(),
                const SizedBox(height: 8),
                _buildSubLayout6d(),
                const SizedBox(height: 8),
                _buildSubLayout6e(),
              ],
            ),
          );
        },
          ),
        );
      
  }

  Widget _buildPlaceholderBox(String text, Color color, {double? height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: const Color.fromARGB(25, 0, 0, 0)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _build6aAnd6bLayout(bool isDesktop) {
    if (isDesktop) {
      return Column(
        children: [
          _buildSubLayout6a(),
          const SizedBox(height: 8),
          _buildSubLayout6b(),
        ],
      );
    } else {
      // mobile
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(13, 75, 76, 77),
          border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            // Untuk mobile, denah diputar dan diberi tinggi tetap.
            Container(
              color: AppColors.bgblu,
              padding: const EdgeInsets.all(8),
              child: const SizedBox(
                height: 800,
                child: InteractiveMapWidget(isRotated: true),
              ),
            ),
            const SizedBox(height: 8),
            const MapDetailSidebar(), // Menggunakan widget detail
            const SizedBox(height: 8),
            _buildPlaceholderBox('gauge', AppColors.bgblu, height: 500),

          ],
        ),
      );
    }
  }
//=============================================Layout============================================
  Widget _buildSubLayout6a() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          // Untuk desktop, denah tidak diputar.
          const Expanded(flex: 4, child: InteractiveMapWidget(isRotated: false)),
          const SizedBox(width: 8), 
          const Expanded(flex: 2, child: MapDetailSidebar()), // Ganti placeholder dengan widget detail
        ],
      ),
    );
  }

  Widget _buildSubLayout6b() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)), borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Expanded(flex: 4, child: _buildPlaceholderBox('gau_dis', AppColors.bgblu, height: 400)),
          const SizedBox(width: 8),
          Expanded(flex: 2, child: _buildPlaceholderBox('alrt_dis', AppColors.bgblu, height: 400)),
        ],
      ),
    );
  }

  Widget _buildSubLayout6c() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)), borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          _buildPlaceholderBox('tit', AppColors.bgblu), 
          const SizedBox(height: 8),
          _buildPlaceholderBox('rh_grafik', AppColors.bgblu, height: 400),
        ],
      ),
    );
  }

  Widget _buildSubLayout6d() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)), borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          _buildPlaceholderBox('temp_grafik', AppColors.bgblu, height: 400),
          //_buildPlaceholderBox('6d.2', Colors.lime.shade100, height: 80),
        ],
      ),
    );
  }

  Widget _buildSubLayout6e() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)), borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          _buildPlaceholderBox('Tab_det', AppColors.bgblu, height: 400),
         // _buildPlaceholderBox('6e.2', Colors.red.shade100, height: 80),
        ],
      ),
    );
  }
}
