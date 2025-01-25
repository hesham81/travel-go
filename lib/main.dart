import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_theme.dart';

import 'modules/first_screen/pages/first_screen.dart';

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
      },
    );
  }
}
