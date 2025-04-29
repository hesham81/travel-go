import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/flight_collections.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/modules/layout/pages/admin/task/flightdeaprturedetails.dart';

class UpdateFlight extends StatefulWidget {
  final Flight flight;

  const UpdateFlight({
    super.key,
    required this.flight,
  });

  @override
  State<UpdateFlight> createState() => _UpdateFlightState();
}

class _UpdateFlightState extends State<UpdateFlight> {
  TextEditingController flightAirlineController = TextEditingController();
  TextEditingController flightIDController = TextEditingController();
  TextEditingController flightNameController = TextEditingController();
  TextEditingController flightPriceController = TextEditingController();
  TextEditingController numberOfSeatsController = TextEditingController();

  @override
  void initState() {
    flightIDController.text = widget.flight.flightId;
    flightAirlineController.text = widget.flight.airline.flighAirLineName;
    flightNameController.text = widget.flight.flightName;
    flightPriceController.text = widget.flight.seats.first.price.toString();
    numberOfSeatsController.text = widget.flight.totalSeats.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    "Update Flight",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff0d75b4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                buildInputField("Flight Airline", "Enter Airline Name",
                    flightAirlineController, true),
                buildInputField(
                  "Flight ID",
                  "Enter Flight ID",
                  flightIDController,
                  true,
                ),
                buildInputField("Flight Name", "Enter Flight Name",
                    flightNameController, null),
                buildInputField("Flight Price", "Enter Flight Price",
                    flightPriceController, null),
                buildInputField("Number Of Seats", "Enter Number of Seats",
                    numberOfSeatsController, null),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0d75b4),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          " Cancel ",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          EasyLoading.show();
                          widget.flight.flightName = flightNameController.text;
                          widget.flight.totalSeats =
                              int.parse(numberOfSeatsController.text);
                          await FlightCollections.addFlight(
                            context,
                            flight: widget.flight,
                          );
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0d75b4),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          " Ok ",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, String hint,
      TextEditingController controller, bool? isReadOnly) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff0d75b4),
            ),
          ),
          SizedBox(height: 5),
          CustomTextFormField(
            hintText: hint,
            controller: controller,
            isReadOnly: isReadOnly ?? false,
          ),
        ],
      ),
    );
  }
}
