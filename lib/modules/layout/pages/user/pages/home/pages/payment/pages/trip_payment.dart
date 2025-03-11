import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/constant/sounds.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/reservation_provider.dart';
import '/core/services/bot_toast.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/credit_card_db.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/models/credit_card_model.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/pages/flight_reservation/pages/flights_reservations_basic_info/pages/flight_reservations.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';
import 'package:u_credit_card/u_credit_card.dart';

class TripPayment extends StatefulWidget {
  const TripPayment({super.key});

  @override
  State<TripPayment> createState() => _TripPaymentState();
}

class _TripPaymentState extends State<TripPayment> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CreditCardModel? cardData;

  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardValidTo = TextEditingController();
  TextEditingController cvv = TextEditingController();

  double balance = 0.0;
  final player = AudioPlayer();

  Future<void>_checkCreditCardData(CreditCardModel card) async {
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
      AssetSource(Sounds.cashMoney),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formKey,
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
                      validThru: cardValidTo.text.isNotEmpty
                          ? cardValidTo.text
                          : "1245",
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
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Card Number";
                      }
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
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Card Holder Name";
                      }
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
                    validation: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Card Valid To";
                      }
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
                      if (value!.isEmpty) {
                        return "Please Enter CVV";
                      }
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
                            if (formKey.currentState!.validate()) {
                              EasyLoading.show();
                              await _checkCreditCardData(
                                CreditCardModel(
                                  creditNumber: cardNumber.text,
                                  cvv: cvv.text,
                                  expiryDate: cardValidTo.text,
                                  holderName: cardHolderName.text,
                                  userId: provider.user!.uid,
                                ),
                              );
                              if (cardData != null) {
                                setState(() {
                                  balance = cardData!.balance!;
                                });
                                await CreditCardDB.withDraw(
                                  cardNumber.text,
                                  provider.getSelectedDeparture!.trip.price * (provider.totalUsers +1 ),
                                ).then(
                                  (value) async {
                                    EasyLoading.dismiss();
                                    if (value) {
                                      EasyLoading.dismiss();
                                      provider.setCard(cardData!);
                                      await _playSounds();
                                      replaceWidget(
                                        newPage: FlightReservations(),
                                        context: context,
                                      );
                                    } else {
                                      BotToastServices.showErrorMessage(
                                        "Your Money Is Not Enough",
                                      );
                                    }
                                  },
                                );
                              } else {
                                EasyLoading.dismiss();
                                BotToastServices.showErrorMessage(
                                  "Card Is Not Valid",
                                );
                              }
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
          ),
        )),
      ),
    );
  }
}
