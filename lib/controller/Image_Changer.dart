import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;
  RxString coverPath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    } else {
      print('No image selected.');
    }
  }
    Future<void> pickCover(ImageSource source) async {
    final pickedCoverFile = await ImagePicker().pickImage(source: source);
    if (pickedCoverFile != null) {
      coverPath.value = pickedCoverFile.path;
    } else {
      print('No image selected.');
    }
  }
}
