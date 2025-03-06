import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/company_model.dart';

class SelectedCompany extends StatelessWidget {
  final Company company;

  const SelectedCompany({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          company.companyName,
          style: theme.titleMedium!.copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
