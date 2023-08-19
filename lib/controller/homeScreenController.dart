import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreenController extends GetxController {
  final selectedButton = 0.obs; // Observable variable to track the selected button

  void selectButton(int index) {
    selectedButton.value = index; // Update the selected button index
  }

  Color? getButtonColor(int index) {
    return index == selectedButton.value ? Color(0xffC0E862) : Colors.black12; // Set color based on selected button
  }

  RxInt currentIndex = 0.obs;
  void slidervalueUpdater(int index) {
    currentIndex.value = index;
    update();
  }

  RxInt sliderValueReturn() {
    return currentIndex;
  }
}
