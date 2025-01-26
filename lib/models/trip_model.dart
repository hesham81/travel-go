import '../core/constant/app_assets.dart';

class TripModel {
  final String id;
  final String imageUrl;
  final String title;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final double price;
  final String currency;

  TripModel({
    this.currency = "LE",
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    required this.price,
  });

  List<TripModel> TripList() {
    List<TripModel> tripList = [
      TripModel(
        id: '1',
        imageUrl: AppAssets.dahabaIMG,
        title: 'Dahab',
        startDateTime: DateTime(2024, 10, 12),
        endDateTime: DateTime(2024, 10, 15),
        price: 3000,
      ),
      TripModel(
        id: '2',
        imageUrl: AppAssets.sharmIMG,
        title: 'Dahab',
        startDateTime: DateTime(2024, 10, 16),
        endDateTime: DateTime(2024, 10, 19),
        price: 4000,
      ),
      TripModel(
        id: '3',
        imageUrl: AppAssets.dahabaIMG,
        title: 'Dahab',
        startDateTime: DateTime(2024, 10, 20),
        endDateTime: DateTime(2024, 10, 23),
        price: 4500,
      ),
    ];
    return tripList;
  }
}
