import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/providers/reservation_provider.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/widget/labels_widget.dart';

class ReserveTotalInfoWidget extends StatefulWidget {
  const ReserveTotalInfoWidget({super.key});

  @override
  State<ReserveTotalInfoWidget> createState() => _ReserveTotalInfoWidgetState();
}

class _ReserveTotalInfoWidgetState extends State<ReserveTotalInfoWidget> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TripAdminProvider>(context);
    var reservationProvider = Provider.of<ReservationProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          LabelsWidget(
            label: "Name : ",
            value: reservationProvider.user?.displayName ?? "No Name",
          ),
          LabelsWidget(
            label: "Email : ",
            value: reservationProvider.user?.email ?? "No Account",
          ),
          LabelsWidget(
            label: "National ID : ",
            value:"01284152478123",
          ),
          LabelsWidget(
            label: "Phone : ",
            value: reservationProvider.user?.phoneNumber ?? "No Phone Number",
          ),
          0.01.height.hSpace,
          Text(
            reservationProvider.getAddress ?? "Not Located",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.black,
                ),
          ).center,
        ],
      ),
    );
  }
}
