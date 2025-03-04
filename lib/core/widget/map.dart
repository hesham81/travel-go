import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/theme/app_colors.dart';

class AppMaps extends StatefulWidget {
  static const routeName = '/app-maps';

  const AppMaps({super.key});

  @override
  State<AppMaps> createState() => _AppMapsState();
}

class _AppMapsState extends State<AppMaps> {
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
  List<Polygon> polygons = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TripAdminProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.move(
            LatLng(latitude, longitude),
            19,
          );
          provider.setCurrentLocation(LatLng(latitude, longitude));
        },
        backgroundColor: AppColors.newBlueColor,
        child: Icon(
          Icons.location_searching,
          color: AppColors.whiteColor,
        ),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            onTap: (tapPosition, point) {
              provider.addMarker(
                Marker(
                  point: point,
                  child: Icon(Icons.location_on_outlined),
                ),
              );
              print(provider.getMarkers.first.point.longitude); // Access the first marker's longitude
            },
        ),
        children: [
          TileLayer(
            userAgentPackageName: "com.maps.app",
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
            markers: provider.getMarkers ?? [], // Fallback to empty list if null (not needed anymore)
          ),
          PolygonLayer(
            polygons: polygons,
          ),
        ],
      ),
    );
  }
}
