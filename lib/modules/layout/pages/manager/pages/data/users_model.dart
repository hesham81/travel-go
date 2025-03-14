class Users {
  final String uid;
  final String email;

  final String role;
  final String? nationalId;

  Users({
    required this.uid,
    required this.email,
    required this.role,
    this.nationalId,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'],
      email: map['email'],
      role: map['role'],
      nationalId: map['nationalId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'nationalId': nationalId,
    };
  }
}
