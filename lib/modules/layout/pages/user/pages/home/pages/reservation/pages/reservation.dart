import 'package:flutter/material.dart';


class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int numberOfGuests = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for the app bar
        elevation: 4, // Subtle shadow for a modern look
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Black back icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reservation Details',
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), // Black text
            ),
            Spacer(),
            Text(
              'Travel go',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600), // Black text
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: ID Details
            buildSection(
              title: 'ID:',
              value: '878',
            ),

            // Section 2: Number of Guests
            buildSection(
              title: 'Number of Guests:',  // The title here will be aligned to the left
              value: '$numberOfGuests',
              customWidget: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline, color: Colors.black54),
                    onPressed: () {
                      setState(() {
                        if (numberOfGuests > 1) numberOfGuests--;
                      });
                    },
                  ),
                  Text('$numberOfGuests', style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.black54),
                    onPressed: () {
                      setState(() {
                        numberOfGuests++;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Section 3: Time of Reservation
            buildSection(
              title: 'Time of Reservation:',
              value: '20/8/2025',
            ),

            // Section 4: Guest ID
            buildSection(
              title: 'Guest ID:',
              value: '5',
            ),

            // Section 5: National ID
            buildSection(
              title: 'National ID:',
              value: '2730811',
            ),

            Spacer(),

            // Continue Button with black text color
            Center(
              child: SizedBox(
                width: 250, // Set a fixed width for the button
                child: ElevatedButton(
                  onPressed: () {
                    // Handle reservation logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    elevation: 5, // Add subtle shadow for the button
                  ),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black, // Set the text color to black
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection({required String title, required String value, Widget? customWidget}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // Add margin between sections
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          customWidget ??
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
        ],
      ),
    );
  }
}
