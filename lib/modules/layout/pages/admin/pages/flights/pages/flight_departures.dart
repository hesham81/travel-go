import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class FlightDepartureScreen extends StatefulWidget {
  @override
  _FlightDepartureScreenState createState() => _FlightDepartureScreenState();
}

class _FlightDepartureScreenState extends State<FlightDepartureScreen> {
  String? sourceCountry;
  String? destinationCountry;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? departureTime;
  TimeOfDay? arrivalTime;

  /*Departures flightdep = Departures (
      startDate :
       endDate :
       source :
       destination :
       hours:
       minutes:
  );
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: Text(
          "Flight Departure",
          style: TextStyle(
            fontSize: 28,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),),
      body: SingleChildScrollView(  // Add this widget to make the content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPickerField("Source", sourceCountry, () {
              showCountryPicker(
                context: context,
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
                onSelect: (Country country) {
                  setState(() {
                    destinationCountry = country.name;
                  });
                },
              );
            }),
            _buildPickerField("Start Date", startDate?.toString().split(" ")[0], () {
              _pickDate().then((date) {
                setState(() => startDate = date);
              });
            }),
            _buildPickerField("End Date", endDate?.toString().split(" ")[0], () {
              _pickDate().then((date) {
                setState(() => endDate = date);
              });
            }),
            _buildPickerField("Departure Time", departureTime?.format(context), () {
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
            InkWell(
              onTap: (){},
              child: Center(
                child: Container(
                  height: 43,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent,
                  ),
                  child:  Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: "Poppins-SemiBold",
                        color: Color(0XffF273236),
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
              ),
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
        Text(title, style: TextStyle(fontSize: 16,
            color:  Colors.blueAccent,
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
            child: Text(value ?? "Select $title", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          ),
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

  Future<TimeOfDay?> _pickTime() async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}