import 'package:get/get.dart';

class UserController extends GetxController {
  // Variables to hold user details
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString userdob = "".obs;
  // Add other fields as required (e.g., age, address, etc.)

  // Method to update user details
  void updateUserDetails(String name, String email, String dob) {
    userName.value = name;
    userEmail.value = email;
    userdob.value = dob;
  }
}
