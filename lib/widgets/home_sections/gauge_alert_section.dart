import 'package:flutter/material.dart';
import 'dart:math'; // Digunakan untuk data gauge acak
import '../../config/color.dart';
import '../common/app_containers.dart';
import '../../models/gauge_value_model.dart';
import 'package:testv1/widgets/features/gauge/double_gauge_display.dart';

class GaugeAlertSection extends StatefulWidget {
  const GaugeAlertSection({super.key});

  @override
  State<GaugeAlertSection> createState() => _GaugeAlertSectionState();
}

class _GaugeAlertSectionState extends State<GaugeAlertSection> {
  // --- State Variables ---
  // Menyimpan nilai yang dipilih untuk setiap dropdown
  late String _selectedRoom;
  late String _selectedSensor;
  late String _selectedCount;
  late String _selectedDay;
  late String _selectedHour;

  // Menyimpan data untuk ditampilkan di gauge
  late GaugeValueModel _gaugeData1;
  late GaugeValueModel _gaugeData2;

  // --- Dropdown Item Lists ---
  // Mendefinisikan item di sini agar tidak dibuat ulang setiap kali build
  final List<String> _roomItems = ['Ruangan 1', 'Ruangan 2'];
  final List<String> _sensorItems = ['Sensor A', 'Sensor B'];
  final List<String> _countItems = ['Jumlah 1', 'Jumlah 2', 'Jumlah 3'];
  final List<String> _dayItems = ['Hari ini', 'Kemarin', 'Minggu ini'];
  final List<String> _hourItems = ['Jam ini', 'Jam lalu'];

  @override
  void initState() {
    super.initState();
    // Menginisialisasi state dengan nilai default
    _selectedRoom = _roomItems.first;
    _selectedSensor = _sensorItems.first;
    _selectedCount = _countItems.first;
    _selectedDay = _dayItems.first;
    _selectedHour = _hourItems.first;

    // Mengatur data gauge awal
    _updateGaugeData();
  }

  // Method untuk mensimulasikan pembaruan data gauge
  void _updateGaugeData() {
    // Di aplikasi nyata, di sini Anda akan memanggil API
    // berdasarkan _selectedRoom, _selectedSensor, dll.
    final random = Random();
    setState(() {
      _gaugeData1 = GaugeValueModel(
        value: 20 + random.nextDouble() * 15, // Nilai acak antara 20.0 - 35.0
        title: 'Temperature',
        unit: '°C',
      );
      _gaugeData2 = GaugeValueModel(
        value: 40 + random.nextDouble() * 30, // Nilai acak antara 40.0 - 70.0
        title: 'Humidity',
        unit: '%',
      );
    });
  }

  // Helper method untuk membuat dropdown agar kode tidak berulang
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true,
      underline: Container(
        height: 1,
        color: AppColors.gra,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.bgblu,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  CardContainer(
                    // Hapus padding di sini, karena akan ditangani oleh Container di dalam
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      // Baris 1
                        Container(
                          color: AppColors.bgblu,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 2, // Disederhanakan dari 16
                                child: Text(
                                  'Kolom di atas Gauge',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1, // Disederhanakan dari 8
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: _buildDropdown(
                                          value: _selectedRoom,
                                          items: _roomItems,
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(
                                                  () => _selectedRoom = value);
                                              _updateGaugeData();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8), // Dibuat konsisten
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(4), // Dibuat konsisten
                                        ),
                                        child: _buildDropdown(
                                          value: _selectedSensor,
                                          items: _sensorItems,
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(() =>
                                                  _selectedSensor = value);
                                              _updateGaugeData();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Baris 2
                        Container(
                          color: AppColors.bgblu,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2, // Disederhanakan dari 20
                                child: _buildDropdown(
                                  value: _selectedCount,
                                  items: _countItems,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => _selectedCount = value);
                                      _updateGaugeData();
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container()), // Placeholder untuk spasi
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1, // Disederhanakan dari 8
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdown(
                                        value: _selectedDay,
                                        items: _dayItems,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() => _selectedDay = value);
                                            _updateGaugeData();
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _buildDropdown(
                                        value: _selectedHour,
                                        items: _hourItems,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(
                                                () => _selectedHour = value);
                                            _updateGaugeData();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Menampilkan Gauge dengan data dari state
                  Row(
                    children: [
                      Expanded(
                        child: DoubleGaugeDisplay(
                          gaugeData1: _gaugeData1,
                          gaugeData2: _gaugeData2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: PlaceholderBox('alrt_dis', height: 400),
          ),
        ],
      ),
    );
  }
}