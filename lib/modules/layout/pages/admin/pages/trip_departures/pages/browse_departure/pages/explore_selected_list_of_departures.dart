import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/widget/trip_departure_item_widget.dart';
import '/core/theme/app_colors.dart';
import '/models/trip_data_model.dart';

class ExploreSelectedListOfDepartures extends StatefulWidget {
  final TripDataModel model;
  final bool isUpdate;
  final bool isDelete;

  const ExploreSelectedListOfDepartures({
    super.key,
    required this.model,
    required this.isUpdate ,
    required this.isDelete ,
  });

  @override
  State<ExploreSelectedListOfDepartures> createState() =>
      _ExploreSelectedListOfDeparturesState();
}

class _ExploreSelectedListOfDeparturesState
    extends State<ExploreSelectedListOfDepartures> {
  List<TripDepartureDataModel> departures = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          widget.model.tripName,
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            StreamBuilder(
              stream: TripDeparturesCollection.getStreamDepartures(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: AppColors.newBlueColor,
                  ).center;
                }
                if (snapshot.hasData) {
                  departures = snapshot.data!.docs
                      .map(
                        (e) => e.data(),
                      )
                      .where(
                        (element) => element.tripId == widget.model.tripId,
                      )
                      .toList();
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TripDepartureItemWidget(
                    isUpdate: widget.isUpdate,
                    isDelete: widget.isDelete,
                    model: departures[index],
                  ),
                  separatorBuilder: (context, _) => 0.01.height.hSpace,
                  itemCount: departures.length,
                );
              },
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
