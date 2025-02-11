import 'package:flutter/material.dart';

class HotelDetailScreen extends StatelessWidget {
  final Map<String, dynamic> hotel;

  HotelDetailScreen({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            hotel['image'],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel['name'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text('${hotel['rating']} ⭐ ${hotel['review']}'),
                Text(hotel['distance']),
                SizedBox(height: 10),
                Text("Check-in: 10 May  |  Check-out: 12 May"),
                SizedBox(height: 10),
                Text("Room: 1  |  Guests: 2 Adults, No Children"),
                SizedBox(height: 15),
                Text(
                  "Set Your Filters:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  value: true,
                  onChanged: (v) {},
                  title: Text("Free cancellation - no prepayment needed"),
                ),
                CheckboxListTile(
                  value: true,
                  onChanged: (v) {},
                  title: Text("Breakfast included"),
                ),
                CheckboxListTile(
                  value: false,
                  onChanged: (v) {},
                  title: Text("Breakfast & Dinner included"),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Book Now"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Add to Favorites"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}