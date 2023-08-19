import 'package:get/get.dart';
class ItemNum extends GetxController{
RxInt num =1.obs;
   void increaseItem(){
    num.value++;
   }

   void decreaseItem(){
    num.value--;
   }
}