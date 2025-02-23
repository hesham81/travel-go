class AttractionsModel {
  final String location;

  final String description;

  final String imageUrl;

  AttractionsModel({
    required this.location,
    required this.description,
    required this.imageUrl,
  });

  factory AttractionsModel.fromJson(Map<String, dynamic> json) {
    return AttractionsModel(
      location: json['location'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'description': description,
      'image_url': imageUrl,
    };
  }
}
