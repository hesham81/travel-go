import 'package:flutter/material.dart';
import '/modules/layout/pages/user/pages/home/pages/flight_home/page/flight_home.dart';
import '/modules/layout/pages/user/pages/home/pages/hotel_home/page/hotel_home.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/home_trip.dart';
import '/models/recommend_model.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/models/trip_model.dart';
import 'chat_bot_home/page/chat_bot_home.dart';
import 'favourite_home/page/favourite_home.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<RecommendModel> recommendations = [
  RecommendModel(
    name: "Sunset Resort",
    imgUrl:
        "https://i.pinimg.com/474x/fd/24/f7/fd24f7618315267be4c3c1f137b07ba5.jpg",
    rating: 4.0,
    location: "Maldives",
  ),
  RecommendModel(
    name: "Mountain Escape",
    imgUrl:
        "https://i.pinimg.com/474x/9a/8a/15/9a8a15c6f624f8eced6e8749814d1346.jpg",
    rating: 3.7,
    location: "Switzerland",
  ),
  RecommendModel(
    name: "Urban Luxury Hotel",
    imgUrl:
        "https://i.pinimg.com/474x/a9/11/11/a91111291a57cbbdd936a3673fb229fb.jpg",
    rating: 4.6,
    location: "New York, USA",
  ),
  RecommendModel(
    name: "Tropical Paradise",
    imgUrl:
        "https://i.pinimg.com/474x/f5/3b/e4/f53be4d19b19f8c0116af5e0e804b4a5.jpg",
    rating: 4.0,
    location: "Bali, Indonesia",
  ),
  RecommendModel(
    name: "Historic Castle Stay",
    imgUrl:
        "https://i.pinimg.com/474x/70/ba/b8/70bab828bc5768acfd79719a8180639f.jpg",
    rating: 4.5,
    location: "Edinburgh, Scotland",
  ),
  RecommendModel(
    name: "Pyramids of Egypt",
    imgUrl:
        "https://i.pinimg.com/474x/9b/73/61/9b7361b0dfbd5ffaf4f92928a2f554ed.jpg",
    rating: 4.5,
    location: "Giza, Egypt",
  ),
];

class _HomeState extends State<Home> {
  var user = FirebaseAuthServices.getCurrentUserData();
  int selectedIndex = 0;

  var searchController = TextEditingController();
  List<TripModel> searchList = [];
  String searchQueryText = "";
  var body = [
    HomeTrip(),
    FlightHome(),
    HotelHome(),
    ChatBotHome(),
    FavouriteHome(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            showUnselectedLabels: false,
            fixedColor: AppColors.whiteColor,
            backgroundColor: AppColors.newBlueColor,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.whiteColor,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: AppColors.whiteColor,
                ),
                label: "Trip",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.flight_outlined,
                  color: AppColors.whiteColor,
                ),
                activeIcon: Icon(
                  Icons.flight,
                  color: AppColors.whiteColor,
                ),
                label: "Flight",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apartment,
                  color: AppColors.whiteColor,
                ),
                activeIcon: Icon(
                  Icons.apartment,
                  color: AppColors.whiteColor,
                ),
                label: "Hotel",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.support_agent,
                  color: AppColors.whiteColor,
                ),
                activeIcon: Icon(
                  Icons.support_agent_sharp,
                  color: AppColors.whiteColor,
                ),
                label: "Chat Bot",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline,
                  color: AppColors.whiteColor,
                ),
                activeIcon: Icon(
                  Icons.bookmark,
                  color: AppColors.whiteColor,
                ),
                label: "Favourite",
              ),
            ],
          ),
        ),
      ),
      body: body[selectedIndex],
    );
  }
}
