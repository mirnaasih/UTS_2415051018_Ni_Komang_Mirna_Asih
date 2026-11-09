import 'models/plant_model.dart';

class PlantManager {
  // Daftar global yang menyimpan semua tanaman (data awal + tanaman baru)
  static final List<Plant> plantList = [
    Plant(
      id: 1,
      name: 'Monstera Deliciosa',
      scientificName: 'Monstera deliciosa',
      category: 'Tanaman Indoor',
      imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b',
      description: 'Tanaman hias populer dengan daun berlubang alami yang estetik.',
    ),
    Plant(
      id: 2,
      name: 'Snake Plant (Lidah Mertua)',
      scientificName: 'Sansevieria trifasciata',
      category: 'Tanaman Indoor',
      imageUrl: 'https://images.unsplash.com/photo-1509423350716-97f9360b4e09',
      description: 'Tanaman tahan banting yang efektif membersihkan udara ruangan.',
    ),
    Plant(
      id: 3,
      name: 'Peace Lily',
      scientificName: 'Spathiphyllum wallisii',
      category: 'Tanaman Indoor',
      imageUrl: 'https://images.unsplash.com/photo-1593482892290-f596e38bc9e0',
      description: 'Memiliki bunga putih bersih yang elegan dan menyukai kelembapan.',
    ),
    Plant(
      id: 4,
      name: 'Aloe Vera',
      scientificName: 'Aloe barbadensis miller',
      category: 'Sukulen',
      imageUrl: 'https://images.unsplash.com/photo-1567683692456-c67d71f1b402',
      description: 'Sukulen kaya manfaat yang perawatannya sangat mudah.',
    ),
  ];

  // Fungsi untuk menambah tanaman baru ke daftar global
  static void addPlant(Plant plant) {
    plantList.add(plant);
  }
}