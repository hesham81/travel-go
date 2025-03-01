class AttractionsModel {
  final String id ;
  final String title;

  final String location;

  final String description;

  final String imageUrl;
  final String? videoUrl;
  final double? lat;
  final double? long;
  final String category;

  AttractionsModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    this.videoUrl,
    this.lat,
    this.long,
    required this.category,
  });

  factory AttractionsModel.fromJson(Map<String, dynamic> json) {
    return AttractionsModel(
      id: json['id'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      title: json['title'],
      lat: json['lat'] ?? 0,
      long: json['long'] ?? 0,
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'description': description,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'title': title,
      'lat': lat ?? 0,
      'long': long ?? 0,
      'category': category,
    };
  }
}
