import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/browse_selected_trip.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/programs/pages/browse_program/pages/program_details.dart';
import '/modules/layout/pages/admin/menna/trippp/all_programs_data.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/browse_attractions/pages/explore_attractions.dart';
import '/modules/layout/pages/admin/pages/trips/pages/select_attraction.dart';
import '/core/providers/trip_admin_provider.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';
import '/core/widget/map.dart';
import '/modules/layout/pages/admin/menna/trippp/assign_flight_trip.dart';
import '/modules/layout/pages/admin/menna/trippp/assign_hotel.dart';
import '/modules/layout/pages/admin/pages/trips/pages/program_day.dart';
import '/modules/layout/pages/admin/pages/trips/pages/trip_program.dart';
import '/modules/layout/pages/admin/pages/attractions/widget/selected_deleted_widget.dart';
import '/modules/layout/pages/manager/pages/manager_home/manager_home_screen.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/delete_attractions/pages/delete_selected_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/selected_attraction.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/pages/reservation.dart';
import '/core/constant/ai_constant.dart';
import '/modules/layout/pages/user/pages/profile/pages/user_profile.dart';
import '/modules/splash_screen/pages/splash_screen.dart';
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
import 'core/providers/collections_provider.dart';
import 'core/theme/app_theme.dart';
import 'modules/forget_password/pages/forget_password.dart';
import 'modules/layout/pages/admin/pages/admin_home.dart';
import 'modules/layout/pages/user/pages/home/pages/home.dart';
import 'modules/otp/pages/otp.dart';
import 'modules/sign_in/pages/sign_in.dart';
import 'modules/sign_up/pages/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Gemini.init(
    apiKey: AiConstants.chatBotApiKey,
  );
  showLoading();
  Supabase.initialize(
    url: SupabaseKeys.url,
    anonKey: SupabaseKeys.anonKey,
  );
  GoogleGemini(apiKey: AiConstants.chatBotApiKey);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TripAdminProvider()),
        ChangeNotifierProvider(create: (context) => CollectionsProvider()),
        // Add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
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
        builder: BotToastInit(),
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
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
        SelectedAttraction.routeName: (context) => SelectedAttraction(),
        DeleteSelectedAttraction.routeName: (context) =>
            DeleteSelectedAttraction(),
        ReservationScreen.routeName: (context) => ReservationScreen(),
        ManagerHomeScreen.routeName: (context) => ManagerHomeScreen(),
        SelectedDeletedWidget.routeName: (context) => SelectedDeletedWidget(),
        TripProgram.routeName: (context) => TripProgram(),
        ProgramDay.routeName: (context) => ProgramDay(),
        AssignFlightTrip.routeName: (context) => AssignFlightTrip(),
        AssignHotel.routeName: (context) => AssignHotel(),
        AppMaps.routeName: (context) => AppMaps(),
        AllProgramsData.routeName: (context) => AllProgramsData(),
        PlayYoutubeVideo.routeName: (context) => PlayYoutubeVideo(),
        ExploreAttractions.routeName: (context) => ExploreAttractions(),
        SelectAttraction.routeName: (context) => SelectAttraction(),
        BrowseSelectedTrip.routeName: (context) => BrowseSelectedTrip(),
        ProgramDetails.routeName: (context) => ProgramDetails(),
      },
    );
  }
}
