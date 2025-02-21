import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_go/core/constant/ai_constant.dart';
import 'package:travel_go/core/utils/chat_bot_response.dart';
import 'package:travel_go/modules/layout/pages/user/pages/profile/pages/user_profile.dart';
import 'package:travel_go/modules/splash_screen/pages/splash_screen.dart';
import '/modules/layout/pages/admin/pages/flights/pages/selected_airline.dart';
import '/modules/layout/pages/admin/pages/hotels/pages/selected_hotel.dart';
import '/core/constant/supabase_key.dart';
import '/modules/layout/pages/admin/pages/hotels/pages/edit_hotels.dart';
import '/modules/layout/pages/admin/pages/hotels/pages/add_hotel.dart';
import '/modules/layout/pages/admin/pages/profile/profile.dart';
import '/modules/layout/pages/admin/pages/trips/pages/selected_trip.dart';
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
  Supabase.initialize(
    url: SupabaseKeys.url,
    anonKey: SupabaseKeys.anonKey,
  );
  GoogleGemini(apiKey: AiConstants.chatBotApi);
  runApp(const MyApp());
}

var navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      theme: AppTheme.lightTheme,
      builder: EasyLoading.init(
        builder: EasyLoading.init(
          builder: BotToastInit(),
        ),
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        FirstScreen.routeName: (context) => const FirstScreen(),
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        Otp.routeName: (context) => Otp(),
        Home.routeName: (context) => Home(),
        AdminHome.routeName: (context) => AdminHome(),
        NewPassword.routeName: (context) => NewPassword(),
        SelectedTrip.routeName: (context) => SelectedTrip(),
        EditHotels.routeName: (context) => EditHotels(),
        AdminProfile.routeName: (context) => AdminProfile(),
        AddHotel.routeName: (context) => AddHotel(),
        SelectedAdminTrip.routeName: (context) => SelectedAdminTrip(),
        SelectedHotel.routeName: (context) => SelectedHotel(),
        SelectedAirline.routeName: (context) => SelectedAirline(),
        UserProfile.routeName: (context) => UserProfile(),
      },
    );
  }
}
