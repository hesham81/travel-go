import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateHotel {
  String location;
  String price;
  String currency;
  List<String> selectedAmenities;
  File? imageFile;

  UpdateHotel({
    required this.location,
    required this.price,
    this.currency = "USD",
    this.selectedAmenities = const ['Wi-Fi', 'Pool'],
    this.imageFile,
  });
}

class AdminHotelScreenUpdate extends StatefulWidget {
  const AdminHotelScreenUpdate({Key? key}) : super(key: key);

  @override
  State<AdminHotelScreenUpdate> createState() => _AdminHotelScreenUpdateState();
}

class _AdminHotelScreenUpdateState extends State<AdminHotelScreenUpdate> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  UpdateHotel hotel = UpdateHotel(location: "Elmamsha, Dahab", price: "4500");

  List<String> amenities = ['Wi-Fi', 'Pool', 'Gym', 'Restaurant', 'Parking'];

  @override
  void initState() {
    super.initState();
    _locationController.text = hotel.location;
    _priceController.text = hotel.price;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        hotel.imageFile = File(pickedFile.path);
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Update"),
          content:
              const Text("Are you sure you want to update the hotel data?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveUpdatedData();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Yes, Update"),
            ),
          ],
        );
      },
    );
  }

  void _saveUpdatedData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Hotel updated successfully!",
              style: TextStyle(color: Colors.white))),
    );
  }

  void _cancelUpdates() {
    setState(() {
      _locationController.text = hotel.location;
      _priceController.text = hotel.price;
      hotel.selectedAmenities = ['Wi-Fi', 'Pool'];
      hotel.imageFile = null;
      hotel.currency = "USD";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
              Text("Changes reverted.", style: TextStyle(color: Colors.white))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text("Update Hotel",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nasema",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
                const SizedBox(height: 16),
                buildTextField("Location", _locationController),
                buildPriceField(),
                const SizedBox(height: 16),
                const Text("Hotel Image",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: hotel.imageFile == null
                        ? const Center(
                            child: Text("Tap to add image",
                                style: TextStyle(color: Colors.grey)))
                        : Image.file(hotel.imageFile!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text("Amenities",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  children: amenities.map((amenity) {
                    return CheckboxListTile(
                      title: Text(amenity),
                      value: hotel.selectedAmenities.contains(amenity),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            hotel.selectedAmenities.add(amenity);
                          } else {
                            hotel.selectedAmenities.remove(amenity);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _showConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(150, 50)),
                      child: const Text("Save",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: _cancelUpdates,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(150, 50)),
                      child: const Text("Cancel",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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

  Widget buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildPriceField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price per Night (${hotel.currency})",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          DropdownButton<String>(
            value: hotel.currency,
            onChanged: (String? newValue) {
              setState(() {
                hotel.currency = newValue!;
              });
            },
            items: ["EGP", "USD", "EUR"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
