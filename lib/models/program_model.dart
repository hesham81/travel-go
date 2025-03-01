import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:travel_go/models/attractions_model.dart';

class ProgramModel {
  final String id;

  final String programTitle;

  final String programDetails;

  final AttractionsModel attraction;

  final int dayNumber;
  final Time from;
  final Time to;

  ProgramModel({
    required this.programTitle,
    required this.programDetails,
    required this.attraction,
    required this.dayNumber,
    required this.from,
    required this.to,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'programTitle': programTitle,
      'programDetails': programDetails,
      'attraction': attraction.toJson(),
      'dayNumber': dayNumber,
      'from': from,
      'to': to,
      'id': id,
    };
  }

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      programTitle: map['programTitle'],
      programDetails: map['programDetails'],
      attraction: AttractionsModel.fromJson(map['attraction']),
      dayNumber: map['dayNumber'],
      from: map['from'],
      to: map['to'],
      id: map['id'],
    );
  }
}
