import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

import 'modules/first_screen/pages/first_screen.dart';
import 'modules/sign_in/pages/sign_in.dart';

void main() {
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
        SignIn.routeName: (context) => const SignIn(),
      },
    );
  }
}
