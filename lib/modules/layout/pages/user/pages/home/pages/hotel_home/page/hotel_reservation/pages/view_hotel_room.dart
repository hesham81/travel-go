import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:travel_go/core/extensions/dimensions.dart';

class ViewHotelRoom extends StatelessWidget {
  final String imageUrl;

  const ViewHotelRoom({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PanoramaViewer(
          sensitivity: 1.8,
          child: Image.network(
            imageUrl,
            height: 1.height,
            cacheWidth: 2048,
            cacheHeight: 1024,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
