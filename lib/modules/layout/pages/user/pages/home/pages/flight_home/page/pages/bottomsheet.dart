import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTravellerBottomSheet extends StatefulWidget {
  const AddTravellerBottomSheet({super.key});

  @override
  _AddTravellerBottomSheetState createState() => _AddTravellerBottomSheetState();
}

class _AddTravellerBottomSheetState extends State<AddTravellerBottomSheet> {
  bool isFemale = true;
  String? selectedNationality;
  String? selectedPassportCountry;
  String? selectedDob;
  String? selectedPassportExpiry;

  // Controllers for input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passportNumberController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up memory
    firstNameController.dispose();
    lastNameController.dispose();
    passportNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, Function(String) onDateSelected) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        onDateSelected(DateFormat('yyyy-MM-dd').format(picked));
      });
    }
  }

  void _pickCountry(Function(String) onCountrySelected) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          onCountrySelected(country.name);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gender Selection
            Center(
              child: ToggleButtons(
                isSelected: [isFemale, !isFemale],
                onPressed: (index) {
                  setState(() {
                    isFemale = index == 0;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: const Color(0xFF0D75B4),
                color: Colors.black,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Female"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Male"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Input Fields
            _buildTextField("First Name", firstNameController),
            const SizedBox(height: 10),
            _buildTextField("Last Name", lastNameController),
            const SizedBox(height: 10),

            // Nationality
            _buildCountryPicker("Nationality", selectedNationality, (value) {
              setState(() {
                selectedNationality = value;
              });
            }),
            const SizedBox(height: 10),

            // Date of Birth
            _buildDatePicker("Date of Birth", selectedDob, (value) {
              setState(() {
                selectedDob = value;
              });
            }),
            const SizedBox(height: 10),

            // Passport Number
            _buildTextField("Passport Number", passportNumberController),
            const SizedBox(height: 10),

            // Passport Country
            _buildCountryPicker("Passport Country", selectedPassportCountry, (value) {
              setState(() {
                selectedPassportCountry = value;
              });
            }),
            const SizedBox(height: 10),

            // Passport Expiry Date
            _buildDatePicker("Passport Expiry", selectedPassportExpiry, (value) {
              setState(() {
                selectedPassportExpiry = value;
              });
            }),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Pass collected data back to the calling screen
                  Navigator.pop(context, {
                    "firstName": firstNameController.text,
                    "lastName": lastNameController.text,
                    "gender": isFemale ? "Female" : "Male",
                    "nationality": selectedNationality,
                    "dob": selectedDob,
                    "passportNumber": passportNumberController.text,
                    "passportCountry": selectedPassportCountry,
                    "passportExpiry": selectedPassportExpiry,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D75B4),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text Field Widget
  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller, // Stores input value
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Date Picker Widget
  Widget _buildDatePicker(String hintText, String? value, Function(String) onDateSelected) {
    return GestureDetector(
      onTap: () => _pickDate(context, onDateSelected),
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            hintText: value ?? hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  // Country Picker Widget
  Widget _buildCountryPicker(String hintText, String? value, Function(String) onCountrySelected) {
    return GestureDetector(
      onTap: () => _pickCountry(onCountrySelected),
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            hintText: value ?? hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}