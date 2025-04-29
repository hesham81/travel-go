import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;

import '../../../../../../../../../core/theme/app_colors.dart';

class MyLocation extends StatefulWidget {
  final LatLng location;

  const MyLocation({
    super.key,
    required this.location,
  });

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  MapController controller = MapController();
  loc.Location location = loc.Location();

  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;

  loc.LocationData? _locationData;

  @override
  void initState() {
    _initLocation();

    super.initState();
  }

  _initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  List<Marker> markers = [
    // Marker(point: point, child: child)
  ];

  @override
  Widget build(BuildContext context) {
    if (markers.isEmpty) {
      markers.add(
        Marker(
          point: widget.location,
          child: Icon(
            Icons.location_on_outlined,
            color: AppColors.newBlueColor,
          ),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.move(
            LatLng(_locationData!.latitude!, _locationData!.longitude!),
            17.0,
          );
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
          initialCenter: widget.location,
        ),
        children: [
          TileLayer(
            userAgentPackageName: "com.maps.app",
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          CurrentLocationLayer(
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
              showAccuracyCircle: false,
              markerSize: const Size(40, 40),
              markerDirection: MarkerDirection.heading,
            ),
          ),
        ],
      ),
    );
  }
}
