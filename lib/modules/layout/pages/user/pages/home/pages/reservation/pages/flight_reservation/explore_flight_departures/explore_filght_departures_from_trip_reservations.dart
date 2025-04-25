import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/utils/flight_departures_collections.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/flight_departures.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/flight_reservation/explore_flight_departures/widget/ticket_flight_generator.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/flight_reservation/pages/flight_accomdations_reservations/pages/flight_accomdations_reservations.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class ExploreFilghtDeparturesFromTripReservations extends StatefulWidget {
  final Flight flight;
  final String dest;

  const ExploreFilghtDeparturesFromTripReservations({
    super.key,
    required this.flight,
    required this.dest,
  });

  @override
  State<ExploreFilghtDeparturesFromTripReservations> createState() =>
      _ExploreFilghtDeparturesFromTripReservationsState();
}

class _ExploreFilghtDeparturesFromTripReservationsState
    extends State<ExploreFilghtDeparturesFromTripReservations> {
  List<FlightDeparture> _departures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            StreamBuilder(
              stream: FlightDeparturesCollections.getStreamDepartures(),
              builder: (context, snapshot) {
                List<FlightDeparture> _allDepartures = snapshot.data?.docs
                        .map(
                          (e) => e.data(),
                        )
                        .toList() ??
                    [];
                _departures = _allDepartures
                    .where(
                      (element) =>
                          element.arrAirport.toLowerCase() ==
                          widget.dest.toLowerCase(),
                    )
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => slideLeftWidget(
                        newPage: FlightAccomdationsReservations(
                          flightDeparture: _departures[index],
                        ),
                        context: context),
                    child: TicketFlightGenerator(
                      flight: widget.flight,
                      departure: _departures[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: _departures.length,
                );
              },
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
