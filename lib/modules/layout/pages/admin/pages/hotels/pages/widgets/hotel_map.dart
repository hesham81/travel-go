import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/providers/hotel_admin_provider.dart';

class HotelMap extends StatefulWidget {
  static const routeName = '/app-maps';

  const HotelMap({super.key});

  @override
  State<HotelMap> createState() => _HotelMapState();
}

class _HotelMapState extends State<HotelMap> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HotelAdminProvider>(context);
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (tapPosition, point) {
            provider.setMarker(
              Marker(
                point: point,
                child: Icon(
                  Icons.location_on_outlined,
                ),
              ),
            );
          },
        ),
        children: [
          TileLayer(
            userAgentPackageName: "com.maps.app",
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
            markers: provider.getMarker,
          )
        ],
      ),
    );
  }
}
