import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/edit_hotels.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/add_hotel.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/profile/profile.dart';
import '/core/services/easy_loading.dart';
import '/modules/layout/pages/user/pages/trips/selected_trip/selected_trip.dart';
import '/modules/new_password/pages/new_password.dart';
import 'core/theme/app_theme.dart';

import 'modules/first_screen/pages/first_screen.dart';
import 'modules/forget_password/pages/forget_password.dart';
import 'modules/layout/pages/admin/pages/admin_home.dart';
import 'modules/layout/pages/user/pages/home/pages/home.dart';
import 'modules/otp/pages/otp.dart';
import 'modules/sign_in/pages/sign_in.dart';
import 'modules/sign_up/pages/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  showLoading();
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
      builder: EasyLoading.init(
        builder: EasyLoading.init(
          builder: BotToastInit(),
        ),
      ),
      routes: {
        FirstScreen.routeName: (context) => const FirstScreen(),
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        Otp.routeName: (context) => Otp(),
        Home.routeName: (context) => Home(),
        AdminHome.routeName: (context) => AdminHome(),
        NewPassword.routeName: (context) => NewPassword(),
        SelectedTrip.routeName : (context) => SelectedTrip(),
        EditHotels.routeName : (context) => EditHotels(),
        Profile.routeName : (context) => Profile(),
        AddHotel.routeName : (context) => AddHotel(),
      },
    );
  }
}
