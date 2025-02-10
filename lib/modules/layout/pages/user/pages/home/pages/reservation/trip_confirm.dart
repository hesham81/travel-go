import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/payment/pages/credit.dart';

class TripConfirmedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB7E0F2), // Light blue background
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              
              "Trip Confirmed !",
              style: TextStyle(
                
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Container(

              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white, // Fills the circle with white
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.black,
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Please check your email for trip confirmation and details.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()),);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffB7E0F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text(
                "Payment",
                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
