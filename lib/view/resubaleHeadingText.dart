import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableHeadingText extends StatelessWidget {
  final String title;
  final Alignment alignment;
  const ReusableHeadingText({
    super.key,
    required this.title,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        alignment: alignment,
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ));
  }
}
