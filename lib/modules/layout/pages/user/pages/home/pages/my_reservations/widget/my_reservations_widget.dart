import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/reservation_model.dart';

class MyReservationsWidget extends StatelessWidget {
  final ReservationModel model;

  const MyReservationsWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return CustomContainer(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trip",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    0.01.height.hSpace,
                    Text(
                      provider.user!.displayName ?? "No Name",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    0.01.height.hSpace,
                    Text(
                      "${model.trip!.from.day} / ${model.trip!.from.month} / ${model.trip!.from.year}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    0.01.height.hSpace,
                    Text(
                      "${model.trip!.to.day} / ${model.trip!.to.month} / ${model.trip!.to.year}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    0.01.height.hSpace,
                    Text(
                      "${model.trip!.trip.price} ${model!.trip!.trip.currency}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ).allPadding(15),
              ),
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  child: LoadingImageNetworkWidget(
                    height: 0.19.height,
                    imageUrl: model.trip!.trip.imageUrl ??
                        "https://via.placeholder.com/150",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
