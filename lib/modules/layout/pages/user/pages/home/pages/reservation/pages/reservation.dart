import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/numbers_text_form_field.dart';
import 'package:travel_go/main.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/widget/reserve_widget_users.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/widget/trip_info_reservation.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/widget/reserve_total_info_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/reservation_provider.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class Reservation extends StatefulWidget {
  const Reservation({
    super.key,
  });

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  TextEditingController totalGuests = TextEditingController();
  @override
  void initState() {
    Provider.of<ReservationProvider>(navigationKey.currentContext!).setTotalUsers(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TripInfoReservation(),
                0.02.height.hSpace,
                ReserveTotalInfoWidget(),
                0.02.height.hSpace,
                Text(
                  "Total Guests",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "Total Guests ",
                  controller: totalGuests,
                  onComplete: (p0) {
                    int? number =
                        (int.tryParse(p0) != 1) ? int.tryParse(p0) ?? 1 : 1;
                    if (number >
                        provider.getSelectedDeparture!.availableSeats) {
                      provider.setValid(false);
                      setState(() {});
                    } else {
                      provider.setValid(true);
                    }
                    number -= 1;

                    provider.setTotalUsers(number);
                  },
                ),
                0.02.height.hSpace,
                (provider.getTotalUsers + 1 != 0 && provider.getValid)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => ReserveWidgetUsers(),
                        separatorBuilder: (context, index) =>
                            0.01.height.hSpace,
                        itemCount: provider.getTotalUsers,
                      )
                    : Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: AppColors.errorColor,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Lottie.asset(
                              "assets/icons/error.json",
                              height: 50,
                              animate: true,
                              repeat: false,
                            ),
                            0.1.width.vSpace,
                            (provider.getValid == false)
                                ? Text(
                                    "No enough seats",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.red,
                                        ),
                                  )
                                : Text(
                                    "No guest",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.red,
                                        ),
                                  ),
                          ],
                        ),
                      ),
                0.03.height.hSpace,
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
