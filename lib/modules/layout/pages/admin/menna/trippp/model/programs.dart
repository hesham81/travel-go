import 'package:travel_go/models/attractions_model.dart';

class Program {
  final String programTitle;

  final String programDetails;

  final AttractionsModel attraction;

  final int dayNumber;

  Program({
    required this.programTitle,
    required this.programDetails,
    required this.attraction,
    required this.dayNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'programTitle': programTitle,
      'programDetails': programDetails,
      'attraction': attraction.toJson(),
      'dayNumber': dayNumber,
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      programTitle: map['programTitle'],
      programDetails: map['programDetails'],
      attraction: AttractionsModel.fromJson(map['attraction']),
      dayNumber: map['dayNumber'],
    );
  }
}
