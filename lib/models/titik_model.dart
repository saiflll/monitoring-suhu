import 'package:equatable/equatable.dart';

class Titik extends Equatable {
  final String id;
  final double x;
  final double y;
  final String status;
  final String deskripsi;
  const Titik({
    required this.id,
    required this.x,
    required this.y,
    required this.status,
    required this.deskripsi,
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
  Titik(id: 's0_1', x: 0.0863, y: 0.0309, status: 'normal', deskripsi: 'Repacking Meat & Pawn'),
  Titik(id: 's0_2', x: 0.0820, y: 0.0112, status: 'normal', deskripsi: 'Meat/pawn Storage'),
  Titik(id: 's0_3', x: 0.0820, y: 0.0450, status: 'normal', deskripsi: 'Frozen Chili & Mushroom'),
  Titik(id: 's0_4', x: 0.0830, y: 0.0602, status: 'normal', deskripsi: 'Ambient WH'),
  Titik(id: 's0_5', x: 0.0830, y: 0.0731, status: 'normal', deskripsi: 'Packing Storage'),
  Titik(id: 's0_6', x: 0.0777, y: 0.0647, status: 'normal', deskripsi: 'Corridor Room'),
  Titik(id: 's0_7', x: 0.0777, y: 0.0281, status: 'normal', deskripsi: 'Intermediate Room'),
  Titik(id: 's0_8', x: 0.0720, y: 0.0140, status: 'normal', deskripsi: 'Meat Processing'),
  Titik(id: 's0_9', x: 0.0720, y: 0.0309, status: 'normal', deskripsi: 'Chilled Room'),
  Titik(id: 's0_10', x: 0.0720, y: 0.0461, status: 'normal', deskripsi: 'Mentos Room'),
  Titik(id: 's0_11', x: 0.0730, y: 0.0461, status: 'normal', deskripsi: 'Basic Mie Room'),
  Titik(id: 's0_12', x: 0.0730, y: 0.0140, status: 'normal', deskripsi: 'Ribbon Room'),
  Titik(id: 's0_13', x: 0.0863, y: 0.0332, status: 'normal', deskripsi: 'Wip Dough Store'),
  Titik(id: 's0_14', x: 0.0654, y: 0.0877, status: 'normal', deskripsi: 'Wheat Flour Storage'),
  Titik(id: 's0_16', x: 0.0365, y: 0.0438, status: 'normal', deskripsi: 'IGF'),
  Titik(id: 's0_17', x: 0.0292, y: 0.0422, status: 'normal', deskripsi: 'Secondary Packing'),
  Titik(id: 's0_18', x: 0.0205, y: 0.0686, status: 'normal', deskripsi: 'Ambient WH FG'),
  Titik(id: 's0_19', x: 0.0205, y: 0.0309, status: 'normal', deskripsi: 'Frozen Storage FG'),
  Titik(id: 's0_20', x: 0.0242, y: 0.0365, status: 'normal', deskripsi: 'Intermediate FSFG'),
  Titik(id: 's0_21', x: 0.0132, y: 0.0281, status: 'normal', deskripsi: 'Loading Platform'),
];