import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/providers/reservation_provider.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class HotelReservationUser extends StatelessWidget {
  const HotelReservationUser({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            LoadingImageNetworkWidget(
              imageUrl: "https://i.pinimg.com/474x/4d/69/0c/4d690cffa41358ec253ccfb5b5ab4b02.jpg",
            )
          ],
        ),
      ),
    );
  }
}
