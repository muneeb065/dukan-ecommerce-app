import 'package:get/get.dart';

class CartItem {
   final String itemName;
  final String itemImage;
  final String itemPrice;
  final RxInt quantity;
  


  CartItem({ required this.itemName,
    required this.itemImage,
    required this.itemPrice,
   int quantity = 1,
   }): quantity = quantity.obs;

}
