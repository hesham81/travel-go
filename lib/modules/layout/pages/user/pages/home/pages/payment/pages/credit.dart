import 'package:flutter/material.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "VISA Classic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB7E0F2),
      appBar: AppBar(
        backgroundColor: Color(0xffB7E0F2),
        elevation: 0,
        title: Text("Payment Details", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  buildPaymentOption("Debit/Credit Card", "**** **** **** 7291",
                      "assets/Visa-Mastercard.png",80,80),
                  SizedBox(height: 15),
                  buildPaymentOption("Apple Pay", "**** **** **** 5638",
                      "assets/apple_pay.png",70,70), // Add MasterCard image
                  SizedBox(height: 15),

                  buildPriceDetails(),
                ],
              ),
            ),
            buildPayNowButton(),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOption(String title, String subtitle, String image,double width_value,double height_value) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11)
      ),

      child: RadioListTile(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
            Spacer(),
            Image.asset(image, width: width_value, height: height_value), // Payment logo

          ],
        ),
        value: title,
        groupValue: selectedPayment,
        onChanged: (value) {
          setState(() {
            selectedPayment = value.toString();
          });
        },
      ),
    );
  }

  Widget buildPriceDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPriceRow("Trip to Dahab", "5000 LE"),
          buildPriceRow("1 Guest", "5000 LE"),
          Divider(thickness: 1),
          buildPriceRow("Subtotal", "10000 LE"),
          buildPriceRow("Total", "10000 LE", isBold: true),
        ],
      ),
    );
  }

  Widget buildPriceRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold )),
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold )),
        ],
      ),
    );
  }

  Widget buildPayNowButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Handle payment logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text("Pay Now", style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}