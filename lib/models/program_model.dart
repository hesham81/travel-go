import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:travel_go/models/attractions_model.dart';

class ProgramModel {
  final String id;

  final String programTitle;

  final String programDetails;

  final List<AttractionsModel> attractions;

  final List<int> dayNumber;
  final Time from;
  final Time to;
  final List<String> images;

  ProgramModel({
    required this.programTitle,
    required this.programDetails,
    required this.attractions,
    required this.dayNumber,
    required this.from,
    required this.to,
    required this.id,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'programTitle': programTitle,
      'programDetails': programDetails,
      'attraction': attractions.map(
        (e) => e.toJson(),
      ),
      'dayNumber': dayNumber,
      'from': from,
      'to': to,
      'id': id,
      'images': images,
    };
  }

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      programTitle: map['programTitle'],
      programDetails: map['programDetails'],
      attractions:  List<AttractionsModel>.from(
        map['attraction'].map((attraction) => AttractionsModel.fromJson(attraction)),
      ),
      dayNumber: map['dayNumber'],
      from: map['from'],
      to: map['to'],
      id: map['id'],
      images: map['images'],
    );
  }
}
