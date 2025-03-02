import 'package:travel_go/core/utils/company_collections.dart';

class Company {
  final String companyName;

  final String companyWebsite;

  final String companyStartFrom;

  final String phoneNumber;

  Company({
    required this.companyName,
    required this.companyWebsite,
    required this.companyStartFrom,
    required this.phoneNumber,
  });


  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['companyName'] ?? "No Company Name",
      companyWebsite: json['companyWebsite'],
      companyStartFrom: json['companyStartFrom'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'companyStartFrom': companyStartFrom,
      'phoneNumber': phoneNumber,
    };
  }
}
