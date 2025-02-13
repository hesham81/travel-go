import 'package:flutter/material.dart';
import '/modules/layout/pages/admin/pages/trips/pages/selected_trip.dart';
import '/core/extensions/center.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/trip_db.dart';
import '/core/widget/search_widget.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../models/trip.dart';
import '../widget/trip_cart.dart';

class EditTrip extends StatefulWidget {
  const EditTrip({super.key});

  @override
  State<EditTrip> createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  TextEditingController searchController = TextEditingController();
  final trip = Trip(
    currency: "LE",
    destination: "Cairo",
    hotelId: "Hotel",
    noOfDays: 10,
    source: "Sharm",
    id: "trip1232",
    imageUrl:
        "https://ulmlgjxomyybsvsjesuv.supabase.co/storage/v1/object/sign/trip/sharm/dahab.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0cmlwL3NoYXJtL2RhaGFiLnBuZyIsImlhdCI6MTczODYyMDMyMSwiZXhwIjoxNzcwMTU2MzIxfQ.OXBFOIOybFO9FQs19GLg0DYASGOetLwPqHhvox4Ovb8",
    title: "Trip test123",
    startDateTime: DateTime(2025, 10, 12),
    endDateTime: DateTime(2025, 10, (12 + 10)),
    price: 3200,
  );
  var trips = [];
  var searchQueryText = "";
  var searchTrip = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SearchWidget(
                borderRadius: 10,
                controller: searchController,
                search: (value) {
                  searchQueryText = searchController.text;
                  searchTripList(searchQueryText);
                  setState(() {});
                  return null;
                },
              ),
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: TripDB.getStreamTripData(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return Icon(
                    Icons.error,
                    color: AppColors.errorColor,
                  ).centerWidget();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.replay,
                        color: AppColors.errorColor,
                      ),
                      0.01.width.hSpace,
                      Text(
                        "No Internet Connection",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  );
                }
                trips = snapshot.data!.docs.map(
                  (data) {
                    return data.data();
                  },
                ).toList();
                return Visibility(
                  visible: searchQueryText.isEmpty,
                  replacement: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SelectedAdminTrip.routeName,
                      );
                    },
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          SelectedAdminTrip.routeName,
                          arguments: searchTrip[index],
                        ),
                        child: TripCart(
                          model: searchTrip[index],
                        ),
                      ),
                      separatorBuilder: (context, _) => 0.01.height.hSpace,
                      itemCount: searchTrip.length,
                    ),
                  ),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        SelectedAdminTrip.routeName,
                        arguments: trips[index],
                      ),
                      child: TripCart(
                        model: trips[index],
                      ),
                    ),
                    separatorBuilder: (context, _) => 0.01.height.hSpace,
                    itemCount: trips.length,
                  ),
                );
              },
            ),
          ],
        ),
      ).allPadding(0.01.height),
    );
  }

  void searchTripList(query) {
    searchTrip.clear();
    for (Trip trip in trips) {
      if (trip.title.toLowerCase().contains(searchQueryText.toLowerCase())) {
        searchTrip.add(trip);
      } else if (trip.noOfDays.toString() == (searchQueryText)) {
        searchTrip.add(trip);
      } else if (trip.price
          .toString()
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchTrip.add(trip);
      } else if (trip.destination
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchTrip.add(trip);
      } else if (trip.source
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchTrip.add(trip);
      } else if (trip.startDateTime.year.toString() == (searchQueryText)) {
        searchTrip.add(trip);
      } else if (trip.startDateTime.month.toString() == (searchQueryText)) {
        searchTrip.add(trip);
      }
      else if (trip.currency.toLowerCase() == (searchQueryText.toLowerCase()))
      {
        searchTrip.add(trip);
      }

    }
    setState(() {});
  }
}
