import 'package:flutter/material.dart';
import '../models/plant_model.dart';

class PlantCareGuideScreen extends StatelessWidget {
  final Plant plant;
  const PlantCareGuideScreen({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F5),
      appBar: AppBar(
        title: const Text('Panduan Tanaman', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: const Color(0xFFD4E7D0),
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(plant.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text(plant.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(plant.category, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 16),

            // Tab Kategori Menu Panduan
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabChip('Ringkasan', true),
                  _buildTabChip('Penyiraman', false),
                  _buildTabChip('Cahaya', false),
                  _buildTabChip('Media Tanam', false),
                  _buildTabChip('Tips', false),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('Tentang Tanaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              '${plant.name} adalah tanaman hias indoor yang sangat cantik dan mudah dirawat. Letakkan di tempat yang mendapatkan cahaya terang tidak langsung agar daunnya tumbuh subur.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
            ),
            const SizedBox(height: 20),

            // Grid Informasi Ringkas
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _buildInfoCard(Icons.wb_sunny_outlined, 'Cahaya', 'Cahaya Terang, Tidak Langsung'),
                _buildInfoCard(Icons.water_drop_outlined, 'Penyiraman', 'Setiap 3 Hari Sekali'),
                _buildInfoCard(Icons.thermostat_outlined, 'Suhu', '18 - 25°C'),
                _buildInfoCard(Icons.opacity_rounded, 'Kelembapan', '60% - 70%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.green[800]! : Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green[700], size: 18),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }
}