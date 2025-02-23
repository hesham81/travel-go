import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:travel_go/core/theme/app_colors.dart';


class DeleteHotel {
  final String name;
  final String location;
  final double price;
  final String currency;
  final List<String> amenities;
  final List<String> selectedAmenities;
  File? imageFile;

  DeleteHotel({
    required this.name,
    required this.location,
    required this.price,
    required this.currency,
    required this.amenities,
    required this.selectedAmenities,
    this.imageFile,
  });
}

class AdminHotelScreenDelete extends StatefulWidget {
  const AdminHotelScreenDelete({Key? key}) : super(key: key);

  @override
  State<AdminHotelScreenDelete> createState() => _AdminHotelScreenDeleteState();
}

class _AdminHotelScreenDeleteState extends State<AdminHotelScreenDelete> {
  DeleteHotel hotel = DeleteHotel(
    name: "Nasema",
    location: "Elmamsha, Dahab",
    price: 4500,
    currency: "USD",
    amenities: ['Wi-Fi', 'Pool', 'Gym', 'Restaurant', 'Parking'],
    selectedAmenities: ['Wi-Fi', 'Pool'],
    imageFile: null,
  );

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this hotel data?"),
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
                _deleteHotelData();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Yes, Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteHotelData() {
    setState(() {
      hotel.imageFile = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Hotel deleted successfully!", style: TextStyle(color: Colors.white))),
    );
  }

  void _cancelAndGoHome() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: _cancelAndGoHome,
        ),
        title: const Text("Delete Hotel", style: TextStyle(color: Colors.white, fontSize: 30)),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hotel.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54)),
                const SizedBox(height: 16),
                _buildDisplayField("Location", hotel.location),
                _buildDisplayField("Price per Night (USD)", hotel.price.toString()),
                const SizedBox(height: 16),
                const Text("Hotel Image", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                const SizedBox(height: 8),
                Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: hotel.imageFile == null
                      ? const Center(child: Text("No image available", style: TextStyle(color: Colors.grey)))
                      : Image.file(hotel.imageFile!, fit: BoxFit.cover),
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text("Amenities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                  children: hotel.amenities.map((amenity) {
                    return ListTile(
                      title: Text(amenity),
                      trailing: hotel.selectedAmenities.contains(amenity) ? const Icon(Icons.check, color: Colors.green) : null,
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
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text("Delete", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: _cancelAndGoHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text("Cancel", style: TextStyle(fontSize: 16, color: Colors.white)),
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

  Widget _buildDisplayField(String label, String value) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            controller: TextEditingController(text: value),
            ),
        );
    }
}