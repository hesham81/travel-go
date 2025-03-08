import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';

import '/core/theme/app_colors.dart';

class SetMapLocation extends StatefulWidget {
  final LatLng locations;
  final String? imageUrl;

  const SetMapLocation({
    super.key,
    required this.locations,
    this.imageUrl,
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
              initialCenter: widget.locations,
              initialZoom: 10,
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
                    child: widget.imageUrl != null
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.newBlueColor,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: LoadingImageNetworkWidget(
                                imageUrl: widget.imageUrl!,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.location_on_outlined,
                            color: AppColors.newBlueColor,
                          ),
                  )
                ],
              ),
              (widget.imageUrl != null)
                  ? CircleLayer(
                      circles: [
                        CircleMarker(
                          point: widget.locations,
                          radius: 10000,
                          color: AppColors.newBlueColor.withAlpha(30),
                          useRadiusInMeter: true,
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
