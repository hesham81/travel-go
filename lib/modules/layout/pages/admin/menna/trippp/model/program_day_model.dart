import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class ProgramDayModel {
  final int dayNumber;

  final List<Program> program;

  ProgramDayModel({
    required this.dayNumber,
    required this.program,
  });

  factory ProgramDayModel.fromJson(Map<String, dynamic> json) {
    return ProgramDayModel(
      dayNumber: json['dayNumber'],
      program: List<Program>.from(
          json['program'].map((program) => Program.fromMap(program))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'program': program.map((program) => program.toMap()).toList(),
    };
  }
}
