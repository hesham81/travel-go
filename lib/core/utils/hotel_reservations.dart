import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HotelReservations{
  static final _firestore  =FirebaseFirestore.instance.collection("HotelReservations");
}