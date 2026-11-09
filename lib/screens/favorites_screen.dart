import 'package:flutter/material.dart';
import '../favorites_manager.dart';
import 'plant_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritePlants = FavoritesManager.favoritePlants;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: const Text(
          'Tanaman Favorit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: favoritePlants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text(
                    'Belum ada tanaman favorit',
                    style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: favoritePlants.length,
                itemBuilder: (context, index) {
                  final plant = favoritePlants[index];
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
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 22),
                        onPressed: () {
                          setState(() {
                            FavoritesManager.removeFavorite(plant);
                          });
                        },
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantDetailScreen(plant: plant),
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}