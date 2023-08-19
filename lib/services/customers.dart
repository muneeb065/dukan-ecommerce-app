import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../view/home_screen.dart';
import '../view/order_screen.dart';

customers(String customerName, String customerEmail, String customerNumber,
    String customerAddress, String customerTotal, String customerId,String? orderImage,String? orderName) 
    async {
  try {
    await FirebaseFirestore.instance.collection('Orders').doc().set(
      {
        'customerName': customerName,
        'customerEmail': customerEmail,
        'customerNumber': customerNumber,
        'customerDeliveryAddress': customerAddress,
        'customerTotal': customerTotal,
        'customerId': customerId,
        'createdAt': DateTime.now(),
        'orderName':orderName,
        'orderImage':orderImage
      },
    ).then((value) => {Get.off(() => OrderScreen())});
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}

siginServices(String siginMail, String siginPassword) {}
