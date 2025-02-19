import 'package:debit_credit_card_widget/debit_credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/home.dart';
import '/core/utils/credit_card_db.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/credit_card_model.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/label.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController cardHoldNumber = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardDate = TextEditingController();
  TextEditingController cardCvv = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cNumber = cardNumber.text;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DebitCreditCardWidget(
              cardExpiry: cardDate.text,
              cardHolderName: cardHoldNumber.text,
              cardNumber: cardNumber.text.isEmpty
                  ? "**** **** **** ****"
                  : cardNumber.text,
              cardBrand: CardBrand.mastercard,
              showNFC: true,
              cardType: CardType.custom,
            ),
            0.01.height.hSpace,
            Label(
              text: "Card Number ",
              style: theme.textTheme.titleMedium,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "Card Number ",
              controller: cardNumber,
              keyboardType: TextInputType.number,
              inputFormatters: [
                CreditCardNumberInputFormatter(
                  useSeparators: true,
                ),
              ],
            ),
            0.01.height.hSpace,
            Label(
              text: "Expire Date ",
              style: theme.textTheme.titleMedium,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "MM/YY",
              controller: cardDate,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(4), // Limits input to 4 digits
                FilteringTextInputFormatter.digitsOnly, // Allows only numbers
              ],
            ),
            0.01.height.hSpace,
            Label(
              text: "Holder Name ",
              style: theme.textTheme.titleMedium,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "name",
              controller: cardHoldNumber,
            ),
            0.03.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomElevatedButton(
                  text: "Pay",
                  textSize: 17,
                  borderRadius: 10,
                  onPressed: () async {
                    EasyLoading.show();
                    bool response = await CreditCardDB.checkIfDataValidOrNot(
                      CreditCardModel(
                        creditNumber: cardNumber.text,
                        cardHolder: cardHoldNumber.text,
                        cvv: "123",
                        expiryDate: cardDate.text,
                        userId: FirebaseAuthServices.getCurrentUserData()!
                            .uid
                            .toString(),
                      ),
                    ).then(
                      (value) => value,
                    );
                    EasyLoading.dismiss();
                    if (response) {
                      BotToastServices.showSuccessMessage("Payment Success");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Home.routeName,
                        (route) => false,
                      );
                    } else {
                      BotToastServices.showErrorMessage("Payment Failed");
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ).hPadding(
        0.03.width,
      ),
    );
  }
}
