import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "Debit/Credit Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB7E0F2),
      appBar: AppBar(
        backgroundColor: Color(0xffB7E0F2),
        elevation: 0,
        title: Text(
          "Payment Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  buildPaymentOption(
                      title: "Debit/Credit Card",
                      subtitle: "**** **** **** 7291",
                      imagePath: "assets/images/Visa-Mastercard.png",
                      width: 70,
                      height: 50),
                  SizedBox(height: 12),
                  buildPaymentOption(
                      title: "Apple Pay",
                      subtitle: "**** **** **** 5638",
                      imagePath: "assets/images/apple_pay.png",
                      width: 60,
                      height: 50),
                  SizedBox(height: 20),
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

  Widget buildPaymentOption({
    required String title,
    required String subtitle,
    required String imagePath,
    required double width,
    required double height,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
            Image.asset(imagePath, width: width, height: height),
          ],
        ),
        value: title,
        groupValue: selectedPayment,
        activeColor: Colors.blue,
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
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
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
          child: Text(
            "Pay Now",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
