// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, sort_child_properties_last

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dukan/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:dukan/view/signin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dukan/view/displayproduct.dart';
import 'package:dukan/view/welcomescreen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPageIndex);
    _startAutoPlay();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    const Duration autoPlayInterval = Duration(seconds: 3);
    _timer = Timer.periodic(autoPlayInterval, (_) {
      if (_currentPageIndex < 2) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait)
            return PageView(
              controller: _pageController,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 469.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Color(0xffc5EB6D),
                      ),
                      child: Image(
                        image: AssetImage('assets/one.png'),
                        height: 50.h,
                        width: 50.w,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      height: 220.h,
                      child: Column(
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Join with us",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 50.h),
                          Container(
                            width: 312.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff0D1C2E)),
                                foregroundColor: MaterialStateProperty.all(
                                    const Color(0xffffffff)),
                                side:
                                    MaterialStateProperty.all(BorderSide.none),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45.0))),
                              ),
                              onPressed: () {
                                Get.to(Signup());
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Inter',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Prev',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0xffC5EB6D),
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5EB6D),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0xffC5EB6D),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 469.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Color(0xffc5EB6D),
                      ),
                      child: Image(
                        image: AssetImage('assets/two.png'),
                        height: 50.h,
                        width: 50.w,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      height: 220.h,
                      child: Column(
                        children: [
                          Text(
                            "Delievery",
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Faster Your Immagination",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 50.h),
                          Container(
                            width: 312.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffC5EB6D)),
                                foregroundColor: MaterialStateProperty.all(
                                    const Color(0xff00000)),
                                side:
                                    MaterialStateProperty.all(BorderSide.none),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45.0))),
                              ),
                              onPressed: () {
                                Get.to(Signup());
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Inter',
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Prev',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0xffC5EB6D),
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
                                  width: 20.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5EB6D),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0xffC5EB6D),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 469.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Color(0xffc5EB6D),
                      ),
                      child: Image(
                        image: AssetImage('assets/third.png'),
                        height: 50.h,
                        width: 50.w,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      height: 220.h,
                      child: Column(
                        children: [
                          Text(
                            "Shopping",
                            style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Branded Products on Cheap Prices",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 50.h),
                          Container(
                            width: 312.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff0D1C2E)),
                                foregroundColor: MaterialStateProperty.all(
                                    const Color(0xff00000)),
                                side:
                                    MaterialStateProperty.all(BorderSide.none),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45.0))),
                              ),
                              onPressed: () {
                                Get.to(Signup());
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Inter',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Prev',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0xffC5EB6D),
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Container(
                                  width: 20.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffC5EB6D),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(0xffC5EB6D),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          else
            return PageView(
              controller: _pageController,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: mediaQuery.height * 1,
                    width: mediaQuery.width * 1,
                    child: Column(
                      children: [
                        Container(
                          height: mediaQuery.height * .5,
                          width: mediaQuery.width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            color: Color(0xffc5EB6D),
                          ),
                          child: Image(
                            image: AssetImage('assets/one.png'),
                            height: 50,
                            width: 50,
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * .06),
                        Container(
                          height: mediaQuery.height * 0.3,
                          child: Column(
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: mediaQuery.height * .002),
                              Text(
                                "Join with us",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: mediaQuery.height * .01),
                              ElevatedButton(
                                onPressed: () {},
                                child: Center(
                                  child: Text(
                                    'Get started',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            45.0), // Set the radius value here
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xff0D1C2E)),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                      Size(mediaQuery.width * .4,
                                          mediaQuery.height * .06),
                                    ) // Set the background color here
                                    ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * .02),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Prev',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffC5EB6D),
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Color(0xffC5EB6D),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Color(0xffD9D9D9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Color(0xffD9D9D9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffC5EB6D),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * .001),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: mediaQuery.height * 1,
                      width: mediaQuery.width * 1,
                      child: Column(
                        children: [
                          Container(
                            height: mediaQuery.height * .5,
                            width: mediaQuery.width * 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              color: Color(0xff0D1C2E),
                            ),
                            child: Image(
                              image: AssetImage('assets/two.png'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .06),
                          Container(
                            height: mediaQuery.height * 0.3,
                            child: Column(
                              children: [
                                Text(
                                  "Delievery",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: mediaQuery.height * .002),
                                Text(
                                  "Faster Your Imagination",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: mediaQuery.height * .01),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Welcome3(),
                                    //   ),
                                    // );
                                  },
                                  // ignore: sort_child_properties_last
                                  child: Center(
                                    child: Text(
                                      'Get started',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff030303)),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              45.0), // Set the radius value here
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xffC0E862)),
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                        Size(mediaQuery.width * .4,
                                            mediaQuery.height * .06),
                                      ) // Set the background color here
                                      ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .02),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Prev',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffC5EB6D),
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Color(0xffD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC5EB6D),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Color(0xffD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffC5EB6D),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .001),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: mediaQuery.height * 1,
                      width: mediaQuery.width * 1,
                      child: Column(
                        children: [
                          Container(
                            height: mediaQuery.height * .5,
                            width: mediaQuery.width * 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              color: Color(0xffc5EB6D),
                            ),
                            child: Image(
                              image: AssetImage('assets/third.png'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .06),
                          Container(
                            height: mediaQuery.height * 0.3,
                            child: Column(
                              children: [
                                Text(
                                  "Shopping",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: mediaQuery.height * .002),
                                Text(
                                  "Branded Products on cheap prices",
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(height: mediaQuery.height * .01),
                                ElevatedButton(
                                  onPressed: () {
                                    //
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Welcome2(),
                                    //   ),
                                    // );
                                  },
                                  child: Center(
                                    child: Text(
                                      'Get started',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              45.0), // Set the radius value here
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xff0D1C2E)),
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                        Size(mediaQuery.width * .4,
                                            mediaQuery.height * .06),
                                      ) // Set the background color here
                                      ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .02),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Prev',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffC5EB6D),
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Color(0xffD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Color(0xffD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Color(0xffC5EB6D),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffC5EB6D),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * .001),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
}
