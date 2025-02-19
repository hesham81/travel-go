import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class AttractionWidget extends StatelessWidget {
  const AttractionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Name",
                style: theme.textTheme.titleMedium,
              ),
              Spacer(),
              Text(
                "Blue Hole",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                "Location",
                style: theme.textTheme.titleMedium,
              ),
              Spacer(),
              Text(
                "Dahab",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                "Activity",
                style: theme.textTheme.titleMedium,
              ),
              Spacer(),
              Text(
                " Scuba Diving, Snorkeling",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://s3-alpha-sig.figma.com/img/4cdb/7315/f3312111895e5a4405d4a2b44908a98e?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KcVptXjQvMOFap4WnmSOppPFEF8qcDxKKd~KuFS0cDwd11sU5o9dPP2M36Hxig7snxejhnsbiYesRLw6sOmyXOopYWJKAiFFfaY9rONS~nrwqj9GhG3acgrBVkZqXixweUPijF-tTVW0L-jUQF5DdvyGryfh88beH9ctlP9U37JCP6OKS0VE36oc9SF8MmdiB4FrybDGc8N6j9yXOMS1tR38birKQD9sfFc8vpSyknJtVfAjCDDW0ynpy2qQRnaNheP6PZg9pGiPIYYMuDPoQrRn5peiZ5rp24g3FPNZlVHhJbhxuau0F13kXGiE-A3lvZldq~YGQt3C46njPU9cwQ__"),
                ),
              ),
              0.01.width.vSpace,
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://s3-alpha-sig.figma.com/img/4cdb/7315/f3312111895e5a4405d4a2b44908a98e?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KcVptXjQvMOFap4WnmSOppPFEF8qcDxKKd~KuFS0cDwd11sU5o9dPP2M36Hxig7snxejhnsbiYesRLw6sOmyXOopYWJKAiFFfaY9rONS~nrwqj9GhG3acgrBVkZqXixweUPijF-tTVW0L-jUQF5DdvyGryfh88beH9ctlP9U37JCP6OKS0VE36oc9SF8MmdiB4FrybDGc8N6j9yXOMS1tR38birKQD9sfFc8vpSyknJtVfAjCDDW0ynpy2qQRnaNheP6PZg9pGiPIYYMuDPoQrRn5peiZ5rp24g3FPNZlVHhJbhxuau0F13kXGiE-A3lvZldq~YGQt3C46njPU9cwQ__"),
                ),
              ),
              0.01.width.vSpace,
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://s3-alpha-sig.figma.com/img/4cdb/7315/f3312111895e5a4405d4a2b44908a98e?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=KcVptXjQvMOFap4WnmSOppPFEF8qcDxKKd~KuFS0cDwd11sU5o9dPP2M36Hxig7snxejhnsbiYesRLw6sOmyXOopYWJKAiFFfaY9rONS~nrwqj9GhG3acgrBVkZqXixweUPijF-tTVW0L-jUQF5DdvyGryfh88beH9ctlP9U37JCP6OKS0VE36oc9SF8MmdiB4FrybDGc8N6j9yXOMS1tR38birKQD9sfFc8vpSyknJtVfAjCDDW0ynpy2qQRnaNheP6PZg9pGiPIYYMuDPoQrRn5peiZ5rp24g3FPNZlVHhJbhxuau0F13kXGiE-A3lvZldq~YGQt3C46njPU9cwQ__"),
                ),
              ),
            ],
          )
        ],
      ).allPadding(10),
    );
  }
}
