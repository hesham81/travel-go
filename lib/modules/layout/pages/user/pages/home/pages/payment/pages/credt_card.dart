import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  TextEditingController cardNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
