import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/programs_collections.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';
import '/modules/layout/pages/admin/pages/programs/pages/new_program.dart';
import '/modules/layout/pages/admin/pages/programs/widget/build_program_widget.dart';

import '/core/theme/app_colors.dart';

class ExploreProgram extends StatefulWidget {
  const ExploreProgram({super.key});

  @override
  State<ExploreProgram> createState() => _ExploreProgramState();
}

class _ExploreProgramState extends State<ExploreProgram> {
  TextEditingController searchController = TextEditingController();
  List<Program> programs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travel Go",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.01.height.hSpace,
            StreamBuilder(
              stream: ProgramsCollections.getStreamPrograms(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        color: AppColors.newBlueColor,
                        size: 180,
                      ).center,
                      0.01.height.hSpace,
                      Text(
                        "No Programs Available",
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ).center,
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator().center,
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_wifi_connected_no_internet_4_sharp,
                        color: AppColors.newBlueColor,
                        size: 180,
                      ).center,
                      0.01.height.hSpace,
                      Text(
                        "No Internet Connections",
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ),
                    ],
                  );
                }

                programs = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => BuildProgramWidget(
                    model: programs[index],
                  ),
                  separatorBuilder: (context, _) => 0.01.height.hSpace,
                  itemCount: programs.length,
                );
              },
            ),
            0.01.height.hSpace,
            CustomElevatedButton(
              text: "New Program",
              borderRadius: 10,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NewProgram.routeName,
                );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
