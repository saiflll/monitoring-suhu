import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/color.dart';
import '../common/app_containers.dart';
import '../features/denah/interactive_map_widget.dart';
import '../features/denah/map_detail_sidebar.dart';

class RoomInfoSection extends StatelessWidget {
  const RoomInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: const Color.fromARGB(0, 0, 0, 0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kontainer atas untuk judul
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.bgblu,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Informasi Ruangan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Denah Ruangan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                // Dropdown
                DropdownButton<String>(
                  value: 'Ruangan 1',
                  items: <String>['Ruangan 1', 'Ruangan 2', 'Ruangan 3']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // TODO: Implement logic for dropdown selection
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Kontainer bawah untuk denah dan detail
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  color: AppColors.bgblu,
                  child: const InteractiveMapWidget(isRotated: false),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(flex: 2, child: MapDetailSidebar()),
            ],
          ),
        ],
      ),
    );
  }
}