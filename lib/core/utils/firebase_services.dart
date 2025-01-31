import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/utils/firestore_services.dart';

abstract class FirebaseAuthServices {
  static bool validation = true;
  static String? role;

  static Future<UserCredential?> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential? user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirestoreServices.RoleBasedSignUp(
          email: email,
          password: password,
          uid: user.user!.uid,
          createdAt: DateTime.now(),
          phoneNumber: "",
          address: "",
          name: name);
      return Future.value(user);
    } on FirebaseAuthException catch (error) {
      handleFirebaseAuthException(error);
    } catch (error) {
      BotToastServices.showErrorMessage(error.toString());
    }
    return null;
  }

  static updatePassword({required newPassword})
  async {
    try
        {
          await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
          return true ;
        }
        on FirebaseAuthException catch (e)
        {
          handleFirebaseAuthException(e);
          return null ;
        }
    catch (e)
    {
      return null ;
    }
  }

  static signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      role = await FirestoreServices.RoleBasedSignIn(
        id: userCredential.user!.uid,
      );
      return role;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e);
      print(e.message);
    } catch (e) {
      print(e);
    }
    return null;
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
      BotToastServices.showErrorMessage('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      BotToastServices.showErrorMessage(
          'The account already exists for that email.');
    } else if (e.code == 'user-not-found') {
      BotToastServices.showErrorMessage('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      BotToastServices.showErrorMessage(
          'Wrong password provided for that user.');
    } else {
      BotToastServices.showErrorMessage(
          'An unexpected Firebase error occurred: ${e.code}');
    }
  }
}
