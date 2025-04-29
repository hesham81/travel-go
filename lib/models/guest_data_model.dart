class GuestDataModel {
  final String name;

  final String age;

  final String role;

  GuestDataModel({
    required this.name,
    required this.age,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'role': role,
    };
  }

  factory GuestDataModel.fromMap(Map<String, dynamic> map) {
    return GuestDataModel(
      name: map['name'],
      age: map['age'],
      role: map['role'],
    );
  }
}
