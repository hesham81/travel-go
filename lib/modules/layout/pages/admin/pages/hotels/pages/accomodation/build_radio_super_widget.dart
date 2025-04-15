import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';


class AccommodationScreen extends StatefulWidget {
  const AccommodationScreen({super.key});

  @override
  State<AccommodationScreen> createState() => _AccommodationScreenState();
}

class _AccommodationScreenState extends State<AccommodationScreen> {
  String? selectedRoomId;
  List<String> roomIds = ['101', '102', '103', '104', '105'];

  List<String> selectedAmenities = [];
  List<String> amenities = ['Wi-Fi', 'TV', 'Mini Bar', 'AC', 'Safe Box'];

  String? selectedRoomType;
  List<String> roomTypes = ['Single', 'Double', 'Suite', 'Family'];

  int? selectedBeds;
  List<int> bedOptions = [1, 2, 3, 4];

  String? selectedLocation;
  List<String> locations = ['Ground Floor', 'First Floor', 'Second Floor'];

  double rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
            onPressed: () {},
          ),
          title: const Text("Accommodation" ,style: TextStyle(color: AppColors.whiteColor),),
          centerTitle: true,
          backgroundColor: AppColors.skyBlueColor,
        ),
        body:
        Container(
          color: AppColors.skyBlueColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // const SizedBox(height: 16),
                  // const Text(
                  //   "Room ID",
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  // ),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(color: AppColors.whiteColor), // Set text color to white
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24, // Light background for visibility
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter Room ID",
                      hintStyle: const TextStyle(color: Colors.white70),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedRoomId = value;
                      });
                    },
                  ),


                  buildRadioSuperMenu("Room Type", roomTypes, selectedRoomType, (value) {
                    setState(() {
                      selectedRoomType = value;
                    });
                  }),

                  buildRadioSuperMenu(
                      "Number of Beds",
                      bedOptions.map((e) => e.toString()).toList(),
                      selectedBeds?.toString(),
                          (value) {
                        setState(() {
                          selectedBeds = int.parse(value!);
                        });
                      }),

                  buildRadioSuperMenu("Location in Hotel", locations, selectedLocation, (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  }),

                  // Amenities (Checkbox-based)
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text("Amenities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.whiteColor)),
                    children: [
                      Column(
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
                    ],
                  ),
                  //
                  SizedBox(height: 10,),

                  // 0.01.height.hSpace,
                  const SizedBox(height: 20),

                  // Update and Delete Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Room Updated")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.skyBlueColor,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text("Update", style: TextStyle(fontSize: 16, color: AppColors.blackColor)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Room Deleted")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.errorColor,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text("Delete", style: TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  // Supermenu for Radio Button Selections
  Widget buildRadioSuperMenu(String title, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ExpansionTile(
            title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.whiteColor)),
            children: items.map((item) {
              return RadioListTile<String>(
                title: Text(item),
                value: item,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    onChanged(value);
                  });
                },
              );
            }).toList(),
          )
        ],
        );
    }
}
// import 'package:flutter/material.dart';
//
// class BuildRadioSuperWidget extends StatelessWidget {
//
//   buildRadioSuperMenu(String title, List<String> items, String? selectedValue, Function(String?) onChanged) {
//
//   @override
//   Widget build(BuildContext context) {
//       return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             ExpansionTile(
//               title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
//               children: items.map((item) {
//                 return RadioListTile<String>(
//                   title: Text(item),
//                   value: item,
//                   groupValue: selectedValue,
//                   onChanged: (value) {
//                     setState(() {
//                       onChanged(value);
//                     });
//                   },
//                 );
//               }).toList(),
//             )
//              ],
//               );
//         }
//   };
//   }
// }
