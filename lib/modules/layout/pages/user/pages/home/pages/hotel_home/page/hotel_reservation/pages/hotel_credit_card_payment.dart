import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../../../../../../../../../../core/constant/soundEffects.dart';
import '../../../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../../../core/utils/credit_card_db.dart';
import '../../../../../../../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../../../../../../../core/widget/custom_text_form_field.dart';
import '../../../../../../../../../../../core/widget/numbers_text_form_field.dart';
import '../../../../../../../../../../../models/credit_card_model.dart';
import '../../../../../../../widget/app_bar.dart';

class HotelCreditCardPayment extends StatefulWidget {
  final double totalBalance;

  const HotelCreditCardPayment({
    super.key,
    required this.totalBalance,
  });

  @override
  State<HotelCreditCardPayment> createState() => _HotelCreditCardPaymentState();
}

class _HotelCreditCardPaymentState extends State<HotelCreditCardPayment> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CreditCardModel? cardData;

  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardValidTo = TextEditingController();
  TextEditingController cvv = TextEditingController();

  double balance = 0.0;
  final player = AudioPlayer();

  _checkCreditCardData(CreditCardModel card) async {
    await CreditCardDB.getCreditData(card.creditNumber).then(
          (value) {
        if (value != null) {
          setState(() {
            cardData = value;
          });
        } else {}
      },
    );
  }
  Future<void> _playSounds() async {
    await player.play(
      AssetSource(SoundEffects.cashMoney),
    );
  }

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
                    currencySymbol: "Eur",
                    showValidFrom: false,
                    showBalance: true,
                    balance: 200,
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
                  validation: (value) {
                    (value!.length < 3) ? "Please enter a valid CVV" : null;
                    return null;
                  },
                ),
                0.06.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: "OK",
                        onPressed: () async {
                          EasyLoading.show();
                          _checkCreditCardData(
                            CreditCardModel(
                              creditNumber: cardNumber.text,
                              cvv: cvv.text,
                              expiryDate: cardValidTo.text,
                              holderName: cardHolderName.text,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          );
                          if (cardData != null) {
                            setState(() {
                              balance = cardData!.balance!;
                            });
                            await CreditCardDB.withDraw(
                              cardNumber.text,
                              widget.totalBalance,
                            ).then(
                              (value) async {
                                EasyLoading.dismiss();
                                if (value) {
                                  EasyLoading.dismiss();
                                  await _playSounds();

                                  Navigator.pop(context);
                                } else {
                                  BotToastServices.showErrorMessage(
                                    "Your Money Is Not Enough",
                                  );
                                }
                              },
                            );
                            provider.setHotelCard(CreditCardModel(
                              creditNumber: cardNumber.text,
                              cvv: cvv.text,
                              expiryDate: cardValidTo.text,
                              holderName: cardHolderName.text,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            ));
                          } else {
                            EasyLoading.dismiss();
                            BotToastServices.showErrorMessage(
                              "Card Is Not Valid",
                            );
                          }
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
