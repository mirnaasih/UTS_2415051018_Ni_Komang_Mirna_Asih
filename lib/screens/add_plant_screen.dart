import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import '../plant_manager.dart'; // Import PlantManager

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key}) : super(key: key);

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scientificNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _scientificNameController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _savePlant() {
    if (_formKey.currentState!.validate()) {
      final newPlant = Plant(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _nameController.text,
        scientificName: _scientificNameController.text,
        category: _categoryController.text,
        imageUrl: _imageUrlController.text.isEmpty
            ? 'https://images.unsplash.com/photo-1512428559087-560fa5ceab42'
            : _imageUrlController.text,
        description: _descriptionController.text,
      );

      // Simpan langsung ke PlantManager secara global
      PlantManager.addPlant(newPlant);

      // Kembali ke halaman sebelumnya
      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil menambahkan ${_nameController.text}!'),
          backgroundColor: Colors.green[700],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      appBar: AppBar(
        title: const Text(
          'Tambah Tanaman Baru',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informasi Tanaman',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Nama Tanaman', Icons.eco_outlined),
                validator: (value) => value == null || value.isEmpty ? 'Nama tanaman tidak boleh kosong' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _scientificNameController,
                decoration: _inputDecoration('Nama Ilmiah (Latin)', Icons.science_outlined),
                validator: (value) => value == null || value.isEmpty ? 'Nama ilmiah tidak boleh kosong' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _categoryController,
                decoration: _inputDecoration('Kategori (cth: Tanaman Indoor)', Icons.category_outlined),
                validator: (value) => value == null || value.isEmpty ? 'Kategori tidak boleh kosong' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _imageUrlController,
                decoration: _inputDecoration('URL Gambar (Opsional/Unsplash)', Icons.image_outlined),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: _inputDecoration('Deskripsi Perawatan', Icons.description_outlined),
                validator: (value) => value == null || value.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _savePlant,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Simpan Tanaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.green),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.green, width: 1.5)),
    );
  }
}