import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/updateflight.dart';

import '../pages/admin_home.dart';

class FlightDepartureUpdate extends StatefulWidget {
  @override
  _FlightDepartureUpdateState createState() => _FlightDepartureUpdateState();
}

class _FlightDepartureUpdateState extends State<FlightDepartureUpdate> {
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
        leading: Icon(Icons.arrow_back_ios, color: Color(0xff0d75b4)),
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
                "Update Flight Departure",
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Updateflight(),
                        ),
                      );
                    },
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
                      "OK",
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
                  "Flight Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0d75b4)),
                ),
                Divider(),
                SizedBox(height: 10),
                _buildInfoRow("From:", sourceCountry ?? "Not selected"),
                _buildInfoRow("To:", destinationCountry ?? "Not selected"),
                _buildInfoRow("Start Date:", startDate?.toString().split(" ")[0] ?? "Not selected"),
                _buildInfoRow("End Date:", endDate?.toString().split(" ")[0] ?? "Not selected"),
                _buildInfoRow("Departure:", departureTime?.format(context) ?? "Not selected"),
                _buildInfoRow("Arrival:", arrivalTime?.format(context) ?? "Not selected"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminHome(),
                      ),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0d75b4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Save Changes", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }
}