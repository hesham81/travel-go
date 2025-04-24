import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/browse_hotels/browse_admin_hotels.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/new_hotel/pages/new_hotel.dart';
import 'package:travel_go/modules/layout/pages/admin/task/Addflight.dart';

import '../../../../../core/theme/app_colors.dart';

class AdminHotelScreen extends StatelessWidget {
  final Map<String, Widget Function()> pageRoutes = {
    "Browse hotel": () => BrowseAdminHotels(),
    "New hotel": () => NewHotel(),
    "Update hotel": () => BrowseAdminHotels(
          isDeleted: false,
        ),
    "Delete hotel": () => BrowseAdminHotels(
          isUpdate: false,
        ),
  };

  void _handleMenuSelection(BuildContext context, String value) {
    if (pageRoutes.containsKey(value)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => pageRoutes[value]!()));
    } else {
      print("Page not found for: $value");
    }
  }

  void _showPopupMenu(BuildContext context, String title) {
    List<String> menuOptions = [
      "Browse $title",
      "New $title",
      "Update $title",
      "Delete $title"
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: menuOptions
                .map(
                  (option) => ListTile(
                    title: Text(option, style: TextStyle(fontSize: 18)),
                    onTap: () {
                      Navigator.pop(context);
                      _handleMenuSelection(context, option);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () => _showPopupMenu(context, title),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250, 70),
        backgroundColor: Color(0xff0d75b4),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Tour And Travel",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPopupButton(context, "hotel"),
            ],
          ),
        ),
      ),
    );
  }
}
