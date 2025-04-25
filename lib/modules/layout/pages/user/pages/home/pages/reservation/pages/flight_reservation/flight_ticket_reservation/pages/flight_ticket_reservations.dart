import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/pages/hotel_reservations_info/pages/hotel_reservation_user.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class FlightTicketReservations extends StatelessWidget {
  const FlightTicketReservations({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      bottomNavigationBar: CustomContainer(
        child: Expanded(
          child: CustomElevatedButton(
            text: "Ok",
            borderRadius: 10,
            onPressed: () => slideLeftWidget(
                newPage: HotelReservationUser(), context: context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            0.1.height.hSpace,
            Stack(
              children: [
                Image.asset(
                  "assets/images/all_ticket.png",
                ),
                Positioned(
                  top: 40,
                  left: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.network(
                                height: 50,
                                width: 50,
                                provider.getFlight?.airline
                                        .flightAirLineImageUrl ??
                                    "",
                              ),
                              Text(
                                provider.getFlight?.airline.flighAirLineName ??
                                    "",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          0.03.width.vSpace,
                          Text(
                            FirebaseAuth.instance.currentUser?.displayName ??
                                "",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      0.01.height.hSpace,
                      Row(
                        children: [
                          CustomContainer(
                            child: Column(
                              children: [
                                Text(
                                  " ${provider.getSelectedDeparture?.from.day}/${provider.getSelectedDeparture?.from.month}/${provider.getSelectedDeparture?.from.year}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                0.01.height.hSpace,
                                Text(
                                  provider.getTrip?.source.substring(0, 3) ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          0.05.width.vSpace,
                          CustomContainer(
                            child: Column(
                              children: [
                                Text(
                                  " ${provider.getSelectedDeparture?.to.day}/${provider.getSelectedDeparture?.to.month}/${provider.getSelectedDeparture?.to.year}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                0.01.height.hSpace,
                                Text(
                                  provider.getTrip?.destination
                                          .substring(0, 3) ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      0.01.height.hSpace,
                      Text(
                        provider.getFlight?.flightId ?? "",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      0.01.height.hSpace,
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              FirebaseAuth.instance.currentUser?.photoURL ?? "",
                            ),
                          ),
                          0.03.width.vSpace,
                          Column(
                            children: [
                              Text(
                                provider.getSeatEconomyDataModel!.economy,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              0.01.height.hSpace,
                              Text(
                                "${provider.getSeatEconomyDataModel!.price} ${provider.getTrip?.currency}",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
