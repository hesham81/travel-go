import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/trip_db.dart';
import '/core/widget/search_widget.dart';
import '/core/theme/app_colors.dart';
import '/models/trip.dart';
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
  bool isLoading = false;

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
                snapshot.data!.docs.map(
                  (element) {
                    trips.add(element.data());
                    print(element.data().source);
                  },
                );
                print("Length ${trips.length}");

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TripCart(
                    model: trips[index],
                  ),
                  separatorBuilder: (context, _) => 0.01.height.hSpace,
                  itemCount: trips.length,
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
      } else if (trip.currency.toLowerCase() ==
          (searchQueryText.toLowerCase())) {
        searchTrip.add(trip);
      }
    }
    setState(() {});
  }
}
