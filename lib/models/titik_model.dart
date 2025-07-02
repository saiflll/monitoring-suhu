import 'package:equatable/equatable.dart';

class Titik extends Equatable {
  final String id;
  final double x;
  final double y;
  final String status;
  final String deskripsi;
  final String suhu;
  final String rh;
  final int no; 
  
  const Titik({
    required this.id,
    required this.x,
    required this.y,
    required this.status,
    required this.deskripsi,
    required this.suhu,
    this.rh = '',
    required this.no,
  });
  String get namaLengkap => '$deskripsi $no';
  @override
  List<Object?> get props => [id, x, y, status, deskripsi, no];

  static List<String> get areaNames {
    try {
      return titikList.map((t) => t.deskripsi).toSet().toList();
    } catch (e) {
      return [];
    }
  }
  
  static String? getAreaNameFromId(String? id) {
    if (id == null) return null;
    try {
      // Cari titik berdasarkan ID dan kembalikan deskripsi area-nya (bukan nama lengkap).
      final titik = titikList.firstWhere((t) => t.id == id, orElse: () => throw Exception('Titik not found'));
      return titik.deskripsi;
    } catch (e) {
      return null;
    }
  }

  /// Mengembalikan daftar item device (misal: "Device 1", "Device 2")
  /// untuk area yang dipilih.
  static List<String> getDeviceItemsForArea(String areaName) {
    try {
      final deviceNumbers = titikList
          .where((t) => t.deskripsi == areaName)
          .map((t) => 'Device ${t.no}')
          .toList();
      return deviceNumbers.isNotEmpty ? deviceNumbers : ['Device 1']; // Fallback
    } catch (e) {
      return ['Device 1']; // Fallback
    }
  }

  /// Get device numbers untuk area tertentu
  static List<int> getDeviceNumbersForArea(String areaName) {
    return titikList
        .where((titik) => titik.deskripsi == areaName)
        .map((titik) => titik.no)
        .toSet()
        .toList()
      ..sort();
  }

  /// Get all available device numbers grouped by area
  static Map<String, List<int>> getAllDeviceNumbersByArea() {
    Map<String, List<int>> devicesByArea = {};

    for (String area in Titik.areaNames) {
      devicesByArea[area] = getDeviceNumbersForArea(area);
    }

    return devicesByArea;
  }

  /// Get sensor IDs based on area and device numbers
  static List<String> getSensorIds(String areaName, List<int> deviceNumbers) {
    return titikList
        .where((titik) => titik.deskripsi == areaName && deviceNumbers.contains(titik.no))
        .map((titik) => titik.id)
        .toList();
  }

  /// Get all sensor IDs for a specific area (for when all devices are selected)
  static List<String> getAllSensorIdsForArea(String areaName) {
    return titikList.where((titik) => titik.deskripsi == areaName).map((titik) => titik.id).toList();
  }

  /// Check if area has multiple devices
  static bool hasMultipleDevices(String areaName) {
    return getDeviceNumbersForArea(areaName).length > 1;
  }

  /// Get device count for area
  static int getDeviceCountForArea(String areaName) {
    return getDeviceNumbersForArea(areaName).length;
  }
}

final titikList = [
  //repacking meat & pawn
  Titik(id: 's0_1', x: 0.8763, y: 0.1809, status: 'normal', deskripsi: 'Repacking Meat & Pawn', suhu: '32', rh: '60', no: 1),
  Titik(id: 's0_2', x: 0.8763, y: 0.3009, status: 'normal', deskripsi: 'Repacking Meat & Pawn', suhu: '22', rh: '40', no: 2),
  Titik(id: 's0_3', x: 0.8763, y: 0.4509, status: 'normal', deskripsi: 'Repacking Meat & Pawn', suhu: '12', rh: '70', no: 3),
  //chili & mushroom storage
  Titik(id: 's0_4', x: 0.8320, y: 0.4250, status: 'normal', deskripsi: 'Meat/pawn Storage', suhu: '33', no: 1),
  Titik(id: 's0_5', x: 0.8320, y: 0.3452, status: 'normal', deskripsi: 'Meat/pawn Storage', suhu: '32', no: 2),
  //meat/pawn storage
  Titik(id: 's0_6', x: 0.8320, y: 0.2642, status: 'normal', deskripsi: 'Meat/pawn Storage', suhu: '34', no: 1),
  Titik(id: 's0_7', x: 0.8320, y: 0.1812, status: 'normal', deskripsi: 'Chili/mushroom Storage', suhu: '31', no: 2),
  Titik(id: 's0_8', x: 0.8320, y: 0.1012, status: 'normal', deskripsi: 'Chili/mushroom Storage', suhu: '36', no: 3),
  //chilled storage
  Titik(id: 's0_9', x: 0.8320, y: 0.5050, status: 'normal', deskripsi: 'Frozen Chili & Mushroom', suhu: '28', rh: '50', no: 1),
  //ambient WH
  Titik(id: 's0_10', x: 0.8430, y: 0.5802, status: 'normal', deskripsi: 'Ambient WH', suhu: '25', rh: '45', no: 1),
  //packing storage
  Titik(id: 's0_11', x: 0.8430, y: 0.7031, status: 'normal', deskripsi: 'Packing Storage', suhu: '27', rh: '48', no: 1),
  //intermediate
  Titik(id: 's0_12', x: 0.7850, y: 0.1847, status: 'normal', deskripsi: 'Intermediate Room', suhu: '26', rh: '47', no: 1),
  Titik(id: 's0_13', x: 0.7850, y: 0.3281, status: 'normal', deskripsi: 'Intermediate Room', suhu: '24', rh: '46', no: 2),
  Titik(id: 's0_14', x: 0.7850, y: 0.6300, status: 'normal', deskripsi: 'Corridor Room', suhu: '23', rh: '45', no: 1),
  //meat processing
  Titik(id: 's0_15', x: 0.7127, y: 0.1580, status: 'normal', deskripsi: 'Meat Proccesing', suhu: '26', rh: '47', no: 1),
  //chilled room
  Titik(id: 's0_16', x: 0.7277, y: 0.3181, status: 'normal', deskripsi: 'Chilled Room', suhu: '24', rh: '46', no: 1),
  //metos room
  Titik(id: 's0_17', x: 0.7320, y: 0.4400, status: 'normal', deskripsi: 'Metos Room', suhu: '23', rh: '45', no: 1),
  //Flour Storage
  Titik(id: 's0_18', x: 0.6380, y: 0.8609, status: 'normal', deskripsi: 'Wheat Flour Storage', suhu: '22', rh: '44', no: 1),
  //Line Production
  Titik(id: 's0_19', x: 0.5720, y: 0.1661, status: 'normal', deskripsi: 'Line Production', suhu: '21', rh: '43', no: 1),
  Titik(id: 's0_20', x: 0.5720, y: 0.3161, status: 'normal', deskripsi: 'Line Production', suhu: '21', rh: '43', no: 2),
  Titik(id: 's0_21', x: 0.5720, y: 0.4461, status: 'normal', deskripsi: 'Line Production', suhu: '21', rh: '43', no: 3),
  Titik(id: 's0_22', x: 0.5720, y: 0.5861, status: 'normal', deskripsi: 'Line Production', suhu: '21', rh: '43', no: 4),
  //IQF
  Titik(id: 's0_23', x: 0.3930, y: 0.1461, status: 'normal', deskripsi: 'IQF', suhu: '20', no: 1),
  Titik(id: 's0_24', x: 0.3930, y: 0.2240, status: 'normal', deskripsi: 'IQF', suhu: '19', no: 2),
  Titik(id: 's0_25', x: 0.3663, y: 0.2900, status: 'normal', deskripsi: 'IQF', suhu: '18', no: 3),
  Titik(id: 's0_26', x: 0.3663, y: 0.3700, status: 'normal', deskripsi: 'IQF', suhu: '17', no: 4),
  Titik(id: 's0_27', x: 0.3665, y: 0.4338, status: 'normal', deskripsi: 'IQF', suhu: '16', no: 5),
  Titik(id: 's0_28', x: 0.3692, y: 0.5022, status: 'normal', deskripsi: 'IQF', suhu: '15', no: 6),
  Titik(id: 's0_29', x: 0.3695, y: 0.5766, status: 'normal', deskripsi: 'IQF', suhu: '14', no: 7),
  Titik(id: 's0_30', x: 0.3805, y: 0.6409, status: 'normal', deskripsi: 'IQF', suhu: '13', no: 8),
  Titik(id: 's0_31', x: 0.3802, y: 0.7065, status: 'normal', deskripsi: 'IQF', suhu: '12', no: 9),
  //secondary packing
  Titik(id: 's0_32', x: 0.2882, y: 0.5681, status: 'normal', deskripsi: 'Secondary Packing', suhu: '11', no: 1),
  Titik(id: 's0_33', x: 0.2882, y: 0.2881, status: 'normal', deskripsi: 'Secondary Packing', suhu: '10', no: 2),
  //intermediate packing
  Titik(id: 's0_34', x: 0.2452, y: 0.3281, status: 'normal', deskripsi: 'Intermediate Packing', suhu: '9', no: 1),
  Titik(id: 's0_35', x: 0.2452, y: 0.4381, status: 'normal', deskripsi: 'Intermediate Packing', suhu: '8', no: 2),
  //Frozen Storage FG
  Titik(id: 's0_36', x: 0.2052, y: 0.1181, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '7', no: 1),
  Titik(id: 's0_37', x: 0.2052, y: 0.1981, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '6', no: 2),
  Titik(id: 's0_38', x: 0.2052, y: 0.2781, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '5', no: 3),
  Titik(id: 's0_39', x: 0.2052, y: 0.3531, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '4', no: 4),
  Titik(id: 's0_40', x: 0.2052, y: 0.4481, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '3', no: 5),
  Titik(id: 's0_41', x: 0.2052, y: 0.5181, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '2', no: 6),
  //warehouse dry FG
  Titik(id: 's0_42', x: 0.2052, y: 0.7081, status: 'normal', deskripsi: 'Warehouse Dry FG', suhu: '1', no: 1),
  //Loading platform
  Titik(id: 's0_43', x: 0.1352, y: 0.2281, status: 'normal', deskripsi: 'Loading Platform', suhu: '0', no: 1),
  Titik(id: 's0_44', x: 0.1352, y: 0.3820, status: 'normal', deskripsi: 'Loading Platform', suhu: '-1', no: 2),
];