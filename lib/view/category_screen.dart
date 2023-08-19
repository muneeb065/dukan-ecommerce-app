import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/reusable_bottomnavibar.dart';
import 'package:dukan/view/sub_category_screen.dart';
import 'package:dukan/view/profile_screen.dart';
import 'package:dukan/view/resubaleHeadingText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dukan/view/home_screen.dart';
import 'package:get/get.dart';

import '../controller/itemcount.dart';
import 'cart_Screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _fireStore = FirebaseFirestore.instance;
  List categoryScreen = [
    {
      "categoryImage":
          'https://images.unsplash.com/photo-1498462440456-0dba182e775b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
      'categoryName': 'Shirt'
    },
    {
      'categoryImage':
          'https://media.gq-magazine.co.uk/photos/627d277c2867047a3ad99ef4/16:9/w_2560%2Cc_limit/Tshirts_HP.jpg',
      'categoryName': 'Shirt'
    }
  ];
   final ItemNum itemNumChanger = Get.put(ItemNum());

  void navigateToCartScreen() {
    Get.to(CartScreen(
      itemNumChanger: itemNumChanger,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEFEFE),
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
                onPressed: () {
                  print("bell");
                }),
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
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              
             Text('Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp)),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder(
                stream: _fireStore.collection('categoryCollection').snapshots(),
                builder: (context, snapshot) {
                  List categoryCollection = [];
                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;

                    for (var doc in docs) {
                      final categoryImage = doc.data()['categoryImage'];
                      final categoryName = doc.data()['categoryName'];
                      final map = {
                        'categoryImage': categoryImage,
                        'categoryName': categoryName
                      };
                      categoryCollection.add(map);
                    }
                  }
                  print(categoryCollection);
                  return reusbalecategory(
                    categoryCollection: categoryCollection,
                  );
                },
              ),
            ],
          )),
        ),
         bottomNavigationBar: ReusableBottomNaviBar(
          currentIndex: 1,
        )
      ),
    );
  }
}

class reusbalecategory extends StatelessWidget {
  reusbalecategory({
    required this.categoryCollection,
  });
  final List categoryCollection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        itemCount: categoryCollection.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              mainAxisExtent: 200,
              crossAxisCount: 2
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding:  EdgeInsets.all(20.0),
            child: Container(
               height: 160,
                width: 140,
              decoration: BoxDecoration(
                  color: Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 4, // Blur radius
                      offset: Offset(0, 2), // Offset in the x and y direction
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryItems(),
                      ),
                    ),
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: Image.network(categoryCollection[index]
                                      ['categoryImage'])
                                  .image,
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.6), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 4, // Blur radius
                              offset: Offset(
                                  0, 2), // Offset in the x and y direction
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height:5,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom:15.0),
                    child: ReusableHeadingText(
                        title: categoryCollection[index]['categoryName'],
                        alignment: Alignment.bottomCenter),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
