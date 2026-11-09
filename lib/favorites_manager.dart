import 'models/plant_model.dart';

class FavoritesManager {
  // List untuk menyimpan tanaman yang difavoritkan
  static final List<Plant> favoritePlants = [];

  // Tambah ke favorit
  static void addFavorite(Plant plant) {
    if (!favoritePlants.any((p) => p.name == plant.name)) {
      favoritePlants.add(plant);
    }
  }

  // Hapus dari favorit
  static void removeFavorite(Plant plant) {
    favoritePlants.removeWhere((p) => p.name == plant.name);
  }

  // Cek apakah tanaman sudah difavoritkan
  static bool isFavorite(Plant plant) {
    return favoritePlants.any((p) => p.name == plant.name);
  }
}