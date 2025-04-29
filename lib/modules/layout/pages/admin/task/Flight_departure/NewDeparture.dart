import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/utils/flight_collections.dart';
import 'package:travel_go/core/utils/flight_departures_collections.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/flight_departures.dart';
import 'package:travel_go/modules/layout/pages/admin/task/adminscreen.dart';

import '../../../../../../core/services/bot_toast.dart';
import '../../../../../../core/theme/app_colors.dart';
//import 'package:flutter_csc_picker/flutter_csc_picker.dart';

class NewDeparture extends StatefulWidget {
  @override
  _NewDepartureState createState() => _NewDepartureState();
}

class _NewDepartureState extends State<NewDeparture> {
  List<Flight> flights = [];

  Future<void> _getAllFlights() async {
    flights = await FlightCollections.getAllFlight();
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      _getAllFlights(),
    ]);
    super.initState();
  }

  _submitDeparture(BuildContext context) async {
    EasyLoading.show();
    FlightDeparture departure = FlightDeparture(
      flightId: _selectedFlight!.flightId,
      depDay: startDate ?? DateTime.now(),
      arrDay: endDate ?? DateTime.now(),
      depTime: departureTime ?? TimeOfDay.now(),
      arrTime: arrivalTime ?? TimeOfDay.now(),
      availableSeats: _selectedFlight!.totalSeats,
      arrAirport: destinationCountry ?? "",
      depAirport: sourceCountry ?? "",
    );

    String? response = await FlightDeparturesCollections.submitFlight(
      departure: departure,
    );
    EasyLoading.dismiss();
    if (response == null )
      {
        BotToastServices.showSuccessMessage("Departure Added Successfully");
        Navigator.pop(context);
      }
    else
      {
        print(response);
        BotToastServices.showErrorMessage(response);
      }
  }

  TextEditingController airlineController = TextEditingController();
  TextEditingController flightIdController = TextEditingController();
  String? sourceCountry;
  String? destinationCountry;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? departureTime;
  TimeOfDay? arrivalTime;
  Flight? _selectedFlight;

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
      body: SingleChildScrollView(
        // Add this widget to make the content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              // Centering the text
              child: Text(
                "New Flight Departure",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d75b4),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomDropdown(
              hintText: _selectedFlight?.flightId ?? "Select Flight",
              headerBuilder: (context, selectedItem, enabled) =>
                  CustomContainer(
                child: Text(
                  selectedItem,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              listItemBuilder: (context, item, isSelected, onItemSelect) =>
                  CustomContainer(
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              items: flights
                  .map(
                    (e) => e.flightId,
                  )
                  .toList(),
              onChanged: (p0) => setState(() {
                _selectedFlight = flights
                    .where(
                      (element) => element.flightId == p0!,
                    )
                    .first;
                airlineController.text =
                    _selectedFlight!.airline!.flighAirLineName;
              }),
            ),
            _buildTextField("Airline", airlineController, true),
            _buildPickerField("Source", sourceCountry, () {
              showCountryPicker(
                context: context,
                countryListTheme: CountryListThemeData(
                    backgroundColor: AppColors.greyColor,
                    textStyle: Theme.of(context).textTheme.labelMedium),
                onSelect: (Country country) {
                  setState(() {
                    sourceCountry = country.name;
                  });
                },
              );
            }),
            _buildPickerField("Destination", destinationCountry, () {
              showCountryPicker(
                context: context,
                countryListTheme: CountryListThemeData(
                    backgroundColor: AppColors.greyColor,
                    textStyle: Theme.of(context).textTheme.labelMedium),
                onSelect: (Country country) {
                  setState(() {
                    destinationCountry = country.name;
                  });
                },
              );
            }),
            _buildPickerField("Start Date", startDate?.toString().split(" ")[0],
                () {
              _pickDate().then((date) {
                setState(() => startDate = date);
              });
            }),
            _buildPickerField("End Date", endDate?.toString().split(" ")[0],
                () {
              _pickDate().then((date) {
                setState(() => endDate = date);
              });
            }),
            _buildPickerField("Departure Time", departureTime?.format(context),
                () {
              _pickTime().then((time) {
                setState(() => departureTime = time);
              });
            }),
            _buildPickerField("Arrival Time", arrivalTime?.format(context), () {
              _pickTime().then((time) {
                setState(() => arrivalTime = time);
              });
            }),
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
                    onPressed: () {
                      _showMiniCard();
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
    );
  }

  Widget _buildPickerField(String title, String? value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff0d75b4),
                fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value ?? "Select $title",
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextField(
      String title, TextEditingController controller, bool isReadOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff0d75b4),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        CustomTextFormField(
          isReadOnly: isReadOnly,
          hintText: title,
          controller: controller,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Future<DateTime?> _pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  void _showMiniCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Flight Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0d75b4)),
                ),
                Divider(),
                SizedBox(height: 10),
                _buildInfoRow("From:", sourceCountry ?? "Not selected"),
                _buildInfoRow("To:", destinationCountry ?? "Not selected"),
                _buildInfoRow("Start Date:",
                    startDate?.toString().split(" ")[0] ?? "Not selected"),
                _buildInfoRow("End Date:",
                    endDate?.toString().split(" ")[0] ?? "Not selected"),
                _buildInfoRow("Departure:",
                    departureTime?.format(context) ?? "Not selected"),
                _buildInfoRow(
                    "Arrival:", arrivalTime?.format(context) ?? "Not selected"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitDeparture(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0d75b4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<TimeOfDay?> _pickTime() async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }
}
