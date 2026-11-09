import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plant_model.dart';
import '../providers/plant_provider.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key}) : super(key: key);

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  // 1. Kunci untuk form validasi
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil teks inputan user
  final _nameController = TextEditingController();
  final _scientificNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _scientificNameController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitData() async {
    // Jalankan validasi form
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final newPlant = Plant(
        name: _nameController.text.trim(),
        scientificName: _scientificNameController.text.trim(),
        category: _categoryController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      // Kirim data via PlantProvider
      bool success = await Provider.of<PlantProvider>(context, listen: false).addPlant(newPlant);

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // User Feedback: SnackBar Sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tanaman berhasil ditambahkan!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      } else {
        // User Feedback: SnackBar Gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menambahkan tanaman, periksa koneksi!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: const Text('Tambah Tanaman Baru', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Pasang form key di sini
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input Nama Tanaman dengan Validasi
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Tanaman',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tanaman tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Input Nama Ilmiah dengan Validasi
              TextFormField(
                controller: _scientificNameController,
                decoration: InputDecoration(
                  labelText: 'Nama Ilmiah',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama ilmiah tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Input Kategori dengan Validasi
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Kategori (cth: Indoor / Outdoor)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kategori wajib diisi!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Input Image URL dengan Validasi
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL Gambar Tanaman',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'URL gambar tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Input Deskripsi dengan Validasi
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Perawatan',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi wajib diisi!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                onPressed: _isLoading ? null : _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Simpan Tanaman',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}