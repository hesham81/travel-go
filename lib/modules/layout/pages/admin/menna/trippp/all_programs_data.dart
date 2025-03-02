import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';
import '/modules/layout/pages/admin/pages/programs/widget/build_program_widget.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/admin/pages/trips/pages/trip_program.dart';

class AllProgramsData extends StatefulWidget {
  static const routeName = '/all-programs-data';

  const AllProgramsData({super.key});

  @override
  State<AllProgramsData> createState() => _AllProgramsDataState();
}

class _AllProgramsDataState extends State<AllProgramsData> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context)!.settings.arguments as int;
    var provider = Provider.of<TripAdminProvider>(context);
    isEmpty = provider.getDaySpecificProgram.isEmpty;
    List<Program> programs = provider.getProgramFromDay(index);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Day ${index + 1} Programs',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (programs.isEmpty)
                ? Image.network(
                    "https://i.pinimg.com/736x/46/4b/ca/464bca0a73f4213243a7293eeb70c639.jpg")
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => BuildProgramWidget(
                      model: programs[index],
                    ),
                    separatorBuilder: (context, _) => 0.01.height.hSpace,
                    itemCount: programs.length,
                  ),
            CustomElevatedButton(
              text: "Add Program",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  TripProgram.routeName,
                  arguments: index,
                );
              },
              borderRadius: 10,
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
