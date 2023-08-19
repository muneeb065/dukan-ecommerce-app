import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/reusable_bottomnavibar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../controller/itemcount.dart';
import 'cart_Screen.dart';
import 'displayproduct.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _fireStore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> _allUsers = [];

  List<Map<String, dynamic>> itemDetails = [];
  @override
  initState() {
    // at the beginning, all users are shown

    super.initState();
    _fetchAllUsers();
  }

  void _fetchAllUsers() async {
    // Fetch the documents from Firestore
    final snapshot = await _fireStore.collection('SearchScreen').get();
    final docs = snapshot.docs;

    // Clear the list before adding new documents
    _allUsers.clear();

    for (var doc in docs) {
      final itemName = doc.data()['itemName'];
      final itemImage = doc.data()['itemImage'];
      final itemDescription = doc.data()['itemDescription'];
      final itemPrice = doc.data()['itemPrice'];
      final itemMap = {
        "itemName": itemName,
        "itemImage": itemImage,
        "itemDescription": itemDescription,
        "itemPrice": itemPrice,
      };
      _allUsers.add(itemMap);
    }

    // Update the itemDetails list with the fetched documents
    _runFilter(''); // Empty string to display all users initially
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user["itemName"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      itemDetails = results;
    });
  }
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
        body: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                _runFilter(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 15),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 4, // Blur radius
                            offset:
                                Offset(0, 2), // Offset in the x and y direction
                          ),
                        ]),
                    child: Icon(
                      Icons.search,
                      size: 25,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Color(0xff0E0E0E).withOpacity(0.03),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          SearchScreenMaterial(itemDetails: itemDetails),

          //testing going on
        ]),
         bottomNavigationBar: ReusableBottomNaviBar(currentIndex: 2,)
        );
  }
}

class SearchScreenMaterial extends StatelessWidget {
  SearchScreenMaterial({
    required this.itemDetails,
  });

  final List<Map<String, dynamic>> itemDetails;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: itemDetails.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 200,
                  crossAxisCount: 2),
              itemCount: itemDetails.length,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.6), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 4, // Blur radius
                              offset: Offset(
                                  0, 2), // Offset in the x and y direction
                            ),
                          ]),
                      height: 160,
                      width: 140,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
       Get.to(() => DisplayProduct(itemName:itemDetails[index]['itemName'],
       itemDetailDescr: itemDetails[index]['itemDescription'] ,
       itemImage: itemDetails[index]['itemImage'],
       itemPrice: itemDetails[index]['itemPrice'],),);

                            },
                            child: Container(
                             height: 90,
                             width: double.infinity,
                           
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle),
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
                  ))
          : const Text(
              'No results found Please try with diffrent search',
              style: TextStyle(fontSize: 15),
            ),
    );
  }
}
