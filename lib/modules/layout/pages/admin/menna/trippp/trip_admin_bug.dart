import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class Tripppp {
  String id;
  String name;
  String organizedBy;
  String source;
  String destination;
  int days;
  String imageUrl;
  double price;
  String? program;
  String? hotel;
  String? flight;

  Tripppp({
    required this.id,
    required this.name,
    required this.organizedBy,
    required this.source,
    required this.destination,
    required this.days,
    required this.imageUrl,
    required this.price,
    this.program,
    this.hotel,
    this.flight,
  });
}

class NewTripScreen extends StatefulWidget {
  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final _formKey = GlobalKey<FormState>();
  static int _idCounter = 1;
  List<Tripppp> trips = [
    Tripppp(
      id: "T001",
      name: "Paris Getaway",
      organizedBy: "Global Travels",
      source: "New York, USA",
      destination: "Paris, France",
      days: 7,
      imageUrl:
          "https://i.pinimg.com/originals/ae/3d/2a/ae3d2a2bca16a845ae196dfedf1a17a7.jpg",
      price: 2500.00,
      hotel: "Eiffel Grand Hotel",
      flight: "Air France",
    ),
    Tripppp(
      id: "T002",
      name: "Tokyo Adventure",
      organizedBy: "Explore Japan",
      source: "Los Angeles, USA",
      destination: "Tokyo, Japan",
      days: 12,
      imageUrl:
          "https://i.pinimg.com/originals/a8/9e/48/a89e48d3bfa44e3832736fd72a6d612b.jpg",
      price: 3200.00,
      flight: "Japan Airlines",
    ),
    Tripppp(
      id: "T003",
      name: "Bali Retreat",
      organizedBy: "Paradise Travels",
      source: "Sydney, Australia",
      destination: "Bali, Indonesia",
      days: 7,
      imageUrl:
          "https://i.pinimg.com/originals/2c/b7/3f/2cb73ffba2e0846ec374b021c7fbc49b.jpg",
      price: 2100.00,
      hotel: "Bali Beach Resort",
      flight: "Garuda Indonesia",
    ),
  ];
  final List<String> hotels = [
    "Eiffel Grand Hotel",
    "Tokyo Grand Hotel",
    "Bali Beach Resort",
    "New York Plaza",
    "Sydney Luxury Inn",
    "Dubai Palace",
  ];
  int numOfDays = 0;

  final List<String> flights = [
    "Air France",
    "Japan Airlines",
    "Garuda Indonesia",
    "Emirates",
    "Qatar Airways",
    "Singapore Airlines",
  ];

  final nameController = TextEditingController();
  final organizedByController = TextEditingController();
  final sourceController = TextEditingController();
  final destinationController = TextEditingController();
  final daysController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();
  final programs = [
    "Safari",
    "Beach",
    "City",
    "Camping",
    "Adventure",
    "Historical",
    "Relaxation",
  ];
  String? selectedProgram;
  String? selectedHotel;
  String? selectedFlight;
  Tripppp? selectedTrip;

  String? tempProgram;
  String? tempHotel;
  String? tempFlight;

  void _addTrip() {
    if (_formKey.currentState?.validate() ?? false) {
      String id = 'T${_idCounter++}';

      Tripppp newTrip = Tripppp(
        id: id,
        name: nameController.text,
        organizedBy: organizedByController.text,
        source: sourceController.text,
        destination: destinationController.text,
        days: int.parse(daysController.text),
        imageUrl: imageUrlController.text,
        price: double.parse(priceController.text),
        program: tempProgram,
        hotel: tempHotel,
        flight: tempFlight,
      );

      setState(() {
        trips.add(newTrip);
      });

      _clearTemporaryData();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrowseTripScreen(trips: trips),
        ),
      );
    }
  }

  void _clearTemporaryData() {
    setState(() {
      nameController.clear();
      organizedByController.clear();
      sourceController.clear();
      destinationController.clear();
      daysController.clear();
      imageUrlController.clear();
      priceController.clear();
      tempProgram = null;
      tempHotel = null;
      tempFlight = null;
    });
  }

  void _editDetails(String type) {
    if (type == 'New Program') {
      _showProgramDialog();
    } else if (type == 'Assign Hotel') {
      _showDialog('Enter Hotel', (value) {
        setState(() {
          tempHotel = value;
        });
      });
    } else if (type == 'Assign Flight') {
      _showDialog('Enter Flight', (value) {
        setState(() {
          tempFlight = value;
        });
      });
    }
  }

  void _showDialog(String title, Function(String) onSave) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter details here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showProgramDialog() {
    int days = int.tryParse(daysController.text) ?? 0;
    if (days <= 0) {
      return;
    }

    List<TextEditingController> dayControllers =
        List.generate(days, (index) => TextEditingController());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Program Line'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Program Line:'),
                for (int i = 0; i < days; i++)
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Day ${i + 1}:'),
                        SizedBox(height: 4),
                        TextField(
                          controller: dayControllers[i],
                          decoration: InputDecoration(
                              hintText: 'Enter attractions for Day ${i + 1}'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tempProgram = dayControllers
                      .map((controller) => controller.text)
                      .join(', ');
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              // Close the dialog without saving
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Trip'),
        backgroundColor: Color(0xFF0d75b4),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the trip name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: organizedByController,
                      decoration: InputDecoration(labelText: 'Organized By'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the organizer';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: sourceController,
                      decoration: InputDecoration(labelText: 'Source'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the source';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: destinationController,
                      decoration: InputDecoration(labelText: 'Destination'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the destination';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: daysController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(labelText: 'Number of Days'),
                      onChanged: (value) {
                        numOfDays = int.tryParse(value) ?? 0;
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of days';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number of days';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: imageUrlController,
                      decoration: InputDecoration(labelText: 'Image URL'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the image URL';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Assign Flight"),
                  value: selectedFlight,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFlight = newValue;
                    });
                  },
                  items: flights.map((String program) {
                    return DropdownMenuItem<String>(
                      value: program,
                      child: Text(program),
                    );
                  }).toList(),
                ),
              ),
              0.02.height.hSpace,
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Assign Hotel"),
                  value: selectedHotel,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedHotel = newValue;
                    });
                  },
                  items: hotels.map((String program) {
                    return DropdownMenuItem<String>(
                      value: program,
                      child: Text(program),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: numOfDays != 0,
                replacement: SizedBox(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    numOfDays = int.tryParse(daysController.text)!;
                    int newIndex = index;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text("Day ${index + 1}"),
                        value: selectedFlight,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProgram = newValue;
                          });
                        },
                        items: programs.map((String program) {
                          return DropdownMenuItem<String>(
                            value: program,
                            child: Text(program),
                          );
                        }).toList(),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: numOfDays ?? 1,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addTrip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0d75b4),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('OK'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _clearTemporaryData(); // Clear any temporary data
                      Navigator.pop(context); // Navigate back
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0d75b4),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BrowseTripScreen extends StatefulWidget {
  final List<Tripppp> trips;

  BrowseTripScreen({required this.trips});

  @override
  _BrowseTripScreenState createState() => _BrowseTripScreenState();
}

class _BrowseTripScreenState extends State<BrowseTripScreen> {
  void _deleteTrip(String id) {
    Tripppp tripToDelete = widget.trips.firstWhere((trip) => trip.id == id);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Are you sure you want to delete this trip?'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${tripToDelete.id}',
                style: TextStyle(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                'Name: ${tripToDelete.name}',
                style: TextStyle(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                'Organized by: ${tripToDelete.organizedBy}',
                style: TextStyle(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                'Source: ${tripToDelete.source}',
                style: TextStyle(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                'Destination: ${tripToDelete.destination}',
                style: TextStyle(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                'Price: \$${tripToDelete.price}',
                style: TextStyle(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.trips.removeWhere((trip) => trip.id == id);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _editTrip(Tripppp trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTripScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Travel Go',
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: Color(0xFF0d75b4),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.trips.length,
          itemBuilder: (context, index) {
            Tripppp trip = widget.trips[index];
            return InkWell(
              onTap: () {
                // Navigate to trip details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetailsScreen(trip: trip),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.network(trip.imageUrl,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(trip.name),
                  subtitle:
                      Text('ID: ${trip.id}\nOrganized by: ${trip.organizedBy}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateTrip(
                              tripModel: trip,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTrip(trip.id),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TripDetailsScreen extends StatelessWidget {
  final Tripppp trip;

  TripDetailsScreen({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trip.name),
        backgroundColor: Color(0xFF0d75b4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(trip.imageUrl),
            SizedBox(height: 16),
            Text('ID: ${trip.id}'),
            Text('Name: ${trip.name}'),
            Text('Organized by: ${trip.organizedBy}'),
            Text('Source: ${trip.source}'),
            Text('Destination: ${trip.destination}'),
            Text('Days: ${trip.days}'),
            Text('Price: \$${trip.price}'),
            if (trip.program != null) ...[
              SizedBox(height: 16),
              Text('Program: ${trip.program}'),
            ],
            if (trip.hotel != null) ...[
              SizedBox(height: 16),
              Text('Hotel: ${trip.hotel}'),
            ],
            if (trip.flight != null) ...[
              SizedBox(height: 16),
              Text('Flight: ${trip.flight}'),
            ],
          ],
        ),
      ),
    );
  }
}

class UpdateTrip extends StatefulWidget {
  final Tripppp tripModel;

  const UpdateTrip({
    super.key,
    required this.tripModel,
  });

  @override
  State<UpdateTrip> createState() => _UpdateTripState();
}

class _UpdateTripState extends State<UpdateTrip> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final organizedByController = TextEditingController();
  final sourceController = TextEditingController();
  final destinationController = TextEditingController();
  final daysController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();
  final programs = [
    "Safari",
    "Beach",
    "City",
    "Camping",
    "Adventure",
    "Historical",
    "Relaxation",
  ];
  int numOfDays = 0;
  String? selectedProgram;
  String? selectedHotel;
  String? selectedFlight;
  Tripppp? selectedTrip;

  String? tempProgram;
  String? tempHotel;
  String? tempFlight;

  List<Tripppp> trips = [
    Tripppp(
      id: "T001",
      name: "Paris Getaway",
      organizedBy: "Global Travels",
      source: "New York, USA",
      destination: "Paris, France",
      days: 7,
      imageUrl:
          "https://i.pinimg.com/474x/fa/95/98/fa95986f2c408098531ca7cc78aee3a4.jpg",
      price: 2500.00,
      hotel: "Eiffel Grand Hotel",
      flight: "Air France",
    ),
    Tripppp(
      id: "T002",
      name: "Tokyo Adventure",
      organizedBy: "Explore Japan",
      source: "Los Angeles, USA",
      destination: "Tokyo, Japan",
      days: 12,
      imageUrl:
          "https://i.pinimg.com/474x/dc/12/01/dc12011c464a71a27804617a107135e0.jpg",
      price: 3200.00,
      flight: "Japan Airlines",
    ),
    Tripppp(
      id: "T003",
      name: "Bali Retreat",
      organizedBy: "Paradise Travels",
      source: "Sydney, Australia",
      destination: "Bali, Indonesia",
      days: 7,
      imageUrl:
          "https://i.pinimg.com/474x/eb/40/44/eb40447e0413f2a4ee29ffaa81df012b.jpg",
      price: 2100.00,
      hotel: "Bali Beach Resort",
      flight: "Garuda Indonesia",
    ),
  ];
  final List<String> hotels = [
    "Eiffel Grand Hotel",
    "Tokyo Grand Hotel",
    "Bali Beach Resort",
    "New York Plaza",
    "Sydney Luxury Inn",
    "Dubai Palace",
  ];

  final List<String> flights = [
    "Air France",
    "Japan Airlines",
    "Garuda Indonesia",
    "Emirates",
    "Qatar Airways",
    "Singapore Airlines",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update  Trip ${widget.tripModel.id}'),
        backgroundColor: Color(0xFF0d75b4),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration:
                          InputDecoration(labelText: widget.tripModel.name),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the trip name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: organizedByController,
                      decoration: InputDecoration(
                          labelText: widget.tripModel.organizedBy),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the organizer';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: sourceController,
                      decoration:
                          InputDecoration(labelText: widget.tripModel.source),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the source';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: destinationController,
                      decoration: InputDecoration(
                          labelText: widget.tripModel.destination),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the destination';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: daysController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          labelText: "${widget.tripModel.days} Day"),
                      onChanged: (value) {
                        numOfDays = int.tryParse(value) ?? 0;
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of days';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number of days';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: imageUrlController,
                      decoration:
                          InputDecoration(labelText: widget.tripModel.imageUrl),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the image URL';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: widget.tripModel.price.toString()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Assign Flight"),
                  value: selectedFlight,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFlight = newValue;
                    });
                  },
                  items: flights.map((String program) {
                    return DropdownMenuItem<String>(
                      value: program,
                      child: Text(program),
                    );
                  }).toList(),
                ),
              ),
              0.02.height.hSpace,
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Assign Hotel"),
                  value: selectedHotel,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedHotel = newValue;
                    });
                  },
                  items: hotels.map((String program) {
                    return DropdownMenuItem<String>(
                      value: program,
                      child: Text(program),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: numOfDays != 0,
                replacement: SizedBox(),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    numOfDays = int.tryParse(daysController.text)!;
                    int newIndex = index;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text("Day ${index + 1}"),
                        value: selectedFlight,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProgram = newValue;
                          });
                        },
                        items: programs.map((String program) {
                          return DropdownMenuItem<String>(
                            value: program,
                            child: Text(program),
                          );
                        }).toList(),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: numOfDays ?? 1,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0d75b4),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('OK'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate back
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0d75b4),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
