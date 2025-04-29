import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:location/location.dart' as loc;
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/hotel_home/page/hotel_home_details.dart';

class HotelMapsLocations extends StatefulWidget {
  const HotelMapsLocations({super.key});

  @override
  State<HotelMapsLocations> createState() => _HotelMapsLocationsState();
}

class _HotelMapsLocationsState extends State<HotelMapsLocations> {
  MapController controller = MapController();
  loc.Location location = loc.Location();

  Future<void> _initLocation() async {
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

  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;

  loc.LocationData? _locationData;
  List<LatLng> _locations = [];
  List<Hotel> _hotels = [];
  bool isLoading = true;
  List<Marker> _markers = [];
  Hotel? _selectedHotel;

  Future<void> _initData() async {
    _hotels = await HotelsDB.getAllHotels();
    _locations = _hotels
        .map(
          (e) => LatLng(
            e.lat,
            e.long,
          ),
        )
        .toList();
    for (int i = 0; i < _hotels.length; i++) {
      _markers.add(
        Marker(
          point: _locations[i],
          child: GestureDetector(
            onTap: () => slideLeftWidget(
                newPage: HotelDetailsScreen(
                  hotelId: _hotels[i].id,
                ),
                context: context),
            child: Container(
              height: 0.2.height,
              width: 0.6.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.newBlueColor,
                  width: 3,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    _hotels[i].imageUrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    Future.wait([
      _initLocation(),
      _initData(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? CircularProgressIndicator(
              color: AppColors.newBlueColor,
            ).center
          : FlutterMap(
              mapController: controller,
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
                MarkerLayer(
                  markers: _markers,
                ),
              ],
            ),
    );
  }
}
