import 'package:flutter/material.dart';
import 'package:testv1/widgets/common/app_containers.dart';
import 'package:testv1/widgets/features/denah/interactive_map_widget.dart';
import 'package:testv1/widgets/features/denah/map_detail_sidebar.dart';
import 'package:testv1/models/gauge_value_model.dart'; // Import gauge model
import 'package:testv1/widgets/features/gauge/gauge.dart';

class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Menggunakan AspectRatio untuk menjaga proporsi denah saat diputar
          // dan untuk mengatasi eror layout pada mobile.
          AspectRatio(
            // Rasio aspek dibalik karena denah diputar 90 derajat (potret)
            // 1777 (tinggi asli) / 3010 (lebar asli)
            aspectRatio: 1777 / 3010,
            child: const InteractiveMapWidget(isRotated: true), // Mobile = potret
          ),
          const SizedBox(height: 8),
          const MapDetailSidebar(), // Menggunakan widget detail
          const SizedBox(height: 8),
          // Kontainer ini tidak menggunakan CardContainer karena stylingnya berbeda (tidak ada border/radius)
          SizedBox(
            height: 500,
            child: RadialGaugeDisplay(
              gaugeData: const GaugeValueModel(
                value: 75.5,
                title: 'Temperature',
                unit: '°C',
                low: 0,
                high: 100, 
                last: 75.5, 
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Kontainer ini tidak menggunakan _CardContainer karena stylingnya berbeda (tidak ada border/radius)
          SizedBox(
            height: 500,
            child: RadialGaugeDisplay(
              gaugeData: const GaugeValueModel(
                value: 42.0, title: 'Humidity', unit: '%',
                low: 0, high: 100, last: 42.0, // Added required arguments
              ),
            ),
          ),
        ],
      ),
    );
  }
}