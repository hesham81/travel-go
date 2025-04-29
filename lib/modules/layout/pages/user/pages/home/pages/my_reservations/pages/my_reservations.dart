import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/reservations_collections.dart';
import 'package:travel_go/models/reservation_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/home.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/widget/my_reservations_widget.dart';

class MyReservations extends StatefulWidget {
  const MyReservations({super.key});

  @override
  State<MyReservations> createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  List<ReservationModel> reservations = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => slideLeftWidget(newPage: Home(), context: context),
        backgroundColor: AppColors.newBlueColor,
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "My Reservations",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            StreamBuilder(
              stream: ReservationCollections.getReservations(),
              builder: (context, snapshot) {
                reservations = snapshot.data?.docs
                        .map(
                          (e) => e.data(),
                        )
                        .toList() ??
                    [];
                reservations = reservations
                    .where(
                      (element) =>
                          element.uid == FirebaseAuth.instance.currentUser!.uid,
                    )
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => MyReservationsWidget(
                    model: reservations[index],
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: reservations.length,
                );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
