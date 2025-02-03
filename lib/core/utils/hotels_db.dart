import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/models/hotel_model.dart';

abstract class HotelsDB {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<Hotel>> getAllHotels() async {
    List<Hotel> hotels = [];
    await _firestore
        .collection("Hotel")
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) {
      hotels =
          value.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> theMap) {
        return Hotel.fromMap(theMap.data());
      }).toList();
    });
    return Future.value(hotels);
  }

  static addHotel({required Hotel hotel}) {
    try{
      _firestore.collection("Hotel").add(hotel.toMap());
    }
    catch(error)
    {
      return null ;
    }
  }
}
