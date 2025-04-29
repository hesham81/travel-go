import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_go/core/providers/trip_admin_provider.dart';

abstract class Storage {
  static final _supabase = Supabase.instance.client.storage.from("images");
  static List<String> urls = [];

  static uploadPublicImage({
    required String hotelName,
    required File image,
    required String fileName,
  }) async {
    try {
      await _supabase.upload(
        "hotels/hotel images /$fileName",
        image,
      );
      return true;
    } catch (error) {
      log("Error $error");
      return false;
    }
  }

  static String? getPublicUrlImage(String path) {
    try {
      String url = _supabase.getPublicUrl("hotels/hotel images /$path");
      return url;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> deleteImage(String path) async {
    try {
      await _supabase.remove(
        ["hotels/hotel images /$path"],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  static uploadPublicAttraction({
    required String attractionName,
    required File image,
    required String fileName,
  }) async {
    try {
      await _supabase.upload(
        "attractions/attraction image/$fileName",
        image,
      );
      return true;
    } catch (error) {
      log("Error $error");
      return false;
    }
  }

  static String? getPublicUrlAttractionImage(String path) {
    try {
      String url = _supabase.getPublicUrl("attractions/attraction image/$path");
      return url;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> deleteAttractionImage(String path) async {
    try {
      await _supabase.remove(
        ["attractions/attraction image/$path"],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> uploadPublicTrip({
    required String tripName,
    required File image,
    required String fileName,
  }) async {
    try {
      await _supabase.upload(
        "Trips/$fileName",
        image,
      );
      return true;
    } catch (error) {
      log("Error $error");
      return false;
    }
  }

  static String? getPublicUrlTripImage(String path) {
    try {
      String url = _supabase.getPublicUrl("Trips/$path");
      return url;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> uploadProgramAttractionsImages(
    List<File> images,
    String programId,
    TripAdminProvider provider,
  ) async {
    try {
      for (var i = 0; i < images.length; i++) {
        await _supabase.upload(
          "Programs/$programId/Image${i + 1}",
          images[i],
        );
        String url =
            _supabase.getPublicUrl("Programs/$programId/Image${i + 1}");
        provider.imageUrls.add(url);
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> deleteTripImage(String path) async {
    try {
      await _supabase.remove(
        ["Trips/$path"],
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> uploadHotels(String path, File file) async {
    try {
      await _supabase.upload("/hotels/hotel images/$path", file);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> uploadAttractions(
      File file, String type, int index , String hotelName) async {
    try {
      await _supabase.upload("$hotelName/accomdation/$type/$index", file);
      return true;
    } catch (error) {
      return false;
    }
  }

  static String getHotelImage(String path) {
    return _supabase.getPublicUrl("/hotels/hotel images/$path");
  }

  static String getHotelAccomdationlImage( String type, int index, String hotelName) {
    return _supabase.getPublicUrl("$hotelName/accomdation/$type/$index");
  }
}
