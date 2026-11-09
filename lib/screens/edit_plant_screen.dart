import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../models/plant_model.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart';

class EditPlantScreen extends StatefulWidget {
  final Plant plant;

  const EditPlantScreen({Key? key, required this.plant}) : super(key: key);

  @override
  State<EditPlantScreen> createState() => _EditPlantScreenState();
}

class _EditPlantScreenState extends State<EditPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _scientificNameController;
  late TextEditingController _categoryController;
  late TextEditingController _imageUrlController;
  late TextEditingController _descriptionController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data tanaman yang lama
    _nameController = TextEditingController(text: widget.plant.name);
    _scientificNameController = TextEditingController(text: widget.plant.scientificName);
    _categoryController = TextEditingController(text: widget.plant.category);
    _imageUrlController = TextEditingController(text: widget.plant.imageUrl);
    _descriptionController = TextEditingController(text: widget.plant.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _scientificNameController.dispose();
    _categoryController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Fungsi untuk menyimpan perubahan data ke Supabase (Tahap 11)
  void _updatePlant() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final updatedPlant = Plant(
        id: widget.plant.id, // Gunakan ID yang sama
        name: _nameController.text.trim(),
        scientificName: _scientificNameController.text.trim(),
        category: _categoryController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        description: _descriptionController.text.trim(),
      );

     bool success = await Provider.of<PlantProvider>(context, listen: false).updatePlant(widget.plant.name, updatedPlant);
      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data tanaman berhasil diperbarui!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Kembali dan kirim sinyal refresh
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal memperbarui data. Periksa koneksi!'),
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
        title: const Text(
          'Edit Tanaman',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Nama Tanaman',
                icon: Icons.local_florist_rounded,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _scientificNameController,
                label: 'Nama Ilmiah',
                icon: Icons.science_rounded,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _categoryController,
                label: 'Kategori (cth: Indoor / Outdoor)',
                icon: Icons.category_rounded,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _imageUrlController,
                label: 'URL Gambar (Image URL)',
                icon: Icons.image_rounded,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Deskripsi Tanaman',
                icon: Icons.description_rounded,
                maxLines: 4,
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updatePlant,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Perbarui Tanaman',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }
}