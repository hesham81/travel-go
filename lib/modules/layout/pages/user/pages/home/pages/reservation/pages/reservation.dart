import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/payment/pages/credit.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/trip_confirm.dart';
// Import for date formatting

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  int numberOfGuests = 0;
  int ID = 0;
  DateTime timeOfReservation = DateTime.now();
  int guestID = 0;
  int nationalID = 0;

  @override
  void initState() {
    super.initState();
    // Ensure timeOfReservation stores only date part
    timeOfReservation = DateTime(timeOfReservation.year, timeOfReservation.month, timeOfReservation.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB7E0F2),
      appBar: AppBar(
        backgroundColor: Color(0xffB7E0F2),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          'Reservation Details',
          style: TextStyle(
            fontFamily: "Poppins-SemiBold",
            color: Colors.black,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID',
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Number of guests',
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Date of Reservation:',
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Guest ID',
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'National ID',
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                ID.toString(),
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        numberOfGuests++;
                                      });
                                    },
                                    child: Icon(Icons.add_circle_outline_outlined, color: Colors.black),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    numberOfGuests.toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins-SemiBold",
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18),
                              Text(
                                DateFormat('dd-MM-yyyy').format(timeOfReservation),
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 18),
                              Text(
                                guestID.toString(),
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 18),
                              Text(
                                nationalID.toString(),
                                style: TextStyle(
                                  fontFamily: "Poppins-SemiBold",
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 33),
          InkWell(
            onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>TripConfirmedScreen()),);            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontFamily: "Poppins-SemiBold",
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}