import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_text_button.dart';
import 'package:travel_go/modules/layout/pages/manager/pages/manager_home/pages/users_data/pages/users_reports_data_screen.dart';
import 'package:travel_go/modules/layout/pages/manager/providers/manager_provider.dart';
import '/core/constant/local_storage.dart';
import '/core/constant/shared_preferences_keys.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/modules/sign_in/pages/sign_in.dart';

class ManagerHomeScreen extends StatefulWidget {
  static const routeName = "/manager";

  const ManagerHomeScreen({super.key});

  @override
  State<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen> {
  List<Map<String, dynamic>> usersList = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ManagerProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => provider.checkUsersReload(),
          color: AppColors.newBlueColor,
          backgroundColor: AppColors.whiteColor,
          child: Column(
            children: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuthServices.logout();
                    LocalStorageData.setString(SharedPreferencesKey.login, "");
                    slideLeftWidget(
                      newPage: SignIn(),
                      context: context,
                    );
                  },
                  icon: Icon(Icons.logout)),
              Text(
                "Users Reports :",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  provider.isLoading
                      ? CircularProgressIndicator(
                          color: AppColors.newBlueColor,
                        )
                      : SizedBox(),
                  Container(
                    height: 50,
                    width: 70,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        "Users",
                        style: theme.labelLarge?.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 70,
                    color: Colors.yellow,
                    child: Center(
                      child: Text(
                        "Admins",
                        style: theme.labelMedium?.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 80,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Managers",
                        style: theme.labelMedium?.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ).hPadding(0.05.width),
              0.01.height.hSpace,
              SizedBox(
                height: 0.3.height,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: provider.endUsers.length.toDouble(),
                        color: Colors.green,
                        radius: 0.1.height,
                        title:
                            "${(provider.totalEndUsers / provider.totalUsers * 100).round()}%",
                        titleStyle: theme.titleLarge?.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                      PieChartSectionData(
                        value: provider.adminUsers.length.toDouble(),
                        color: Colors.yellow,
                        radius: 0.1.height,
                        titleStyle: theme.titleLarge?.copyWith(
                          color: AppColors.blackColor,
                        ),
                        title:
                            "${(provider.totalAdminUsers / provider.totalUsers * 100).round()}%",
                      ),
                      PieChartSectionData(
                        value: provider.managerUsers.length.toDouble(),
                        color: Colors.red,
                        radius: 0.1.height,
                        titleStyle: theme.titleLarge?.copyWith(
                          color: AppColors.blackColor,
                        ),
                        title:
                            "${(provider.totalManagerUsers / provider.totalUsers * 100).round()}%",
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextButton(
                onPressed: () => slideLeftWidget(
                  newPage: UsersReportsDataScreen(),
                  context: context,
                ),
                text: "Explore All Users Data",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
