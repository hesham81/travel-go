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
      'attraction': attractions.map((e) => e.toJson()).toList(),
      'dayNumber': dayNumber,
      'from': {
        'hour': from.hour,
        'minute': from.minute,
      },
      'to': {
        'hour': to.hour,
        'minute': to.minute,
      },
      'id': id,
      'images': images,
    };
  }

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      programTitle: map['programTitle'],
      programDetails: map['programDetails'],
      attractions: List<AttractionsModel>.from(
        map['attraction'].map((attraction) => AttractionsModel.fromJson(attraction)),
      ),
      dayNumber: List<int>.from(map['dayNumber']),
      from: Time(hour: map['from']['hour'], minute: map['from']['minute']),
      to: Time(hour: map['to']['hour'], minute: map['to']['minute']),
      id: map['id'],
      images: List<String>.from(map['images']),
    );
  }
}
