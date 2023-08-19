import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:like_button/like_button.dart';

import '../controller/homeScreenController.dart';
import '../controller/itemcount.dart';
import 'cart_Screen.dart';
import 'displayproduct.dart';

class Category1 extends StatefulWidget {
  const Category1({super.key});

  @override
  State<Category1> createState() => _Category1State();
}

class _Category1State extends State<Category1> {
   final _fireStore = FirebaseFirestore.instance;
     final ItemNum itemNumChanger = Get.put(ItemNum());

  void navigateToCartScreen() {
    Get.to(CartScreen(
      itemNumChanger: itemNumChanger,
    ));
  }
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
               StreamBuilder(
                    stream: _fireStore.collection('HomeScreenTopCategory1').snapshots(),
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
                            "itemDetailDescr":itemDetailDescr,
                          };
                          itemDetail.add(itemMap);
                        }
                      }
                      return reusableItemDetails(itemDetails: itemDetail);
                    })
          ],
        ),
      ),
    );
  }
}
class reusableItemDetails extends StatelessWidget {
   reusableItemDetails({
    super.key,
    required this.itemDetails,
  });

  final List itemDetails;
  final ItemNum itemNumChanger = Get.put(ItemNum());

  void navigateToCartScreen() {
    Get.to(CartScreen(
      itemNumChanger: itemNumChanger,
    ));
  }
  @override
  Widget build(BuildContext context) {
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
          aspectRatio: 2.5,
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
                  child: Image.network(
                    storyImage,
                    fit: BoxFit.fill,
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
