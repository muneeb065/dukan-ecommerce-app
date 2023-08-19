// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/view/profile_screen.dart';
import 'package:dukan/view/resubaleHeadingText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dukan/controller/cart_controller.dart';
import 'package:dukan/controller/cart_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/customers.dart';
import 'home_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class CheckoutScreen extends StatelessWidget {

  String? productImage;
  String? productName;

  CheckoutScreen({required this.productImage,required this.productName});
  final CartController _cartController = Get.find();

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerPhoneNoController = TextEditingController();
  TextEditingController customerDeliveryAddressController =
  TextEditingController();
      
  User? UserId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
       leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0,
        centerTitle: true,
        title: Text('Checkout',style: TextStyle(color: Colors.black, fontSize: 27.sp),),
        backgroundColor: Colors.white,

      ),
        body: SingleChildScrollView(
            // padding: EdgeInsets.all(16.0),
            child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ReusableHeadingText(
                      alignment: Alignment.centerLeft,
                      title: 'Billing Information',
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cost:',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal)),
                              Text('Rs. ${_cartController.calculateSubtotal()}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery Fee:',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal)),
                              Text('Rs.50',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total:',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal)),
                              Text('Rs. ${_cartController.calculateTotal()}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 10.r),
                ReusableHeadingText(
                  title: 'Enter Your Details',
                  alignment: Alignment.topLeft,
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: customerNameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20.r),
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: customerEmailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: customerPhoneNoController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                          textAlign: TextAlign.left,
                        controller: customerDeliveryAddressController,
                        maxLines: 4,
                        decoration: InputDecoration(
                         contentPadding: EdgeInsets.only(left: 20, top: 20), // Adjust left and top padding as needed
                          labelText: 'Delivery Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
     
     
                    Center(
                      child: Container(
                        height: 50.h,
                              width: 156.w,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: Color(0xff01BC87),
                                borderRadius: BorderRadius.circular(10),
                        ),
                        child: OutlinedButton(
                           style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff01BC87),),
                                    foregroundColor: MaterialStateProperty.all(
                                        const Color(0xffffffff)),
                                    side:
                                        MaterialStateProperty.all(BorderSide.none),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(45.0))),
                                  ),
                                  onPressed: () async{ 
                                    print(UserId) ;
                                      var customerName = customerNameController.text.trim();
                        var customerEmail = customerEmailController.text.trim();
                        var customerNumber =
                            customerPhoneNoController.text.trim();
                        var customerAddress =
                             customerDeliveryAddressController.text.trim();
                         var orderName = productName;
                         var orderImage = productImage;
                             var customerTotal = _cartController.calculateSubtotal().toString();
                            String customerId = UserId.toString();
                   
                         customers(customerName,customerEmail,customerNumber,customerAddress,customerTotal,customerId,orderImage,orderName);
                                  },
                          child: Center(
                            child: Text(
                                      'Order',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Inter',
                                          color: Colors.white),
                                    ),
                          ),
                        ),
                      ),
                    ),



              ]),
            ],
          ),
        )));
  }
}
