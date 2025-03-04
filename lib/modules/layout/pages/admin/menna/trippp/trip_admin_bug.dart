import 'dart:io';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import '/core/services/bot_toast.dart';
import '/core/services/storage.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/core/utils/company_collections.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/core/utils/id_generator.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/extensions/align.dart';
import '/core/widget/map.dart';
import '/modules/layout/pages/admin/menna/trippp/assign_flight_trip.dart';
import '/modules/layout/pages/admin/menna/trippp/assign_hotel.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/admin/pages/trips/pages/program_day.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/core/widget/widget_eleveted_button.dart';
import '/core/theme/app_colors.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  File? _image;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      _image = File(selectedImage.path);
    }
    setState(() {});
  }

  TextEditingController idController = TextEditingController();
  TextEditingController tripNameController = TextEditingController();
  TextEditingController tripTotalProgramsController = TextEditingController();
  TextEditingController tripVideoUrlController = TextEditingController();
  TextEditingController tripTotalGuestsController = TextEditingController();
  TextEditingController tripTotalDaysController = TextEditingController();
  TextEditingController tripBudgetController = TextEditingController();
  TextEditingController tripTitleController = TextEditingController();

  String? source;
  Company? selectedCompany;

  String? destination;

  var controller = DateRangePickerController();

  List<Company> companies = [];

  @override
  void initState() {
    _getAllCompanies();
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  _getAllCompanies() async {
    await CompanyCollections.getAllCompany().then(
      (value) {
        companies = value;
      },
    );
  }

  String? from;

  String? dest;

  @override
  Widget build(BuildContext context) {
    idController.text = IdGenerator.generateTripId(
        dayNumber: int.tryParse(tripTotalDaysController.text) ?? 0,
        tripOrganizedBy: selectedCompany?.companyName ?? "",
        tripTitle: tripTitleController.text ?? "");
    var provider = Provider.of<TripAdminProvider>(context);
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Trip",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: (_image == null)
                    ? GestureDetector(
                        onTap: () {
                          pickImage();
                          setState(() {});
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(AppAssets.noAvailableImages),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_image!),
                      ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: " Trip ID",
                controller: idController,
                isReadOnly: true,
              ),
              0.02.height.hSpace,
              CustomTextFormField(
                hintText: "Trip Name ",
                controller: tripTitleController,
                validation: (value) => (tripTitleController.text.isEmpty)
                    ? "Enter Trip Title"
                    : null,
              ),
              0.02.height.hSpace,
              CustomTextFormField(
                hintText: provider.source ?? "Source",
                isReadOnly: true,
              ),
              0.02.height.hSpace,
              CustomTextFormField(
                hintText: provider.destination ?? "Destination",
                isReadOnly: true,
              ),
              0.02.height.hSpace,
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppMaps.routeName);
                },
                child: Text(
                  "From .. To",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              0.01.height.hSpace,
              Container(
                height: 0.2.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: AppColors.newBlueColor,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AppMaps(),
                ),
              ).center,
              0.02.height.hSpace,
              CustomTextFormField(
                hintText: "Video Url",
                controller: tripVideoUrlController,
                validation: (value) => (tripVideoUrlController.text.isEmpty)
                    ? "Enter Vide Url"
                    : null,
              ),
              0.02.height.hSpace,
              NumbersTextFormField(
                hintText: "Total Guests",
                controller: tripTotalGuestsController,
                validation: (value) => (tripTotalGuestsController.text.isEmpty)
                    ? "Total Guests Can't be empty"
                    : null,
              ),
              0.02.height.hSpace,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: NumbersTextFormField(
                      hintText: "Budget",
                      controller: tripBudgetController,
                      onComplete: (p0) {
                        int value =
                            int.tryParse(tripTotalDaysController.text) ?? 0;
                        provider.setTotalDays(value);
                      },
                      validation: (value) => (tripBudgetController.text.isEmpty)
                          ? "Total Days Can't Be Empty"
                          : null,
                    ),
                  ),
                  0.01.width.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      padding: EdgeInsets.symmetric(vertical: 0.015.height),
                      text: provider.getCurrency?.name.substring(0, 4) ?? "Cur",
                      onPressed: () {
                        showCurrencyPicker(
                            context: context,
                            theme: CurrencyPickerThemeData(
                              flagSize: 25,
                              titleTextStyle: TextStyle(fontSize: 17),
                              subtitleTextStyle: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).hintColor),
                              bottomSheetHeight:
                                  MediaQuery.of(context).size.height / 2,
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            onSelect: (Currency currency) =>
                                provider.setCurrency(currency));
                      },
                    ),
                  )
                ],
              ),
              0.02.height.hSpace,
              NumbersTextFormField(
                hintText: "Total Days",
                controller: tripTotalDaysController,
                onComplete: (p0) {
                  int value = int.tryParse(tripTotalDaysController.text) ?? 0;
                  provider.setTotalDays(value);
                },
                validation: (value) => (tripTotalDaysController.text.isEmpty)
                    ? "Total Days Can't Be Empty"
                    : null,
              ),
              0.02.height.hSpace,
              NumbersTextFormField(
                hintText: "Total Programs",
                controller: tripTotalProgramsController,
                onComplete: (p0) {
                  int value =
                      int.tryParse(tripTotalProgramsController.text) ?? 0;
                  provider.setTotalPrograms(value);
                },
                validation: (value) =>
                    (tripTotalProgramsController.text.isEmpty)
                        ? "Total Programs Can't Be Empty"
                        : null,
              ),
              0.02.height.hSpace,
              DropdownMenu(
                enableSearch: true,
                width: double.maxFinite,
                hintText: "Organized By",
                onSelected: (value) {
                  provider.setSelectedCompany(value!);
                },
                dropdownMenuEntries: [
                  for (var company in companies)
                    DropdownMenuEntry(
                      value: company,
                      label: company.companyName,
                    ),
                ],
              ),
              0.02.height.hSpace,
              WidgetElevetedButton(
                borderRadius: 10,
                onPressed: () => Navigator.pushNamed(
                  context,
                  ProgramDay.routeName,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Program ${provider.getTotalDays} Days",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
              0.02.height.hSpace,
              WidgetElevetedButton(
                borderRadius: 10,
                onPressed: () {},
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AssignFlightTrip.routeName,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        provider.getSelectionFlight == null
                            ? "Assign Flight"
                            : "${provider.getSelectionFlight!.flightName}  ${provider.getSelectionFlight!.airline!.flighAirLineName}",
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.whiteColor,
                      )
                    ],
                  ),
                ),
              ),
              0.02.height.hSpace,
              WidgetElevetedButton(
                borderRadius: 10,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AssignHotel.routeName,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      provider.getSelectionHotel == null
                          ? "Assign Hotel"
                          : provider.getSelectionHotel!.hotelName,
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
              0.02.height.hSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "OK",
                      borderRadius: 10,
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            provider.getSelectionHotel != null &&
                            provider.getSelectionFlight != null &&
                            provider.getCurrency != null &&
                            provider.getSelectedCompany != null &&
                            _image != null &&
                            provider.getDaySpecificProgram.isNotEmpty) {
                          EasyLoading.show();
                          await Storage.uploadPublicTrip(
                            image: _image!,
                            fileName: idController.text,
                            tripName: tripNameController.text,
                          );
                          String imageUrl = Storage.getPublicUrlTripImage(
                                tripNameController.text,
                              ) ??
                              "";
                          // String imageUrl = "";
                          TripDataModel trip = TripDataModel(
                            destination: provider.destination ??
                                "No Destination Located",
                            source: provider.source ?? "No Source Located",
                            tripId: idController.text,
                            tripName: tripNameController.text,
                            tripVideoUrl: tripVideoUrlController.text,
                            fromLong: provider.getMarkers.first.point.longitude,
                            fromLat: provider.getMarkers.first.point.latitude,
                            toLat: provider.getMarkers[1].point.latitude,
                            toLong: provider.getMarkers[1].point.longitude,
                            totalGuests:
                                int.tryParse(tripTotalGuestsController.text) ??
                                    0,
                            price:
                                double.tryParse(tripBudgetController.text) ?? 0,
                            imageUrl: imageUrl,
                            currency: provider.getCurrency!.code,
                            organizedBy: provider.getSelectedCompany!,
                            programDetails: provider.listOfPrograms,
                            hotel: provider.getSelectionHotel!,
                            flight: provider.getSelectionFlight!,
                          );
                          print(imageUrl);
                          await TripCollections.addTrip(trip).then(
                            (value) {
                              if (value) {
                                EasyLoading.dismiss();
                                BotToastServices.showSuccessMessage(
                                  "Trip Added Successfully",
                                );
                                provider.endOfTrip();
                                Navigator.pop(context);
                              } else {
                                EasyLoading.dismiss();
                                BotToastServices.showErrorMessage(
                                  "Error While Upload Trip",
                                );
                              }
                            },
                          );
                        } else {
                          EasyLoading.showError("Check Your Inputs");
                        }
                      },
                    ),
                  ),
                  0.03.width.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      borderRadius: 10,
                      btnColor: AppColors.errorColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              0.02.height.hSpace,
            ],
          ).allPadding(10),
        ),
      ),
    );
  }
}
