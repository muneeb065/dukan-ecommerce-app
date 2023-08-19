import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/view/profile_screen.dart';
import 'package:dukan/view/resubaleHeadingText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'displayproduct.dart';

class CategoryItems extends StatefulWidget {
//  String categoryName;
//   CategoryItems(String categoryName){
//       this.categoryName = categoryName;
//   }
      
  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}



class _CategoryItemsState extends State<CategoryItems> {
  // Remove the 'final String categoryName = '';'

  @override
  Widget build(BuildContext context) {
    Stream<List<Map<String, dynamic>>> getSubcategoriesStream() {
      return FirebaseFirestore.instance
          .collection('categoryCollection')
          .snapshots()
          .asyncMap((categoriesSnapshot) {
        var subcollectionFutures = categoriesSnapshot.docs.map((categoryDoc) {
          return categoryDoc.reference
              .collection('TShirt') // Use the categoryName field as the subcollection name
              .get()
              .then((subcategoriesSnapshot) {
            return subcategoriesSnapshot.docs.map((doc) => doc.data()).toList();
          });
        });

        return Future.wait(subcollectionFutures);
      }).map((snapshotsList) {
        List<Map<String, dynamic>> subcategories = [];
        snapshotsList.forEach((subcategoriesList) {
          subcategories.addAll(subcategoriesList);
        });
        return subcategories;
      });
    }

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
            // Your existing code...
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ... Your existing code ...

                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: getSubcategoriesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No subcategories found.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      List<Map<String, dynamic>> subcategories = snapshot.data!;
                      return reusbalecategory(
                        categoryCollection: subcategories,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
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
                      // onTap: () {
                      //   Get.to(
                      //     () => DisplayProduct(
                      //       itemName: categoryCollection[index]['itemName'],
                      //       itemDetailDescr: categoryCollection[index]
                      //           ['itemDetailDescr'],
                      //       itemImage: categoryCollection[index]['itemImage'],
                      //       itemPrice: categoryCollection[index]['itemPrice'],
                      //     ),
                      //   );
                      // },
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
                    height: 5,
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
