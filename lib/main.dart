import 'package:dukan/view/cart_screen.dart';
import 'package:dukan/view/displayproduct.dart';
import 'package:dukan/view/order_screen.dart';
import 'package:dukan/view/profile_Screen.dart';
import 'package:dukan/view/home_screen.dart';
import 'package:dukan/view/search_screen.dart';
import 'package:dukan/view/topCategory1.dart';
import 'package:dukan/view/topcategory2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:dukan/controller/cart_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put<CartController>(CartController());

  runApp(Dukan());
}

class Dukan extends StatelessWidget {
  const Dukan({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
     Get.put(CartController());
    return ScreenUtilInit(
      designSize: Size(360, 800),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ); 
      },
    );
  }
}
