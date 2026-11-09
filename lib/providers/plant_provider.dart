import 'package:flutter/foundation.dart';
import '../models/plant_model.dart';
import '../repositories/plant_repository.dart';

class PlantProvider with ChangeNotifier {
  List<Plant> _plants = [];
  bool _isLoading = false;

  List<Plant> get plants => _plants;
  bool get isLoading => _isLoading;

  // CONSTRUCTOR: Otomatis ambil data saat Provider pertama kali dijalankan
  PlantProvider() {
    fetchPlants();
  }

  Future<void> fetchPlants() async {
    _isLoading = true;
    notifyListeners();

    try {
      _plants = await PlantRepository.getPlants();
    } catch (e) {
      print('Error fetching plants: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addPlant(Plant plant) async {
    bool success = await PlantRepository.addPlant(plant);
    if (success) {
      await fetchPlants(); // Langsung refresh data setelah berhasil tambah
    }
    return success;
  }

  Future<bool> updatePlant(String oldName, Plant plant) async {
    bool success = await PlantRepository.updatePlant(oldName, plant);
    if (success) {
      await fetchPlants(); // Langsung refresh data setelah berhasil edit
    }
    return success;
  }
}