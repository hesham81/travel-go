import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/browse_attractions/pages/browse_attractions.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/delete_attractions/pages/delete_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/new_attractions/pages/new_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/update_attraction.dart';

class Attraction extends StatelessWidget {
  final Map<String, Widget Function()> pageRoutes = {
    "Browse Attraction": () => BrowseAttractions(),
    "New Attraction": () => NewAttraction(),
    "Update Attraction": () => UpdateAttraction(),
    "Delete Attraction": () => DeleteAttraction(),
  };

  void _handleMenuSelection(BuildContext context, String value) {
    if (pageRoutes.containsKey(value)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageRoutes[value]!(),
        ),
      );
    } else {
      print("Page not found for: $value");
    }
  }

  void _showPopupMenu(BuildContext context, String title) {
    List<String> menuOptions = [
      "Browse Attraction",
      "New Attraction",
      "Update Attraction",
      "Delete Attraction"
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
                    title: Text(
                      option,
                      style: TextStyle(fontSize: 18),
                    ),
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
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
              _buildPopupButton(
                context,
                " Attraction Info ",
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
