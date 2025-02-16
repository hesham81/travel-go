import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/modules/layout/pages/admin/pages/flights/pages/edit_flights.dart';
import '/modules/layout/pages/admin/pages/programs/pages/edit_programs.dart';
import '/modules/layout/pages/admin/pages/trips/pages/edit_trip.dart';
import '/modules/first_screen/pages/first_screen.dart';
import '/modules/layout/pages/admin/pages/profile/profile.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import 'hotels/pages/edit_hotels.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/admin-home';

  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  User currentUser = FirebaseAuthServices.getCurrentUserData();
  List<Widget> pages = [
    EditTrip(),
    EditHotels(),
    EditPrograms(),
    EditFlights(),
  ];
  int selectedIndex = 0;
  User user = FirebaseAuthServices.getCurrentUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Home'),
      ),
      drawer: Drawer(
        width: 0.5.width,
        backgroundColor: AppColors.greyColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Profile.routeName);
                  },
                  child: Column(
                    children: [
                      SafeArea(
                        child: CircleAvatar(
                          radius: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              currentUser.photoURL ??
                                  "https://i.pinimg.com/474x/2e/d4/09/2ed409f40d20ad2eb8ff068621d29904.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      0.01.height.hSpace,
                      Text(
                        "${user.email}",
                        style: TextStyle(
                          color: AppColors.dodgurBlueColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Trips",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex = 0;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Programs",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex = 0;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Hotels",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex = 1;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Attractions",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex == 0;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Flights",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex = 3;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Reports",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex == 0;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: AppColors.dodgurBlueColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedIndex == 0;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
              0.01.height.hSpace,
              ListTile(
                style: ListTileStyle.drawer,
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    color: AppColors.errorColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  EasyLoading.show();
                  FirebaseAuthServices.logout();
                  EasyLoading.dismiss();
                  Navigator.pushReplacementNamed(
                    context,
                    FirstScreen.routeName,
                  );
                },
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.dodgurBlueColor,
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
