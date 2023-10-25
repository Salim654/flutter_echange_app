class Terrain {
  final String? id;
  final String? nom;
  final String? description;
  final String? adresse;
  final double prix;
  final String image;

  Terrain({
    required this.id,
    required this.nom,
    required this.description,
    required this.adresse,
    required this.prix,
    required this.image,
  });

  factory Terrain.fromJson(Map<String, dynamic> json) {
    return Terrain(
      id: json['_id'],
      nom: json['nom'],
      description: json['description'],
      adresse: json['adresse'],
      prix: json['prix'].toDouble(),
      image: json['image'],
    );
  }
}
