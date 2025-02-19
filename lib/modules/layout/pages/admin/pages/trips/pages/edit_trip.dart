// import 'package:flutter/material.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:travel_go/core/extensions/align.dart';
// import 'package:travel_go/core/widget/loading_image_network_widget.dart';
// import '/core/extensions/extensions.dart';
// import '/core/utils/trip_db.dart';
// import '/core/widget/search_widget.dart';
// import '/core/theme/app_colors.dart';
// import '/models/trip.dart';
// import '../widget/trip_cart.dart';
//
// class EditTrip extends StatefulWidget {
//   const EditTrip({super.key});
//
//   @override
//   State<EditTrip> createState() => _EditTripState();
// }
//
// class _EditTripState extends State<EditTrip> {
//   TextEditingController searchController = TextEditingController();
//   final trip = Trip(
//     currency: "LE",
//     destination: "Cairo",
//     hotelId: "Hotel",
//     noOfDays: 10,
//     source: "Sharm",
//     id: "trip1232",
//     imageUrl:
//         "https://ulmlgjxomyybsvsjesuv.supabase.co/storage/v1/object/sign/trip/sharm/dahab.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0cmlwL3NoYXJtL2RhaGFiLnBuZyIsImlhdCI6MTczODYyMDMyMSwiZXhwIjoxNzcwMTU2MzIxfQ.OXBFOIOybFO9FQs19GLg0DYASGOetLwPqHhvox4Ovb8",
//     title: "Trip test123",
//     startDateTime: DateTime(2025, 10, 12),
//     endDateTime: DateTime(2025, 10, (12 + 10)),
//     price: 3200,
//   );
//   var trips = [];
//   var searchQueryText = "";
//   var searchTrip = [];
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: AppColors.primaryColor.withOpacity(0.8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Icon(
//           Icons.add,
//           color: AppColors.blackColor,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SafeArea(
//               child: SearchWidget(
//                 borderRadius: 10,
//                 controller: searchController,
//                 search: (value) {
//                   searchQueryText = searchController.text;
//                   searchTripList(searchQueryText);
//                   setState(() {});
//                   return null;
//                 },
//               ),
//             ),
//             0.01.height.hSpace,
//             StreamBuilder(
//               stream: TripDB.getStreamTripData(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData == false) {
//                   print("object");
//                   return Icon(
//                     Icons.data_exploration,
//                   );
//                 }
//                 snapshot.data!.docs.map(
//                   (element) {
//                     trips.add(element.data());
//                     print(element.data().source);
//                   },
//                 );
//                 print("Length ${trips.length}");
//
//                 return ListView.separated(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) => TripCart(
//                     model: trips[index],
//                   ),
//                   separatorBuilder: (context, _) => 0.01.height.hSpace,
//                   itemCount: trips.length,
//                 );
//               },
//             ),
//           ],
//         ),
//       ).allPadding(0.01.height),
//     );
//   }
//
//   void searchTripList(query) {
//     searchTrip.clear();
//     for (Trip trip in trips) {
//       if (trip.title.toLowerCase().contains(searchQueryText.toLowerCase())) {
//         searchTrip.add(trip);
//       } else if (trip.noOfDays.toString() == (searchQueryText)) {
//         searchTrip.add(trip);
//       } else if (trip.price
//           .toString()
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchTrip.add(trip);
//       } else if (trip.destination
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchTrip.add(trip);
//       } else if (trip.source
//           .toLowerCase()
//           .contains(searchQueryText.toLowerCase())) {
//         searchTrip.add(trip);
//       } else if (trip.startDateTime.year.toString() == (searchQueryText)) {
//         searchTrip.add(trip);
//       } else if (trip.startDateTime.month.toString() == (searchQueryText)) {
//         searchTrip.add(trip);
//       } else if (trip.currency.toLowerCase() ==
//           (searchQueryText.toLowerCase())) {
//         searchTrip.add(trip);
//       }
//     }
//     setState(() {});
//   }
// }
import 'package:flutter/material.dart';

class Trip {
  String id;
  String imageUrl;
  String title;
  DateTime startDateTime;
  DateTime endDateTime;
  double price;
  String currency;
  String destination;
  int noOfDays;
  String source;
  String companyName;
  List<String> flights;
  List<String> attractions;
  List<String> hotels;

  Trip({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    required this.price,
    this.currency = "LE",
    required this.destination,
    required this.noOfDays,
    required this.source,
    required this.companyName,
    required this.flights,
    required this.attractions,
    required this.hotels,
  });
}

class EditTrip extends StatefulWidget {
  const EditTrip({super.key});

  @override
  _EditTripScreenState createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTrip> {
  List<Trip> trips = [
    Trip(
      id: "trip1232",
      imageUrl:
          "https://www.cashe.co.in/wp-content/uploads/2024/12/How-to-Budget-a-family-trip.png",
      title: "Trip to Dahab",
      startDateTime: DateTime(2025, 10, 12),
      endDateTime: DateTime(2025, 10, 22),
      price: 3200,
      destination: "Dahab",
      noOfDays: 10,
      source: "Sharm",
      companyName: "Travel World Agency",
      flights: ["Flight 1: Cairo to Dahab", "Flight 2: Sharm to Dahab"],
      attractions: ["Dahab Beach", "Mount Sinai"],
      hotels: ["Dahab Resort", "Sinai Bay Hotel"],
    ),
  ];

  void _addNewTrip() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController destinationController = TextEditingController();
    final TextEditingController sourceController = TextEditingController();
    final TextEditingController daysController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController companyController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add New Trip'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Trip Name'),
                ),
                TextField(
                  controller: destinationController,
                  decoration: const InputDecoration(labelText: 'Destination'),
                ),
                TextField(
                  controller: sourceController,
                  decoration: const InputDecoration(labelText: 'Source'),
                ),
                TextField(
                  controller: daysController,
                  decoration:
                      const InputDecoration(labelText: 'Number of Days'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Organized by'),
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  trips.add(
                    Trip(
                      id: DateTime.now().toString(),
                      imageUrl: imageUrlController.text,
                      title: titleController.text,
                      startDateTime: DateTime.now(),
                      endDateTime: DateTime.now().add(const Duration(days: 5)),
                      price: double.tryParse(priceController.text) ?? 0,
                      destination: destinationController.text,
                      noOfDays: int.tryParse(daysController.text) ?? 0,
                      source: sourceController.text,
                      companyName: companyController.text,
                      flights: [],
                      attractions: [],
                      hotels: [],
                    ),
                  );
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Add Trip'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return TripCard(
              trip: trips[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SelectedTripScreen(trip: trips[index]),
                  ),
                );
              },
              onEdit: () {
                _showEditTripDialog(context, trips[index]);
              },
              onDelete: () {
                _deleteTrip(context, index);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTrip,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditTripDialog(BuildContext context, Trip trip) {
    final TextEditingController titleController =
        TextEditingController(text: trip.title);
    final TextEditingController destinationController =
        TextEditingController(text: trip.destination);
    final TextEditingController sourceController =
        TextEditingController(text: trip.source);
    final TextEditingController daysController =
        TextEditingController(text: trip.noOfDays.toString());
    final TextEditingController priceController =
        TextEditingController(text: trip.price.toString());
    final TextEditingController companyController =
        TextEditingController(text: trip.companyName);
    final TextEditingController imageUrlController =
        TextEditingController(text: trip.imageUrl);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Trip Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Trip Name'),
                ),
                TextField(
                  controller: destinationController,
                  decoration: const InputDecoration(labelText: 'Destination'),
                ),
                TextField(
                  controller: sourceController,
                  decoration: const InputDecoration(labelText: 'Source'),
                ),
                TextField(
                  controller: daysController,
                  decoration:
                      const InputDecoration(labelText: 'Number of Days'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Organized by'),
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                trip.title = titleController.text;
                trip.destination = destinationController.text;
                trip.source = sourceController.text;
                trip.noOfDays = int.tryParse(daysController.text) ?? 0;
                trip.price = double.tryParse(priceController.text) ?? 0;
                trip.companyName = companyController.text;
                Navigator.of(ctx).pop();
              },
              child: const Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTrip(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Trip'),
          content: const Text('Are you sure you want to delete this trip?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  trips.removeAt(index);
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Image.network(trip.imageUrl, width: 50, fit: BoxFit.cover),
          title: Text(trip.title),
          subtitle: Text("Duration: ${trip.noOfDays} days"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedTripScreen extends StatefulWidget {
  final Trip trip;

  const SelectedTripScreen({super.key, required this.trip});

  @override
  _SelectedTripScreenState createState() => _SelectedTripScreenState();
}

class _SelectedTripScreenState extends State<SelectedTripScreen> {
  bool _isFlightsExpanded = false;
  bool _isAttractionsExpanded = false;
  bool _isHotelsExpanded = false;

  void _addItem(BuildContext context, String section) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Item'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (section == 'flights') {
                    widget.trip.flights.add(controller.text);
                  } else if (section == 'attractions') {
                    widget.trip.attractions.add(controller.text);
                  } else if (section == 'hotels') {
                    widget.trip.hotels.add(controller.text);
                  }
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editItem(BuildContext context, String section, int index) {
    final TextEditingController controller = TextEditingController(
        text: section == 'flights'
            ? widget.trip.flights[index]
            : section == 'attractions'
                ? widget.trip.attractions[index]
                : widget.trip.hotels[index]);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Edit Item'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (section == 'flights') {
                    widget.trip.flights[index] = controller.text;
                  } else if (section == 'attractions') {
                    widget.trip.attractions[index] = controller.text;
                  } else if (section == 'hotels') {
                    widget.trip.hotels[index] = controller.text;
                  }
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(BuildContext context, String section, int index) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (section == 'flights') {
                    widget.trip.flights.removeAt(index);
                  } else if (section == 'attractions') {
                    widget.trip.attractions.removeAt(index);
                  } else if (section == 'hotels') {
                    widget.trip.hotels.removeAt(index);
                  }
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.trip.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.network(widget.trip.imageUrl),
            const SizedBox(height: 8.0),
            Text("Destination: ${widget.trip.destination}"),
            Text("Source: ${widget.trip.source}"),
            Text("Days: ${widget.trip.noOfDays}"),
            Text("Price: ${widget.trip.price} ${widget.trip.currency}"),
            Text("Organized by: ${widget.trip.companyName}"),
            const SizedBox(height: 16.0),
            ExpansionTile(
              title: const Text("Flights"),
              trailing: Icon(
                  _isFlightsExpanded ? Icons.expand_less : Icons.expand_more),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isFlightsExpanded = expanded;
                });
              },
              children: widget.trip.flights
                  .map((flight) => ListTile(
                        title: Text(flight),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editItem(context, 'flights',
                                    widget.trip.flights.indexOf(flight));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteItem(context, 'flights',
                                    widget.trip.flights.indexOf(flight));
                              },
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            ListTile(
              title: const Text('Add Flight'),
              trailing: const Icon(Icons.add),
              onTap: () {
                _addItem(context, 'flights');
              },
            ),
            const SizedBox(height: 16.0),
            ExpansionTile(
              title: const Text("Attractions"),
              trailing: Icon(_isAttractionsExpanded
                  ? Icons.expand_less
                  : Icons.expand_more),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isAttractionsExpanded = expanded;
                });
              },
              children: widget.trip.attractions
                  .map((attraction) => ListTile(
                        title: Text(attraction),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editItem(
                                    context,
                                    'attractions',
                                    widget.trip.attractions
                                        .indexOf(attraction));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteItem(
                                    context,
                                    'attractions',
                                    widget.trip.attractions
                                        .indexOf(attraction));
                              },
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            ListTile(
              title: const Text('Add Attraction'),
              trailing: const Icon(Icons.add),
              onTap: () {
                _addItem(context, 'attractions');
              },
            ),
            const SizedBox(height: 16.0),
            ExpansionTile(
              title: const Text("Hotels"),
              trailing: Icon(
                  _isHotelsExpanded ? Icons.expand_less : Icons.expand_more),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isHotelsExpanded = expanded;
                });
              },
              children: widget.trip.hotels
                  .map((hotel) => ListTile(
                        title: Text(hotel),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _editItem(context, 'hotels',
                                    widget.trip.hotels.indexOf(hotel));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteItem(context, 'hotels',
                                    widget.trip.hotels.indexOf(hotel));
                              },
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            ListTile(
              title: const Text('Add Hotel'),
              trailing: const Icon(Icons.add),
              onTap: () {
                _addItem(context, 'hotels');
              },
            ),
          ],
        ),
      ),
    );
  }
}
