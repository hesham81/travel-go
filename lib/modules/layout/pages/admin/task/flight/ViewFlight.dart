import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/core/theme/app_colors.dart';
import '/models/flight_airlines.dart';
import "flight_card.dart";

class ViewFlights extends StatefulWidget {
  final FlightAirlines airline;

  const ViewFlights({
    super.key,
    required this.airline,
  });

  @override
  State<ViewFlights> createState() => _ViewFlightsState();
}

class _ViewFlightsState extends State<ViewFlights> {
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  Map<String, bool> airlines = {
    "Air Canada": false,
    "WestJe": false,
    "Porter Airlines": false,
    "Air Transat": false,
  };
  final List<Map<String, String>> flights = [
    {
      "destination": "Sharm el sheikh",
      "date": "26/2/2025",
      "time": "8:00 am",
      "price": "3,000 L.E",
      "class": "Economy"
    },
    {
      "destination": "Cairo",
      "date": "27/2/2025",
      "time": "9:00 am",
      "price": "6,000 L.E",
      "class": "First class"
    },
    {
      "destination": "Alexandria",
      "date": "27/2/2025",
      "time": "10:30 am",
      "price": "6,000 L.E",
      "class": "First class"
    },
  ];
  String selectedDestination = "Vancouver";

  DateTime? selectedStartDate;

  String selectedDepartureTime = "Any Time";

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filters",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),

                    SizedBox(height: 20),

                    _priceFilter(),
                    Divider(),
                    _airlinesFilter(setModalState), // FIXED
                    Divider(),
                    _startDateFilter(),
                    Divider(),
                    _departureTimeFilter(),
                    Divider(),
                    _destinationFilter(),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              setModalState(() {
                                // Reset all filters to default values
                                minPriceController.clear();
                                maxPriceController.clear();
                                airlines.updateAll((key, value) => false);
                                selectedStartDate = null;
                                selectedDepartureTime = "Any Time";
                                selectedDestination = "Vancouver";
                              });
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.grey[300]),
                            child: Text("Reset",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Collect the selected airlines
                              List<String> selectedAirlines = airlines.entries
                                  .where((entry) => entry.value == true)
                                  .map((entry) => entry.key)
                                  .toList();

                              // Prepare filter data to send to the database
                              Map<String, dynamic> filterData = {
                                "min_price": minPriceController.text.isEmpty
                                    ? null
                                    : int.parse(minPriceController.text),
                                "max_price": maxPriceController.text.isEmpty
                                    ? null
                                    : int.parse(maxPriceController.text),
                                "selected_airlines": selectedAirlines,
                                "start_date": selectedStartDate != null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(selectedStartDate!)
                                    : null,
                                "departure_time":
                                    selectedDepartureTime == "Any Time"
                                        ? null
                                        : selectedDepartureTime,
                                "destination": selectedDestination,
                              };

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff0d75b4)),
                            child: Text(
                              "Show Flights",
                              style: TextStyle(
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
            );
          },
        );
      },
    );
  }

  Widget _priceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price Range (CAD)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Min Price", border: OutlineInputBorder()),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Max Price", border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _airlinesFilter(Function setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Airlines",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Column(
          children: airlines.keys.map((airline) {
            return CheckboxListTile(
              title: Text(airline),
              value: airlines[airline],
              onChanged: (value) {
                setModalState(() {
                  airlines[airline] = value!;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _startDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Start Date",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              setState(() {
                selectedStartDate = pickedDate;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              selectedStartDate == null
                  ? "Select Date"
                  : DateFormat.yMMMd().format(selectedStartDate!),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _departureTimeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Departure Time",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                selectedDepartureTime = pickedTime.format(context);
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              selectedDepartureTime == "Any Time"
                  ? "Select Time"
                  : selectedDepartureTime,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _destinationFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Destination",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedDestination,
          items: ["Vancouver", "Montreal", "Calgary", "Ottawa"]
              .map((city) => DropdownMenuItem(value: city, child: Text(city)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedDestination = value!;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.airline.flighAirLineName,
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Flights",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.newBlueColor,
              ),
            ),
            SizedBox(
              height: 33,
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xff0d75b4)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // Border when not focused
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff0d75b4), // Custom color
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Border when focused
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xff0d75b4), // Same color as enabled
                        width: 2,
                      ),
                    ),
                  ),
                )),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(
                    Icons.filter_list_alt,
                    size: 40,
                    color: Color(0xff0d75b4),
                  ),
                  onPressed: () {
                    _showFilters();
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];
                  return FlightCard(
                    destination: flight["destination"]!,
                    date: flight["date"]!,
                    time: flight["time"]!,
                    price: flight["price"]!,
                    flightClass: flight["class"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
