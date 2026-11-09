import '../services/supabase_service.dart';
import '../models/plant_model.dart';

class PlantRepository {
  // Mengambil dan memetakan data dari Supabase ke model Plant
  static Future<List<Plant>> getPlants() async {
    try {
      final response = await SupabaseService.fetchPlantsData();
      
      // Pastikan respons di-casting ke List<dynamic> lalu dipetakan ke objek Plant
      final dataList = response as List<dynamic>;
      
      return dataList.map((json) => Plant.fromMap(json as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error in PlantRepository.getPlants: $e');
      return [];
    }
  }

  static Future<bool> addPlant(Plant plant) async {
    try {
      await SupabaseService.insertPlantData(plant.toMap());
      return true;
    } catch (e) {
      print('Error in PlantRepository.addPlant: $e');
      return false;
    }
  }

  static Future<bool> updatePlant(String oldName, Plant plant) async {
    try {
      await SupabaseService.updatePlantData(oldName, plant.toMap());
      return true;
    } catch (e) {
      print('Error in PlantRepository.updatePlant: $e');
      return false;
    }
  }
}