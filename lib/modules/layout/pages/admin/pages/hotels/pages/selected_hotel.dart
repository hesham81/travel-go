// import 'package:country_state_city_picker/country_state_city_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:travel_go/core/services/bot_toast.dart';
// import 'package:travel_go/core/widget/custom_rating_widget.dart';
// import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/widgets/bottom_nav_sheet.dart';
// import '/core/extensions/align.dart';
// import '/core/extensions/extensions.dart';
// import '/core/theme/app_colors.dart';
// import '/core/utils/hotels_db.dart';
// import '/core/widget/custom_elevated_button.dart';
// import '/core/widget/custom_text_form_field.dart';
// import '/core/widget/label.dart';
// import '/core/widget/loading_image_network_widget.dart';
//
// import '/models/hotel_model.dart';
//
// class SelectedHotel extends StatefulWidget {
//   static const routeName = '/selected_hotel';
//
//   const SelectedHotel({super.key});
//
//   @override
//   State<SelectedHotel> createState() => _SelectedHotelState();
// }
//
// class _SelectedHotelState extends State<SelectedHotel> {
//   var viewMode = true;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
//     _showModelSheet(BuildContext context, String hotelName) {
//       showModalBottomSheet(
//         context: context,
//         builder: (context) => BottomNavSheet(
//           hotel: hotel,
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(hotel.hotelName),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             LoadingImageNetworkWidget(
//               imageUrl: hotel.imageUrl,
//             ),
//             0.01.height.hSpace,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Label(
//                   text: "Hotel Name",
//                   textSize: 15,
//                 ),
//                 0.01.height.hSpace,
//                 CustomTextFormField(
//                   hintText: hotel.hotelName,
//                   isReadOnly: viewMode,
//                 ),
//                 0.01.height.hSpace,
//                 Label(
//                   text: "Hotel Location",
//                   textSize: 15,
//                 ),
//                 0.01.height.hSpace,
//                 CustomTextFormField(
//                   hintText: hotel.hotelLocation,
//                   isReadOnly: viewMode,
//                 ),
//                 0.01.height.hSpace,
//                 Label(
//                   text: "Total Rooms",
//                   textSize: 15,
//                 ),
//                 0.01.height.hSpace,
//                 CustomTextFormField(
//                   hintText: hotel.totalRooms.toString(),
//                   isReadOnly: viewMode,
//                 ),
//                 0.01.height.hSpace,
//                 CustomRatingWidget(
//                   allowHalfRating: true,
//                   initialRating: hotel.hotelRating,
//                   minRating: hotel.hotelRating,
//                 ).center,
//                 0.01.height.hSpace,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomElevatedButton(
//                         text: "Update Hotel",
//                         textSize: 15,
//                         borderRadius: 10,
//                         onPressed: () {
//                           _showModelSheet(
//                             context,
//                             hotel.hotelName,
//                           );
//                         },
//                       ),
//                     ),
//                     0.02.width.vSpace,
//                     Expanded(
//                       child: CustomElevatedButton(
//                         text: "Delete Hotel",
//                         textSize: 15,
//                         btnColor: AppColors.errorColor.withOpacity(0.5),
//                         borderRadius: 10,
//                         onPressed: () async {
//                           EasyLoading.show();
//                           await HotelsDB.deleteHotelByName(hotel.hotelName);
//                           Navigator.pop(context);
//                           EasyLoading.dismiss();
//
//                           BotToastServices.showSuccessMessage(
//                             "Hotel Deleted Successfully ",
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ).hPadding(0.03.width)
//           ],
//         ),
//       ),
//     );
//   }
// }
