import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/providers/trip_admin_provider.dart';

import '/core/theme/app_colors.dart';

class AttractionMap extends StatefulWidget {
  const AttractionMap({super.key});

  @override
  State<AttractionMap> createState() => _AttractionMapState();
}

class _AttractionMapState extends State<AttractionMap> {
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
    var provider = Provider.of<TripAdminProvider>(context);
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
              onTap: (tapPosition, point) {
                provider.setAttractionLocation(
                  LatLng(
                    point.latitude,
                    point.longitude,
                  ),
                );
                markers.clear();
                markers.add(
                  Marker(
                    point: point,
                    child: Icon(
                      Icons.attractions_sharp,
                      color: AppColors.newBlueColor,
                    ),
                  ),
                );
                setState(() {});
              },
            ),
            children: [
              TileLayer(
                userAgentPackageName: "com.maps.app",
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              MarkerLayer(
                markers: markers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
