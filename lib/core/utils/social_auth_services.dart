import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '/core/constant/local_storage.dart';
import '/core/constant/shared_preferences_keys.dart';
import '/core/services/bot_toast.dart';
import '/modules/layout/pages/user/pages/home/pages/home.dart';

abstract class SocialAuthServices {
  static loginWithGoogle(BuildContext context) async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    EasyLoading.show();

    await FirebaseAuth.instance.signInWithCredential(credential);
    EasyLoading.dismiss();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Home.routeName,
      (route) => false,
    );
    BotToastServices.showSuccessMessage(
      "Welcome Back",
    );
    LocalStorageData.setString( SharedPreferencesKey.login, "user");
  }
}
