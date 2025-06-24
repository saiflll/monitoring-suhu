class Titik {
  final String id;
  final double x;
  final double y;
  final String status;
  final String deskripsi;
  final int backgroundStage;
  final int? targetStage; // Stage tujuan saat titik ini diklik

  Titik({
    required this.id,
    required this.x,
    required this.y,
    required this.status,
    required this.deskripsi,
    required this.backgroundStage,
    this.targetStage,
  });
}

// LIST TITIK STATIC
// Di aplikasi nyata, data ini akan berasal dari API
final titikList = [
  // Stage 0 Points
  Titik(id: 's0_1', x: 2600, y: 550, status: 'normal', deskripsi: 'Repacking Meat & Pawn', backgroundStage: 0),
  Titik(id: 's0_2', x: 2470, y: 200, status: 'normal', deskripsi: 'Meat/pawn Storage', backgroundStage: 0),
  Titik(id: 's0_3', x: 2470, y: 800, status: 'normal', deskripsi: 'Forzen Chili & Mushroom', backgroundStage: 0),
  Titik(id: 's0_4', x: 2500, y: 1070, status: 'normal', deskripsi: 'Ambient WH', backgroundStage: 0),
  Titik(id: 's0_5', x: 2500, y: 1300, status: 'normal', deskripsi: 'Packing Storage', backgroundStage: 0),
  Titik(id: 's0_6', x: 2340, y: 1150, status: 'normal', deskripsi: 'corldoor room', backgroundStage: 0),
  Titik(id: 's0_7', x: 2340, y: 500, status: 'normal', deskripsi: 'Intermediate room', backgroundStage: 0),
  Titik(id: 's0_8', x: 2170, y: 250, status: 'normal', deskripsi: 'Meet Processing', backgroundStage: 0),
  Titik(id: 's0_9', x: 2170, y: 550, status: 'normal', deskripsi: 'Chilled room', backgroundStage: 0),
  Titik(id: 's0_10', x: 2170, y: 820, status: 'normal', deskripsi: 'Mentos room', backgroundStage: 0),
  Titik(id: 's0_11', x: 2200, y: 820, status: 'normal', deskripsi: 'Basic Mie room', backgroundStage: 0),
  Titik(id: 's0_12', x: 2200, y: 250, status: 'normal', deskripsi: 'Ribbon room', backgroundStage: 0),
  Titik(id: 's0_13', x: 2600, y: 590, status: 'normal', deskripsi: 'Wip Dough Store', backgroundStage: 0),
  Titik(id: 's0_14', x: 1975, y: 1560, status: 'normal', deskripsi: 'Wheat Flour Storage', backgroundStage: 0),
  Titik(id: 's0_15', x: 1500, y: 750, status: 'normal', deskripsi: 'Production Hall (Masuk)', backgroundStage: 0, targetStage: 1),
  Titik(id: 's0_16', x: 1100, y: 780, status: 'normal', deskripsi: 'IGF', backgroundStage: 0),
  Titik(id: 's0_17', x: 880, y: 750, status: 'normal', deskripsi: 'Secondary Packing', backgroundStage: 0),
  Titik(id: 's0_18', x: 620, y: 1225, status: 'normal', deskripsi: 'Ambient WH FG', backgroundStage: 0),
  Titik(id: 's0_19', x: 620, y: 550, status: 'normal', deskripsi: 'Frozen Storage FG', backgroundStage: 0),
  Titik(id: 's0_20', x: 735, y: 650, status: 'normal', deskripsi: 'Intermediate FSFG', backgroundStage: 0),
  Titik(id: 's0_21', x: 400, y: 500, status: 'normal', deskripsi: 'Lading Platform', backgroundStage: 0),
  // Stage 1 Points
  Titik(id: 's1_back', x: 50, y: 50, status: 'normal', deskripsi: 'Kembali ke Peta Utama', backgroundStage: 1, targetStage: 0),
  Titik(id: 's1_c1', x: 130, y: 160, status: 'warning', deskripsi: 'Area C1 - Bahan Kimia', backgroundStage: 1),
  Titik(id: 's1_a2', x: 200, y: 250, status: 'normal', deskripsi: 'Area A2 - Loading Dock', backgroundStage: 1),
];