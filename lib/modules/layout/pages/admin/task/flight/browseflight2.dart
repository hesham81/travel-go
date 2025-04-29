import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/flight.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/airline_db.dart';
import '/models/flight_airlines.dart';

import 'ViewFlight.dart';

class BrowseFlight2 extends StatefulWidget {
  const BrowseFlight2({super.key});

  @override
  State<BrowseFlight2> createState() => _BrowseFlight2State();
}

class _BrowseFlight2State extends State<BrowseFlight2> {
  List<FlightAirlines> airlines = [];
  List<Flight> flights = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Tour And Travel",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xff0d75b4)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff0d75b4),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff0d75b4),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FlightAirlinesDB.getStreamFlightAirlines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: AppColors.newBlueColor,
                    );
                  }
                  airlines = snapshot.data!.docs
                      .map(
                        (e) => e.data(),
                      )
                      .toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, _) => 0.01.height.hSpace,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    itemCount: airlines.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewFlights(
                                airline: airlines[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      airlines[index].flighAirLineName,
                                      style: TextStyle(
                                        fontFamily: "Poppins-SemiBold",
                                        color: Color(0xff0d75b4),
                                        fontSize: 21,
                                      ),
                                    ),
                                    0.01.height.hSpace,
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LoadingImageNetworkWidget(
                                  imageUrl:airlines[index].flightAirLineImageUrl,
                                  width: 150,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
