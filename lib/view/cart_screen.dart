import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dukan/controller/cart_controller.dart';
import 'package:dukan/controller/cart_item.dart';
import 'package:dukan/controller/itemcount.dart'; // Change this import to the correct path of ItemNum class
import 'package:dukan/view/checkout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CartScreen extends StatelessWidget {
 final CartController _cartController = Get.find();
  final ItemNum itemNumChanger;
  String? orderImage;
  String? orderName;
  List orderList = [];
  // ignore: use_key_in_widget_constructors
  CartScreen({required this.itemNumChanger});
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
        title: Text('Cart',style: TextStyle(color: Colors.black, fontSize: 27.sp),),
        backgroundColor: Colors.white,

      ),
       
      body: GetX<CartController>(
        init: _cartController,
        builder: (controller) {
          return ListView.builder(
          itemCount: _cartController.cartItems.length,
          itemBuilder: (context, index) {
            CartItem cartItem = _cartController.cartItems[index];
             orderList.add(cartItem);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:4.0,horizontal: 10),
              child: Card(
                child: ListTile(
                    leading: Image.network(
                      cartItem.itemImage,
                      height: 80,
                      width: 80, // Adjusts the image within the container
                    ), // Display the item image
                  title: Text(cartItem.itemName,
                  maxLines: 2,
                 
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis
                    ),),
                    
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top:4.0),
                      child: Obx(
                        () => Text(
                          
                          '${controller.increasePrice(cartItem.itemPrice, cartItem.quantity.value)}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  
                  
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                _cartController.decreaseQuantity(cartItem);
                         
                        },
                      ),
                      Obx(() => Text(cartItem.quantity.value.toString())), // Display the quantity
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                 _cartController.increaseQuantity(cartItem);
                            print(cartItem.itemPrice);
                        
                 // Update the itemValue
                        },
                      ),
                      GestureDetector(child:
                        Icon(Icons.delete),
                        onTap: () {
                _cartController.removeFromCart(cartItem);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }),
    bottomNavigationBar: Obx(()=>
      Visibility(
                  visible: _cartController.cartItems.isNotEmpty,
    
        child: Container(
                padding: EdgeInsets.only(top: 15.r),
                color: Color(0xffffffff),
                width: 360.w,
                height: 132.h,
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
                            'Total Cost',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1D1E20),
                            ),
                          ),
                          Text(
                            'Rs. ${_cartController.calculateSubtotal()}',
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
                      height: 5.h,
                    ),
                   
                    Divider(
                      thickness: 1,
                      color: Color(0xff000000).withOpacity(.2),
                    ),
                    SizedBox(height: 5.h),
      
                    //Buttons of Order and Share
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
                                  onPressed: (){   Get.to(() => CheckoutScreen(productImage: orderList[0].itemImage,productName:orderList[0].itemName ));},
                          child: Center(
                            child: Text(
                                      'Checkout',
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
                  ],
                ),
              ),
      ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    
    );
  }
}