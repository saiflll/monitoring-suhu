import 'package:equatable/equatable.dart';

class Titik extends Equatable {
  final String id;
  final double x;
  final double y;
  final String status;
  final String deskripsi;
  final String suhu;
  final String rh;
  const Titik({
    required this.id,
    required this.x,
    required this.y,
    required this.status,
    required this.deskripsi,
    required this.suhu,
    this.rh = '',
  });
  @override
  List<Object?> get props => [id, x, y, status, deskripsi];

  static List<String> get areaNames {
    try {
      // Mengembalikan daftar deskripsi unik dari titikList.
      return titikList.map((t) => t.deskripsi).toSet().toList();
    } catch (e) {
      // Jika terjadi error, kembalikan list kosong atau handle error.
      return [];
    }
  }
  static String? getAreaNameFromId(String? id) {
    if (id == null) return null;
    try {
      // Cari titik berdasarkan ID dan kembalikan deskripsinya.
      final titik = titikList.firstWhere((t) => t.id == id);
      return titik.deskripsi;
    } catch (e) {
      return null;
    }
  }
}


final titikList = [
  //repacking meat & pawn
  Titik(id: 's0_1', x: 0.8763, y: 0.1809, status: 'normal', deskripsi: 'Repacking Meat & Pawn 1', suhu: '32', rh: '60'),
  Titik(id: 's0_2', x: 0.8763, y: 0.3009, status: 'normal', deskripsi: 'Repacking Meat & Pawn 2', suhu: '22', rh: '40'),
  Titik(id: 's0_3', x: 0.8763, y: 0.4509, status: 'normal', deskripsi: 'Repacking Meat & Pawn 3', suhu: '12', rh: '70'),
  //meat/pawn storage
  Titik(id: 's0_4', x: 0.8320, y: 0.4250, status: 'normal', deskripsi: 'Meat/pawn Storage 1', suhu: '33', ),
  Titik(id: 's0_5', x: 0.8320, y: 0.3452, status: 'normal', deskripsi: 'Meat/pawn Storage 2', suhu: '32', ),
  Titik(id: 's0_6', x: 0.8320, y: 0.2642, status: 'normal', deskripsi: 'Meat/pawn Storage 3', suhu: '34', ),
  Titik(id: 's0_7', x: 0.8320, y: 0.1812, status: 'normal', deskripsi: 'Meat/pawn Storage 4', suhu: '31', ),
  Titik(id: 's0_8', x: 0.8320, y: 0.1012, status: 'normal', deskripsi: 'Meat/pawn Storage 5', suhu: '36', ),
  //chilled storage
  Titik(id: 's0_9', x: 0.8320, y: 0.5050, status: 'normal', deskripsi: 'Frozen Chili & Mushroom', suhu: '28', rh: '50'),
  //ambient WH
  Titik(id: 's0_10', x: 0.8430, y: 0.5802, status: 'normal', deskripsi: 'Ambient WH', suhu: '25', rh: '45'),
  //packing storage
  Titik(id: 's0_11', x: 0.8430, y: 0.6931, status: 'normal', deskripsi: 'Packing Storage', suhu: '27', rh: '48'),
  //intermediate
  Titik(id: 's0_12', x: 0.7850, y: 0.1847, status: 'normal', deskripsi: 'Intermediate Room 1', suhu: '26', rh: '47'),
  Titik(id: 's0_13', x: 0.7850, y: 0.3281, status: 'normal', deskripsi: 'Intermediate Room 2', suhu: '24', rh: '46'),
  Titik(id: 's0_14', x: 0.7850, y: 0.6280, status: 'normal', deskripsi: 'Corridor Room', suhu: '23', rh: '45'),
  //meat processing
  Titik(id: 's0_15', x: 0.7177, y: 0.1547, status: 'normal', deskripsi: 'Meat Proccesing', suhu: '26', rh: '47'),
  //chilled room
  Titik(id: 's0_16', x: 0.7277, y: 0.3181, status: 'normal', deskripsi: 'Intermediate Room', suhu: '24', rh: '46'),
  //metos room
  Titik(id: 's0_17', x: 0.7320, y: 0.4500, status: 'normal', deskripsi: 'Metos Room', suhu: '23', rh: '45'),
  //Flour Storage
  Titik(id: 's0_18', x: 0.6420, y: 0.8609, status: 'normal', deskripsi: 'Wheat Flour Storage', suhu: '22', rh: '44'),
  //Line Production
  Titik(id: 's0_19', x: 0.5720, y: 0.8461, status: 'danger', deskripsi: 'Line Production 1', suhu: '21', rh: '43'),
  Titik(id: 's0_20', x: 0.5720, y: 0.8461, status: 'danger', deskripsi: 'Line Production 2', suhu: '21', rh: '43'),
  Titik(id: 's0_21', x: 0.5720, y: 0.8461, status: 'danger', deskripsi: 'Line Production 3', suhu: '21', rh: '43'),
  Titik(id: 's0_22', x: 0.5720, y: 0.8461, status: 'danger', deskripsi: 'Line Production 4', suhu: '21', rh: '43'),

  //IGF
  Titik(id: 's0_17', x: 0.0730, y: 0.0461, status: 'normal', deskripsi: 'Basic Mie Room', suhu: '20', rh: '42'),
  Titik(id: 's0_18', x: 0.0730, y: 0.0140, status: 'normal', deskripsi: 'Ribbon Room', suhu: '19', rh: '41'),
  Titik(id: 's0_19', x: 0.0863, y: 0.0332, status: 'normal', deskripsi: 'Wip Dough Store', suhu: '18', rh: '40'),
  Titik(id: 's0_20', x: 0.0654, y: 0.0877, status: 'normal', deskripsi: 'Wheat Flour Storage', suhu: '17'),
  Titik(id: 's0_21', x: 0.0365, y: 0.0438, status: 'normal', deskripsi: 'IGF', suhu: '16', rh: '38'),
  Titik(id: 's0_22', x: 0.0292, y: 0.0422, status: 'normal', deskripsi: 'Secondary Packing', suhu: '15', rh: '37'),
  Titik(id: 's0_23', x: 0.0205, y: 0.0686, status: 'normal', deskripsi: 'Ambient WH FG', suhu: '14', rh: '36'),
  Titik(id: 's0_24', x: 0.0205, y: 0.0309, status: 'normal', deskripsi: 'Frozen Storage FG', suhu: '13', rh: '35'),
  Titik(id: 's0_25', x: 0.0242, y: 0.0365, status: 'normal', deskripsi: 'Intermediate FSFG', suhu: '12', rh: '34'),
  Titik(id: 's0_26', x: 0.0132, y: 0.0281, status: 'normal', deskripsi: 'Loading Platform', suhu: '11'),
];