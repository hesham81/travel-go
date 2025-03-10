import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/reservation_provider.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';
import 'package:u_credit_card/u_credit_card.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardValidTo = TextEditingController();
  TextEditingController cvv = TextEditingController();

  double balance = 0.0;

  // _checkCreditCard() {
  //   if (cardNumber.text.length == 16) {
  //     CreditCardDB.getCreditData(cardNumber.text).then(
  //       (value) {
  //         balance = value!.balance;
  //         if (value.holderName == cardHolderName.text &&
  //             value.expiryDate == cardValidTo.text &&
  //             value.cvv == cvv.text) {
  //           BotToastServices.showSuccessMessage("Payment Successfully");
  //         }
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(),
            Row(
              children: [
                Expanded(
                  child: CreditCardUi(
                    autoHideBalance: true,
                    bottomRightColor: AppColors.newBlueColor,
                    topLeftColor: AppColors.newBlueColor,
                    enableFlipping: true,
                    placeNfcIconAtTheEnd: true,
                    currencySymbol: provider.selectedDeparture!.trip.currency,
                    showValidFrom: false,
                    showBalance: true,
                    balance: balance,
                    cvvNumber: cvv.text,
                    cardType: CardType.giftCard,
                    creditCardType: CreditCardType.mastercard,
                    cardHolderFullName: cardHolderName.text.isNotEmpty
                        ? cardHolderName.text
                        : "cardHolderName",
                    cardNumber: cardNumber.text.isNotEmpty
                        ? cardNumber.text
                        : "cardNumber",
                    validThru:
                        cardValidTo.text.isNotEmpty ? cardValidTo.text : "1245",
                  ),
                ),
              ],
            ),
            0.02.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Card Number",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: "XXXX XXXX XXXX XXXX",
                  controller: cardNumber,
                  onChanged: (value) {
                    setState(() {
                      if (value!.length <= 16) cardNumber.text = value;
                      if (value.length > 16) cardNumber.clear();
                    });
                    return null;
                  },
                ),
                0.02.height.hSpace,
                Text(
                  "Card Holder Name",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: "Hisham Aymen ",
                  controller: cardHolderName,
                  onChanged: (value) {
                    setState(() {
                      cardHolderName.text = value!;
                    });
                    return null;
                  },
                ),
                0.02.height.hSpace,
                Text(
                  "Card Valid To",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "1225",
                  controller: cardValidTo,
                  onChanged: (value) {
                    setState(() {
                      if (value!.length < 4) cardValidTo.text = value;
                      if (value.length > 4) cardValidTo.clear();
                      if (value.length == 4) {
                        cardValidTo.text =
                            "${cardValidTo.text.substring(0, 2)}/${cardValidTo.text.substring(2, 4)}";
                      }
                    });
                    return null;
                  },
                ),
                0.02.height.hSpace,
                Text(
                  "CVV",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "1234",
                  controller: cvv,
                  onChanged: (value) {
                    setState(() {
                      if (value!.length < 4) cvv.text = value;
                      if (value.length > 4) cvv.clear();
                    });
                    return null;
                  },
                ),
                0.06.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: "OK",
                        onPressed: () {
                          EasyLoading.show();
                          Timer(
                            Duration(seconds: 3),
                            () => EasyLoading.dismiss(),
                          );

                          EasyLoading.showSuccess("Payment Successfully");
                          // _checkCreditCard();
                        },
                      ),
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: CustomElevatedButton(
                        text: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        btnColor: AppColors.errorColor,
                      ),
                    ),
                  ],
                )
              ],
            ).hPadding(0.03.width)
          ],
        )),
      ),
    );
  }
}
