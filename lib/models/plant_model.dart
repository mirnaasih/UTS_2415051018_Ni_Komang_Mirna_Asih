class Plant {
  final int? id; // Ubah jadi int? agar aman jika null
  final String name;
  final String scientificName;
  final String category;
  final String imageUrl;
  final String description;

  Plant({
    this.id,
    required this.name,
    required this.scientificName,
    required this.category,
    required this.imageUrl,
    required this.description,
  });

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'] != null ? map['id'] as int : null, // Aman dari nilai null
      name: map['name'] ?? '',
      scientificName: map['scientific_name'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['image_url'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'scientific_name': scientificName,
      'category': category,
      'image_url': imageUrl,
      'description': description,
    };
  }
}