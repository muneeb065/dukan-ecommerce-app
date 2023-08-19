// ignore_for_file: prefer_const_constructors
import 'package:share_plus/share_plus.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';
import 'package:dukan/controller/itemcount.dart';
import 'package:dukan/view/home_screen.dart';
import 'package:dukan/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dukan/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:dukan/controller/cart_item.dart';
import 'package:dukan/view/cart_screen.dart';

import '../controller/itemSizeController.dart';

class DisplayProduct extends StatefulWidget {
  
  final String itemName;
  final String itemDetailDescr;
  final String itemImage;
  final String itemPrice;
 
  DisplayProduct(
      {required this.itemName,
      required this.itemImage,
      required this.itemDetailDescr,
      required this.itemPrice,
     });
  

  @override
  State<DisplayProduct> createState() => _DisplayProductState();
}

class _DisplayProductState extends State<DisplayProduct>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _fireStore = FirebaseFirestore.instance;
  final ItemNum itemNumChanger = Get.put(ItemNum());
  final CartController _cartController = Get.put(CartController());
  // Function to handle the cart button click

  void addToCart() async {
    // Check if the cartItems list is null or empty
    if (_cartController.cartItems.isEmpty) {
      // If the cart is empty or null, initialize it as an empty list
      _cartController.cartItems = [].obs;

      // Add the item to the cart with a quantity of 1
      _cartController.addToCart(
          CartItem(itemName: widget.itemName, itemImage: widget.itemImage, itemPrice: widget.itemPrice));

      // Show a snackbar to indicate that the item is added to the cart
      Get.snackbar(
        'Added to Cart',
        '${widget.itemName} added to the cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } else {
      // Check if the item already exists in the cart
      bool itemExistsInCart = _cartController.cartItems.any(
        (item) => item.itemName == widget.itemName,
      );

      if (itemExistsInCart) {
        Future.delayed(Duration(seconds: 5));
        Get.snackbar(
          'Existed',
          '${widget.itemName} already in the cart',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      Future.delayed(Duration(seconds: 2));// A delay to allow the state to update
    Get.to(CartScreen(itemNumChanger: itemNumChanger));
    // Pass the itemNumChanger controller to the CartScre
        // If the item is already in the cart, increase its quantity
        var cartItem = _cartController.cartItems.firstWhere(
          (item) => item.itemName == widget.itemName,
        );
        cartItem.quantity++;

        // Show a snackbar to indicate that the item is added to the cart
        
      } else {
        // If the item is not in the cart, add it with a quantity of 1
        _cartController.addToCart(
            CartItem(itemName: widget.itemName, itemImage: widget.itemImage, itemPrice: widget.itemPrice));

        // Show a snackbar to indicate that the item is added to the cart
        Get.snackbar(
          'Added to Cart',
          '${widget.itemName} added to the cart',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
    }

    // Navigate to the cart screen after adding the item to the cart
    await Future.delayed(
        Duration(seconds: 2)); // A delay to allow the state to update
    Get.to(CartScreen(itemNumChanger: itemNumChanger));
    // Pass the itemNumChanger controller to the CartScreen
  }

  // Function to handle the share button click
void shareProduct(String productDetails) async{
  // 'productDetails' is a string containing the details of the current product
  // For example, you can format it like this:
  // String productDetails = "Product Name: $productName\nPrice: $productPrice\nDescription: $productDescription";
 final box = context.findRenderObject() as RenderBox?;
    await Share.share(widget.itemName,
        subject: 'www.google.com',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  Share.share(productDetails, subject: 'Check out this product!');
}




  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Map> reviews = [];
  final SizeSelectionController sizeSelectionController =
      Get.put(SizeSelectionController());
  @override
  Widget build(BuildContext context) {
    bool _isBottomNavBarVisible = true;

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Color(0xff111260),
                unselectedLabelColor: Color(0xff000000).withOpacity(0.3),
                automaticIndicatorColorAdjustment: true,
                dividerColor: Color(0xff111260),
                labelColor: Color(0xff111260),
                tabs: [
                  Tab(
                    child: InkWell(
                      onTap: () {
                        _tabController.animateTo(0);
                        // Move to the first tab
                      },
                      child: Text(
                        'Details',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: InkWell(
                      onTap: () {
                        _tabController.animateTo(1); // Move to the first tab
                      },
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Container(
                height: 800.h,
                width: 360.w,
                color: Color(0xffFFFFFF),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15.r),
                        height: 250.h,
                        width: 295.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(widget.itemImage),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      Container(
                        width: 335.w,
                        height: 691.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.r),
                              child: Text(
                                'Product Code: CB57544 ',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff000000).withOpacity(.4)),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.itemName,
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff111260)),
                                  ),

                                  //Container for add items

                                  Container(
                                    margin: EdgeInsets.only(left: 35),
                                    height: 28.h,
                                    width: 71.w,
                                    decoration: BoxDecoration(
                                        color: Color(0xffC0E862),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            itemNumChanger.decreaseItem();
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.minus,
                                            size: 13.sp,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                        Obx(() {
                                          return Text(
                                            itemNumChanger.num.toString(),
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Color(0xffffffff)),
                                          );
                                        }),
                                        GestureDetector(
                                          onTap: () {
                                            itemNumChanger.increaseItem();
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 13.sp,
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.r),
                              child: Text(
                                'Delievery Time: 30 Minutes ',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff111260),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.r),
                              child: Row(
                                children: [
                                  //Container for add items
                                  RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      tapOnlyMode: false,
                                      itemCount: 5,
                                      itemSize: 36.sp,
                                      itemPadding: EdgeInsets.only(left: 3.0),
                                      itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                      onRatingUpdate: (rating) {}),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Size',
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff111260),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Show size guide
                                    },
                                    child: Text(
                                      'Size Guide',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff8F959E),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProductSizeBoxes(
                                    textSize: 'S',
                                    boxColor: Color(0xffF5F6FA),
                                    onPressed: () =>
                                          sizeSelectionController.setSize('S'),
                                    isSelected: sizeSelectionController
                                            .selectedSize.value ==
                                        'S',
                                  ),
                                  ProductSizeBoxes(
                                    textSize: 'M',
                                    boxColor: Color(0xffF5F6FA),
                                    onPressed: () =>
                                        sizeSelectionController.setSize('M'),
                                    isSelected: sizeSelectionController
                                            .selectedSize.value ==
                                        'M',
                                  ),

                        
                                  ProductSizeBoxes(
                                    textSize: 'L',
                                    boxColor: Color(0xffF5F6FA),
                                    onPressed: () =>
                                        sizeSelectionController.setSize('L'),
                                    isSelected: sizeSelectionController
                                            .selectedSize.value ==
                                        'L',
                                  ),
                                  ProductSizeBoxes(
                                    textSize: 'XL',
                                    boxColor: Color(0xffF5F6FA),
                                    onPressed: () =>
                                        sizeSelectionController.setSize('XL'),
                                    isSelected: sizeSelectionController
                                            .selectedSize.value ==
                                        'XL',
                                  ),
                                  ProductSizeBoxes(
                                    textSize: '2XL',
                                    boxColor: Color(0xffF5F6FA),
                                    onPressed: () =>
                                        sizeSelectionController.setSize('2XL'),
                                    isSelected: sizeSelectionController
                                            .selectedSize.value ==
                                        '2XL',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details & Ingredient ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color(0xff111260).withOpacity(.6)),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    widget.itemDetailDescr,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff46474B).withOpacity(.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //second tab content
                    ],
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 15.r),
                      height: 200.h,
                      width: 230.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(widget.itemImage),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        widget.itemName,
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff111260)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xff000000).withOpacity(.2),
                      indent: 80,
                      endIndent: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream:
                          _fireStore.collection('ChooseCategory').snapshots(),
                      builder: (context, snapshot) {
                        List customerCollection = [];
                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;

                          for (var doc in docs) {
                            final customerImage = doc.data()['customerImage'];
                            final customerName = doc.data()['customerName'];
                            final customerMessage =
                                doc.data()['customerMessage'];
                            final map = {
                              'customerImage': customerImage,
                              'customerName': customerName,
                              'customerMessage': customerMessage,
                            };
                            customerCollection.add(map);
                          }
                        }
                        print(customerCollection);

                        return ReviewsScreen(reviews: customerCollection);
                      },
                    ),
                  ]),
                ),
              ),
            ],
          ),
          bottomNavigationBar: 
          Container(
            padding: EdgeInsets.only(top: 5.r),
            color: Color(0xffffffff),
            width: 360,
            height: 132,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1D1E20),
                        ),
                      ),
                      Text(
                        'Rs. ${widget.itemPrice}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1D1E20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.r),
                  child: Text(
                    'With Delivery Charges',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff46474B).withOpacity(.7),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color(0xff000000).withOpacity(.2),
                ),
                SizedBox(height: 2.h),

                //Buttons of Order and Share
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: addToCart,
                      child: Container(
                        height: 50.h,
                        width: 156.w,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Color(0xff01BC87),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/🦆 icon _hexagon dice_.png',
                                height: 33.h,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                'Cart',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //button2
                    GestureDetector(
                      onTap: () {
                        String productDetails = "Product Name: ${widget.itemName}\nPrice: ${widget.itemPrice}";
                      shareProduct(productDetails);
                      },
                      child: Container(
                        height: 50.h,
                        width: 156.w,
                        // padding: EdgeInsets.only(left: 30),

                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Color(0xff019DCD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/🦆 icon _share android_.png',
                                height: 33.h,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                'Share',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewsScreen extends StatelessWidget {
  ReviewsScreen({
    super.key,
    required this.reviews,
  });

  final List reviews;
  List<double> initialRatings = [2, 3, 4, 1, 5];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(reviews[index]['customerImage']),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reviews[index]['customerName']),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: RatingBar.builder(
                    initialRating: initialRatings[index],
                    glow: false,
                    itemSize: 20,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // Do something with the updated rating if needed
                      print(rating);
                    },
                  ),
                ),
              ],
            ),
            subtitle: Text(reviews[index]['customerMessage']),
          );
        },
      ),
    );
  }
}

class ProductSizeBoxes extends StatelessWidget {
  ProductSizeBoxes({required this.textSize, required this.boxColor,  required this.isSelected, // Add isSelected to the constructor
    required this.onPressed,});

  final String textSize;
  final Color boxColor;
  final bool isSelected; // Add isSelected property here
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: 55.w,
      // padding: EdgeInsets.only(left: 30),

      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          textSize,
          textAlign: TextAlign.center,
          //textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xff1D1E20),
          ),
        ),
      ),
    );
  }
}
