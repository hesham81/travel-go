// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:travel_go/core/utils/firestore_services.dart';
// import 'package:travel_go/modules/layout/pages/user/pages/trips/selected_trip/selected_trip.dart';
// import '/modules/layout/pages/user/pages/home/widget/trip_card_widget.dart';
// import '/core/constant/app_assets.dart';
// import '/models/trip_model.dart';
// import '/core/extensions/extensions.dart';
// import '/core/widget/search_widget.dart';
//
// class Home extends StatefulWidget {
//   static const routeName = '/home';
//
//   Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   var searchController = TextEditingController();
//   List<TripModel> searchList = [];
//   List<TripModel> tripList = [
//     TripModel(
//       id: '1',
//       imageUrl: AppAssets.dahabaIMG,
//       title: 'Dahab',
//       startDateTime: DateTime(2024, 10, 12),
//       endDateTime: DateTime(2024, 10, 15),
//       price: 3000,
//     ),
//     TripModel(
//         id: '5',
//         imageUrl: AppAssets.dahabaIMG,
//         title: 'Dynamo Kiev',
//         startDateTime: DateTime(2024, 10, 12),
//         endDateTime: DateTime(2024, 10, 15),
//         price: 1800,
//         currency: "USD"),
//     TripModel(
//       id: '6',
//       imageUrl: AppAssets.sharmIMG,
//       title: 'Aswan',
//       startDateTime: DateTime(2024, 10, 12),
//       endDateTime: DateTime(2024, 10, 15),
//       price: 800,
//     ),
//     TripModel(
//       id: '4',
//       imageUrl: AppAssets.dahabaIMG,
//       title: 'Sharm',
//       startDateTime: DateTime(2025, 3, 12),
//       endDateTime: DateTime(2025, 8, 15),
//       price: 3000,
//     ),
//     TripModel(
//       id: '2',
//       imageUrl: AppAssets.sharmIMG,
//       title: 'Dahab',
//       startDateTime: DateTime(2024, 10, 16),
//       endDateTime: DateTime(2024, 10, 19),
//       price: 4000,
//     ),
//     TripModel(
//       id: '3',
//       imageUrl: AppAssets.dahabaIMG,
//       title: 'Alex',
//       startDateTime: DateTime(2024, 10, 20),
//       endDateTime: DateTime(2024, 10, 23),
//       price: 4500,
//     ),
//   ];
//   String searchQueryText = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SearchWidget(
//                 controller: searchController,
//                 search: (value) {
//                   searchQueryText = value;
//                   searchQuery();
//                   setState(() {});
//                 },
//               ).vPadding(0.01.height).hPadding(0.09.width),
//               0.02.height.hSpace,
//               Visibility(
//                 visible: searchList.isEmpty,
//                 replacement: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) => GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         SelectedTrip.routeName,
//                         arguments: searchList[index],
//                       );
//                     },
//                     child: TripCardWidget(
//                       tripModel: searchList[index],
//                     ),
//                   ),
//                   separatorBuilder: (index, context) => 0.02.height.hSpace,
//                   itemCount: searchList.length,
//                 ),
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) => GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         SelectedTrip.routeName,
//                         arguments: tripList[index],
//                       );
//                     },
//                     child: TripCardWidget(
//                       tripModel: tripList[index],
//                     ),
//                   ),
//                   separatorBuilder: (index, context) => 0.02.height.hSpace,
//                   itemCount: tripList.length,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void searchQuery() {
//     searchList.clear();
//
//     for (var trip in tripList) {
//       if (trip.title.toLowerCase().contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.id
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.currency
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.price
//           .toString()
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.startDateTime.year
//           .toString()
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.endDateTime.day
//           .toString()
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.endDateTime.month
//           .toString()
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchList.add(trip);
//       } else if (trip.price.toString() == searchQueryText) {
//         searchList.add(trip);
//       }
//     }
//     setState(() {});
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/user/pages/v1/flight.dart';



class Home extends StatelessWidget {
  static const String routeName = 'home';
  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Dahab',
      'startDate': '12/10/2024',
      'endDate': '15/10/2024',
      'price': '5,000 LE',
      'image':'https://media.digitalnomads.world/wp-content/uploads/2021/03/20120536/dahab-digital-nomads-1024x683.jpg',},
    {
      'name': 'Hurghada',
      'startDate': '20/10/2024',
      'endDate': '25/10/2024',
      'price': '4,000 LE',
      'image':
'https://media.tacdn.com/media/attractions-splice-spp-674x446/0a/56/9e/29.jpg'    },
    {
      'name': 'Istanbul',
      'startDate': '01/11/2024',
      'endDate': '07/11/2024',
      'price': '8,000 LE',
      'image':
'https://www.etbtoursegypt.com/storage/849/conversions/istanbul-sightseeing-webp.webp'    },
    {
      'name': 'Alexandria',
      'startDate': '10/12/2024',
      'endDate': '12/12/2024',
      'price': '2,000 LE',
      'image':
'https://sempretravelegypt.com/wp-content/uploads/2021/08/Ausflug-nach-Kairo-und-Alexandria-2-Tage-ab-El-Gouna-870x555-3-800x600.jpg'    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF7FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF68B0E2),
        elevation: 0,
        title: Text(
          'Travel go',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search trip', // Updated to "Search trip"
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Category Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Trip', Colors.grey[300]!, context),
                _buildCategoryButton('Flight', Colors.white, context),
                _buildCategoryButton('Hotel', Colors.white, context),
              ],
            ),
          ),
          // List of Destinations
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: Image.network(
                            destination['image'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  destination['name'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Start date: ${destination['startDate']}'),
                                Text('End date: ${destination['endDate']}'),
                                Text('Price: ${destination['price']}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label, Color backgroundColor, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(color: Colors.black12),
      ),
      onPressed: (
          ) {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>DahabTripScreen()),);
      },
      child: Text(label),
    );
  }
}