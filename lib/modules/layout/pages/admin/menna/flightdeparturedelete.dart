import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../pages/admin_home.dart';

class FlightDepartureDelete extends StatefulWidget {

  @override
  _FlightDepartureDeleteState createState() => _FlightDepartureDeleteState();
}

class _FlightDepartureDeleteState extends State<FlightDepartureDelete> {
  String? sourceCountry;
  String? destinationCountry;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? departureTime;
  TimeOfDay? arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff0d75b4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Travel Go",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff0d75b4),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Delete Flight Departure",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d75b4),
                ),
              ),
            ),
            SizedBox(height: 15),
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
            _buildPickerField("Start Date", startDate?.toString().split(" ")[0], () async {
              DateTime? date = await _pickDate();
              if (date != null) setState(() => startDate = date);
            }),
            _buildPickerField("End Date", endDate?.toString().split(" ")[0], () async {
              DateTime? date = await _pickDate();
              if (date != null) setState(() => endDate = date);
            }),
            _buildPickerField("Departure Time", departureTime != null ? departureTime!.format(context) : null, () async {
              TimeOfDay? time = await _pickTime();
              if (time != null) setState(() => departureTime = time);
            }),
            _buildPickerField("Arrival Time", arrivalTime != null ? arrivalTime!.format(context) : null, () async {
              TimeOfDay? time = await _pickTime();
              if (time != null) setState(() => arrivalTime = time);
            }),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0d75b4),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showMiniCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Delete",
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
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Color(0xff0d75b4), fontWeight: FontWeight.bold),
        ),
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
                  "Delete Flight?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                Divider(),
                SizedBox(height: 10),
                Text(
                  "Are you sure you want to delete this flight?",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel", style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>AdminHome(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0d75b4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Ok", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}