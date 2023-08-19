// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dukan/view/home_screen.dart';
import 'package:dukan/view/resubaleHeadingText.dart';
import 'package:dukan/view/search_screen.dart';
import 'package:dukan/view/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:dukan/controller/Image_Changer.dart';
import 'package:image_picker/image_picker.dart';
import '../reusable_bottomnavibar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 4;
  final ImagePickerController controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Choose an option'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      GestureDetector(
                                        child: Text('Gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _getCoverImage(ImageSource.gallery);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        child: Text('Camera'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _getCoverImage(ImageSource.camera);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Obx(() {
                          final hasImage =
                              controller.coverPath.value != null &&
                                  controller.coverPath.value.isNotEmpty;
                          return hasImage
                              ?   Container(
                        width: double.infinity,
                        height: 160.sp,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:FileImage(File(controller.coverPath.value)),
                                fit: BoxFit.cover)),
                      )
                              :  Container(
                        width: double.infinity,
                        height: 160.sp,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:FileImage(File(controller.coverPath.value)),
                                fit: BoxFit.cover)),
                      );
                        }),
                      ),
                    Positioned(
                       bottom: -70,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Choose an option'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      GestureDetector(
                                        child: Text('Gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _getImage(ImageSource.gallery);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        child: Text('Camera'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _getImage(ImageSource.camera);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Obx(() {
                          final hasImage =
                              controller.imagePath.value != null &&
                                  controller.imagePath.value.isNotEmpty;
                          return hasImage
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      FileImage(File(controller.imagePath.value)),
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                  ),
                                );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                ReusableHeadingText(title: 'Change Picture', alignment: Alignment.bottomCenter),
                SizedBox(
                  height: 30,
                ),
                // The rest of your code...
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //TODO:TEXTFIELD
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                                borderRadius: BorderRadius.circular(50),
                            elevation: 3,
                            child: ListTile(
                              //contentPadding: EdgeInsets.symmetric(vertical: 2),
                              leading: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 25,
                                  color: Color(0xff000000),
                                ),
                              ),
                              title: Text(
                                'Usertest333',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //TODO:TEXTFIELD2
                          Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                                borderRadius: BorderRadius.circular(50),
                            elevation: 3,
                            child: ListTile(
                              //contentPadding: EdgeInsets.symmetric(vertical: 2),
                              leading: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.email,
                                  size: 25,
                                  color: Color(0xff000000),
                                ),
                              ),
                              title: Text(
                                'Usertest333@gmail.com',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //TODO: TEXTFIELD3
                        SizedBox(height: 5),
                         Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                                borderRadius: BorderRadius.circular(50),
                            elevation: 3,
                            child: ListTile(
                              leading: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.calendar_month_sharp,
                                  size: 25,
                                  color: Color(0xff000000),
                                ),
                              ),
                              title: Text(
                                '10-Oct-2001',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //TODO:TEXT FIELD 4
                          Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                                borderRadius: BorderRadius.circular(50),
                            elevation: 3,
                            child: ListTile(
                              //contentPadding: EdgeInsets.symmetric(vertical: 2),
                              leading: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.lock,
                                  size: 25,
                                  color: Color(0xff000000),
                                ),
                              ),
                              title: Text(
                                'Usertesting123',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          width: 282.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffff0800)),
                              foregroundColor: MaterialStateProperty.all(
                                  const Color(0xff030303)),
                              side: MaterialStateProperty.all(BorderSide.none),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(45.0))),
                            ),
                            onPressed: () {
                              // FirebaseAuth.instance.signOut();
                              // Get.off(Signin());
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Inter',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) 

              ],
            ),
          ),
        ),
        bottomNavigationBar: ReusableBottomNaviBar(currentIndex: 4),
      ),
    );
  }

  // Add this method to the class to handle image picking
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      controller.imagePath.value = pickedFile.path;
    } else {
      print('No image selected.');
    }
  }
   Future<void> _getCoverImage(ImageSource source) async {
    final pickedCoverFile = await ImagePicker().pickImage(source: source);
    if (pickedCoverFile != null) {
      controller.coverPath.value = pickedCoverFile.path;
    } else {
      print('No image selected.');
    }
  }
  
}
