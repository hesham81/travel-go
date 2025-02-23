import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';

class AddHotel {
  String name;
  String location;
  String price;
  List<String> amenities;
  File? image;

  AddHotel({
    required this.name,
    required this.location,
    required this.price,
    required this.amenities,
    this.image,
  });
}


class AdminHotelScreenAdd extends StatefulWidget {
  const AdminHotelScreenAdd({Key? key}) : super(key: key);

  @override
  State<AdminHotelScreenAdd> createState() => _AdminHotelScreenState();
}

class _AdminHotelScreenState extends State<AdminHotelScreenAdd> {
  final TextEditingController _hotelNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<String> selectedAmenities = [];
  List<String> amenities = ['Wi-Fi', 'Pool', 'Gym', 'Restaurant', 'Parking'];

  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveHotelData() {
    AddHotel newHotel = AddHotel(
      name: _hotelNameController.text,
      location: _locationController.text,
      price: _priceController.text,
      amenities: selectedAmenities,
      image: _imageFile,
    );

    print(
        "Hotel Data Saved: ${newHotel.name}, ${newHotel.location}, ${newHotel.price}, ${newHotel.amenities}, ${newHotel.image?.path ?? "No image"}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Hotel added successfully!",
              style: TextStyle(color: Colors.blue))),
    );
  }

  void _clearData() {
    setState(() {
      _hotelNameController.clear();
      _locationController.clear();
      _priceController.clear();
      selectedAmenities.clear();
      _imageFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
              Text("All data cleared", style: TextStyle(color: Colors.blue))),
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
        title: const Text("New Hotel",
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
                _buildTextField("Hotel Name", _hotelNameController),
                _buildTextField("Location", _locationController),
                _buildTextField("Price per Night", _priceController,
                    isNumber: true),
                const SizedBox(height: 16),
                const Text("Hotel Image",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: _imageFile == null
                        ? const Center(
                            child: Text("Tap to add image",
                                style: TextStyle(color: Colors.grey)))
                        : Image.file(_imageFile!, fit: BoxFit.cover),
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
                      value: selectedAmenities.contains(amenity),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedAmenities.add(amenity);
                          } else {
                            selectedAmenities.remove(amenity);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveHotelData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(200, 50),
                        ),
                        child: const Text("Save",
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    0.03.width.vSpace,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          minimumSize: const Size(200, 50),
                        ),
                        child: const Text("Cancel",
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
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

  Widget _buildTextField(String label, TextEditingController controller,
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
}
