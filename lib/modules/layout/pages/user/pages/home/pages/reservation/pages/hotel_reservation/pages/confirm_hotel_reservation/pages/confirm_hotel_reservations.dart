import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/confirm_reservations/pages/confirm_user_reservations.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/reservation_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/labels_widget.dart';

class ConfirmHotelReservations extends StatefulWidget {
  const ConfirmHotelReservations({super.key});

  @override
  State<ConfirmHotelReservations> createState() =>
      _ConfirmHotelReservationsState();
}

class _ConfirmHotelReservationsState extends State<ConfirmHotelReservations> {
  List<String> items = [
    "Single Room",
    "Double Room",
    "Triple Room",
    "Quad Room",
    "Queen Room",
    "King Room",
    "Suite Room",
  ];
  String? selectedRoom;
  List<double> prices = [
    3000.0,
    5000.0,
    7000.0,
    9000.0,
    11000.0,
    13000.0,
    15000.0,
    17000.0,
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hotel Reservation",
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
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                "assets/images/hotel_reservation.jpg",
              ),
              CustomContainer(
                child: Column(
                  children: [
                    LabelsWidget(
                      label: "Name : ",
                      value: provider.user!.displayName!,
                    ),
                    0.01.height.hSpace,
                    LabelsWidget(
                      label: "Email : ",
                      value: provider.user!.email!,
                    ),
                    0.01.height.hSpace,
                    LabelsWidget(
                        label: "No Of Days :",
                        value:
                            "${provider.getSelectedDeparture!.trip.totalDays} Days"),
                    0.01.height.hSpace,
                    LabelsWidget(
                      label: "Room Type : ",
                      value: selectedRoom ?? "No Room Selected Yet",
                    ),
                    if (selectedRoom != null) 0.01.height.hSpace,
                    if (selectedRoom != null)
                      LabelsWidget(
                        label: "Room Price : ",
                        value:
                            "${prices[items.indexOf(selectedRoom!)]} ${provider.getSelectedDeparture!.trip.currency} Per Night",
                      ),
                  ],
                ),
              ).hPadding(0.03.width),
              0.01.height.hSpace,
              CustomDropdown(
                items: items,
                hintText: selectedRoom ?? "Select Room Type",
                headerBuilder: (context, hint, enabled) => CustomContainer(
                  child: LabelsWidget(
                    label: "",
                    value: hint,
                  ),
                ),
                onChanged: (p0) {
                  selectedRoom = p0;
                  setState(() {});
                },
                listItemPadding: EdgeInsets.symmetric(
                  vertical: 0.01.height,
                  horizontal: 0.03.width,
                ),
                listItemBuilder: (
                  context,
                  item,
                  isSelected,
                  onItemSelect,
                ) =>
                    CustomContainer(
                  child: LabelsWidget(
                    label: "",
                    value: item,
                  ),
                ),
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "OK",
                      onPressed: () {
                        provider.setReserveHotel(true);
                        slideLeftWidget(
                          newPage: ConfirmUserReservations(),
                          context: context,
                        );
                      },
                    ),
                  ),
                  0.02.width.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                        provider.setReserveHotel(false);
                      },
                      btnColor: AppColors.errorColor,
                    ),
                  ),
                ],
              ).hPadding(0.03.width)
            ],
          ),
        ),
      ),
    );
  }
}
