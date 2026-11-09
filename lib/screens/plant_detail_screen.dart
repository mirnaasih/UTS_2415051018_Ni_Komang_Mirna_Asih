import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import 'edit_plant_screen.dart';
import '../favorites_manager.dart'; // Jangan lupa import halaman edit

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;

  const PlantDetailScreen({Key? key, required this.plant}) : super(key: key);

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  bool isFavorite = false; // State lokal untuk tombol favorit
  late Plant _currentPlant;

  @override
  void initState() {
    super.initState();
    _currentPlant = widget.plant;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: const Text(
          'Detail Tanaman',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          // Tombol Favorit Interaktif di AppBar
          IconButton(
  icon: Icon(
    isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
    color: isFavorite ? Colors.redAccent : Colors.black87,
  ),
  onPressed: () {
    setState(() {
      isFavorite = !isFavorite;
    });

    // TAMBAHKAN PEMANGGILAN INI AGAR TERSIMPAN KE MANAGER FAVORIT
    if (isFavorite) {
      FavoritesManager.favoritePlants.add(_currentPlant);
    } else {
      FavoritesManager.favoritePlants.removeWhere((p) => p.name == _currentPlant.name);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '${_currentPlant.name} ditambahkan ke Favorit!'
              : '${_currentPlant.name} dihapus dari Favorit.',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green[700],
      ),
    );
  },
),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama Tanaman
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  _currentPlant.imageUrl,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama & Kategori Tanaman
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentPlant.name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentPlant.category,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // TOMBOL EDIT YANG DIHUBUNGKAN KE EditPlantScreen
                IconButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPlantScreen(plant: _currentPlant),
                      ),
                    );

                    // Jika data berhasil di-update, perbarui state tampilan
                    if (result == true) {
                      setState(() {
                        // Jika ingin memperbarui data lokal langsung
                      });
                      Navigator.pop(context, true); // Kembali ke list dan refresh
                    }
                  },
                  icon: const Icon(Icons.edit_outlined, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Kartu Informasi Perawatan (Penyiraman, Cahaya, Suhu, Kelembapan)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard(Icons.water_drop_outlined, 'Penyiraman', 'Hari Ini'),
                _buildInfoCard(Icons.wb_sunny_outlined, 'Cahaya', 'Terang'),
                _buildInfoCard(Icons.thermostat_outlined, 'Suhu', '18-25°C'),
                _buildInfoCard(Icons.eco_outlined, 'Kelembapan', '60-70%'),
              ],
            ),
            const SizedBox(height: 24),

            // Bagian Pengingat Perawatan
            const Text(
              'Pengingat Perawatan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            _buildReminderCard(Icons.check_circle, Colors.green, 'Siram Tanaman', 'Setiap 3 Hari'),
            const SizedBox(height: 10),
            _buildReminderCard(Icons.eco, Colors.green, 'Beri Pupuk', 'Setiap 2 Minggu'),
            const SizedBox(height: 10),
            _buildReminderCard(Icons.check_circle, Colors.green, 'Bersihkan Daun', 'Setiap 1 Minggu'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.green[700], size: 22),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildReminderCard(IconData icon, Color iconColor, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ],
      ),
    );
  }
}