import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import '../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../core/utils/check_tour_guide.dart';

class TrackLocations extends StatefulWidget {
  const TrackLocations({super.key});

  @override
  State<TrackLocations> createState() => _TrackLocationsState();
}

class _TrackLocationsState extends State<TrackLocations> {
  MapController controller = MapController();

  // Single marker instance
  Marker? marker;

  final String imageUrl =
      "https://snkdebzdhsftylikqzlh.supabase.co/storage/v1/object/public/images/Trips/Trip-Tech%20Innovators-Italy";

  // Stream subscription for location updates
  StreamSubscription? _locationStream;

  @override
  void initState() {
    super.initState();
    _startLocationStream();
  }

  @override
  void dispose() {
    _locationStream?.cancel(); // Cancel the stream subscription when the widget is disposed
    super.dispose();
  }

  // Start listening to the location stream
  void _startLocationStream() {
    // Replace this with your actual stream source (e.g., Firestore, backend API, etc.)
    _locationStream = TourGuideServices.getTourGuide("Departure-Italy-2025:4:16-2025:4:18").listen(
          (event) {
        try {
          // Extract latitude and longitude from the stream data
          final lat = event.docs.first.data().lat; // Example: Assuming first document contains the location
          final long = event.docs.first.data().long;

          if (lat == null || long == null) {
            debugPrint("Invalid location data. Latitude or Longitude is null.");
            return;
          }

          // Update the marker's position
          setState(() {
            marker = Marker(
              point: LatLng(lat, long),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.newBlueColor,
                  border: Border.all(
                    color: AppColors.newBlueColor,
                    width: 3
                  ),
                ),
                child: CircleAvatar(
                  radius: 200, // Adjust the size of the marker
                  backgroundImage: CachedNetworkImageProvider(imageUrl),
                ),
              ),
            );
          });


        } catch (e) {
          debugPrint("Error processing location stream: $e");
        }
      },
      onError: (error) {
        debugPrint("Error in location stream: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (marker != null) {
            controller.move(
              marker!.point,
              17.0,
            );
          }
        },
        backgroundColor: AppColors.newBlueColor,
        child: Icon(
          Icons.my_location,
          color: AppColors.primaryColor,
        ),
      ),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
          initialCenter: LatLng(0, 0), // Default center (will be updated by the stream)
        ),
        children: [
          TileLayer(
            userAgentPackageName: "com.maps.app",
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          if (marker != null) MarkerLayer(markers: [marker!]), // Single marker layer
        ],
      ),
    );
  }
}