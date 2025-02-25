import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/modules/layout/pages/manager/pages/utils/users_reports.dart';

class ManagerHomeScreen extends StatefulWidget {
  static const routeName = "/manager";

  const ManagerHomeScreen({super.key});

  @override
  State<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen> {
  List<Map<String, dynamic>> usersList = [];

  _getTotalUsers() async {
    print("Caleed");
    var users = await UsersReports.getTotalUsersData();
    usersList = users
        .map(
          (e) => e.data(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _getTotalUsers();
    UsersReports.getAllAppUsers().then(
      (value) => print(value),
    );

    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tour And Travel App",
          style: theme.titleLarge?.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            "Users Reports :",
          ),
          SfPyramidChart(
            title: ChartTitle(
              text: "Users Reports",
            ),
            series: PyramidSeries(
              dataSource: [
                {"x": "Users", "y": usersList.length},
                {"x": "Managers", "y": 1},
              ],
              xValueMapper: (datum, index) => datum["x"],
              yValueMapper: (datum, index) => datum["y"],
              dataLabelSettings: DataLabelSettings(
                isVisible: true,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
