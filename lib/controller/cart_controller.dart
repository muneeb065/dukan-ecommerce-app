import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:collection/collection.dart'; 
import 'package:dukan/controller/cart_item.dart';// Import for using firstWhereOrNull

class CartController extends GetxController {
  RxList cartItems = <CartItem>[].obs;

  bool isItemAlreadyAdded(CartItem item) {
    return cartItems.any((cartItem) =>
        cartItem.itemName == item.itemName &&
        cartItem.itemImage == item.itemImage &&
        cartItem.itemPrice == item.itemPrice);
  }

  double increasePrice(String itemPrice, int count) {
    double convertedvalue = double.parse(itemPrice);
    double value = convertedvalue * count;
    return value;
  }

  void addToCart(CartItem item) {
    cartItems.add(item);
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  void increaseQuantity(CartItem item) {
    item.quantity.value++;
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    }
  }

  int calculateSubtotal() {
    double subtotal = 0;
    for (var item in cartItems) {
      double itemPricE = double.parse(item.itemPrice);
      subtotal += itemPricE * item.quantity.value;
    }
    
    return subtotal.toInt();
  }

  int calculateTotal() {
    int deliveryFee = 50; // Assuming a fixed delivery fee
    int subtotal = calculateSubtotal();
    return subtotal + deliveryFee;
  }
}



