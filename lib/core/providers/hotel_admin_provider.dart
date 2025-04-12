import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/services/storage.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/core/utils/id_generator.dart';
import 'package:travel_go/models/hotel_accomdations_data_model.dart';
import 'package:travel_go/models/hotel_model.dart';

class HotelAdminProvider extends ChangeNotifier {
  final List<Marker> _marker = [];

  List<File> singleImages = [];
  List<File> doubleImages = [];
  List<File> suitImages = [];

  List<Marker> get getMarker => _marker;

  File? _image;

  File? get getImage => _image;

  Future<void> pickImage({
    required ImageSource source,
    required List<File> targetList,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: source);

    if (selectedImage != null) {
      final File imageFile = File(selectedImage.path);
      targetList.add(imageFile);
      _image = imageFile;
      notifyListeners();
    }
  }

  Future<void> pickListOfImages({
    required List<File> targetList,
    required ImageSource source,
  }) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? selectedImages = await picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      final List<File> imageFiles =
          selectedImages.map((xFile) => File(xFile.path)).toList();
      targetList
          .addAll(imageFiles); // Add all selected images to the target list
    }
    notifyListeners();
  }

  Future<void> pickSingleImages() async {
    await pickListOfImages(
      targetList: singleImages,
      source: ImageSource.gallery,
    );
  }

  Future<void> pickDoubleImages() async {
    await pickListOfImages(
      targetList: doubleImages,
      source: ImageSource.gallery,
    );
  }

  Future<void> pickSuitImages() async {
    await pickListOfImages(
      targetList: suitImages,
      source: ImageSource.gallery,
    );
  }

  Future<void> pickSingleImagesList() async {
    await pickImage(source: ImageSource.gallery, targetList: singleImages);
  }

  Future<void> pickDoubleImagesList() async {
    await pickImage(source: ImageSource.gallery, targetList: doubleImages);
  }

  Future<void> pickSuitImagesList() async {
    await pickImage(source: ImageSource.gallery, targetList: suitImages);
  }

  void clearImages(List<File> targetList) {
    targetList.clear();
    notifyListeners();
  }

  // Clear all images from all lists
  void clearAllImages() {
    singleImages.clear();
    doubleImages.clear();
    suitImages.clear();
    notifyListeners();
  }

  pickImageTarget() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      _image = File(selectedImage.path);
    }
    notifyListeners();
  }

  void setMarker(Marker val) {
    _marker.clear();
    _marker.add(val);
    notifyListeners();
  }

  HotelAccomdationsDataModel? _singleRoom;

  HotelAccomdationsDataModel? _doubleRoom;

  HotelAccomdationsDataModel? _suitRoom;
  TextEditingController singleTotalRoomsController = TextEditingController();
  TextEditingController singleAvailableRoomsController =
      TextEditingController();
  TextEditingController singlePriceController = TextEditingController();

  TextEditingController doubleTotalRoomsController = TextEditingController();
  TextEditingController doubleAvailableRoomsController =
      TextEditingController();
  TextEditingController doublePriceController = TextEditingController();

  TextEditingController suiteTotalRoomsController = TextEditingController();
  TextEditingController suiteAvailableRoomsController = TextEditingController();
  TextEditingController suitePriceController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  TextEditingController hotelNameController = TextEditingController();
  TextEditingController hotelRatingController = TextEditingController();

  TextEditingController hotelIdController = TextEditingController();

  void createRooms({
    required HotelAccomdationsDataModel singleRoom,
    required HotelAccomdationsDataModel doubleRoom,
    required HotelAccomdationsDataModel suitRoom,
  }) {
    _singleRoom = singleRoom;
    _doubleRoom = doubleRoom;
    _suitRoom = suitRoom;
    notifyListeners();
  }

  HotelAccomdationsDataModel? get singleRoom => _singleRoom;

  HotelAccomdationsDataModel? get doubleRoom => _doubleRoom;

  HotelAccomdationsDataModel? get suitRoom => _suitRoom;

  void disposeData() {
    _singleRoom = null;
    _doubleRoom = null;
    _suitRoom = null;
    _image = null;
    singleImages.clear();
    doubleImages.clear();
    suitImages.clear();
    singleTotalRoomsController.clear();
    singleAvailableRoomsController.clear();
    singlePriceController.clear();
    doubleTotalRoomsController.clear();
    doubleAvailableRoomsController.clear();
    doublePriceController.clear();
    suiteTotalRoomsController.clear();
    suiteAvailableRoomsController.clear();
    suitePriceController.clear();
    hotelNameController.clear();
    hotelRatingController.clear();
    hotelIdController.clear();
    _marker.clear();
    clearAllImages();

    notifyListeners();
  }

  bool checkIfHotelIsValid() {
    if (_singleRoom != null &&
        _doubleRoom != null &&
        _suitRoom != null &&
        _image != null &&
        singleTotalRoomsController.text.isNotEmpty &&
        singleAvailableRoomsController.text.isNotEmpty &&
        singlePriceController.text.isNotEmpty &&
        doubleTotalRoomsController.text.isNotEmpty &&
        doubleAvailableRoomsController.text.isNotEmpty &&
        doublePriceController.text.isNotEmpty &&
        suiteTotalRoomsController.text.isNotEmpty &&
        suiteAvailableRoomsController.text.isNotEmpty &&
        hotelNameController.text.isNotEmpty &&
        hotelRatingController.text.isNotEmpty) {
      IdGenerator.generateHotelId(name: hotelNameController.text);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> confirm(BuildContext context) async {
    try {
      if (checkIfHotelIsValid()) {
        EasyLoading.show();
        await Storage.uploadHotels(
          hotelIdController.text,
          _image!,
        );
        BotToastServices.showSuccessMessage(
          "Hotel Image Uploaded Successfully",
        );
        for (int index = 0; index < singleImages.length; index++) {
          await Storage.uploadAttractions(
            singleImages[index],
            "Single",
            index,
          );
        }
        BotToastServices.showSuccessMessage(
          "Single Room Images Uploaded Successfully",
        );
        for (int index = 0; index < doubleImages.length; index++) {
          await Storage.uploadAttractions(
            doubleImages[index],
            "Double",
            index,
          );
        }
        BotToastServices.showSuccessMessage(
          "Double Room Images Uploaded Successfully",
        );
        for (int index = 0; index < suitImages.length; index++) {
          await Storage.uploadAttractions(
            suitImages[index],
            "Suit",
            index,
          );
        }
        BotToastServices.showSuccessMessage(
          "Suit Room Images Uploaded Successfully",
        );
      }
      List<String> singleImagesUrls = [];
      List<String> doubleImagesUrls = [];
      List<String> suitImagesUrls = [];
      for (var i = 0; i < singleImages.length; i++) {
        Storage.getHotelAccomdationlImage("Single", i);
        singleImagesUrls.add(Storage.getHotelAccomdationlImage("Single", i));
      }
      for (var i = 0; i < doubleImages.length; i++) {
        Storage.getHotelAccomdationlImage("Double", i);
        doubleImagesUrls.add(Storage.getHotelAccomdationlImage("Double", i));
      }
      for (var i = 0; i < suitImages.length; i++) {
        Storage.getHotelAccomdationlImage("Suit", i);
        suitImagesUrls.add(Storage.getHotelAccomdationlImage("Suit", i));
      }
      int totalRooms = int.tryParse(singleTotalRoomsController.text)! +
          int.tryParse(doubleTotalRoomsController.text)! +
          int.tryParse(suiteTotalRoomsController.text)!;
      int availableRooms = int.tryParse(singleAvailableRoomsController.text)! +
          int.tryParse(doubleAvailableRoomsController.text)! +
          int.tryParse(suiteAvailableRoomsController.text)!;
      HotelsDB.addHotel(
        hotel: Hotel(
          lat: _marker.first.point.latitude,
          long: _marker.first.point.longitude,
          id: hotelIdController.text,
          imageUrl: Storage.getHotelImage(hotelIdController.text),
          availableRooms: availableRooms,
          hotelLocation: "hotelLocation",
          hotelName: hotelNameController.text,
          hotelRating: double.tryParse(hotelRatingController.text)!,
          totalRooms: totalRooms,
          accomdations: [
            HotelAccomdationsDataModel(
              roomType: "Single Room",
              roomPrice: double.tryParse(singlePriceController.text)!,
              roomAvailable: int.tryParse(singleAvailableRoomsController.text)!,
              imagesUrls: singleImagesUrls,
            ),
            HotelAccomdationsDataModel(
              roomType: "Double Room",
              roomPrice: double.tryParse(doublePriceController.text)!,
              roomAvailable: int.tryParse(doubleAvailableRoomsController.text)!,
              imagesUrls: doubleImagesUrls,
            ),
            HotelAccomdationsDataModel(
              roomType: "Suite Room",
              roomPrice: double.tryParse(suitePriceController.text)!,
              roomAvailable: int.tryParse(suiteAvailableRoomsController.text)!,
              imagesUrls: suitImagesUrls,
            ),
          ],
        ),
      );
      EasyLoading.dismiss();
      disposeData();
      return Future.value(true);
    } catch (e) {
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }
}
