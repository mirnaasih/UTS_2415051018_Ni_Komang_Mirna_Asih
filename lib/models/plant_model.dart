class Plant {
  final int id;
  final String name;
  final String scientificName;
  final String category;
  final String imageUrl;
  final String description;

  Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.category,
    required this.imageUrl,
    required this.description,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] ?? 0,
      name: json['common_name'] ?? json['name'] ?? 'Tanaman Tanpa Nama',
      scientificName: json['scientific_name'] != null 
          ? (json['scientific_name'] is List 
              ? json['scientific_name'].join(', ') 
              : json['scientific_name']) 
          : 'Nama Ilmiah Tidak Tersedia',
      category: json['category'] ?? 'Tanaman Hias',
      imageUrl: json['image_url'] ?? json['default_image']?['regular_url'] ?? 'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&w=500&q=60',
      description: json['description'] ?? 'Deskripsi mengenai tanaman ini belum tersedia.',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scientific_name': scientificName,
      'category': category,
      'image_url': imageUrl,
      'description': description,
    };
  }
}