// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class SignupController extends GetxController {
//   TextEditingController usernameController = TextEditingController();
//    TextEditingController emailController = TextEditingController();
//     TextEditingController dobController = TextEditingController();
//      TextEditingController passwordController = TextEditingController();


//   RxString username = RxString('');
//   RxString email = RxString('');
//   RxString emailError = RxString('');
//   RxString dob = RxString('');
//   RxString password = RxString('');
//    Rx<File?> image = Rx<File?>(null); // Add this line to hold the user's profile image

//   void setImage(File imageFile) {
//     image.value = imageFile;
//   }
//     void validateUsername(String value) {
//     if (value.isEmpty) {
//       // Username is empty
//       // You can show an error message or perform any other action
//       print('Username is empty');
//     } else if (value.length < 4) {
//       // Username is too short
//       // You can show an error message or perform any other action
//       print('Username is too short');
//     } else {
//       // Username is valid
//       // You can perform any required action
//       print('Username is valid: $value');
//     }
//   }


//   void signup() {
        

    
//     // Validate the input fields
//     if (username.value.isEmpty || email.value.isEmpty || dob.value.isEmpty || password.value.isEmpty) {
//       // Display an error message if any field is empty
//       Get.snackbar('Error', 'Please fill in all fields',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 3),
//       backgroundColor: Colors.grey[900],
//       colorText: Colors.white,
//       borderRadius: 10.0,
//       margin: EdgeInsets.all(16.0),);
//       return;
//     }

    

//     // Clear the input fields after signup
//     username.value = '';
//     email.value = '';
//     dob.value = '';
//     password.value = '';

//     // Display a success message
//     Get.snackbar('Success', 'Signup successful',snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 3),
//       backgroundColor: Colors.grey[900],
//       colorText: Colors.white,
//       borderRadius: 10.0,
//       margin: EdgeInsets.all(16.0),);
//   }
// }
