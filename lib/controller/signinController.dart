
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:dukan/view/signup.dart';

// class LoginBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => LoginController());
//   }
// }

// class LoginController extends GetxController {
//   final loginFormKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void onInit() {
//     // Simulating obtaining the user name from some local storage
//     emailController.text = '';
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//    // passwordController.dispose();
//     super.onClose();
//   }

//   String? validator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please this field must be filled';
//     }
//     return null;
//   }

//   void login() {
//     if (loginFormKey.currentState!.validate()) {
//       checkUser(emailController.text, passwordController.text).then((auth) {
//         if (auth) {
//           Get.snackbar(
//             'Login',
//             'Login successfully',
//             snackPosition: SnackPosition.BOTTOM,
//             duration: Duration(seconds: 3),
//             backgroundColor: Colors.grey[900],
//             colorText: Colors.white,
//             borderRadius: 10.0,
//             margin: EdgeInsets.all(16.0),

//           );
//           Get.to(()=> Signup());
//         } else {
//           Get.snackbar(
//             'Login',
//             'Invalid email or password',
//             snackPosition: SnackPosition.BOTTOM,
//             duration: Duration(seconds: 3),
//             backgroundColor: Colors.grey[900],
//             colorText: Colors.white,
//             borderRadius: 10.0,
//             margin: EdgeInsets.all(16.0),
//           );
//         }
//         passwordController.clear();
//       });
//     }
//   }

//   // Api Simulation
//   Future<bool> checkUser(String user, String password) {
//     if (user == 'tech@' && password == '123') {
//       return Future.value(true);
//     }
//     return Future.value(false);
//   }
// }
