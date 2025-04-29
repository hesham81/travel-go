import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/flight_home/page/reservationflight.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class FlightHome extends StatefulWidget {
  @override
  State<FlightHome> createState() => _FlightHomeState();
}

class _FlightHomeState extends State<FlightHome> {
  final List<Map<String, String>> flights = [
    {
      "airline": "Etihad Airways",
      "logo":
          "https://logolook.net/wp-content/uploads/2024/02/Etihad-Airways-Logo.png",
      "departureTime": "13:15",
      "departureCity": "Cairo",
      "arrivalTime": "10:25",
      "arrivalCity": "Abu-dhabi",
      "price": "6000EP"
    },
    {
      "airline": "EgyptAir",
      "logo": "https://static.cdnlogo.com/logos/e/89/egyptair-thumb.png",
      "departureTime": "15:30",
      "departureCity": "Cairo",
      "arrivalTime": "12:45",
      "arrivalCity": "Abu-dhabi",
      "price": "7500EP"
    },
    {
      "airline": "Qatar Airways",
      "logo":
          "https://storage.googleapis.com/moq-bucket-moq-skwid/Qatar_Airways_Emblem_1b89b4d9fb/Qatar_Airways_Emblem_1b89b4d9fb.png",
      "departureTime": "17:45",
      "departureCity": "Cairo",
      "arrivalTime": "14:55",
      "arrivalCity": "Abu-dhabi",
      "price": "8000EP"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<ReservationProvider>(context);

    // var provider = Provider.of<CollectionsProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            Text(
              "Abu-dhabi",
              style: theme.textTheme.titleLarge!.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDateBox("14/6/2025"),
                SizedBox(width: 15),
                _buildDateBox("19/6/2025"),
              ],
            ),
            0.01.height.hSpace,
            _buildTabBar(),
            0.01.height.hSpace,
            Expanded(
              child: TabBarView(
                children: [
                  _buildFlightList(),
                  _buildFlightList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBox(String date) {
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          date,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.blackColor,
              ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Color(0xFFEAEAEA),
        borderRadius: BorderRadius.circular(33),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            color: AppColors.newBlueColor,
            borderRadius: BorderRadius.circular(33),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: "Economy"),
            Tab(text: "First Class"),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => 0.01.height.hSpace,
      itemCount: flights.length,
      itemBuilder: (context, index) {
        return _buildFlightCard(
          flights[index]["airline"]!,
          flights[index]["logo"]!,
          flights[index]["departureTime"]!,
          flights[index]["departureCity"]!,
          flights[index]["arrivalTime"]!,
          flights[index]["arrivalCity"]!,
          flights[index]["price"]!,
        );
      },
    );
  }

  Widget _buildFlightCard(
      String airline,
      String logo,
      String departureTime,
      String departureCity,
      String arrivalTime,
      String arrivalCity,
      String price) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                airline,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              Image.network(logo, height: 30),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    departureTime,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                  Text(
                    departureCity,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                ],
              ),
              Icon(Icons.flight_takeoff, color: Colors.grey, size: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    arrivalTime,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                  Text(
                    arrivalCity,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Divider(thickness: 1, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$price L.E",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.newBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  "Book Now",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).hPadding(0.01.width);
  }
}
