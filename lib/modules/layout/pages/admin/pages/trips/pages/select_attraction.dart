import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/attractions_db.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/attractions_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/new_attractions/pages/new_attraction.dart';

class SelectAttraction extends StatefulWidget {
  static const String routeName = "/select-program-attractions";

  const SelectAttraction({super.key});

  @override
  State<SelectAttraction> createState() => _SelectAttractionState();
}

class _SelectAttractionState extends State<SelectAttraction> {
  List<AttractionsModel> attractions = [];
  late TripAdminProvider provider;

  _getAllAttractions(BuildContext context) async {
    EasyLoading.show();
    await AttractionsDB.getAttractionsList().then(
      (value) {
        EasyLoading.dismiss();
        provider.attractions = value;
      },
    );
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TripAdminProvider>(context);
    _getAllAttractions(context);

    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Program ${provider.listOfPrograms.length + 1} Attractions",
          style: theme.titleMedium!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CheckboxListTile(
                value: provider.selectedAttraction
                    .contains(provider.attractions[index]),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      provider.selectedAttraction
                          .add(provider.attractions[index]);
                    } else {
                      provider.selectedAttraction
                          .remove(provider.attractions[index]);
                    }
                  });
                },
                title: Text(
                  provider.attractions[index].title,
                  style:
                      theme.bodyMedium!.copyWith(color: AppColors.blackColor),
                ),
              ),
              separatorBuilder: (context, index) => 0.02.height.hSpace,
              itemCount: provider.attractions.length,
            ),
            0.01.height.hSpace,
            CustomElevatedButton(
              text: "Add Attraction",
              borderRadius: 10,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewAttraction(),
                ),
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
