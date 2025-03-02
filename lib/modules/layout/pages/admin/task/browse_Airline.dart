import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/airline_db.dart';
import '/models/flight_airlines.dart';
import 'flightdepartureairline.dart';

class BrowseAirlines extends StatefulWidget {
  const BrowseAirlines({super.key});

  @override
  State<BrowseAirlines> createState() => _BrowseAirlinesState();
}

class _BrowseAirlinesState extends State<BrowseAirlines> {
  List<FlightAirlines> airlines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff0d75b4),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Tour And Travel ",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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
                              builder: (context) => FlightDepartureairline(),
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
                                child: Image.network(
                                  airlines[index].flightAirLineImageUrl,
                                  width: 150,
                                  fit: BoxFit.cover,
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
