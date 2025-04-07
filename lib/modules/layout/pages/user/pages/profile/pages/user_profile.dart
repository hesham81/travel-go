import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/favourite_home/page/favourite_home.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_location/pages/my_location.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/pages/my_reservations.dart';
import '/core/constant/local_storage.dart';
import '/core/constant/shared_preferences_keys.dart';
import '/core/routes/route_names.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/user/pages/profile/widget/choose_profile_index.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/constant/app_assets.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/user-profile';

  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<ReservationProvider>(context);
    final user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.newBlueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Color(0xFF0d75b4)),
                ),
                SizedBox(height: 10),
                Text(
                  user.displayName ?? 'No Name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  user.email ?? 'No Email',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => slideLeftWidget(
                        newPage: MyLocation(location: provider.location),
                        context: context,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.location_on, color: Colors.white),
                          SizedBox(height: 5),
                          Text('Location',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => slideLeftWidget(
                        newPage: FavouriteHome(),
                        context: context,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.bookmark, color: Colors.white),
                          SizedBox(height: 5),
                          Text('Favorites',
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => slideLeftWidget(
                        newPage: MyReservations(),
                        context: context,
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.event, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            'Reservations',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('My Profile'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Languages'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Payments'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Color(0xFF0d75b4)),
                  title: Text('Logout'),
                  onTap: () async {
                    EasyLoading.show();
                    await FirebaseAuthServices.logout();
                    EasyLoading.dismiss();
                    LocalStorageData.setString(SharedPreferencesKey.login, "");
                    Navigator.of(context)
                        .pushReplacementNamed(RouteNames.signIn);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
