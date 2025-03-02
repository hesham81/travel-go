import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/airline_db.dart';
import '/core/utils/flight_collections.dart';
import '/core/validations/validations.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/models/flight.dart';
import '/models/flight_airlines.dart';

class NewFlight extends StatefulWidget {
  const NewFlight({super.key});

  @override
  State<NewFlight> createState() => _NewFlightState();
}

class _NewFlightState extends State<NewFlight> {
  TextEditingController flightIdController = TextEditingController();
  TextEditingController flightAirlineController = TextEditingController();
  TextEditingController flightNameController = TextEditingController();
  TextEditingController flightPriceController = TextEditingController();
  TextEditingController numberOfSeatsController = TextEditingController();
  List<FlightAirlines> airlines = [];
  var formKey = GlobalKey<FormState>();

  _getAllAirlines() async {
    FlightAirlinesDB.getAllAirlines().then(
      (value) {
        airlines = value;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    _getAllAirlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    flightIdController.text =
        "F-${flightAirlineController.text.trim().toLowerCase()}-${flightNameController.text.toLowerCase()}";
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "New Flight",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff0d75b4),
                      fontWeight: FontWeight.bold,
                    ),
                  ).center,
                  0.01.height.hSpace,
                  buildInputField(
                    label: "Flight ID",
                    hint: "Enter Flight ID",
                    isReadOnly: true,
                    controller: flightIdController,
                  ),
                  0.01.height.hSpace,
                  Text(
                    "Flight Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0d75b4),
                    ),
                  ),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: "Flight Name",
                    controller: flightNameController,
                    validation: (value) {
                      return Validations.isNameValid(flightNameController.text);
                    },
                  ),
                  0.01.height.hSpace,
                  Text(
                    "Air Line",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0d75b4),
                    ),
                  ),
                  0.01.height.hSpace,
                  DropdownMenu(
                    width: double.maxFinite,
                    controller: flightAirlineController,
                    hintText: "Air Line Name",
                    onSelected: (value) => setState(() {}),
                    dropdownMenuEntries: [
                      for (var airline in airlines)
                        DropdownMenuEntry(
                          value: airline.flighAirLineName,
                          label: airline.flighAirLineName,
                        ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0d75b4),
                    ),
                  ),
                  0.01.height.hSpace,
                  NumbersTextFormField(
                    hintText: "Price",
                    controller: flightPriceController,
                    validation: (value) {
                      return flightPriceController.text.isEmpty
                          ? "Required"
                          : null;
                    },
                  ),
                  0.01.height.hSpace,
                  Text(
                    "Number Of Seats ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0d75b4),
                    ),
                  ),
                  0.01.height.hSpace,
                  NumbersTextFormField(
                    hintText: "Number Of Seats",
                    controller: numberOfSeatsController,
                    validation: (value) {
                      return numberOfSeatsController.text.isEmpty
                          ? "Required"
                          : null;
                    },
                  ),
                  0.03.height.hSpace,
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
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      0.02.width.vSpace,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            EasyLoading.show();
                            FlightAirlines airline = airlines
                                .where(
                                  (airline) =>
                                      airline.flighAirLineName ==
                                      flightAirlineController.text,
                                )
                                .first;
                            if (formKey.currentState!.validate()) {
                              await FlightCollections.addFlight(
                                context,
                                flight: Flight(
                                  flightId: flightIdController.text,
                                  flightName: flightNameController.text,
                                  airline: airline,
                                ),
                              ).then(
                                (value) {
                                  if (value) {
                                    EasyLoading.dismiss();
                                    BotToastServices.showSuccessMessage(
                                        "Flight Added Succefully");
                                    Navigator.pop(context);
                                  } else {
                                    EasyLoading.dismiss();
                                    BotToastServices.showErrorMessage(
                                        "Something Went Wrong");
                                  }
                                },
                              );
                            }
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
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
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
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required String hint,
    TextEditingController? controller,
    bool isReadOnly = false,
  }) {
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
            isReadOnly: isReadOnly,
          )
        ],
      ),
    );
  }
}
