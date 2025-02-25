class AttractionsModel {
  final String title;

  final String location;

  final String description;

  final String imageUrl;
  final String? videoUrl;

  AttractionsModel({
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    this.videoUrl,
  });

  factory AttractionsModel.fromJson(Map<String, dynamic> json) {
    return AttractionsModel(
      location: json['location'],
      description: json['description'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'description': description,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'title': title,
    };
  }
}
