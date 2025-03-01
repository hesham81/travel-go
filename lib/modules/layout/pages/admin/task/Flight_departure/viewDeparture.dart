import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/task/adminscreen.dart';

class ViewFlightDepartureScreen extends StatefulWidget {
  final String sourceCountry;
  final String destinationCountry;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay departureTime;
  final TimeOfDay arrivalTime;

  ViewFlightDepartureScreen({
    required this.sourceCountry,
    required this.destinationCountry,
    required this.startDate,
    required this.endDate,
    required this.departureTime,
    required this.arrivalTime,
  });

  @override
  _ViewFlightDepartureScreenState createState() =>
      _ViewFlightDepartureScreenState();
}

class _ViewFlightDepartureScreenState extends State<ViewFlightDepartureScreen> {
  late String sourceCountry;
  late String destinationCountry;
  late DateTime startDate;
  late DateTime endDate;
  late TimeOfDay departureTime;
  late TimeOfDay arrivalTime;

  @override
  void initState() {
    super.initState();
    sourceCountry = widget.sourceCountry;
    destinationCountry = widget.destinationCountry;
    startDate = widget.startDate;
    endDate = widget.endDate;
    departureTime = widget.departureTime;
    arrivalTime = widget.arrivalTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0d75b4),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          "Tour And Travel",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
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
                "View Flight Departure Details",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0d75b4)),
              ),
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Airline",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff0d75b4),
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("EgyptAir",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                ),
                SizedBox(height: 16),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Flight ID",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff0d75b4),
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("#1858",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                ),
                SizedBox(height: 16),
              ],
            ),
            _buildPickerField("Source", sourceCountry, () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  setState(() => sourceCountry = country.name);
                },
              );
            }),
            _buildPickerField("Destination", destinationCountry, () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  setState(() => destinationCountry = country.name);
                },
              );
            }),
            _buildPickerField("Start Date", startDate.toString().split(" ")[0],
                () async {
              DateTime? date = await _pickDate();
              if (date != null) setState(() => startDate = date);
            }),
            _buildPickerField("End Date", endDate.toString().split(" ")[0],
                () async {
              DateTime? date = await _pickDate();
              if (date != null) setState(() => endDate = date);
            }),
            _buildPickerField("Departure Time", departureTime.format(context),
                () async {
              TimeOfDay? time = await _pickTime();
              if (time != null) setState(() => departureTime = time);
            }),
            _buildPickerField("Arrival Time", arrivalTime.format(context),
                () async {
              TimeOfDay? time = await _pickTime();
              if (time != null) setState(() => arrivalTime = time);
            }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _validateAndProceed() {
    if (sourceCountry.isEmpty ||
        destinationCountry.isEmpty ||
        startDate == null ||
        endDate == null ||
        departureTime == null ||
        arrivalTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all fields."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      _showMiniCard();
    }
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Flight Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0d75b4))),
                Divider(),
                _buildInfoRow("From:", sourceCountry),
                _buildInfoRow("To:", destinationCountry),
                _buildInfoRow(
                    "Start Date:", startDate.toString().split(" ")[0]),
                _buildInfoRow("End Date:", endDate.toString().split(" ")[0]),
                _buildInfoRow("Departure:", departureTime.format(context)),
                _buildInfoRow("Arrival:", arrivalTime.format(context)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminHome())),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0d75b4)),
                  child: Text("Save", style: TextStyle(color: Colors.white)),
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
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
