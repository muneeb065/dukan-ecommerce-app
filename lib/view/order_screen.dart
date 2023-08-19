import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import '../reusable_bottomnavibar.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          labelColor: Colors.purple,
          indicatorColor: Colors.purple,
          controller: _tabController,
          tabs: [
            Tab(text: 'Ongoing'),
            Tab(text: 'Delivered'),
        

          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Dukan',
          style: TextStyle(color: Colors.black, fontSize: 35.sp),
        ),
      ),
      // AppBar(
      //
      // //   leading: Text('Dukan'),
      //   bottom: TabBar(
      //     controller: _tabController,
      //     tabs: [
      //       Tab(text: 'Ongoing'),
      //       Tab(text: 'Delivered'),
      //       Tab(text: 'Returned'),
      //     ],
      //   ),
      // ),
      body: TabBarView(
        controller: _tabController,
        children: [
          if (true)
            Container(
              color: Colors.white,
              child: Column(
                children: [
                   StreamBuilder(
                  stream: _fireStore.collection('Orders').snapshots(),
                  builder: (context, snapshot) {
                    List orderDetail = [];
                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs.reversed;

                      for (var doc in docs) {
                        final customerName = doc.data()['customerName'];
                        final customerEmail = doc.data()['customerEmail'];
                        final customerNumber = doc.data()['customerNumber'];
                        final customerAddress = doc.data()['customerDeliveryAddress'];
                        final customerOrderName = doc.data()['orderName'];
                        final customerOrderImage = doc.data()['orderImage'];
                        final customerTotalPrice = doc.data()['customerTotal'];
                        final itemMap = {
                          "customerName": customerName,
                          "customerEmail":customerEmail,
                          " customerNumber": customerNumber,
                          " customerAddress": customerAddress,
                          "customerOrderName":customerOrderName,
                          "customerOrderImage":customerOrderImage,
                          "customerTotalPrice":customerTotalPrice,
                        
                        };
                        orderDetail.add(itemMap);
                      }
                    }
                    return orderWidget(orderDetail:orderDetail,);
                  }),
                  // Container(
                  //     padding: EdgeInsets.only(top: 20.r),
                  //     margin: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Aug 31, 2050 at 17:02 pm',
                  //       style: TextStyle(fontSize: 10.sp),
                  //     )),
                  // main card starting point
                  


                  
                  // Container(
                  //     padding: EdgeInsets.only(top: 20.r),
                  //     margin: EdgeInsets.only(left: 10),
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Aug 31, 2050 at 17:02 pm',
                  //       style: TextStyle(fontSize: 10.sp),
                  //     )),
                  // main card starting point
                  // Padding(
                  //   padding: EdgeInsets.all(8.r),
                  //   child: Container(
                  //     height: 290.h,
                  //     width: 340.w,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10.0),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey
                  //                 .withOpacity(0.3), // Shadow color
                  //             spreadRadius: 2, // Spread radius
                  //             blurRadius: 4, // Blur radius
                  //             offset: Offset(
                  //                 0, 2), // Offset in the x and y direction
                  //           ),
                  //         ]),
                  //     child: Column(
                  //       children: [
                  //         SizedBox(
                  //           height: 10,
                  //         ),
                  //         Row(
                  //           children: [
                  //             SizedBox(
                  //               width: 10.w,
                  //             ),
                  //             Container(
                  //               height: 150.h,
                  //               width: 180.w,
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                   color: Colors.white,
                  //                   image: const DecorationImage(
                  //                       fit: BoxFit.cover,
                  //                       image: AssetImage('assets/ad3.jpg'))),
                  //             ),
                  //             SizedBox(
                  //               width: 10.w,
                  //             ),
                  //             Container(
                  //               alignment: Alignment.topLeft,
                  //               child: Column(
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Special Pizza',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                         fontSize: 13.sp),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 8.h,
                  //                   ),
                  //                   Text(
                  //                     'Customer: Muneeb',
                  //                     style: TextStyle(fontSize: 13.r),
                  //                   ),
                  //                   SizedBox(
                  //                     height: 8.h,
                  //                   ),
                  //                   Text(
                  //                     'Order No. : 699612',
                  //                     style: TextStyle(fontSize: 13.r),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Divider(
                  //           color: Color(0xffC0E862),
                  //           height: 20.h,
                  //           endIndent: 20,
                  //           indent: 20,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Text('Status'),
                  //             Text('Shipped Booked'),
                  //           ],
                  //         ),
                  //         Divider(
                  //           thickness: 3,
                  //           color: Color(0xffC0E862),
                  //           height: 20.h,
                  //           endIndent: 20,
                  //           indent: 20,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             Container(
                  //               width: 150.w,
                  //               height: 45.h,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(45),
                  //               ),
                  //               child: OutlinedButton(
                  //                 style: ButtonStyle(
                  //                   backgroundColor:
                  //                       MaterialStateProperty.all(
                  //                           const Color(0xffC0E862)),
                  //                   foregroundColor:
                  //                       MaterialStateProperty.all(
                  //                           const Color(0xff030303)),
                  //                   side: MaterialStateProperty.all(
                  //                       BorderSide.none),
                  //                   shape: MaterialStateProperty.all(
                  //                       RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(45.0))),
                  //                 ),
                  //                 onPressed: () {},
                  //                 child: Text(
                  //                   'Track Order',
                  //                   style: TextStyle(
                  //                       fontSize: 18.sp,
                  //                       fontWeight: FontWeight.normal,
                  //                       fontFamily: 'Inter',
                  //                       color: Colors.black),
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: 150.w,
                  //               height: 45.h,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(45),
                  //               ),
                  //               child: OutlinedButton(
                  //                 style: ButtonStyle(
                  //                   backgroundColor:
                  //                       MaterialStateProperty.all(
                  //                           const Color(0xffC0E862)),
                  //                   foregroundColor:
                  //                       MaterialStateProperty.all(
                  //                           const Color(0xff030303)),
                  //                   side: MaterialStateProperty.all(
                  //                       BorderSide.none),
                  //                   shape: MaterialStateProperty.all(
                  //                       RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(45.0))),
                  //                 ),
                  //                 onPressed: () {},
                  //                 child: Text(
                  //                   'Details',
                  //                   style: TextStyle(
                  //                       fontSize: 18.sp,
                  //                       fontWeight: FontWeight.normal,
                  //                       fontFamily: 'Inter',
                  //                       color: Colors.black),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ReusableEmptyOrderScreens(
            title: 'No delivered placed yet',
          ),
          ReusableEmptyOrderScreens(
            title: 'No returned orders',
          ),
        ],
      ),
      bottomNavigationBar: ReusableBottomNaviBar(
        currentIndex: 3,
      ),
    );
  }
}

class orderWidget extends StatelessWidget {
  orderWidget({
    required this.orderDetail,
  });
final List orderDetail ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
   
      child: ListView.builder(
          itemCount: orderDetail.length,
        itemBuilder: (context, index) {
        return Padding(                                
        padding: EdgeInsets.all(8),
        child: Container(
          height: 290,
         
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.3), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 4, // Blur radius
                  offset: Offset(
                      0, 2), // Offset in the x and y direction
                ),
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 155,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${orderDetail[index]['customerOrderImage']}'))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                           '${orderDetail[index]['customerOrderName']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 150.w,
                          child: Text(
                            'Customer: ${orderDetail[index]['customerName']}',
                            style: TextStyle(fontSize: 13,overflow: TextOverflow.ellipsis,color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Price. : ${orderDetail[index]['customerTotalPrice']}',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color(0xffC0E862),
                height: 20,
                endIndent: 20,
                indent: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Status'),
                  Text('Shipped Booked'),
                ],
              ),
              Divider(
                thickness: 3,
                color: Color(0xffC0E862),
                height: 20,
                endIndent: 20,
                indent: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(
                                const Color(0xffC0E862)),
                        foregroundColor:
                            MaterialStateProperty.all(
                                const Color(0xff030303)),
                        side: MaterialStateProperty.all(
                            BorderSide.none),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(45.0))),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Track Order',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Inter',
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(
                                const Color(0xffC0E862)),
                        foregroundColor:
                            MaterialStateProperty.all(
                                const Color(0xff030303)),
                        side: MaterialStateProperty.all(
                            BorderSide.none),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(45.0))),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Details',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Inter',
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      },),
    );
  }
}

class ReusableEmptyOrderScreens extends StatelessWidget {
  const ReusableEmptyOrderScreens({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Image.asset(height: 200.h, 'assets/NoOrders.jpg'),
          SizedBox(
            height: 30.h,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: 250.w,
            child: Text(
              textAlign: TextAlign.center,
              'Help your customers discover and promote products they love, and leave the rest to us once they place their orders.',
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: 312.w,
            height: 56.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(45),
            ),
            child: OutlinedButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(const Color(0xff030303)),
                side: MaterialStateProperty.all(BorderSide.none),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0))),
              ),
              onPressed: () {
                Get.to(() => SearchScreen());
              },
              child: Text(
                'Discover',
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
    );
  }
}
