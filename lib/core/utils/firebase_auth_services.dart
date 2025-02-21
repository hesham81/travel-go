import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '/core/services/bot_toast.dart';
import '/core/utils/firestore_services.dart';

abstract class FirebaseAuthServices {
  static Future<UserCredential?> signUp(
    BuildContext context,
    String email,
    String password,
    String name,
    String nationalId,
  ) async {
    try {
      UserCredential? user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirestoreServices.RoleBasedSignUp(
        email: email,
        uid: user.user!.uid,
        nationalId: nationalId,
      );
      BotToastServices.showSuccessMessage(
        "Account Created Successfully",
      );
      user.user!.updateDisplayName(name);
      user.user!.reload();
      return Future.value(user);
    } on FirebaseAuthException catch (error) {
      handleFirebaseAuthException(error, context);
    } catch (error) {
      BotToastServices.showErrorMessage(error.toString());
    }
    return null;
  }

  static updatePassword(BuildContext context, {required newPassword}) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e, context);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      String role = "";
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
      handleFirebaseAuthException(e, context);
    } catch (e) {
      BotToastServices.showErrorMessage("Error");
    }
    return null;
  }

  static forgetPassword(
    String email,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e, context);
    } catch (e) {
      print(e);
    }
  }

  static getCurrentUserData() {
    return FirebaseAuth.instance.currentUser;
  }

  static logout() {
    FirebaseAuth.instance.signOut();
  }

  static void handleFirebaseAuthException(
    FirebaseAuthException e,
    BuildContext context,
  ) {
    if (e.code == 'weak-password') {
      BotToastServices.showErrorMessage('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      BotToastServices.showErrorMessage('Account Already Exist');
    } else if (e.code == 'user-not-found') {
      BotToastServices.showErrorMessage('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      BotToastServices.showErrorMessage('User Name Or Password is Invalid');
    } else {
      BotToastServices.showErrorMessage(
          e.code);
    }
  }
}
