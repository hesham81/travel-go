import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreServices {
  static final _fireStore = FirebaseFirestore.instance;

  static RoleBasedSignUp({
    required String email,
    required String password,
    required String uid,
    required DateTime createdAt,
    required String? phoneNumber,
    required String? address,
    required String? name,
    bool isAdmin = false,
  }) async {
    try {
      await _fireStore.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'uid': uid,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'role': (isAdmin) ? 'admin' : 'user',
        'phoneNumber': phoneNumber,
        'address': address,
        'name': name,
      });
      return null;
    } catch (error) {
      return error;
    }
  }

  static RoleBasedSignIn({
    required userCredential,
  }) async {
    try {
      print(userCredential.user!.uid);
      _fireStore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
            return snapshot;
        // if (snapshot.exists) {
        //   print(snapshot.get('role'));
        //   return snapshot.get('role');
        // } else {
        //   return null;
        // }
      });
    } catch (error) {
      return error;
    }
  }
}
