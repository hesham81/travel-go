class TourGuideDataModel {
  final String id;

  final String name;

  final String imageUrl;

   double lat;

   double long;

   String description;

  bool isActiveNow;

  TourGuideDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lat,
    required this.long,
    required this.description,
    required this.isActiveNow,
  });

  factory TourGuideDataModel.fromJson(Map<String, dynamic> json) =>
      TourGuideDataModel(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        lat: json['lat'],
        long: json['long'],
        description: json['description'],
        isActiveNow: json['isActiveNow'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'lat': lat,
        'long': long,
        'description': description,
        'isActiveNow': isActiveNow,
      };
}
