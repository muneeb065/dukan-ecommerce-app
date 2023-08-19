import 'dart:async';

import 'package:dukan/view/displayproduct.dart';
import 'package:dukan/view/topCategory1.dart';
import 'package:dukan/view/topcategory2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:marquee/marquee.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:dukan/controller/homeScreenController.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import '../reusable_bottomnavibar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/view/cart_Screen.dart';

import 'package:dukan/controller/itemcount.dart'; // Ensure this import is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final _fireStore = FirebaseFirestore.instance;
  final CarouselController carouselController = CarouselController();
  List adsList = [
    {"id": 1, "images": 'assets/ad1.jpg'},
    {"id": 2, "images": 'assets/ad2.jpg'},
    {"id": 3, "images": 'assets/ad3.jpg'}
  ];
  final ItemNum itemNumChanger = Get.put(ItemNum());

  void navigateToCartScreen() {
    Get.to(CartScreen(
      itemNumChanger: itemNumChanger,
    ));
  }

  int currentIndex = 0;
  List storiesList = [
    {"food": "Hamburger"},
    {"food": "Cheese burger"},
    {"food": "French Fries"},
    {"food": "Chicken Nuggets"},
    {"food": "Hot Dog"},
    {"food": "Pizza"},
    {"food": "Tacos"},
    {"food": "Burritos"},
    {"food": "Fried Chicken"},
    {"food": "Chicken Wings"},
    {"food": "Onion Rings"},
    {"food": "Milkshake"},
    {"food": "Ice Cream"},
    {"food": "Soft Serve"},
    {"food": "Nachos"},
    {"food": "Quesadilla"},
    {"food": "Sliders"},
    {"food": "Chicken Sandwich"},
    {"food": "Fish and Chips"},
    {"food": "Donuts"}
  ];

  List itemDetails1 = [
    {
      "itemName": "Chicken Pizza",
      "itemImage": "assets/ad1.jpg",
      "itemDescription": "with tommato sauce",
      "itemPrice": "Rs. 900"
    },
    {
      "itemName": "Burger Pizza",
      "itemImage": "assets/ad2.jpg",
      "itemDescription": "with tommato sauce",
      "itemPrice": "Rs. 900"
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Lock screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            'Dukan',
            style: TextStyle(color: Colors.black, fontSize: 35.sp),
          ),
          actions: [
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.bell,
                  size: 25.sp,
                  color: Colors.black,
                ),
                onPressed: () {}),
            IconButton(
                icon: GestureDetector(
                  onTap: navigateToCartScreen,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 30.sp,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {}),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // main container of avatars widgets
                Container(
                  alignment: Alignment.center,
                  height: 120.h,
                  child: StreamBuilder(
                    stream: _fireStore.collection('stories').snapshots(),
                    builder: (context, snapshot) {
                      List<Widget> storyList = [];
                      if (snapshot.hasData) {
                        final docs = snapshot.data?.docs;
                        for (var message in docs!) {
                          final storyText = message.data()['story'];
                          final storyImagefromDB = message.data()['ad'];
                          final textWidget = reusableStorynText(
                            storiesList: storiesList,
                            title: storyText,
                            storyImage: storyImagefromDB,
                          );
                          storyList.add(textWidget);
                          print('storyList');
                        }
                      }
                      return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: storyList,
                          ));
                    },
                  ),
                ),

                // add bar container

                Container(
                  alignment: Alignment.center,
                  height: 25.h,
                  color: Color(0xffC0E862),
                  child: Marquee(
                    text: 'Har Order per 50 rupees ka discount.',
                    style: TextStyle(fontSize: 15.sp, color: Colors.black),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    blankSpace: 400.0,
                    velocity: 50.0,
                    // pauseAfterRound: Duration(seconds: 1),
                    startPadding: 20.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                    textDirection: TextDirection.rtl,
                  ),
                ),

                StreamBuilder(
                    stream: _fireStore.collection('mainAds').snapshots(),
                    builder: ((context, snapshot) {
                      List imagesList = [];
                      if (snapshot.hasData) {
                        final snapshots = snapshot.data!.docs;
                        for (var snapshot in snapshots) {
                          final image = snapshot.data()['mainAd'];
                          final map = {"images": image};
                          imagesList.add(map);
                        }
                      }
                      return reusableSlider(
                          adsList: imagesList,
                          carouselController: carouselController,
                          homeScreenController: homeScreenController);
                    })),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: adsList.asMap().entries.map((entry) {
                    return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: GetBuilder<HomeScreenController>(
                          builder: (homeScreenController) {
                            return Container(
                              width: homeScreenController
                                          .sliderValueReturn()
                                          .value ==
                                      entry.key
                                  ? 17
                                  : 7,
                              height: 7.0,
                              margin: const EdgeInsets.only(
                                  left: 3.0, right: 3.0, top: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: homeScreenController
                                              .sliderValueReturn()
                                              .value ==
                                          entry.key
                                      ? Colors.green
                                      : Colors.teal),
                            );
                          },
                        ));
                  }).toList(),
                ),
                ReusableRowText(
                  leftText: 'Top Categories',
                  rightText: 'See all',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(Category1());
                      },
                      child: Container(
                        height: 90.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/ad2.jpg'))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Category2());
                      },
                      child: Container(
                         height: 90.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/ad1.jpg'))),
                      ),
                    ),
                  ],
                ),
                ReusableRowText(
                  leftText: 'Choose Category',
                  rightText: 'See all',
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            homeScreenController.selectedButton(0);
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              height: 25.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: homeScreenController.getButtonColor(0),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                  child: Text(
                                'All',
                                style: TextStyle(fontSize: 15.sp),
                              )),
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            homeScreenController.selectedButton(1);
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              height: 25.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: homeScreenController.getButtonColor(1),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                  child: Text(
                                'Burger',
                                style: TextStyle(fontSize: 15.sp),
                              )),
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            homeScreenController.selectedButton(2);
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              height: 25.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: homeScreenController.getButtonColor(2),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                  child: Text(
                                'Pizza',
                                style: TextStyle(fontSize: 15.sp),
                              )),
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            homeScreenController.selectedButton(3);
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              height: 25.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: homeScreenController.getButtonColor(3),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                  child: Text(
                                'Fries',
                                style: TextStyle(fontSize: 15.sp),
                              )),
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            homeScreenController.selectedButton(4);
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                bottom: 10.0,
                              ),
                              height: 25.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: homeScreenController.getButtonColor(4),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                  child: Text(
                                'Shawarma',
                                style: TextStyle(fontSize: 15.sp),
                              )),
                            ),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: _fireStore.collection('ChooseCategory').snapshots(),
                    builder: (context, snapshot) {
                      List itemDetail = [];
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;

                        for (var doc in docs) {
                          final itemName = doc.data()['itemName'];
                          final itemImage = doc.data()['itemImage'];
                          final itemDescription = doc.data()['itemDescr'];
                          final itemDetailDescr = doc.data()['itemDetailDescr'];
                          final itemPrice = doc.data()['itemPrice'];
                          final itemMap = {
                            "itemName": itemName,
                            "itemImage": itemImage,
                            "itemDescription": itemDescription,
                            "itemPrice": itemPrice,
                            "itemDetailDescr": itemDetailDescr,
                          };
                          itemDetail.add(itemMap);
                        }
                      }
                      return reusableItemDetails(itemDetails: itemDetail);
                    })
              ],
            ),
          ),
        ),
        // Initialize the current index

        bottomNavigationBar: ReusableBottomNaviBar(
          currentIndex: 0,
        ));
  }
}

class reusableItemDetails extends StatelessWidget {
  const reusableItemDetails({
    super.key,
    required this.itemDetails,
  });

  final List itemDetails;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      child: GridView.builder(
          itemCount: itemDetails.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 200,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 4, // Blur radius
                        offset: Offset(0, 2), // Offset in the x and y direction
                      ),
                    ]),
                height: 160,
                width: 140,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => DisplayProduct(
                            itemName: itemDetails[index]['itemName'],
                            itemDetailDescr: itemDetails[index]
                                ['itemDetailDescr'],
                            itemImage: itemDetails[index]['itemImage'],
                            itemPrice: itemDetails[index]['itemPrice'],
                          ),
                        );
                      },
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    itemDetails[index]['itemImage']))),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemDetails[index]['itemName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          LikeButton(
                            size: 30,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            itemDetails[index]['itemDescription'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs. ${itemDetails[index]['itemPrice']}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w900),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.orange, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class reusableSlider extends StatelessWidget {
  const reusableSlider({
    super.key,
    required this.adsList,
    required this.carouselController,
    required this.homeScreenController,
  });

  final List adsList;
  final CarouselController carouselController;
  final HomeScreenController homeScreenController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CarouselSlider(
        items: adsList
            .map((item) => Image.network(
                  item['images'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ))
            .toList(),
        carouselController: carouselController,
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          autoPlay: true,
          aspectRatio: 3.0,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            homeScreenController.slidervalueUpdater(index);
            // print(homeScreenController.sliderValueReturn());
          },
        ),
      ),
    );
  }
}

class reusableStorynText extends StatelessWidget {
  const reusableStorynText(
      {super.key,
      required this.storiesList,
      required this.title,
      required this.storyImage});

  final List storiesList;
  final String title;
  final String storyImage;
void _showFullScreenImage(BuildContext context) {
    showDialog(
      
      context: context,
      builder: (BuildContext context) {
        return Dialog(
           backgroundColor: Colors.transparent, 
          child: SizedBox(
            width: 200.h,
            height: 200.h,
            child: PhotoView(
              imageProvider: NetworkImage(storyImage),
            ),
          ),
        );
      },
    );

    // Automatically close the full-screen image after 5 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80.0,
            width: 80.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: GradientBoxBorder(
                width: 3,
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.redAccent],
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: GestureDetector(
                    onTap: (){
                                  _showFullScreenImage(context);

                    },
                    child: Image.network(
                      storyImage,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              '$title',

              maxLines: 2, // Set the maximum number of lines
              overflow:
                  TextOverflow.ellipsis, // Truncate the text with ellipsis
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableRowText extends StatelessWidget {
  const ReusableRowText({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
          ),
          Text(
            rightText,
            style: TextStyle(fontSize: 16.sp, color: Colors.green[400]),
          ),
        ],
      ),
    );
  }
}
