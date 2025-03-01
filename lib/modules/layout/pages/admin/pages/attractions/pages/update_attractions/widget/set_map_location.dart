import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '/core/theme/app_colors.dart';

class SetMapLocation extends StatefulWidget {
  final LatLng locations;

  const SetMapLocation({
    super.key,
    required this.locations,
  });

  @override
  State<SetMapLocation> createState() => _SetMapLocationState();
}

class _SetMapLocationState extends State<SetMapLocation> {
  MapController mapController = MapController();
  Location location = Location();

  LocationData? locationData;
  List<LatLng> tappedPoints = [
    LatLng(51.5, -0.09),
    LatLng(51.5, -0.09),
  ];
  double longitude = 0.0;

  double latitude = 0.0;

  getLocationData() async {
    var currentLocation = await location.getLocation();
    longitude = currentLocation.longitude ?? 0.0;
    latitude = currentLocation.latitude ?? 0.0;
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.newBlueColor,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: widget.locations
            ),
            children: [
              TileLayer(
                userAgentPackageName: "com.maps.app",
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.locations,
                    child: Icon(
                      Icons.attractions,
                      color: AppColors.newBlueColor,
                      size: 30,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
