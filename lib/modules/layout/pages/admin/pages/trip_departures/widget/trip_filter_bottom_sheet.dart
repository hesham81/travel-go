import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/providers/collections_provider.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';

class TripFilterBottomSheet extends StatefulWidget {
  final Function() sortAToZ;
  final Function() sortZToA;
  final Function() mostCheep;
  final Function(Company?) companyFilter;

  const TripFilterBottomSheet({
    super.key,
    required this.sortAToZ,
    required this.sortZToA,
    required this.mostCheep,
    required this.companyFilter,
  });

  @override
  State<TripFilterBottomSheet> createState() => _TripFilterBottomSheetState();
}

class _TripFilterBottomSheetState extends State<TripFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CollectionsProvider>(context);
    var theme = Theme.of(context).textTheme;
    return Container(
      height: 0.7.height,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sort By",
              style: theme.labelLarge,
            ),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  text: "A-Z",
                  borderRadius: 25,
                  onPressed: widget.sortAToZ,
                ),
                0.01.width.vSpace,
                CustomElevatedButton(
                  text: "Z-A",
                  borderRadius: 25,
                  onPressed: widget.sortZToA,
                ),
                0.01.width.vSpace,
              ],
            ),
            0.01.height.hSpace,
            Divider(
              color: AppColors.newBlueColor,
            ).hPadding(0.07.width),
            0.01.height.hSpace,
            Text(
              "Company",
              style: theme.labelLarge,
            ),
            0.01.height.hSpace,
            Column(
              children: [
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),

                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: provider.getAllCompaniesData
                      .map((e) => CustomElevatedButton(
                            text: e.companyName,
                            borderRadius: 25,
                            onPressed: () => widget.companyFilter(e),
                          ).allPadding(10))
                      .toList(),
                ),
              ],
            ),
          ],
        ).allPadding(16),
      ),
    );
  }
}
