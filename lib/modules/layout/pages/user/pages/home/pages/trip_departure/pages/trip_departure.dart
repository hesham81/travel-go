import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/routes/route_transact.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/reservation.dart';
import '/core/extensions/extensions.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import '/modules/layout/pages/user/pages/home/pages/trip_departure/widget/trip_departure_user_widget.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class TripDeparture extends StatefulWidget {
  final TripDataModel model;

  const TripDeparture({
    super.key,
    required this.model,
  });

  @override
  State<TripDeparture> createState() => _TripDepartureState();
}

class _TripDepartureState extends State<TripDeparture> {
  List<TripDepartureDataModel> departures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: TripDeparturesCollection.getStreamDepartures(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Lottie.file("assets/icons/no_favourite.json");
                }
                departures = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList()
                    .where(
                        (element) => element.trip.tripId == widget.model.tripId)
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => slideRightWidget(
                        newPage: Reservation(
                          model: widget.model,
                        ),
                        context: context),
                    child: TripDepartureUserWidget(
                      model: departures[index],
                    ),
                  ),
                  separatorBuilder: (context, _) => 0.01.height.hSpace,
                  itemCount: departures.length,
                );
              },
            ),
            0.03.height.hSpace,
          ],
        ),
      ),
    );
  }
}
