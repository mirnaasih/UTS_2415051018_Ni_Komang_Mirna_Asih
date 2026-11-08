import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import '../widgets/custom_card.dart';

class PlantListScreen extends StatelessWidget {
  const PlantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Data dummy sementara untuk pengujian layout responsif
    final List<Plant> dummyPlants = [
      Plant(
        id: 1,
        name: 'Monstera Deliciosa',
        scientificName: 'Monstera deliciosa',
        category: 'Indoor',
        imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?auto=format&fit=crop&w=500&q=60',
        description: 'Tanaman hias populer dengan daun berlubang alami.',
      ),
      Plant(
        id: 2,
        name: 'Lidah Buaya',
        scientificName: 'Aloe vera',
        category: 'Outdoor',
        imageUrl: 'https://images.unsplash.com/photo-1509423350716-97f9360b4e09?auto=format&fit=crop&w=500&q=60',
        description: 'Tanaman herbal kaya manfaat untuk kulit dan kesehatan.',
      ),
      Plant(
        id: 3,
        name: 'Sirih Gading',
        scientificName: 'Epipremnum aureum',
        category: 'Indoor',
        imageUrl: 'https://images.unsplash.com/photo-1596727147705-61a532a659bd?auto=format&fit=crop&w=500&q=60',
        description: 'Tanaman merambat yang sangat mudah dirawat di dalam ruangan.',
      ),
      Plant(
        id: 4,
        name: 'Kaktus Mini',
        scientificName: 'Cactaceae',
        category: 'Succulent',
        imageUrl: 'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?auto=format&fit=crop&w=500&q=60',
        description: 'Tanaman gurun penyimpan air yang tahan di cuaca panas.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Tanaman (Responsif)'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      // LayoutBuilder digunakan untuk mendeteksi ukuran lebar layar secara dinamis
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Jika lebar layar > 600 pixel (misal Tablet/Web), gunakan 3 kolom. Jika HP, gunakan 2 kolom.
          int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: dummyPlants.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75, // Perbandingan tinggi dan lebar card
              ),
              itemBuilder: (context, index) {
                final plant = dummyPlants[index];
                return CustomPlantCard(
                  title: plant.name,
                  subtitle: plant.scientificName,
                  imageUrl: plant.imageUrl,
                  onTap: () {
                    // Aksi ketika card ditekan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Memilih: ${plant.name}')),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}