import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/favorites_screen.dart';
import 'screens/plant_list_screen.dart';
import 'screens/plant_detail_screen.dart';
import 'screens/add_plant_screen.dart';
import 'screens/profile_screen.dart';
import 'models/plant_model.dart';
import 'package:provider/provider.dart';
import 'providers/plant_provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://xmkjwykvrdwhfaigyxvu.supabase.co',
    anonKey: 'sb_publishable_DS5v6ZJhq65Zk65oj6uSHQ_flL9G-V4',
  );

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantProvider()),
      ],
      child: const PlantCatalogApp(),
    ),
  );
}


class PlantCatalogApp extends StatelessWidget {
  const PlantCatalogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Tanaman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF9F6F0),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Menggunakan fungsi agar screen di-refresh saat tab dipilih ulang
  Widget _getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return const HomeDashboardTab();
      case 1:
        return const PlantListScreen();
      case 2:
        return  FavoritesScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeDashboardTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedScreen(_currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );
          setState(() {}); // Refresh setelah kembali dari tambah tanaman
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.eco_rounded), label: 'Tanaman'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomeDashboardTab extends StatefulWidget {
  const HomeDashboardTab({Key? key}) : super(key: key);

  @override
  State<HomeDashboardTab> createState() => _HomeDashboardTabState();
}

class _HomeDashboardTabState extends State<HomeDashboardTab> {
  @override
  Widget build(BuildContext context) {
    // Ambil daftar tanaman secara dinamis dari PlantProvider
   final plantList = Provider.of<PlantProvider>(context).plants;
    final samplePlant = plantList.isNotEmpty ? plantList.first : Plant(
      id: 1,
      name: 'Monstera Deliciosa',
      scientificName: 'Monstera deliciosa',
      category: 'Tanaman Indoor',
      imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b',
      description: 'Tanaman hias populer dengan daun berlubang alami yang estetik.',
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.menu_rounded), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Selamat Pagi', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 2),
              const Row(
                children: [
                  Text('Mirna Asih', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.eco, color: Colors.green, size: 24),
                ],
              ),
              const SizedBox(height: 4),
              const Text('NIM: 2415051018 • Mari rawat tanamanmu!', style: TextStyle(fontSize: 12, color: Colors.green)),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tanaman Anda', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 6),
                        // Menampilkan jumlah total tanaman secara dinamis dari PlantProvider
                        Text(
                          '${plantList.length}',
                          style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        const Text('Total Tanaman', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PlantListScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                            foregroundColor: Colors.white,
                            elevation: 0,
                          ),
                          child: const Text('Lihat Semua', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        samplePlant.imageUrl,
                        width: 110,
                        height: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 80, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Tugas Hari Ini', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTaskCard(
                      icon: Icons.water_drop_outlined,
                      title: 'Siram Monstera',
                      time: '09:00 WITA',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlantDetailScreen(plant: samplePlant)));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTaskCard(
                      icon: Icons.eco_outlined,
                      title: 'Beri Pupuk',
                      time: '11:00 WITA',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlantDetailScreen(plant: samplePlant)));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Tips Perawatan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1509423350716-97f9360b4e09',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'Bersihkan daun tanaman secara rutin agar dapat bernapas dan menyerap cahaya lebih baik.',
                        style: TextStyle(fontSize: 13, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard({required IconData icon, required String title, required String time, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFFE8F3E8), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.green, size: 22),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time_rounded, size: 13, color: Colors.grey),
                const SizedBox(width: 4),
                Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}