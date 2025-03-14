import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/constant/soundEffects.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/credit_card_db.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/models/credit_card_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/payment/pages/credit_card.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/pages/hotel_reservations_info/pages/hotel_reservation_user.dart';
import 'package:u_credit_card/u_credit_card.dart';

class OldCards extends StatefulWidget {
  const OldCards({super.key});

  @override
  State<OldCards> createState() => _OldCardsState();
}

class _OldCardsState extends State<OldCards> {
  final player = AudioPlayer();

  Future<void> _playSounds() async {
    await player.play(
      AssetSource(SoundEffects.cashMoney),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          0.3.height.hSpace,
          SafeArea(
            child: CreditCardUi(
              autoHideBalance: true,
              bottomRightColor: AppColors.newBlueColor,
              topLeftColor: AppColors.newBlueColor,
              enableFlipping: true,
              placeNfcIconAtTheEnd: true,
              currencySymbol: provider.selectedDeparture!.trip.currency,
              showValidFrom: false,
              showBalance: true,
              balance: provider.getCard!.balance,
              cvvNumber: provider.getCard!.cvv,
              cardType: CardType.giftCard,
              creditCardType: CreditCardType.mastercard,
              cardHolderFullName: provider.getCard!.holderName,
              cardNumber: provider.getCard!.creditNumber,
              validThru: provider.getCard!.expiryDate,
            ),
          ).center,
          Spacer(),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: "OK",
                  onPressed: () async {
                    if (provider.getCard!.balance! >= 8000) {
                      EasyLoading.show();
                      await CreditCardDB.withDraw(
                          provider.getCard!.creditNumber, 8000);
                      await _playSounds();
                      CreditCardModel card = CreditCardModel(
                        creditNumber: provider.getCard!.creditNumber,
                        cvv: provider.getCard!.cvv,
                        expiryDate: provider.getCard!.expiryDate,
                        holderName: provider.getCard!.holderName,
                        userId: provider.getCard!.userId,
                        balance: (provider.getCard!.balance! - 8000),
                      );
                      provider.setCard(card);
                      EasyLoading.dismiss();
                      replaceWidget(
                        newPage: HotelReservationUser(),
                        context: context,
                      );
                    } else {
                      EasyLoading.showError("Your Money Is Not Enough");
                    }
                  },
                ),
              ),
              0.02.width.vSpace,
              Expanded(
                child: CustomElevatedButton(
                  text: "Another Card",
                  btnColor: AppColors.errorColor,
                  onPressed: () => slideLeftWidget(
                      newPage: CreditCardScreen(
                        route: HotelReservationUser(),
                      ),
                      context: context),
                ),
              ),
            ],
          ).hPadding(0.03.width),
          0.01.height.hSpace,
        ],
      ),
    );
  }
}
