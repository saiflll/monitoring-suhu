import 'package:equatable/equatable.dart';

class Titik extends Equatable {
  final String id;
  final double x;
  final double y;
  final double width;
  final double height;
  final String status;
  final String deskripsi;
  const Titik({
    required this.id,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.status,
    required this.deskripsi,
  });
  @override
  List<Object?> get props => [id, x, y, width, height, status, deskripsi];

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
  // Stage 0 Points
  Titik(id: 's0_1', x: 260, y: 55, width: 15, height: 10, status: 'normal', deskripsi: 'Repacking Meat & Pawn'),
  Titik(id: 's0_2', x: 247, y: 20, width: 10, height: 15, status: 'normal', deskripsi: 'Meat/pawn Storage'),
  Titik(id: 's0_3', x: 247, y: 80, width: 10, height: 15, status: 'normal', deskripsi: 'Frozen Chili & Mushroom'),
  Titik(id: 's0_4', x: 250, y: 107, width: 12, height: 12, status: 'normal', deskripsi: 'Ambient WH'),
  Titik(id: 's0_5', x: 250, y: 130, width: 12, height: 12, status: 'normal', deskripsi: 'Packing Storage'),
  Titik(id: 's0_6', x: 234, y: 115, width: 10, height: 10, status: 'normal', deskripsi: 'Corridor Room'),
  Titik(id: 's0_7', x: 234, y: 50, width: 10, height: 10, status: 'normal', deskripsi: 'Intermediate Room'),
  Titik(id: 's0_8', x: 217, y: 25, width: 10, height: 10, status: 'normal', deskripsi: 'Meat Processing'),
  Titik(id: 's0_9', x: 217, y: 55, width: 10, height: 10, status: 'normal', deskripsi: 'Chilled Room'),
  Titik(id: 's0_10', x: 217, y: 82, width: 10, height: 10, status: 'normal', deskripsi: 'Mentos Room'),
  Titik(id: 's0_11', x: 220, y: 82, width: 10, height: 10, status: 'normal', deskripsi: 'Basic Mie Room'),
  Titik(id: 's0_12', x: 220, y: 25, width: 10, height: 10, status: 'normal', deskripsi: 'Ribbon Room'),
  Titik(id: 's0_13', x: 260, y: 59, width: 10, height: 10, status: 'normal', deskripsi: 'Wip Dough Store'),
  Titik(id: 's0_14', x: 197, y: 156, width: 15, height: 15, status: 'normal', deskripsi: 'Wheat Flour Storage'),
  Titik(id: 's0_16', x: 110, y: 78, width: 15, height: 15, status: 'normal', deskripsi: 'IGF'),
  Titik(id: 's0_17', x: 88, y: 75, width: 15, height: 15, status: 'normal', deskripsi: 'Secondary Packing'),
  Titik(id: 's0_18', x: 62, y: 122, width: 15, height: 15, status: 'normal', deskripsi: 'Ambient WH FG'),
  Titik(id: 's0_19', x: 62, y: 55, width: 15, height: 15, status: 'normal', deskripsi: 'Frozen Storage FG'),
  Titik(id: 's0_20', x: 73, y: 65, width: 10, height: 10, status: 'normal', deskripsi: 'Intermediate FSFG'),
  Titik(id: 's0_21', x: 40, y: 50, width: 15, height: 15, status: 'normal', deskripsi: 'Loading Platform'),
];