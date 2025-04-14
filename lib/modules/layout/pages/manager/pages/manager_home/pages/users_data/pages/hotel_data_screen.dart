import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/hotels_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/manager/providers/manager_provider.dart';

class HotelReportsDataScreen extends StatefulWidget {
  const HotelReportsDataScreen({super.key});

  @override
  State<HotelReportsDataScreen> createState() => _HotelReportsDataScreenState();
}

class _HotelReportsDataScreenState extends State<HotelReportsDataScreen> {
  List<Hotels> hotels = [];


  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
    var provider = Provider.of<ManagerProvider>(context, listen: false);
    users = provider.users.map((user) => Users.fromMap(user)).toList();

    // Categorize users based on their roles
    adminUsers = users.where((user) => user.role == 'admin').toList();
    managerUsers = users.where((user) => user.role == 'manager').toList();
    users = users.where((user) => user.role != 'admin' && user.role != 'manager').toList();

    setState(() {}); // Refresh the UI after fetching and categorizing data
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _buildUserTable("Admins", adminUsers, theme, screenWidth),
              _buildUserTable("Managers", managerUsers, theme, screenWidth),
              _buildUserTable("Users", users, theme, screenWidth),
              0.03.height.hSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTable(String title, List<Users> userList, TextTheme theme, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: theme.titleLarge?.copyWith(
              color: AppColors.newBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth, // Set max width to screen width
            ),
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.newBlueColor,
              ),
              headingTextStyle: theme.titleLarge?.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
              dataRowColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.whiteColor,
              ),
              dividerThickness: 2,
              border: TableBorder.all(
                color: AppColors.newBlueColor,
                width: 1.5,
                borderRadius: BorderRadius.circular(8.0),
              ),
              columns: [
                DataColumn(
                  label: Container(
                    width: 100, // Set a minimum width for the UID column
                    child: Text(
                      "UID",
                      style: theme.titleLarge?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Container(
                    width: 200, // Set a minimum width for the Email column
                    child: Text(
                      "Email",
                      style: theme.titleLarge?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "National ID",
                    style: theme.titleLarge?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
              rows: userList.map((user) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        user.uid ?? "N/A",
                        style: theme.labelLarge?.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        user.email ?? "N/A",
                        style: theme.labelLarge?.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 150, // Set a minimum width for the National ID cell
                        child: Text(
                          user.nationalId ?? "N/A",
                          style: theme.labelLarge?.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    ).hPadding(0.01.width);
  }
}