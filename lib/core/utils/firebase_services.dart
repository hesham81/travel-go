import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseServices {
  static bool validation = false;

  static Future<UserCredential?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      validation = true;
      return userCredential; // Return UserCredential for further actions
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
      validation = false;

      return null;

      // Indicate failure
    } catch (e) {
      validation = false;

      print(e); // Log other unexpected errors
      return null;
    }
  }

  static Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      validation = true;

      return userCredential; // Return UserCredential for further actions
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
      validation = false;

      return null; // Indicate failure
    } catch (e) {
      validation = false;

      print(e); // Log other unexpected errors
      return null;
    }
  }

  static forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
    } catch (e) {
      print(e); // Log other unexpected errors
    }
  }

  static void handleFirebaseAuthException(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    } else if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print('An unexpected Firebase error occurred: ${e.code}');
    }
  }
}
