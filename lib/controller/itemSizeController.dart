import 'package:get/get.dart';

class SizeSelectionController extends GetxController {
  RxString selectedSize = "".obs;

  void setSize(String size) {
    selectedSize.value = size;
  }
}
