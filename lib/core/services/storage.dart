import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Storage {
  static final _supabase = Supabase.instance.client.storage.from("images");

  static  uploadPublicImage({
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
  static String? getPublicUrlImage(String path)
  {
    try{
      String url = _supabase.getPublicUrl("hotels/hotel images /$path");
      return url ;
    }
    catch(error)
    {
      return null;
    }
  }
}
