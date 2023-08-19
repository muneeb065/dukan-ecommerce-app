import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dukan/view/category_screen.dart';
import 'package:dukan/view/home_screen.dart';
import 'package:dukan/view/order_screen.dart';
import 'package:dukan/view/profile_screen.dart';
import 'package:dukan/view/search_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ReusableBottomNaviBar extends StatelessWidget {
  const ReusableBottomNaviBar({
     required this.currentIndex,
  });
final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      activeColor: Color(0xffC0E862),
      backgroundColor: Colors.white,
      color: Color(0xffB3B9C4),
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.apps_rounded, title: 'Category'),
        TabItem(icon: Icons.search, title: 'Search'),
        TabItem(icon: Icons.list_alt, title: 'Orders'),
        TabItem(icon: Icons.person, title: 'Profile'),
      ],
      onTap: (int i) {
        // Update the current index
        if (i == 0) {
          Get.to(() => const HomeScreen());
        } else if (i == 1) {
          Get.to(() => CategoryScreen());
        } else if (i == 2) {
          Get.to(() => SearchScreen());
        } else if (i == 3) {
          Get.to(() => OrderScreen());
        }
        if (i == 4) {
          Get.to(() => ProfileScreen());
        }
      },
      initialActiveIndex: currentIndex,
    );
  }
}
