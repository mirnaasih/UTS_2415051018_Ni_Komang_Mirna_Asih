import 'models/plant_model.dart';

class FavoritesManager {
  // Daftar global untuk menyimpan tanaman yang difavoritkan
  static final List<Plant> favoritePlants = [];

  // Cek apakah tanaman sudah ada di favorit
  static bool isFavorite(Plant plant) {
    return favoritePlants.any((p) => p.id == plant.id);
  }

  // Tambah atau hapus tanaman dari favorit
  static void toggleFavorite(Plant plant) {
    if (isFavorite(plant)) {
      favoritePlants.removeWhere((p) => p.id == plant.id);
    } else {
      favoritePlants.add(plant);
    }
  }
}