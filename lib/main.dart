import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

import 'modules/first_screen/pages/first_screen.dart';
import 'modules/sign_in/pages/sign_in.dart';
import 'modules/sign_up/pages/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

var navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirstScreen.routeName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      theme: AppTheme.lightTheme,
      routes: {
        FirstScreen.routeName: (context) => const FirstScreen(),
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => const SignUp(),
      },
    );
  }
}
