import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final _supabase = Supabase.instance.client;

  static Future<dynamic> fetchPlantsData() async {
    final response = await _supabase.from('plants').select();
    return response;
  }

  static Future<void> insertPlantData(Map data) async {
    await _supabase.from('plants').insert(data);
  }

  static Future<void> updatePlantData(String oldName, Map data) async {
    await _supabase.from('plants').update(data).eq('name', oldName);
  }
  static Future<void> deletePlantData(String plantName) async {
  await _supabase.from('plants').delete().eq('name', plantName);
}
}