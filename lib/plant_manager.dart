import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/plant_model.dart';

class PlantManager {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // List lokal untuk cadangan / state sementara
  static List<Plant> plantList = [];

  // Mengambil data tanaman dari tabel Supabase
  static Future<List<Plant>> fetchPlantsFromSupabase() async {
    try {
      final response = await _supabase.from('plants').select();
      
      plantList = (response as List).map((data) {
        return Plant(
          id: data['id'] ?? 0,
          name: data['name'] ?? '',
          scientificName: data['scientific_name'] ?? '',
          category: data['category'] ?? '',
          imageUrl: data['image_url'] ?? '',
          description: data['description'] ?? '',
        );
      }).toList();

      return plantList;
    } catch (e) {
      print('Error mengambil data dari Supabase: $e');
      return [];
    }
  }

  // Menambahkan tanaman baru ke Supabase
  static Future<bool> addPlantToSupabase(Plant plant) async {
    try {
      await _supabase.from('plants').insert({
        'name': plant.name,
        'scientific_name': plant.scientificName,
        'category': plant.category,
        'image_url': plant.imageUrl,
        'description': plant.description,
      });
      
      // Ambil ulang data terbaru setelah insert
      await fetchPlantsFromSupabase();
      return true;
    } catch (e) {
      print('Error menambah data ke Supabase: $e');
      return false;
    }
  }

  // Alias agar kompatibel dengan pemanggilan addPlant di form screen
  static Future<bool> addPlant(Plant plant) async {
    return await addPlantToSupabase(plant);
  }
}