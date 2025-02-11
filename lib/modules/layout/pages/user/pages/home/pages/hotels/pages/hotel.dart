import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/payment/pages/credit.dart';
import 'package:travel_go/modules/layout/pages/user/pages/v1/flight.dart';

import 'hotel_details_screen.dart';
class Hotels extends StatelessWidget {
  final List<Map<String, dynamic>> hotels = [
    {
      'name': 'Safir Dahab Resort',
      'rating': 5.0,
      'review': 'Excellent',
      'distance': '2.57 km from Elrayga Camp',
      'price': 3582,
      'image':
'https://dahab-resort.albooked.com/data/Photos/OriginalPhoto/12710/1271044/1271044159/Safir-Dahab-Resort-Exterior.JPEG',    },
    {
      'name': 'Dahab Lagoon Club',
      'rating': 4.7,
      'review': 'Very Good',
      'distance': '2.54 km from Elrayga Camp',
      'price': 5186,
      'image':

'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYuTU6PDf9WMmKMBpn7z-ZmMY9CyF3hhq8HQ&s',    },
    {
      'name': 'Swiss Inn Resort Dahab',
      'rating': 4.7,
      'review': 'Very Good',
      'distance': '2.93 km from Elrayga Camp',
      'price': 4538,
      'image':
'https://d2p1cf6997m1ir.cloudfront.net/media/thumbnails/0f/2d/0f2d34d1ce2defe3c6db58bc48af1d1d.webp'    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "  ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              "Travel go",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dahab',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text("Start Date: "),
                IconButton(
                  icon: Icon(Icons.calendar_today, size: 16),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null) {
                      print('Selected start date: ${selectedDate.toLocal()}');
                    }
                  },
                ),
                Text("May 12"),
                SizedBox(width: 16),
                Text("End Date: "),
                IconButton(
                  icon: Icon(Icons.calendar_today, size: 16),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null) {
                      print('Selected end date: ${selectedDate.toLocal()}');
                    }
                  },
                ),
                Text("May 15"),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(
                        hotel['image'],
                        width: 48,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        hotel['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${hotel['rating']} ⭐ ${hotel['review']}'),
                          Row(
                            children: [

                              Icon(Icons.location_on, size: 16),
                              SizedBox(),
                              Text(hotel['distance']),
                            ],
                          ),
                          Text(
                            '${hotel['price']} EGP Per Night',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HotelDetailScreen(hotel: hotel),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>PaymentScreen(),
            ),
          );
        },
        tooltip: 'Skip',
        child: Icon(Icons.skip_next),
      ),
    );
  }
}


