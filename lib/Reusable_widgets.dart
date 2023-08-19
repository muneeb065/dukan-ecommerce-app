import 'package:flutter/material.dart';

class ReusableAppbarIcon extends StatelessWidget {
  const ReusableAppbarIcon({
    super.key,
    required this.mediaQuery,
    required this.icon,
  });

  final double mediaQuery;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Icon(
        size: mediaQuery * 0.04,
        icon,
        color: Colors.black,
      ),
    );
  }
}
