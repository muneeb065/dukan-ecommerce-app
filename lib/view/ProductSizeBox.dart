import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/itemSizeController.dart';
class ProductSizeBoxes extends StatefulWidget {
  final String textSize;
  final Color boxColor;
  final bool isSelected;
  final VoidCallback onPressed;

  ProductSizeBoxes({
    required this.textSize,
    required this.boxColor,
    required this.isSelected,
    required this.onPressed,
  });
   final SizeSelectionController sizeSelectionController =
      Get.put(SizeSelectionController());

  @override
  _ProductSizeBoxesState createState() => _ProductSizeBoxesState();
}

class _ProductSizeBoxesState extends State<ProductSizeBoxes> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        // Customize the visual appearance based on isSelected
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.blue : widget.boxColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(8),
        child: Text(
          widget.textSize,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
