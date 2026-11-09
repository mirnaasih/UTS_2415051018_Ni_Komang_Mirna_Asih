import 'package:flutter/material.dart';
import '../plant_manager.dart';
import 'plant_detail_screen.dart';
import 'add_plant_screen.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({Key? key}) : super(key: key);

  @override
  State<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await PlantManager.fetchPlantsFromSupabase();
    setState(() {}); // Memperbarui UI setelah data berhasil ditarik dari Supabase
  }

  void _navigateToAddPlant() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPlantScreen()),
    );
    if (result == true) {
      _loadData(); // Refresh ulang data saat kembali dari tambah tanaman
    }
  }

  @override
  Widget build(BuildContext context) {
    final plantList = PlantManager.plantList; // Ambil data dari PlantManager

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: const Text(
          'Katalog Tanaman',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: plantList.isEmpty
            ? const Center(
                child: Text(
                  'Belum ada tanaman di katalog',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: plantList.length,
                itemBuilder: (context, index) {
                  final plant = plantList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          plant.imageUrl,
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        ),
                      ),
                      title: Text(
                        plant.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(plant.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(plant.scientificName, style: const TextStyle(fontSize: 11, color: Colors.green)),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantDetailScreen(plant: plant),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}