import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/hotel_admin_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/core/widget/numbers_text_form_field.dart';
import 'package:travel_go/core/widget/widget_eleveted_button.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/widgets/hotel_map.dart';

class NewHotel extends StatelessWidget {
  const NewHotel({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HotelAdminProvider>(context);
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Hotel",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppAssets.noAvailableImages,
            ),
            0.01.height.hSpace,
            Column(
              children: [
                CustomTextFormField(
                  hintText: "Hotel ID",
                  isReadOnly: true,
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: "Hotel Name",
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "Hotel Rating",
                ),
                0.01.height.hSpace,
                SizedBox(
                  height: 0.4.height,
                  width: double.maxFinite,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                    child: HotelMap(),
                  ),
                ),
                0.01.height.hSpace,
                WidgetElevetedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "Hotel Accomdations",
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.2.height.hSpace,
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "OK",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                0.02.width.vSpace,
                Expanded(
                  child: CustomElevatedButton(
                    btnColor: AppColors.errorColor,
                    text: "Cancel",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.03.height.hSpace
          ],
        ),
      ),
    );
  }
}
